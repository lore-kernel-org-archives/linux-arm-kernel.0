From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 15:49:03 +0200
Subject: [PATCH 01/10] ARM: ux500: delete UART static map
In-Reply-To: <1431619947-14850-1-git-send-email-linus.walleij@linaro.org>
References: <1431619947-14850-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <2124704.Sx5NxN2EF7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 May 2015 18:12:27 Linus Walleij wrote:
> Delete the static maps for the Ux500 UARTs and rely
> on debug_ll_io_init() to do the trick.
> commit f87b95dd2e4a8832b1d6034f15a5324db42608a0
> "ARM: ux500: move debugmacro to debug includes"
> defined the necessary addruart macro two years ago.

Hi Linus,

The whole series turned out even nicer than I expected, great work!

I've taken a closer look at the remaining early map for the soc ID
and found that this is essentially not needed either. I also found
some more dead code, so here is what I came up with. Does this
look reasonable to you?

	Arnd

 arch/arm/mach-ux500/Makefile                  |   3 +-
 arch/arm/mach-ux500/board-mop500-regulators.c |  72 -------
 arch/arm/mach-ux500/cache-l2x0.c              |  57 ------
 arch/arm/mach-ux500/cpu-db8500.c              |  32 ++++
 arch/arm/mach-ux500/cpu.c                     |  36 +---
 arch/arm/mach-ux500/id.c                      |  53 ++----
 arch/arm/mach-ux500/id.h                      | 121 ------------
 arch/arm/mach-ux500/setup.h                   |   3 +-
 arch/arm/mach-ux500/timer.c                   |  48 -----
 drivers/clk/ux500/Makefile                    |   1 -
 drivers/clk/ux500/u8500_clk.c                 | 525 ----------------------------------------------------
 drivers/clocksource/clksrc-dbx500-prcmu.c     |   6 +-
 include/linux/platform_data/clk-ux500.h       |   3 -
 13 files changed, 61 insertions(+), 899 deletions(-)

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 4418a5078833..b4f1847f0188 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -2,8 +2,7 @@
 # Makefile for the linux kernel, U8500 machine.
 #
 
-obj-y				:= cpu.o id.o timer.o pm.o
-obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
+obj-y				:= cpu.o id.o pm.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o
 obj-$(CONFIG_MACH_MOP500)	+= board-mop500-regulators.o \
 				board-mop500-audio.o
diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 32d744e91ec2..b2ad6f68d03e 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -991,75 +991,3 @@ struct ab8500_regulator_platform_data ab8505_regulator_plat_data = {
 	.regulator              = ab8505_regulators,
 	.num_regulator          = ARRAY_SIZE(ab8505_regulators),
 };
-
-static void ab8500_modify_reg_init(int id, u8 mask, u8 value)
-{
-	int i;
-
-	if (cpu_is_u8520()) {
-		for (i = ARRAY_SIZE(ab8505_reg_init) - 1; i >= 0; i--) {
-			if (ab8505_reg_init[i].id == id) {
-				u8 initval = ab8505_reg_init[i].value;
-				initval = (initval & ~mask) | (value & mask);
-				ab8505_reg_init[i].value = initval;
-
-				BUG_ON(mask & ~ab8505_reg_init[i].mask);
-				return;
-			}
-		}
-	} else {
-		for (i = ARRAY_SIZE(ab8500_reg_init) - 1; i >= 0; i--) {
-			if (ab8500_reg_init[i].id == id) {
-				u8 initval = ab8500_reg_init[i].value;
-				initval = (initval & ~mask) | (value & mask);
-				ab8500_reg_init[i].value = initval;
-
-				BUG_ON(mask & ~ab8500_reg_init[i].mask);
-				return;
-			}
-		}
-	}
-
-	BUG_ON(1);
-}
-
-void mop500_regulator_init(void)
-{
-	struct regulator_init_data *regulator;
-
-	/*
-	 * Temporarily turn on Vaux2 on 8520 machine
-	 */
-	if (cpu_is_u8520()) {
-		/* Vaux2 initialized to be on */
-		ab8500_modify_reg_init(AB8505_VAUX12REGU, 0x0f, 0x05);
-	}
-
-	/*
-	 * Handle AB8500_EXT_SUPPLY2 on HREFP_V20_V50 boards (do it for
-	 * all HREFP_V20 boards)
-	 */
-	if (cpu_is_u8500v20()) {
-		/* VextSupply2RequestCtrl =  HP/OFF depending on VxRequest */
-		ab8500_modify_reg_init(AB8500_REGUREQUESTCTRL3, 0x01, 0x01);
-
-		/* VextSupply2SysClkReq1HPValid = SysClkReq1 controlled */
-		ab8500_modify_reg_init(AB8500_REGUSYSCLKREQ1HPVALID2,
-			0x20, 0x20);
-
-		/* VextSupply2 = force HP at initialization */
-		ab8500_modify_reg_init(AB8500_EXTSUPPLYREGU, 0x0c, 0x04);
-
-		/* enable VextSupply2 during platform active */
-		regulator = &ab8500_ext_regulators[AB8500_EXT_SUPPLY2];
-		regulator->constraints.always_on = 1;
-
-		/* disable VextSupply2 in suspend */
-		regulator = &ab8500_ext_regulators[AB8500_EXT_SUPPLY2];
-		regulator->constraints.state_mem.disabled = 1;
-		regulator->constraints.state_standby.disabled = 1;
-
-		/* enable VextSupply2 HW control (used in suspend) */
-		regulator->driver_data = (void *)&ab8500_ext_supply2;
-	}
-}
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
deleted file mode 100644
index e97ee556f92f..000000000000
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2011
- *
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/io.h>
-#include <linux/of.h>
-
-#include <asm/hardware/cache-l2x0.h>
-
-#include "db8500-regs.h"
-#include "id.h"
-
-static int __init ux500_l2x0_unlock(void)
-{
-	int i;
-	void __iomem *l2x0_base = __io_address(U8500_L2CC_BASE);
-
-	/*
-	 * Unlock Data and Instruction Lock if locked. Ux500 U-Boot versions
-	 * apparently locks both caches before jumping to the kernel. The
-	 * l2x0 core will not touch the unlock registers if the l2x0 is
-	 * already enabled, so we do it right here instead. The PL310 has
-	 * 8 sets of registers, one per possible CPU.
-	 */
-	for (i = 0; i < 8; i++) {
-		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D_BASE +
-			       i * L2X0_LOCKDOWN_STRIDE);
-		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I_BASE +
-			       i * L2X0_LOCKDOWN_STRIDE);
-	}
-	return 0;
-}
-
-static void ux500_l2c310_write_sec(unsigned long val, unsigned reg)
-{
-	/*
-	 * We can't write to secure registers as we are in non-secure
-	 * mode, until we have some SMI service available.
-	 */
-}
-
-static int __init ux500_l2x0_init(void)
-{
-	/* Multiplatform guard */
-	if (!((cpu_is_u8500_family() || cpu_is_ux540_family())))
-		return -ENODEV;
-
-	/* Unlock before init */
-	ux500_l2x0_unlock();
-	outer_cache.write_sec = ux500_l2c310_write_sec;
-	l2x0_of_init(0, ~0);
-
-	return 0;
-}
-early_initcall(ux500_l2x0_init);
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 537a7753afc1..47d0f9ddd14f 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -88,6 +88,27 @@ static void __init u8500_map_io(void)
 		iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
 }
 
+void __init ux500_timer_init(void)
+{
+	if (of_machine_is_compatible("st-ericsson,u8500")
+		u8500_of_clk_init(U8500_CLKRST1_BASE,
+				  U8500_CLKRST2_BASE,
+				  U8500_CLKRST3_BASE,
+				  U8500_CLKRST5_BASE,
+				  U8500_CLKRST6_BASE);
+
+	else if (of_machine_is_compatible("st-ericsson,u9540")
+		u9540_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
+			       U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
+			       U8500_CLKRST6_BASE);
+	else if (of_machine_is_compatible("st-ericsson,u8540")
+		u8540_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
+			       U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
+			       U8500_CLKRST6_BASE);
+
+	clocksource_of_init();
+}
+
 /*
  * The PMU IRQ lines of two cores are wired together into a single interrupt.
  * Bounce the interrupt to the other core if it's not ours.
@@ -131,6 +152,14 @@ static struct device * __init db8500_soc_device_init(void)
 	return ux500_soc_device_init(soc_id);
 }
 
+static void ux500_l2c310_write_sec(unsigned long val, unsigned reg)
+{
+	/*
+	 * We can't write to secure registers as we are in non-secure
+	 * mode, until we have some SMI service available.
+	 */
+}
+
 static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires call-back bindings. */
 	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
@@ -189,6 +218,9 @@ static const char * stericsson_dt_platform_compat[] = {
 };
 
 DT_MACHINE_START(U8500_DT, "ST-Ericsson Ux5x0 platform (Device Tree Support)")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
+	.l2c_write_sec	= ux500_l2c310_write_sec,
 	.smp            = smp_ops(ux500_smp_ops),
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 6ced0f680262..99042ea0bc3a 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -55,37 +55,15 @@ void __init ux500_init_irq(void)
 	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND);
 	irqchip_init();
 
-	/*
-	 * Init clocks here so that they are available for system timer
-	 * initialization.
-	 */
-	if (cpu_is_u8500_family()) {
-		prcmu_early_init(U8500_PRCMU_BASE, SZ_8K - 1);
-		ux500_pm_init(U8500_PRCMU_BASE, SZ_8K - 1);
-
-		u8500_of_clk_init(U8500_CLKRST1_BASE,
-				  U8500_CLKRST2_BASE,
-				  U8500_CLKRST3_BASE,
-				  U8500_CLKRST5_BASE,
-				  U8500_CLKRST6_BASE);
-	} else if (cpu_is_u9540()) {
-		prcmu_early_init(U8500_PRCMU_BASE, SZ_8K - 1);
-		ux500_pm_init(U8500_PRCMU_BASE, SZ_8K - 1);
-		u9540_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
-			       U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
-			       U8500_CLKRST6_BASE);
-	} else if (cpu_is_u8540()) {
-		prcmu_early_init(U8500_PRCMU_BASE, SZ_8K + SZ_4K - 1);
-		ux500_pm_init(U8500_PRCMU_BASE, SZ_8K + SZ_4K - 1);
-		u8540_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
-			       U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
-			       U8500_CLKRST6_BASE);
-	}
+	prcmu_early_init(U8500_PRCMU_BASE, SZ_8K + SZ_4K - 1);
+	ux500_pm_init(U8500_PRCMU_BASE, SZ_8K + SZ_4K - 1);
 }
 
+static struct dbx500_asic_id dbx500_id;
+
 static const char * __init ux500_get_machine(void)
 {
-	return kasprintf(GFP_KERNEL, "DB%4x", dbx500_partnumber());
+	return kasprintf(GFP_KERNEL, "DB%4x", dbx500_id.partnumber);
 }
 
 static const char * __init ux500_get_family(void)
@@ -95,7 +73,7 @@ static const char * __init ux500_get_family(void)
 
 static const char * __init ux500_get_revision(void)
 {
-	unsigned int rev = dbx500_revision();
+	unsigned int rev = dbx500_id.revision;
 
 	if (rev == 0x01)
 		return kasprintf(GFP_KERNEL, "%s", "ED");
@@ -138,6 +116,8 @@ struct device * __init ux500_soc_device_init(const char *soc_id)
 	if (!soc_dev_attr)
 		return ERR_PTR(-ENOMEM);
 
+	ux500_asic_id(&dbx500_id);
+
 	soc_info_populate(soc_dev_attr, soc_id);
 
 	soc_dev = soc_device_register(soc_dev_attr);
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index 392f2fdb37d0..a79613b96c7d 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -19,32 +19,11 @@
 #include "db8500-regs.h"
 #include "id.h"
 
-struct dbx500_asic_id dbx500_id;
-
-static unsigned int __init ux500_read_asicid(phys_addr_t addr)
-{
-	phys_addr_t base = addr & ~0xfff;
-	struct map_desc desc = {
-		.virtual	= (unsigned long)UX500_VIRT_ROM,
-		.pfn		= __phys_to_pfn(base),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	};
-
-	iotable_init(&desc, 1);
-
-	/* As in devicemaps_init() */
-	local_flush_tlb_all();
-	flush_cache_all();
-
-	return readl(UX500_VIRT_ROM + (addr & 0xfff));
-}
-
-static void ux500_print_soc_info(unsigned int asicid)
+static void ux500_print_soc_info(struct dbx500_asic_id *id, unsigned int asicid)
 {
-	unsigned int rev = dbx500_revision();
+	unsigned int rev = id->revision;
 
-	pr_info("DB%4x ", dbx500_partnumber());
+	pr_info("DB%4x ", id->partnumber);
 
 	if (rev == 0x01)
 		pr_cont("Early Drop");
@@ -56,11 +35,6 @@ static void ux500_print_soc_info(unsigned int asicid)
 	pr_cont(" [%#010x]\n", asicid);
 }
 
-static unsigned int partnumber(unsigned int asicid)
-{
-	return (asicid >> 8) & 0xffff;
-}
-
 /*
  * SOC		MIDR		ASICID ADDRESS		ASICID VALUE
  * DB8500ed	0x410fc090	0x9001FFF4		0x00850001
@@ -72,11 +46,12 @@ static unsigned int partnumber(unsigned int asicid)
  * DB9540	0x413fc090	0xFFFFDBF4		0x009540xx
  */
 
-void __init ux500_map_io(void)
+void __init ux500_asic_id(struct dbx500_asic_id *id)
 {
 	unsigned int cpuid = read_cpuid_id();
 	unsigned int asicid = 0;
 	phys_addr_t addr = 0;
+	void __iomem *virt;
 
 	switch (cpuid) {
 	case 0x410fc090: /* DB8500ed */
@@ -100,17 +75,17 @@ void __init ux500_map_io(void)
 		break;
 	}
 
-	if (addr)
-		asicid = ux500_read_asicid(addr);
-
-	if (!asicid) {
-		pr_err("Unable to identify SoC\n");
-		ux500_unknown_soc();
+	if (addr) {
+		virt = ioremap(addr, 4)
+		asicid = readl(addr);
+		iounmap(virt);
 	}
 
-	dbx500_id.process = asicid >> 24;
-	dbx500_id.partnumber = partnumber(asicid);
-	dbx500_id.revision = asicid & 0xff;
+	WARN(!asicid, "Unable to identify SoC\n");
+
+	id->process = asicid >> 24;
+	id->partnumber = (asicid >> 8) & 0xffff;
+	id->revision = asicid & 0xff;
 
 	ux500_print_soc_info(asicid);
 }
diff --git a/arch/arm/mach-ux500/id.h b/arch/arm/mach-ux500/id.h
index bcc58a8cccbc..5171ebfe201d 100644
--- a/arch/arm/mach-ux500/id.h
+++ b/arch/arm/mach-ux500/id.h
@@ -20,125 +20,4 @@ struct dbx500_asic_id {
 	u8	process;
 };
 
-extern struct dbx500_asic_id dbx500_id;
-
-static inline unsigned int __attribute_const__ dbx500_partnumber(void)
-{
-	return dbx500_id.partnumber;
-}
-
-static inline unsigned int __attribute_const__ dbx500_revision(void)
-{
-	return dbx500_id.revision;
-}
-
-/*
- * SOCs
- */
-
-static inline bool __attribute_const__ cpu_is_u8500(void)
-{
-	return dbx500_partnumber() == 0x8500;
-}
-
-static inline bool __attribute_const__ cpu_is_u8520(void)
-{
-	return dbx500_partnumber() == 0x8520;
-}
-
-static inline bool cpu_is_u8500_family(void)
-{
-	return cpu_is_u8500() || cpu_is_u8520();
-}
-
-static inline bool __attribute_const__ cpu_is_u9540(void)
-{
-	return dbx500_partnumber() == 0x9540;
-}
-
-static inline bool __attribute_const__ cpu_is_u8540(void)
-{
-	return dbx500_partnumber() == 0x8540;
-}
-
-static inline bool __attribute_const__ cpu_is_u8580(void)
-{
-	return dbx500_partnumber() == 0x8580;
-}
-
-static inline bool cpu_is_ux540_family(void)
-{
-	return cpu_is_u9540() || cpu_is_u8540() || cpu_is_u8580();
-}
-
-/*
- * 8500 revisions
- */
-
-static inline bool __attribute_const__ cpu_is_u8500ed(void)
-{
-	return cpu_is_u8500() && dbx500_revision() == 0x00;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v1(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() & 0xf0) == 0xA0;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v10(void)
-{
-	return cpu_is_u8500() && dbx500_revision() == 0xA0;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v11(void)
-{
-	return cpu_is_u8500() && dbx500_revision() == 0xA1;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v2(void)
-{
-	return cpu_is_u8500() && ((dbx500_revision() & 0xf0) == 0xB0);
-}
-
-static inline bool cpu_is_u8500v20(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() == 0xB0);
-}
-
-static inline bool cpu_is_u8500v21(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() == 0xB1);
-}
-
-static inline bool cpu_is_u8500v22(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() == 0xB2);
-}
-
-static inline bool cpu_is_u8500v20_or_later(void)
-{
-	return (cpu_is_u8500() && !cpu_is_u8500v10() && !cpu_is_u8500v11());
-}
-
-/*
- * 8540 revisions
- */
-
-static inline bool __attribute_const__ cpu_is_u8540v10(void)
-{
-	return cpu_is_u8540() && dbx500_revision() == 0xA0;
-}
-
-static inline bool __attribute_const__ cpu_is_u8580v10(void)
-{
-	return cpu_is_u8580() && dbx500_revision() == 0xA0;
-}
-
-static inline bool ux500_is_svp(void)
-{
-	return false;
-}
-
-#define ux500_unknown_soc()	BUG()
-
 #endif
diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
index 2dea8b59d222..c24004dba2aa 100644
--- a/arch/arm/mach-ux500/setup.h
+++ b/arch/arm/mach-ux500/setup.h
@@ -18,7 +18,8 @@
 
 void ux500_restart(enum reboot_mode mode, const char *cmd);
 
-void __init ux500_map_io(void);
+struct dbx500_asic_id;
+void __init ux500_asic_id(struct dbx500_asic_id *id);
 
 extern void __init ux500_init_irq(void);
 
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
deleted file mode 100644
index ff28d8ad1ed7..000000000000
--- a/arch/arm/mach-ux500/timer.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2011
- *
- * License Terms: GNU General Public License v2
- * Author: Mattias Wallin <mattias.wallin@stericsson.com> for ST-Ericsson
- */
-#include <linux/io.h>
-#include <linux/errno.h>
-#include <linux/clksrc-dbx500-prcmu.h>
-#include <linux/clocksource.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include "setup.h"
-
-#include "db8500-regs.h"
-#include "id.h"
-
-static const struct of_device_id prcmu_timer_of_match[] __initconst = {
-	{ .compatible = "stericsson,db8500-prcmu-timer-4", },
-	{ },
-};
-
-void __init ux500_timer_init(void)
-{
-	void __iomem *prcmu_timer_base;
-	void __iomem *tmp_base;
-	struct device_node *np;
-
-	if (cpu_is_u8500_family() || cpu_is_ux540_family())
-		prcmu_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
-	else
-		ux500_unknown_soc();
-
-	np = of_find_matching_node(NULL, prcmu_timer_of_match);
-	if (!np)
-		goto dt_fail;
-
-	tmp_base = of_iomap(np, 0);
-	if (!tmp_base)
-		goto dt_fail;
-
-	prcmu_timer_base = tmp_base;
-
-dt_fail:
-	clksrc_dbx500_prcmu_init(prcmu_timer_base);
-	clocksource_of_init();
-}
diff --git a/drivers/clk/ux500/Makefile b/drivers/clk/ux500/Makefile
index 521483f0ba33..f3baef29859c 100644
--- a/drivers/clk/ux500/Makefile
+++ b/drivers/clk/ux500/Makefile
@@ -9,7 +9,6 @@ obj-y += clk-sysctrl.o
 
 # Clock definitions
 obj-y += u8500_of_clk.o
-obj-y += u8500_clk.o
 obj-y += u9540_clk.o
 obj-y += u8540_clk.o
 
diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
deleted file mode 100644
index 80069c370a47..000000000000
--- a/drivers/clk/ux500/u8500_clk.c
+++ /dev/null
@@ -1,525 +0,0 @@
-/*
- * Clock definitions for u8500 platform.
- *
- * Copyright (C) 2012 ST-Ericsson SA
- * Author: Ulf Hansson <ulf.hansson@linaro.org>
- *
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include <linux/clk-provider.h>
-#include <linux/mfd/dbx500-prcmu.h>
-#include <linux/platform_data/clk-ux500.h>
-#include "clk.h"
-
-void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
-		    u32 clkrst5_base, u32 clkrst6_base)
-{
-	struct prcmu_fw_version *fw_version;
-	const char *sgaclk_parent = NULL;
-	struct clk *clk;
-
-	/* Clock sources */
-	clk = clk_reg_prcmu_gate("soc0_pll", NULL, PRCMU_PLLSOC0,
-				CLK_IS_ROOT|CLK_IGNORE_UNUSED);
-	clk_register_clkdev(clk, "soc0_pll", NULL);
-
-	clk = clk_reg_prcmu_gate("soc1_pll", NULL, PRCMU_PLLSOC1,
-				CLK_IS_ROOT|CLK_IGNORE_UNUSED);
-	clk_register_clkdev(clk, "soc1_pll", NULL);
-
-	clk = clk_reg_prcmu_gate("ddr_pll", NULL, PRCMU_PLLDDR,
-				CLK_IS_ROOT|CLK_IGNORE_UNUSED);
-	clk_register_clkdev(clk, "ddr_pll", NULL);
-
-	/* FIXME: Add sys, ulp and int clocks here. */
-
-	clk = clk_register_fixed_rate(NULL, "rtc32k", "NULL",
-				CLK_IS_ROOT|CLK_IGNORE_UNUSED,
-				32768);
-	clk_register_clkdev(clk, "clk32k", NULL);
-	clk_register_clkdev(clk, "apb_pclk", "rtc-pl031");
-
-	/* PRCMU clocks */
-	fw_version = prcmu_get_fw_version();
-	if (fw_version != NULL) {
-		switch (fw_version->project) {
-		case PRCMU_FW_PROJECT_U8500_C2:
-		case PRCMU_FW_PROJECT_U8520:
-		case PRCMU_FW_PROJECT_U8420:
-			sgaclk_parent = "soc0_pll";
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (sgaclk_parent)
-		clk = clk_reg_prcmu_gate("sgclk", sgaclk_parent,
-					PRCMU_SGACLK, 0);
-	else
-		clk = clk_reg_prcmu_gate("sgclk", NULL,
-					PRCMU_SGACLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "mali");
-
-	clk = clk_reg_prcmu_gate("uartclk", NULL, PRCMU_UARTCLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "UART");
-
-	clk = clk_reg_prcmu_gate("msp02clk", NULL, PRCMU_MSP02CLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "MSP02");
-
-	clk = clk_reg_prcmu_gate("msp1clk", NULL, PRCMU_MSP1CLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "MSP1");
-
-	clk = clk_reg_prcmu_gate("i2cclk", NULL, PRCMU_I2CCLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "I2C");
-
-	clk = clk_reg_prcmu_gate("slimclk", NULL, PRCMU_SLIMCLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "slim");
-
-	clk = clk_reg_prcmu_gate("per1clk", NULL, PRCMU_PER1CLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "PERIPH1");
-
-	clk = clk_reg_prcmu_gate("per2clk", NULL, PRCMU_PER2CLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "PERIPH2");
-
-	clk = clk_reg_prcmu_gate("per3clk", NULL, PRCMU_PER3CLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "PERIPH3");
-
-	clk = clk_reg_prcmu_gate("per5clk", NULL, PRCMU_PER5CLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "PERIPH5");
-
-	clk = clk_reg_prcmu_gate("per6clk", NULL, PRCMU_PER6CLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "PERIPH6");
-
-	clk = clk_reg_prcmu_gate("per7clk", NULL, PRCMU_PER7CLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "PERIPH7");
-
-	clk = clk_reg_prcmu_scalable("lcdclk", NULL, PRCMU_LCDCLK, 0,
-				CLK_IS_ROOT|CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "lcd");
-	clk_register_clkdev(clk, "lcd", "mcde");
-
-	clk = clk_reg_prcmu_opp_gate("bmlclk", NULL, PRCMU_BMLCLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "bml");
-
-	clk = clk_reg_prcmu_scalable("hsitxclk", NULL, PRCMU_HSITXCLK, 0,
-				CLK_IS_ROOT|CLK_SET_RATE_GATE);
-
-	clk = clk_reg_prcmu_scalable("hsirxclk", NULL, PRCMU_HSIRXCLK, 0,
-				CLK_IS_ROOT|CLK_SET_RATE_GATE);
-
-	clk = clk_reg_prcmu_scalable("hdmiclk", NULL, PRCMU_HDMICLK, 0,
-				CLK_IS_ROOT|CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "hdmi");
-	clk_register_clkdev(clk, "hdmi", "mcde");
-
-	clk = clk_reg_prcmu_gate("apeatclk", NULL, PRCMU_APEATCLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "apeat");
-
-	clk = clk_reg_prcmu_gate("apetraceclk", NULL, PRCMU_APETRACECLK,
-				CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "apetrace");
-
-	clk = clk_reg_prcmu_gate("mcdeclk", NULL, PRCMU_MCDECLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "mcde");
-	clk_register_clkdev(clk, "mcde", "mcde");
-	clk_register_clkdev(clk, "dsisys", "dsilink.0");
-	clk_register_clkdev(clk, "dsisys", "dsilink.1");
-	clk_register_clkdev(clk, "dsisys", "dsilink.2");
-
-	clk = clk_reg_prcmu_opp_gate("ipi2cclk", NULL, PRCMU_IPI2CCLK,
-				CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "ipi2");
-
-	clk = clk_reg_prcmu_gate("dsialtclk", NULL, PRCMU_DSIALTCLK,
-				CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "dsialt");
-
-	clk = clk_reg_prcmu_gate("dmaclk", NULL, PRCMU_DMACLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "dma40.0");
-
-	clk = clk_reg_prcmu_gate("b2r2clk", NULL, PRCMU_B2R2CLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "b2r2");
-	clk_register_clkdev(clk, NULL, "b2r2_core");
-	clk_register_clkdev(clk, NULL, "U8500-B2R2.0");
-
-	clk = clk_reg_prcmu_scalable("tvclk", NULL, PRCMU_TVCLK, 0,
-				CLK_IS_ROOT|CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "tv");
-	clk_register_clkdev(clk, "tv", "mcde");
-
-	clk = clk_reg_prcmu_gate("sspclk", NULL, PRCMU_SSPCLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "SSP");
-
-	clk = clk_reg_prcmu_gate("rngclk", NULL, PRCMU_RNGCLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "rngclk");
-
-	clk = clk_reg_prcmu_gate("uiccclk", NULL, PRCMU_UICCCLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "uicc");
-
-	clk = clk_reg_prcmu_gate("timclk", NULL, PRCMU_TIMCLK, CLK_IS_ROOT);
-	clk_register_clkdev(clk, NULL, "mtu0");
-	clk_register_clkdev(clk, NULL, "mtu1");
-
-	clk = clk_reg_prcmu_opp_volt_scalable("sdmmcclk", NULL, PRCMU_SDMMCCLK,
-					100000000,
-					CLK_IS_ROOT|CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "sdmmc");
-
-	clk = clk_reg_prcmu_scalable("dsi_pll", "hdmiclk",
-				PRCMU_PLLDSI, 0, CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, "dsihs2", "mcde");
-	clk_register_clkdev(clk, "dsihs2", "dsilink.2");
-
-
-	clk = clk_reg_prcmu_scalable("dsi0clk", "dsi_pll",
-				PRCMU_DSI0CLK, 0, CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, "dsihs0", "mcde");
-	clk_register_clkdev(clk, "dsihs0", "dsilink.0");
-
-	clk = clk_reg_prcmu_scalable("dsi1clk", "dsi_pll",
-				PRCMU_DSI1CLK, 0, CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, "dsihs1", "mcde");
-	clk_register_clkdev(clk, "dsihs1", "dsilink.1");
-
-	clk = clk_reg_prcmu_scalable("dsi0escclk", "tvclk",
-				PRCMU_DSI0ESCCLK, 0, CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, "dsilp0", "dsilink.0");
-	clk_register_clkdev(clk, "dsilp0", "mcde");
-
-	clk = clk_reg_prcmu_scalable("dsi1escclk", "tvclk",
-				PRCMU_DSI1ESCCLK, 0, CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, "dsilp1", "dsilink.1");
-	clk_register_clkdev(clk, "dsilp1", "mcde");
-
-	clk = clk_reg_prcmu_scalable("dsi2escclk", "tvclk",
-				PRCMU_DSI2ESCCLK, 0, CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, "dsilp2", "dsilink.2");
-	clk_register_clkdev(clk, "dsilp2", "mcde");
-
-	clk = clk_reg_prcmu_scalable_rate("armss", NULL,
-				PRCMU_ARMSS, 0, CLK_IS_ROOT|CLK_IGNORE_UNUSED);
-	clk_register_clkdev(clk, "armss", NULL);
-
-	clk = clk_register_fixed_factor(NULL, "smp_twd", "armss",
-				CLK_IGNORE_UNUSED, 1, 2);
-	clk_register_clkdev(clk, NULL, "smp_twd");
-
-	/*
-	 * FIXME: Add special handled PRCMU clocks here:
-	 * 1. clkout0yuv, use PRCMU as parent + need regulator + pinctrl.
-	 * 2. ab9540_clkout1yuv, see clkout0yuv
-	 */
-
-	/* PRCC P-clocks */
-	clk = clk_reg_prcc_pclk("p1_pclk0", "per1clk", clkrst1_base,
-				BIT(0), 0);
-	clk_register_clkdev(clk, "apb_pclk", "uart0");
-
-	clk = clk_reg_prcc_pclk("p1_pclk1", "per1clk", clkrst1_base,
-				BIT(1), 0);
-	clk_register_clkdev(clk, "apb_pclk", "uart1");
-
-	clk = clk_reg_prcc_pclk("p1_pclk2", "per1clk", clkrst1_base,
-				BIT(2), 0);
-	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.1");
-
-	clk = clk_reg_prcc_pclk("p1_pclk3", "per1clk", clkrst1_base,
-				BIT(3), 0);
-	clk_register_clkdev(clk, "apb_pclk", "msp0");
-	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.0");
-
-	clk = clk_reg_prcc_pclk("p1_pclk4", "per1clk", clkrst1_base,
-				BIT(4), 0);
-	clk_register_clkdev(clk, "apb_pclk", "msp1");
-	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.1");
-
-	clk = clk_reg_prcc_pclk("p1_pclk5", "per1clk", clkrst1_base,
-				BIT(5), 0);
-	clk_register_clkdev(clk, "apb_pclk", "sdi0");
-
-	clk = clk_reg_prcc_pclk("p1_pclk6", "per1clk", clkrst1_base,
-				BIT(6), 0);
-	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.2");
-
-	clk = clk_reg_prcc_pclk("p1_pclk7", "per1clk", clkrst1_base,
-				BIT(7), 0);
-	clk_register_clkdev(clk, NULL, "spi3");
-
-	clk = clk_reg_prcc_pclk("p1_pclk8", "per1clk", clkrst1_base,
-				BIT(8), 0);
-	clk_register_clkdev(clk, "apb_pclk", "slimbus0");
-
-	clk = clk_reg_prcc_pclk("p1_pclk9", "per1clk", clkrst1_base,
-				BIT(9), 0);
-	clk_register_clkdev(clk, NULL, "gpio.0");
-	clk_register_clkdev(clk, NULL, "gpio.1");
-	clk_register_clkdev(clk, NULL, "gpioblock0");
-
-	clk = clk_reg_prcc_pclk("p1_pclk10", "per1clk", clkrst1_base,
-				BIT(10), 0);
-	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.4");
-
-	clk = clk_reg_prcc_pclk("p1_pclk11", "per1clk", clkrst1_base,
-				BIT(11), 0);
-	clk_register_clkdev(clk, "apb_pclk", "msp3");
-	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.3");
-
-	clk = clk_reg_prcc_pclk("p2_pclk0", "per2clk", clkrst2_base,
-				BIT(0), 0);
-	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.3");
-
-	clk = clk_reg_prcc_pclk("p2_pclk1", "per2clk", clkrst2_base,
-				BIT(1), 0);
-	clk_register_clkdev(clk, NULL, "spi2");
-
-	clk = clk_reg_prcc_pclk("p2_pclk2", "per2clk", clkrst2_base,
-				BIT(2), 0);
-	clk_register_clkdev(clk, NULL, "spi1");
-
-	clk = clk_reg_prcc_pclk("p2_pclk3", "per2clk", clkrst2_base,
-				BIT(3), 0);
-	clk_register_clkdev(clk, NULL, "pwl");
-
-	clk = clk_reg_prcc_pclk("p2_pclk4", "per2clk", clkrst2_base,
-				BIT(4), 0);
-	clk_register_clkdev(clk, "apb_pclk", "sdi4");
-
-	clk = clk_reg_prcc_pclk("p2_pclk5", "per2clk", clkrst2_base,
-				BIT(5), 0);
-	clk_register_clkdev(clk, "apb_pclk", "msp2");
-	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.2");
-
-	clk = clk_reg_prcc_pclk("p2_pclk6", "per2clk", clkrst2_base,
-				BIT(6), 0);
-	clk_register_clkdev(clk, "apb_pclk", "sdi1");
-
-	clk = clk_reg_prcc_pclk("p2_pclk7", "per2clk", clkrst2_base,
-				BIT(7), 0);
-	clk_register_clkdev(clk, "apb_pclk", "sdi3");
-
-	clk = clk_reg_prcc_pclk("p2_pclk8", "per2clk", clkrst2_base,
-				BIT(8), 0);
-	clk_register_clkdev(clk, NULL, "spi0");
-
-	clk = clk_reg_prcc_pclk("p2_pclk9", "per2clk", clkrst2_base,
-				BIT(9), 0);
-	clk_register_clkdev(clk, "hsir_hclk", "ste_hsi.0");
-
-	clk = clk_reg_prcc_pclk("p2_pclk10", "per2clk", clkrst2_base,
-				BIT(10), 0);
-	clk_register_clkdev(clk, "hsit_hclk", "ste_hsi.0");
-
-	clk = clk_reg_prcc_pclk("p2_pclk11", "per2clk", clkrst2_base,
-				BIT(11), 0);
-	clk_register_clkdev(clk, NULL, "gpio.6");
-	clk_register_clkdev(clk, NULL, "gpio.7");
-	clk_register_clkdev(clk, NULL, "gpioblock1");
-
-	clk = clk_reg_prcc_pclk("p2_pclk12", "per2clk", clkrst2_base,
-				BIT(12), 0);
-
-	clk = clk_reg_prcc_pclk("p3_pclk0", "per3clk", clkrst3_base,
-				BIT(0), 0);
-	clk_register_clkdev(clk, "fsmc", NULL);
-	clk_register_clkdev(clk, NULL, "smsc911x.0");
-
-	clk = clk_reg_prcc_pclk("p3_pclk1", "per3clk", clkrst3_base,
-				BIT(1), 0);
-	clk_register_clkdev(clk, "apb_pclk", "ssp0");
-
-	clk = clk_reg_prcc_pclk("p3_pclk2", "per3clk", clkrst3_base,
-				BIT(2), 0);
-	clk_register_clkdev(clk, "apb_pclk", "ssp1");
-
-	clk = clk_reg_prcc_pclk("p3_pclk3", "per3clk", clkrst3_base,
-				BIT(3), 0);
-	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.0");
-
-	clk = clk_reg_prcc_pclk("p3_pclk4", "per3clk", clkrst3_base,
-				BIT(4), 0);
-	clk_register_clkdev(clk, "apb_pclk", "sdi2");
-
-	clk = clk_reg_prcc_pclk("p3_pclk5", "per3clk", clkrst3_base,
-				BIT(5), 0);
-	clk_register_clkdev(clk, "apb_pclk", "ske");
-	clk_register_clkdev(clk, "apb_pclk", "nmk-ske-keypad");
-
-	clk = clk_reg_prcc_pclk("p3_pclk6", "per3clk", clkrst3_base,
-				BIT(6), 0);
-	clk_register_clkdev(clk, "apb_pclk", "uart2");
-
-	clk = clk_reg_prcc_pclk("p3_pclk7", "per3clk", clkrst3_base,
-				BIT(7), 0);
-	clk_register_clkdev(clk, "apb_pclk", "sdi5");
-
-	clk = clk_reg_prcc_pclk("p3_pclk8", "per3clk", clkrst3_base,
-				BIT(8), 0);
-	clk_register_clkdev(clk, NULL, "gpio.2");
-	clk_register_clkdev(clk, NULL, "gpio.3");
-	clk_register_clkdev(clk, NULL, "gpio.4");
-	clk_register_clkdev(clk, NULL, "gpio.5");
-	clk_register_clkdev(clk, NULL, "gpioblock2");
-
-	clk = clk_reg_prcc_pclk("p5_pclk0", "per5clk", clkrst5_base,
-				BIT(0), 0);
-	clk_register_clkdev(clk, "usb", "musb-ux500.0");
-
-	clk = clk_reg_prcc_pclk("p5_pclk1", "per5clk", clkrst5_base,
-				BIT(1), 0);
-	clk_register_clkdev(clk, NULL, "gpio.8");
-	clk_register_clkdev(clk, NULL, "gpioblock3");
-
-	clk = clk_reg_prcc_pclk("p6_pclk0", "per6clk", clkrst6_base,
-				BIT(0), 0);
-	clk_register_clkdev(clk, "apb_pclk", "rng");
-
-	clk = clk_reg_prcc_pclk("p6_pclk1", "per6clk", clkrst6_base,
-				BIT(1), 0);
-	clk_register_clkdev(clk, NULL, "cryp0");
-	clk_register_clkdev(clk, NULL, "cryp1");
-
-	clk = clk_reg_prcc_pclk("p6_pclk2", "per6clk", clkrst6_base,
-				BIT(2), 0);
-	clk_register_clkdev(clk, NULL, "hash0");
-
-	clk = clk_reg_prcc_pclk("p6_pclk3", "per6clk", clkrst6_base,
-				BIT(3), 0);
-	clk_register_clkdev(clk, NULL, "pka");
-
-	clk = clk_reg_prcc_pclk("p6_pclk4", "per6clk", clkrst6_base,
-				BIT(4), 0);
-	clk_register_clkdev(clk, NULL, "hash1");
-
-	clk = clk_reg_prcc_pclk("p6_pclk5", "per6clk", clkrst6_base,
-				BIT(5), 0);
-	clk_register_clkdev(clk, NULL, "cfgreg");
-
-	clk = clk_reg_prcc_pclk("p6_pclk6", "per6clk", clkrst6_base,
-				BIT(6), 0);
-	clk_register_clkdev(clk, "apb_pclk", "mtu0");
-
-	clk = clk_reg_prcc_pclk("p6_pclk7", "per6clk", clkrst6_base,
-				BIT(7), 0);
-	clk_register_clkdev(clk, "apb_pclk", "mtu1");
-
-	/* PRCC K-clocks
-	 *
-	 * FIXME: Some drivers requires PERPIH[n| to be automatically enabled
-	 * by enabling just the K-clock, even if it is not a valid parent to
-	 * the K-clock. Until drivers get fixed we might need some kind of
-	 * "parent muxed join".
-	 */
-
-	/* Periph1 */
-	clk = clk_reg_prcc_kclk("p1_uart0_kclk", "uartclk",
-			clkrst1_base, BIT(0), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "uart0");
-
-	clk = clk_reg_prcc_kclk("p1_uart1_kclk", "uartclk",
-			clkrst1_base, BIT(1), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "uart1");
-
-	clk = clk_reg_prcc_kclk("p1_i2c1_kclk", "i2cclk",
-			clkrst1_base, BIT(2), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "nmk-i2c.1");
-
-	clk = clk_reg_prcc_kclk("p1_msp0_kclk", "msp02clk",
-			clkrst1_base, BIT(3), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "msp0");
-	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.0");
-
-	clk = clk_reg_prcc_kclk("p1_msp1_kclk", "msp1clk",
-			clkrst1_base, BIT(4), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "msp1");
-	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.1");
-
-	clk = clk_reg_prcc_kclk("p1_sdi0_kclk", "sdmmcclk",
-			clkrst1_base, BIT(5), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "sdi0");
-
-	clk = clk_reg_prcc_kclk("p1_i2c2_kclk", "i2cclk",
-			clkrst1_base, BIT(6), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "nmk-i2c.2");
-
-	clk = clk_reg_prcc_kclk("p1_slimbus0_kclk", "slimclk",
-			clkrst1_base, BIT(8), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "slimbus0");
-
-	clk = clk_reg_prcc_kclk("p1_i2c4_kclk", "i2cclk",
-			clkrst1_base, BIT(9), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "nmk-i2c.4");
-
-	clk = clk_reg_prcc_kclk("p1_msp3_kclk", "msp1clk",
-			clkrst1_base, BIT(10), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "msp3");
-	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.3");
-
-	/* Periph2 */
-	clk = clk_reg_prcc_kclk("p2_i2c3_kclk", "i2cclk",
-			clkrst2_base, BIT(0), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "nmk-i2c.3");
-
-	clk = clk_reg_prcc_kclk("p2_sdi4_kclk", "sdmmcclk",
-			clkrst2_base, BIT(2), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "sdi4");
-
-	clk = clk_reg_prcc_kclk("p2_msp2_kclk", "msp02clk",
-			clkrst2_base, BIT(3), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "msp2");
-	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.2");
-
-	clk = clk_reg_prcc_kclk("p2_sdi1_kclk", "sdmmcclk",
-			clkrst2_base, BIT(4), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "sdi1");
-
-	clk = clk_reg_prcc_kclk("p2_sdi3_kclk", "sdmmcclk",
-			clkrst2_base, BIT(5), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "sdi3");
-
-	/* Note that rate is received from parent. */
-	clk = clk_reg_prcc_kclk("p2_ssirx_kclk", "hsirxclk",
-			clkrst2_base, BIT(6),
-			CLK_SET_RATE_GATE|CLK_SET_RATE_PARENT);
-	clk = clk_reg_prcc_kclk("p2_ssitx_kclk", "hsitxclk",
-			clkrst2_base, BIT(7),
-			CLK_SET_RATE_GATE|CLK_SET_RATE_PARENT);
-
-	/* Periph3 */
-	clk = clk_reg_prcc_kclk("p3_ssp0_kclk", "sspclk",
-			clkrst3_base, BIT(1), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "ssp0");
-
-	clk = clk_reg_prcc_kclk("p3_ssp1_kclk", "sspclk",
-			clkrst3_base, BIT(2), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "ssp1");
-
-	clk = clk_reg_prcc_kclk("p3_i2c0_kclk", "i2cclk",
-			clkrst3_base, BIT(3), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "nmk-i2c.0");
-
-	clk = clk_reg_prcc_kclk("p3_sdi2_kclk", "sdmmcclk",
-			clkrst3_base, BIT(4), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "sdi2");
-
-	clk = clk_reg_prcc_kclk("p3_ske_kclk", "rtc32k",
-			clkrst3_base, BIT(5), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "ske");
-	clk_register_clkdev(clk, NULL, "nmk-ske-keypad");
-
-	clk = clk_reg_prcc_kclk("p3_uart2_kclk", "uartclk",
-			clkrst3_base, BIT(6), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "uart2");
-
-	clk = clk_reg_prcc_kclk("p3_sdi5_kclk", "sdmmcclk",
-			clkrst3_base, BIT(7), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "sdi5");
-
-	/* Periph6 */
-	clk = clk_reg_prcc_kclk("p3_rng_kclk", "rngclk",
-			clkrst6_base, BIT(0), CLK_SET_RATE_GATE);
-	clk_register_clkdev(clk, NULL, "rng");
-}
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index b375106844d8..76b12750d449 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -63,9 +63,9 @@ static u64 notrace dbx500_prcmu_sched_clock_read(void)
 
 #endif
 
-void __init clksrc_dbx500_prcmu_init(void __iomem *base)
+static void __init clksrc_dbx500_prcmu_init(struct device_node *node)
 {
-	clksrc_dbx500_timer_base = base;
+	clksrc_dbx500_timer_base = of_iomap(node, 0);
 
 	/*
 	 * The A9 sub system expects the timer to be configured as
@@ -85,3 +85,5 @@ void __init clksrc_dbx500_prcmu_init(void __iomem *base)
 #endif
 	clocksource_register_hz(&clocksource_dbx500_prcmu, RATE_32K);
 }
+
+CLOCKSOURCE_OF_DECLARE(dbx500_prcmu, "stericsson,db8500-prcmu-timer-4", clksrc_dbx500_prcmu_init);
diff --git a/include/linux/platform_data/clk-ux500.h b/include/linux/platform_data/clk-ux500.h
index 97baf831e071..68afd8b6950b 100644
--- a/include/linux/platform_data/clk-ux500.h
+++ b/include/linux/platform_data/clk-ux500.h
@@ -12,9 +12,6 @@
 
 void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 		       u32 clkrst5_base, u32 clkrst6_base);
-
-void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
-		    u32 clkrst5_base, u32 clkrst6_base);
 void u9540_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 		    u32 clkrst5_base, u32 clkrst6_base);
 void u8540_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
