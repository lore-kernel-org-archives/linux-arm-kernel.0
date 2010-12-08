From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 8 Dec 2010 11:07:57 +0530
Subject: [PATCH 5/9] ux500: remove build-time changing macros
In-Reply-To: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
References: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1291786681-8664-5-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow the possiblity of building U8500 and U5500 support in the same
image.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/clock.c                    |   14 +++-
 arch/arm/mach-ux500/cpu-db5500.c               |   12 +++-
 arch/arm/mach-ux500/cpu-db8500.c               |   18 +++++-
 arch/arm/mach-ux500/cpu.c                      |   74 ++++++++++++-----------
 arch/arm/mach-ux500/include/mach/debug-macro.S |   19 ++++++-
 arch/arm/mach-ux500/include/mach/entry-macro.S |    5 --
 arch/arm/mach-ux500/include/mach/hardware.h    |   60 +-------------------
 arch/arm/mach-ux500/include/mach/setup.h       |    1 -
 arch/arm/mach-ux500/platsmp.c                  |   37 +++++++++---
 9 files changed, 123 insertions(+), 117 deletions(-)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 7ec2544..3576e66 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -130,8 +130,7 @@ EXPORT_SYMBOL(clk_disable);
  */
 static unsigned long clk_mtu_get_rate(struct clk *clk)
 {
-	void __iomem *addr = __io_address(UX500_PRCMU_BASE)
-		+ PRCM_TCR;
+	void __iomem *addr;
 	u32 tcr;
 	int mtu = (int) clk->data;
 	/*
@@ -143,13 +142,20 @@ static unsigned long clk_mtu_get_rate(struct clk *clk)
 	unsigned long mturate;
 	unsigned long retclk;
 
+	if (cpu_is_u5500())
+		addr = __io_address(U5500_PRCMU_BASE);
+	else if (cpu_is_u8500())
+		addr = __io_address(U8500_PRCMU_BASE);
+	else
+		ux500_unknown_soc();
+
 	/*
 	 * On a startup, always conifgure the TCR to the doze mode;
 	 * bootloaders do it for us. Do this in the kernel too.
 	 */
-	writel(PRCM_TCR_DOZE_MODE, addr);
+	writel(PRCM_TCR_DOZE_MODE, addr + PRCM_TCR);
 
-	tcr = readl(addr);
+	tcr = readl(addr + PRCM_TCR);
 
 	/* Get the rate from the parent as a default */
 	if (clk->parent_periph)
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index acc841e..7b0ab833 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -22,6 +22,16 @@
 #include "devices-db5500.h"
 
 static struct map_desc u5500_io_desc[] __initdata = {
+	__IO_DEV_DESC(U5500_UART0_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_UART2_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_GIC_CPU_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_GIC_DIST_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_L2CC_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_TWD_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_MTU0_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_SCU_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_BACKUPRAM0_BASE, SZ_8K),
+
 	__IO_DEV_DESC(U5500_GPIO0_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_GPIO1_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_GPIO2_BASE, SZ_4K),
@@ -143,8 +153,6 @@ static void __init db5500_add_gpios(void)
 
 void __init u5500_map_io(void)
 {
-	ux500_map_io();
-
 	iotable_init(u5500_io_desc, ARRAY_SIZE(u5500_io_desc));
 }
 
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 658384c..304b20a 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -30,6 +30,22 @@ static struct platform_device *platform_devs[] __initdata = {
 
 /* minimum static i/o mapping required to boot U8500 platforms */
 static struct map_desc u8500_io_desc[] __initdata = {
+	__IO_DEV_DESC(U8500_UART0_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_UART2_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_GIC_CPU_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_L2CC_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_TWD_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_MTU0_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_BACKUPRAM0_BASE, SZ_8K),
+
+	__IO_DEV_DESC(U8500_CLKRST1_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_CLKRST2_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_CLKRST3_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_CLKRST5_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_CLKRST6_BASE, SZ_4K),
+
 	__IO_DEV_DESC(U8500_PRCMU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO1_BASE, SZ_4K),
@@ -117,8 +133,6 @@ bool cpu_is_u8500v20(void)
 
 void __init u8500_map_io(void)
 {
-	ux500_map_io();
-
 	iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
 
 	if (cpu_is_u8500ed())
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 5730409..35a3af1 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -23,37 +23,29 @@
 
 #include "clock.h"
 
-static struct map_desc ux500_io_desc[] __initdata = {
-	__IO_DEV_DESC(UX500_UART0_BASE, SZ_4K),
-	__IO_DEV_DESC(UX500_UART2_BASE, SZ_4K),
-
-	__IO_DEV_DESC(UX500_GIC_CPU_BASE, SZ_4K),
-	__IO_DEV_DESC(UX500_GIC_DIST_BASE, SZ_4K),
-	__IO_DEV_DESC(UX500_L2CC_BASE, SZ_4K),
-	__IO_DEV_DESC(UX500_TWD_BASE, SZ_4K),
-	__IO_DEV_DESC(UX500_SCU_BASE, SZ_4K),
-
-	__IO_DEV_DESC(UX500_CLKRST1_BASE, SZ_4K),
-	__IO_DEV_DESC(UX500_CLKRST2_BASE, SZ_4K),
-	__IO_DEV_DESC(UX500_CLKRST3_BASE, SZ_4K),
-	__IO_DEV_DESC(UX500_CLKRST5_BASE, SZ_4K),
-	__IO_DEV_DESC(UX500_CLKRST6_BASE, SZ_4K),
-
-	__IO_DEV_DESC(UX500_MTU0_BASE, SZ_4K),
-	__IO_DEV_DESC(UX500_MTU1_BASE, SZ_4K),
-
-	__IO_DEV_DESC(UX500_BACKUPRAM0_BASE, SZ_8K),
-};
+#ifdef CONFIG_CACHE_L2X0
+static void __iomem *l2x0_base;
+#endif
 
 void __init ux500_map_io(void)
 {
-	iotable_init(ux500_io_desc, ARRAY_SIZE(ux500_io_desc));
 }
 
 void __init ux500_init_irq(void)
 {
-	gic_init(0, 29, __io_address(UX500_GIC_DIST_BASE),
-		 __io_address(UX500_GIC_CPU_BASE));
+	void __iomem *dist_base;
+	void __iomem *cpu_base;
+
+	if (cpu_is_u5500()) {
+		dist_base = __io_address(U5500_GIC_DIST_BASE);
+		cpu_base = __io_address(U5500_GIC_CPU_BASE);
+	} else if (cpu_is_u8500()) {
+		dist_base = __io_address(U8500_GIC_DIST_BASE);
+		cpu_base = __io_address(U8500_GIC_CPU_BASE);
+	} else
+		ux500_unknown_soc();
+
+	gic_init(0, 29, dist_base, cpu_base);
 
 	/*
 	 * Init clocks here so that they are available for system timer
@@ -74,7 +66,8 @@ static inline void ux500_cache_wait(void __iomem *reg, unsigned long mask)
 
 static inline void ux500_cache_sync(void)
 {
-	void __iomem *base = __io_address(UX500_L2CC_BASE);
+	void __iomem *base = l2x0_base;
+
 	writel_relaxed(0, base + L2X0_CACHE_SYNC);
 	ux500_cache_wait(base + L2X0_CACHE_SYNC, 1);
 }
@@ -96,20 +89,23 @@ static void ux500_l2x0_disable(void)
  */
 static void ux500_l2x0_inv_all(void)
 {
-	void __iomem *l2x0_base = __io_address(UX500_L2CC_BASE);
+	void __iomem *base = l2x0_base;
 	uint32_t l2x0_way_mask = (1<<16) - 1;	/* Bitmask of active ways */
 
 	/* invalidate all ways */
-	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
-	ux500_cache_wait(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
+	writel_relaxed(l2x0_way_mask, base + L2X0_INV_WAY);
+	ux500_cache_wait(base + L2X0_INV_WAY, l2x0_way_mask);
 	ux500_cache_sync();
 }
 
 static int ux500_l2x0_init(void)
 {
-	void __iomem *l2x0_base;
-
-	l2x0_base = __io_address(UX500_L2CC_BASE);
+	if (cpu_is_u5500())
+		l2x0_base = __io_address(U5500_L2CC_BASE);
+	else if (cpu_is_u8500())
+		l2x0_base = __io_address(U8500_L2CC_BASE);
+	else
+		ux500_unknown_soc();
 
 	/* 64KB way size, 8 way associativity, force WA */
 	l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
@@ -127,13 +123,21 @@ static void __init ux500_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
 	/* Setup the local timer base */
-	twd_base = __io_address(UX500_TWD_BASE);
+	if (cpu_is_u5500())
+		twd_base = __io_address(U5500_TWD_BASE);
+	else if (cpu_is_u8500())
+		twd_base = __io_address(U8500_TWD_BASE);
+	else
+		ux500_unknown_soc();
 #endif
-	/* Setup the MTU base */
-	if (cpu_is_u8500ed())
+	if (cpu_is_u5500())
+		mtu_base = __io_address(U5500_MTU0_BASE);
+	else if (cpu_is_u8500ed())
 		mtu_base = __io_address(U8500_MTU0_BASE_ED);
+	else if (cpu_is_u8500())
+		mtu_base = __io_address(U8500_MTU0_BASE);
 	else
-		mtu_base = __io_address(UX500_MTU0_BASE);
+		ux500_unknown_soc();
 
 	nmdk_timer_init();
 }
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
index be7c0f1..700fb05 100644
--- a/arch/arm/mach-ux500/include/mach/debug-macro.S
+++ b/arch/arm/mach-ux500/include/mach/debug-macro.S
@@ -14,7 +14,24 @@
 #error Invalid Ux500 debug UART
 #endif
 
-#define __UX500_UART(n)	UX500_UART##n##_BASE
+/*
+ * DEBUG_LL only works if only one SOC is built in.  We don't use #else below
+ * in order to get "__UX500_UART redefined" warnings if more than one SOC is
+ * built, so that there's some hint during the build that something is wrong.
+ */
+
+#ifdef CONFIG_UX500_SOC_DB5500
+#define __UX500_UART(n)	U5500_UART##n##_BASE
+#endif
+
+#ifdef CONFIG_UX500_SOC_DB8500
+#define __UX500_UART(n)	U8500_UART##n##_BASE
+#endif
+
+#ifndef __UX500_UART
+#error Unknown SOC
+#endif
+
 #define UX500_UART(n)	__UX500_UART(n)
 #define UART_BASE	UX500_UART(CONFIG_UX500_DEBUG_UART)
 
diff --git a/arch/arm/mach-ux500/include/mach/entry-macro.S b/arch/arm/mach-ux500/include/mach/entry-macro.S
index a37f585..071bba9 100644
--- a/arch/arm/mach-ux500/include/mach/entry-macro.S
+++ b/arch/arm/mach-ux500/include/mach/entry-macro.S
@@ -11,15 +11,10 @@
  * warranty of any kind, whether express or implied.
  */
 #include <mach/hardware.h>
-#define HAVE_GET_IRQNR_PREAMBLE
 #include <asm/hardware/entry-macro-gic.S>
 
 		.macro	disable_fiq
 		.endm
 
-		.macro  get_irqnr_preamble, base, tmp
-		ldr     \base, =IO_ADDRESS(UX500_GIC_CPU_BASE)
-		.endm
-
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 6295cc5..bced4a8 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -29,65 +29,6 @@
 #include <mach/db8500-regs.h>
 #include <mach/db5500-regs.h>
 
-#ifdef CONFIG_UX500_SOC_DB8500
-#define UX500(periph)		U8500_##periph##_BASE
-#elif defined(CONFIG_UX500_SOC_DB5500)
-#define UX500(periph)		U5500_##periph##_BASE
-#endif
-
-#define UX500_BACKUPRAM0_BASE	UX500(BACKUPRAM0)
-#define UX500_BACKUPRAM1_BASE	UX500(BACKUPRAM1)
-#define UX500_B2R2_BASE		UX500(B2R2)
-
-#define UX500_CLKRST1_BASE	UX500(CLKRST1)
-#define UX500_CLKRST2_BASE	UX500(CLKRST2)
-#define UX500_CLKRST3_BASE	UX500(CLKRST3)
-#define UX500_CLKRST5_BASE	UX500(CLKRST5)
-#define UX500_CLKRST6_BASE	UX500(CLKRST6)
-
-#define UX500_DMA_BASE		UX500(DMA)
-#define UX500_FSMC_BASE		UX500(FSMC)
-
-#define UX500_GIC_CPU_BASE	UX500(GIC_CPU)
-#define UX500_GIC_DIST_BASE	UX500(GIC_DIST)
-
-#define UX500_I2C1_BASE		UX500(I2C1)
-#define UX500_I2C2_BASE		UX500(I2C2)
-#define UX500_I2C3_BASE		UX500(I2C3)
-
-#define UX500_L2CC_BASE		UX500(L2CC)
-#define UX500_MCDE_BASE		UX500(MCDE)
-#define UX500_MTU0_BASE		UX500(MTU0)
-#define UX500_MTU1_BASE		UX500(MTU1)
-#define UX500_PRCMU_BASE	UX500(PRCMU)
-
-#define UX500_RNG_BASE		UX500(RNG)
-#define UX500_RTC_BASE		UX500(RTC)
-
-#define UX500_SCU_BASE		UX500(SCU)
-
-#define UX500_SDI0_BASE		UX500(SDI0)
-#define UX500_SDI1_BASE		UX500(SDI1)
-#define UX500_SDI2_BASE		UX500(SDI2)
-#define UX500_SDI3_BASE		UX500(SDI3)
-#define UX500_SDI4_BASE		UX500(SDI4)
-
-#define UX500_SPI0_BASE		UX500(SPI0)
-#define UX500_SPI1_BASE		UX500(SPI1)
-#define UX500_SPI2_BASE		UX500(SPI2)
-#define UX500_SPI3_BASE		UX500(SPI3)
-
-#define UX500_SIA_BASE		UX500(SIA)
-#define UX500_SVA_BASE		UX500(SVA)
-
-#define UX500_TWD_BASE		UX500(TWD)
-
-#define UX500_UART0_BASE	UX500(UART0)
-#define UX500_UART1_BASE	UX500(UART1)
-#define UX500_UART2_BASE	UX500(UART2)
-
-#define UX500_USBOTG_BASE	UX500(USBOTG)
-
 /* ST-Ericsson modified pl022 id */
 #define SSP_PER_ID		0x01080022
 
@@ -143,6 +84,7 @@ static inline bool cpu_is_u5500(void)
 }
 
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
+#define ux500_unknown_soc()	BUG()
 
 #endif
 
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 469877e..5d84232 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -14,7 +14,6 @@
 #include <asm/mach/time.h>
 #include <linux/init.h>
 
-extern void __init ux500_map_io(void);
 extern void __init u5500_map_io(void);
 extern void __init u8500_map_io(void);
 
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 7f0a83e..5cada5d 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -20,6 +20,7 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
+#include <mach/setup.h>
 
 /*
  * control for which core is the next to come out of the secondary
@@ -27,6 +28,18 @@
  */
 volatile int __cpuinitdata pen_release = -1;
 
+static void __iomem *scu_base_addr(void)
+{
+	if (cpu_is_u5500())
+		return __io_address(U5500_SCU_BASE);
+	else if (cpu_is_u8500())
+		return __io_address(U8500_SCU_BASE);
+	else
+		ux500_unknown_soc();
+
+	return NULL;
+}
+
 static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
@@ -89,6 +102,15 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init wakeup_secondary(void)
 {
+	void __iomem *backupram;
+
+	if (cpu_is_u5500())
+		backupram = __io_address(U5500_BACKUPRAM0_BASE);
+	else if (cpu_is_u8500())
+		backupram = __io_address(U8500_BACKUPRAM0_BASE);
+	else
+		ux500_unknown_soc();
+
 	/* nobody is to be released from the pen yet */
 	pen_release = -1;
 
@@ -98,15 +120,13 @@ static void __init wakeup_secondary(void)
 	 * backup ram register at offset 0x1FF0, which is what boot rom code
 	 * is waiting for. This would wake up the secondary core from WFE
 	 */
-#define U8500_CPU1_JUMPADDR_OFFSET 0x1FF4
+#define UX500_CPU1_JUMPADDR_OFFSET 0x1FF4
 	__raw_writel(virt_to_phys(u8500_secondary_startup),
-		__io_address(UX500_BACKUPRAM0_BASE) +
-		U8500_CPU1_JUMPADDR_OFFSET);
+		     backupram + UX500_CPU1_JUMPADDR_OFFSET);
 
-#define U8500_CPU1_WAKEMAGIC_OFFSET 0x1FF0
+#define UX500_CPU1_WAKEMAGIC_OFFSET 0x1FF0
 	__raw_writel(0xA1FEED01,
-		__io_address(UX500_BACKUPRAM0_BASE) +
-		U8500_CPU1_WAKEMAGIC_OFFSET);
+		     backupram + UX500_CPU1_WAKEMAGIC_OFFSET);
 
 	/* make sure write buffer is drained */
 	mb();
@@ -118,9 +138,10 @@ static void __init wakeup_secondary(void)
  */
 void __init smp_init_cpus(void)
 {
+	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
 
-	ncores = scu_get_core_count(__io_address(UX500_SCU_BASE));
+	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
 
 	/* sanity check */
 	if (ncores > NR_CPUS) {
@@ -146,6 +167,6 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
 
-	scu_enable(__io_address(UX500_SCU_BASE));
+	scu_enable(scu_base_addr());
 	wakeup_secondary();
 }
-- 
1.7.2.dirty
