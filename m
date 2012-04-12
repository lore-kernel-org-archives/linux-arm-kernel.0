From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 12 Apr 2012 19:23:54 +0200
Subject: [PATCH v3] ARM: ux500: core U9540 support
Message-ID: <1334251434-15154-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds support for the U9540 variant of the U8500 series. This
is an application processor without internal modem. This is the
most basic part with ASIC ID, CPU-related fixes, IRQ list, register
ranges, timer, UART, and L2 cache setup. This is based on a patch
by Michel Jaouen which was rewritten to fit with the latest 3.3
kernel.

ChangeLog v1->v2: deleted the irqs-db9540.h file since we expect to
  migrate to using Device Tree for getting the IRQs to devices.
ChangeLog v2->v3: introduced a fixed virtual offset for the ROM
  as suggested by Arnd Bergmann.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sebastien Pasdeloup <sebastien.pasdeloup-nonst@stericsson.com>
Signed-off-by: Michel Jaouen <michel.jaouen@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-uib.c         |    2 +-
 arch/arm/mach-ux500/cache-l2x0.c               |   16 +++++++++++++---
 arch/arm/mach-ux500/clock.c                    |    2 +-
 arch/arm/mach-ux500/cpu-db8500.c               |    6 +++---
 arch/arm/mach-ux500/cpu.c                      |    4 ++--
 arch/arm/mach-ux500/id.c                       |    9 +++++++--
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    6 ++++++
 arch/arm/mach-ux500/include/mach/hardware.h    |    3 +++
 arch/arm/mach-ux500/include/mach/id.h          |   17 ++++++++++++++++-
 arch/arm/mach-ux500/include/mach/irqs.h        |    2 +-
 arch/arm/mach-ux500/include/mach/setup.h       |    7 +++++++
 arch/arm/mach-ux500/platsmp.c                  |    4 ++--
 arch/arm/mach-ux500/timer.c                    |    2 +-
 drivers/cpufreq/db8500-cpufreq.c               |    2 +-
 14 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-uib.c b/arch/arm/mach-ux500/board-mop500-uib.c
index 5af36aa..b29a788 100644
--- a/arch/arm/mach-ux500/board-mop500-uib.c
+++ b/arch/arm/mach-ux500/board-mop500-uib.c
@@ -102,7 +102,7 @@ static int __init mop500_uib_init(void)
 	struct i2c_adapter *i2c0;
 	int ret;
 
-	if (!cpu_is_u8500())
+	if (!cpu_is_u8500_family())
 		return -ENODEV;
 
 	if (uib) {
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 77a75ed..677bb76 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -36,9 +36,11 @@ static int __init ux500_l2x0_unlock(void)
 
 static int __init ux500_l2x0_init(void)
 {
+	u32 aux_val = 0x3e000000;
+
 	if (cpu_is_u5500())
 		l2x0_base = __io_address(U5500_L2CC_BASE);
-	else if (cpu_is_u8500())
+	else if (cpu_is_u8500_family())
 		l2x0_base = __io_address(U8500_L2CC_BASE);
 	else
 		ux500_unknown_soc();
@@ -46,11 +48,19 @@ static int __init ux500_l2x0_init(void)
 	/* Unlock before init */
 	ux500_l2x0_unlock();
 
+	/* DB9540's L2 has 128KB way size */
+	if (cpu_is_u9540())
+		/* 128KB way size */
+		aux_val |= (0x4 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
+	else
+		/* 64KB way size */
+		aux_val |= (0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
+
 	/* 64KB way size, 8 way associativity, force WA */
 	if (of_have_populated_dt())
-		l2x0_of_init(0x3e060000, 0xc0000fff);
+		l2x0_of_init(aux_val, 0xc0000fff);
 	else
-		l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
+		l2x0_init(l2x0_base, aux_val, 0xc0000fff);
 
 	/*
 	 * We can't disable l2 as we are in non secure mode, currently
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index ec35f0a..cc87f77 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -151,7 +151,7 @@ static unsigned long clk_mtu_get_rate(struct clk *clk)
 
 	if (cpu_is_u5500())
 		addr = __io_address(U5500_PRCMU_BASE);
-	else if (cpu_is_u8500())
+	else if (cpu_is_u8500_family())
 		addr = __io_address(U8500_PRCMU_BASE);
 	else
 		ux500_unknown_soc();
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 9bd8163..0bdcdd9 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -34,8 +34,8 @@ static struct map_desc u8500_uart_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_UART0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_UART2_BASE, SZ_4K),
 };
-
-static struct map_desc u8500_io_desc[] __initdata = {
+/*  U8500 and U9540 common io_desc */
+static struct map_desc u8500_common_io_desc[] __initdata = {
 	/* SCU base also covers GIC CPU BASE and TWD with its 4K page */
 	__IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
@@ -66,7 +66,7 @@ void __init u8500_map_io(void)
 
 	ux500_map_io();
 
-	iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
+	iotable_init(u8500_common_io_desc, ARRAY_SIZE(u8500_common_io_desc));
 
 	_PRCMU_BASE = __io_address(U8500_PRCMU_BASE);
 }
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index d11f389..857e481 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -43,7 +43,7 @@ void __init ux500_init_irq(void)
 	if (cpu_is_u5500()) {
 		dist_base = __io_address(U5500_GIC_DIST_BASE);
 		cpu_base = __io_address(U5500_GIC_CPU_BASE);
-	} else if (cpu_is_u8500()) {
+	} else if (cpu_is_u8500_family()) {
 		dist_base = __io_address(U8500_GIC_DIST_BASE);
 		cpu_base = __io_address(U8500_GIC_CPU_BASE);
 	} else
@@ -62,7 +62,7 @@ void __init ux500_init_irq(void)
 	 */
 	if (cpu_is_u5500())
 		db5500_prcmu_early_init();
-	if (cpu_is_u8500())
+	if (cpu_is_u8500_family())
 		db8500_prcmu_early_init();
 	clk_init();
 }
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index 15a0f63..d157992 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -23,7 +23,7 @@ static unsigned int ux500_read_asicid(phys_addr_t addr)
 {
 	phys_addr_t base = addr & ~0xfff;
 	struct map_desc desc = {
-		.virtual	= IO_ADDRESS(base),
+		.virtual	= UX500_VIRT_ROM,
 		.pfn		= __phys_to_pfn(base),
 		.length		= SZ_16K,
 		.type		= MT_DEVICE,
@@ -35,7 +35,7 @@ static unsigned int ux500_read_asicid(phys_addr_t addr)
 	local_flush_tlb_all();
 	flush_cache_all();
 
-	return readl(__io_address(addr));
+	return readl(IOMEM(UX500_VIRT_ROM + (addr & 0xfff)));
 }
 
 static void ux500_print_soc_info(unsigned int asicid)
@@ -67,6 +67,7 @@ static unsigned int partnumber(unsigned int asicid)
  * DB8500v2	0x412fc091	0x9001DBF4		0x008500B0
  * DB8520v2.2	0x412fc091	0x9001DBF4		0x008500B2
  * DB5500v1	0x412fc091	0x9001FFF4		0x005500A0
+ * DB9540	0x413fc090	0xFFFFDBF4		0x009540xx
  */
 
 void __init ux500_map_io(void)
@@ -91,6 +92,10 @@ void __init ux500_map_io(void)
 		/* DB5500v1 */
 		addr = 0x9001FFF4;
 		break;
+
+	case 0x413fc090: /* DB9540 */
+		addr = 0xFFFFDBF4;
+		break;
 	}
 
 	if (addr)
diff --git a/arch/arm/mach-ux500/include/mach/db8500-regs.h b/arch/arm/mach-ux500/include/mach/db8500-regs.h
index 9ec20b9..1530d49 100644
--- a/arch/arm/mach-ux500/include/mach/db8500-regs.h
+++ b/arch/arm/mach-ux500/include/mach/db8500-regs.h
@@ -41,6 +41,10 @@
 /* ASIC ID is at 0xbf4 offset within this region */
 #define U8500_ASIC_ID_BASE	0x9001D000
 
+#define U9540_BOOT_ROM_BASE	0xFFFE0000
+/* ASIC ID is@0xbf4 offset within this region */
+#define U9540_ASIC_ID_BASE	0xFFFFD000
+
 #define U8500_PER6_BASE		0xa03c0000
 #define U8500_PER7_BASE		0xa03d0000
 #define U8500_PER5_BASE		0xa03e0000
@@ -96,7 +100,9 @@
 #define U8500_SCR_BASE		(U8500_PER4_BASE + 0x05000)
 #define U8500_DMC_BASE		(U8500_PER4_BASE + 0x06000)
 #define U8500_PRCMU_BASE	(U8500_PER4_BASE + 0x07000)
+#define U9540_DMC1_BASE		(U8500_PER4_BASE + 0x0A000)
 #define U8500_PRCMU_TCDM_BASE	(U8500_PER4_BASE + 0x68000)
+#define U9540_PRCMU_TCDM_BASE	(U8500_PER4_BASE + 0x6A000)
 #define U8500_PRCMU_TCPM_BASE   (U8500_PER4_BASE + 0x60000)
 #define U8500_PRCMU_TIMER_3_BASE (U8500_PER4_BASE + 0x07338)
 #define U8500_PRCMU_TIMER_4_BASE (U8500_PER4_BASE + 0x07450)
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index f846989..8361657 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -17,6 +17,8 @@
  */
 #define U8500_IO_VIRTUAL	0xf0000000
 #define U8500_IO_PHYSICAL	0xa0000000
+/* This is where we map in the ROM to check ASIC IDs */
+#define UX500_VIRT_ROM		0xf0000000
 
 /* This macro is used in assembly, so no cast */
 #define IO_ADDRESS(x)           \
@@ -24,6 +26,7 @@
 
 /* typesafe io address */
 #define __io_address(n)		IOMEM(IO_ADDRESS(n))
+
 /* Used by some plat-nomadik code */
 #define io_p2v(n)		__io_address(n)
 
diff --git a/arch/arm/mach-ux500/include/mach/id.h b/arch/arm/mach-ux500/include/mach/id.h
index 833d6a6..c6e2db9 100644
--- a/arch/arm/mach-ux500/include/mach/id.h
+++ b/arch/arm/mach-ux500/include/mach/id.h
@@ -41,6 +41,16 @@ static inline bool __attribute_const__ cpu_is_u8500(void)
 	return dbx500_partnumber() == 0x8500;
 }
 
+static inline bool __attribute_const__ cpu_is_u9540(void)
+{
+	return dbx500_partnumber() == 0x9540;
+}
+
+static inline bool cpu_is_u8500_family(void)
+{
+	return cpu_is_u8500() || cpu_is_u9540();
+}
+
 static inline bool __attribute_const__ cpu_is_u5500(void)
 {
 	return dbx500_partnumber() == 0x5500;
@@ -111,7 +121,12 @@ static inline bool cpu_is_u8500v21(void)
 
 static inline bool cpu_is_u8500v20_or_later(void)
 {
-	return cpu_is_u8500() && !cpu_is_u8500v10() && !cpu_is_u8500v11();
+	/*
+	 * U9540 has so much in common with U8500 that is is considered a
+	 * U8500 variant.
+	 */
+	return cpu_is_u9540() ||
+		(cpu_is_u8500() && !cpu_is_u8500v10() && !cpu_is_u8500v11());
 }
 
 static inline bool ux500_is_svp(void)
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index c23a6b5..7da9ec5 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -24,7 +24,7 @@
  */
 #define IRQ_MTU0		(IRQ_SHPI_START + 4)
 
-#define DBX500_NR_INTERNAL_IRQS		160
+#define DBX500_NR_INTERNAL_IRQS		166
 
 /* After chip-specific IRQ numbers we have the GPIO ones */
 #define NOMADIK_NR_GPIO			288
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 3dc00ff..48e007d 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -49,4 +49,11 @@ extern struct sys_timer ux500_timer;
 	.type		= MT_MEMORY,		\
 }
 
+#define __MEM_DEV_DESC_DB9540_ROM(x, sz) {		\
+	.virtual	= IO_ADDRESS_DB9540_ROM(x),	\
+	.pfn		= __phys_to_pfn(x),		\
+	.length		= sz,				\
+	.type		= MT_MEMORY,			\
+}
+
 #endif /*  __ASM_ARCH_SETUP_H */
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index eff5842..f499a07 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -50,7 +50,7 @@ static void __iomem *scu_base_addr(void)
 {
 	if (cpu_is_u5500())
 		return __io_address(U5500_SCU_BASE);
-	else if (cpu_is_u8500())
+	else if (cpu_is_u8500_family())
 		return __io_address(U8500_SCU_BASE);
 	else
 		ux500_unknown_soc();
@@ -122,7 +122,7 @@ static void __init wakeup_secondary(void)
 
 	if (cpu_is_u5500())
 		backupram = __io_address(U5500_BACKUPRAM0_BASE);
-	else if (cpu_is_u8500())
+	else if (cpu_is_u8500_family())
 		backupram = __io_address(U8500_BACKUPRAM0_BASE);
 	else
 		ux500_unknown_soc();
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index d37df98..3bfbfdf 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -51,7 +51,7 @@ static void __init ux500_timer_init(void)
 	if (cpu_is_u5500()) {
 		mtu_timer_base = __io_address(U5500_MTU0_BASE);
 		prcmu_timer_base = __io_address(U5500_PRCMU_TIMER_3_BASE);
-	} else if (cpu_is_u8500()) {
+	} else if (cpu_is_u8500_family()) {
 		mtu_timer_base = __io_address(U8500_MTU0_BASE);
 		prcmu_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
 	} else {
diff --git a/drivers/cpufreq/db8500-cpufreq.c b/drivers/cpufreq/db8500-cpufreq.c
index 0bf1b89..74b830b 100644
--- a/drivers/cpufreq/db8500-cpufreq.c
+++ b/drivers/cpufreq/db8500-cpufreq.c
@@ -161,7 +161,7 @@ static struct cpufreq_driver db8500_cpufreq_driver = {
 
 static int __init db8500_cpufreq_register(void)
 {
-	if (!cpu_is_u8500v20_or_later())
+	if (!cpu_is_u8500_family())
 		return -ENODEV;
 
 	pr_info("cpufreq for DB8500 started\n");
-- 
1.7.9.2
