From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 6 Aug 2012 18:32:08 +0200
Subject: [PATCH] clk: convert ARM RealView to common clk
Message-ID: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This converts the ARM RealView machine over to using the common
clock. The approach is similar to the one used for the Integrator,
and we're reusing the ICST wrapper code.

We have to put the clock intialization in the timer init function
for the clocks to be available when initializing the timer,
keeping them in early_init() is too early for the common clk.

Since we now have to go down and compile drivers/clk/versatile
a CONFIG_COMMON_CLK_VERSATILE symbol has been added so the proper
code gets compiled into the kernel for either machine. A leftover
CLK_VERSATILE in the Integrator Kconfig was fixed up to use
the new symbol as well.

Tested on ARM RealView PB1176.

Cc: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                             |   7 +-
 arch/arm/mach-realview/core.c                | 106 -------------------------
 arch/arm/mach-realview/include/mach/clkdev.h |  16 ----
 arch/arm/mach-realview/realview_eb.c         |   2 +
 arch/arm/mach-realview/realview_pb1176.c     |   2 +
 arch/arm/mach-realview/realview_pb11mp.c     |   2 +
 arch/arm/mach-realview/realview_pba8.c       |   2 +
 arch/arm/mach-realview/realview_pbx.c        |   2 +
 drivers/clk/Kconfig                          |   7 ++
 drivers/clk/Makefile                         |   2 +-
 drivers/clk/versatile/Makefile               |   1 +
 drivers/clk/versatile/clk-realview.c         | 114 +++++++++++++++++++++++++++
 include/linux/platform_data/clk-realview.h   |   1 +
 13 files changed, 137 insertions(+), 127 deletions(-)
 delete mode 100644 arch/arm/mach-realview/include/mach/clkdev.h
 create mode 100644 drivers/clk/versatile/clk-realview.c
 create mode 100644 include/linux/platform_data/clk-realview.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..530630c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -279,7 +279,7 @@ config ARCH_INTEGRATOR
 	select ARM_AMBA
 	select ARCH_HAS_CPUFREQ
 	select COMMON_CLK
-	select CLK_VERSATILE
+	select COMMON_CLK_VERSATILE
 	select HAVE_TCM
 	select ICST
 	select GENERIC_CLOCKEVENTS
@@ -295,13 +295,12 @@ config ARCH_INTEGRATOR
 config ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
 	select ARM_AMBA
-	select CLKDEV_LOOKUP
-	select HAVE_MACH_CLKDEV
+	select COMMON_CLK
+	select COMMON_CLK_VERSATILE
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLOCK
 	select PLAT_VERSATILE_CLCD
 	select ARM_TIMER_SP804
 	select GPIO_PL061 if GPIOLIB
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 45868bb..ff007d1 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -30,7 +30,6 @@
 #include <linux/ata_platform.h>
 #include <linux/amba/mmci.h>
 #include <linux/gfp.h>
-#include <linux/clkdev.h>
 #include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
@@ -226,115 +225,10 @@ struct mmci_platform_data realview_mmc1_plat_data = {
 	.cd_invert	= true,
 };
 
-/*
- * Clock handling
- */
-static const struct icst_params realview_oscvco_params = {
-	.ref		= 24000000,
-	.vco_max	= ICST307_VCO_MAX,
-	.vco_min	= ICST307_VCO_MIN,
-	.vd_min		= 4 + 8,
-	.vd_max		= 511 + 8,
-	.rd_min		= 1 + 2,
-	.rd_max		= 127 + 2,
-	.s2div		= icst307_s2div,
-	.idx2s		= icst307_idx2s,
-};
-
-static void realview_oscvco_set(struct clk *clk, struct icst_vco vco)
-{
-	void __iomem *sys_lock = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_LOCK_OFFSET;
-	u32 val;
-
-	val = readl(clk->vcoreg) & ~0x7ffff;
-	val |= vco.v | (vco.r << 9) | (vco.s << 16);
-
-	writel(0xa05f, sys_lock);
-	writel(val, clk->vcoreg);
-	writel(0, sys_lock);
-}
-
-static const struct clk_ops oscvco_clk_ops = {
-	.round	= icst_clk_round,
-	.set	= icst_clk_set,
-	.setvco	= realview_oscvco_set,
-};
-
-static struct clk oscvco_clk = {
-	.ops	= &oscvco_clk_ops,
-	.params	= &realview_oscvco_params,
-};
-
-/*
- * These are fixed clocks.
- */
-static struct clk ref24_clk = {
-	.rate	= 24000000,
-};
-
-static struct clk sp804_clk = {
-	.rate	= 1000000,
-};
-
-static struct clk dummy_apb_pclk;
-
-static struct clk_lookup lookups[] = {
-	{	/* Bus clock */
-		.con_id		= "apb_pclk",
-		.clk		= &dummy_apb_pclk,
-	}, {	/* UART0 */
-		.dev_id		= "dev:uart0",
-		.clk		= &ref24_clk,
-	}, {	/* UART1 */
-		.dev_id		= "dev:uart1",
-		.clk		= &ref24_clk,
-	}, {	/* UART2 */
-		.dev_id		= "dev:uart2",
-		.clk		= &ref24_clk,
-	}, {	/* UART3 */
-		.dev_id		= "fpga:uart3",
-		.clk		= &ref24_clk,
-	}, {	/* UART3 is on the dev chip in PB1176 */
-		.dev_id		= "dev:uart3",
-		.clk		= &ref24_clk,
-	}, {	/* UART4 only exists in PB1176 */
-		.dev_id		= "fpga:uart4",
-		.clk		= &ref24_clk,
-	}, {	/* KMI0 */
-		.dev_id		= "fpga:kmi0",
-		.clk		= &ref24_clk,
-	}, {	/* KMI1 */
-		.dev_id		= "fpga:kmi1",
-		.clk		= &ref24_clk,
-	}, {	/* MMC0 */
-		.dev_id		= "fpga:mmc0",
-		.clk		= &ref24_clk,
-	}, {	/* CLCD is in the PB1176 and EB DevChip */
-		.dev_id		= "dev:clcd",
-		.clk		= &oscvco_clk,
-	}, {	/* PB:CLCD */
-		.dev_id		= "issp:clcd",
-		.clk		= &oscvco_clk,
-	}, {	/* SSP */
-		.dev_id		= "dev:ssp0",
-		.clk		= &ref24_clk,
-	}, {	/* SP804 timers */
-		.dev_id		= "sp804",
-		.clk		= &sp804_clk,
-	},
-};
-
 void __init realview_init_early(void)
 {
 	void __iomem *sys = __io_address(REALVIEW_SYS_BASE);
 
-	if (machine_is_realview_pb1176())
-		oscvco_clk.vcoreg = sys + REALVIEW_SYS_OSC0_OFFSET;
-	else
-		oscvco_clk.vcoreg = sys + REALVIEW_SYS_OSC4_OFFSET;
-
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
 	versatile_sched_clock_init(sys + REALVIEW_SYS_24MHz_OFFSET, 24000000);
 }
 
diff --git a/arch/arm/mach-realview/include/mach/clkdev.h b/arch/arm/mach-realview/include/mach/clkdev.h
deleted file mode 100644
index e58d077..0000000
--- a/arch/arm/mach-realview/include/mach/clkdev.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#include <plat/clock.h>
-
-struct clk {
-	unsigned long		rate;
-	const struct clk_ops	*ops;
-	const struct icst_params *params;
-	void __iomem		*vcoreg;
-};
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index baf382c..a33e33b 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -27,6 +27,7 @@
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
+#include <linux/platform_data/clk-realview.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -414,6 +415,7 @@ static void __init realview_eb_timer_init(void)
 	else
 		timer_irq = IRQ_EB_TIMER0_1;
 
+	realview_clk_init(__io_address(REALVIEW_SYS_BASE), false);
 	realview_timer_init(timer_irq);
 	realview_eb_twd_init();
 }
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index b1d7caf..f0298cb 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -29,6 +29,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
+#include <linux/platform_data/clk-realview.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -326,6 +327,7 @@ static void __init realview_pb1176_timer_init(void)
 	timer2_va_base = __io_address(REALVIEW_PB1176_TIMER2_3_BASE);
 	timer3_va_base = __io_address(REALVIEW_PB1176_TIMER2_3_BASE) + 0x20;
 
+	realview_clk_init(__io_address(REALVIEW_SYS_BASE), true);
 	realview_timer_init(IRQ_DC1176_TIMER0);
 }
 
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index a98c536..1f019f7 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -27,6 +27,7 @@
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
+#include <linux/platform_data/clk-realview.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -312,6 +313,7 @@ static void __init realview_pb11mp_timer_init(void)
 	timer2_va_base = __io_address(REALVIEW_PB11MP_TIMER2_3_BASE);
 	timer3_va_base = __io_address(REALVIEW_PB11MP_TIMER2_3_BASE) + 0x20;
 
+	realview_clk_init(__io_address(REALVIEW_SYS_BASE), false);
 	realview_timer_init(IRQ_TC11MP_TIMER0_1);
 	realview_pb11mp_twd_init();
 }
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 5965017..5032775 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -27,6 +27,7 @@
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
+#include <linux/platform_data/clk-realview.h>
 
 #include <asm/irq.h>
 #include <asm/leds.h>
@@ -261,6 +262,7 @@ static void __init realview_pba8_timer_init(void)
 	timer2_va_base = __io_address(REALVIEW_PBA8_TIMER2_3_BASE);
 	timer3_va_base = __io_address(REALVIEW_PBA8_TIMER2_3_BASE) + 0x20;
 
+	realview_clk_init(__io_address(REALVIEW_SYS_BASE), false);
 	realview_timer_init(IRQ_PBA8_TIMER0_1);
 }
 
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 3f2f605..de64ba0 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -26,6 +26,7 @@
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
+#include <linux/platform_data/clk-realview.h>
 
 #include <asm/irq.h>
 #include <asm/leds.h>
@@ -320,6 +321,7 @@ static void __init realview_pbx_timer_init(void)
 	timer2_va_base = __io_address(REALVIEW_PBX_TIMER2_3_BASE);
 	timer3_va_base = __io_address(REALVIEW_PBX_TIMER2_3_BASE) + 0x20;
 
+	realview_clk_init(__io_address(REALVIEW_SYS_BASE), false);
 	realview_timer_init(IRQ_PBX_TIMER0_1);
 	realview_pbx_twd_init();
 }
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 7f0b5ca..89b726d 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -40,4 +40,11 @@ config COMMON_CLK_WM831X
           Supports the clocking subsystem of the WM831x/2x series of
 	  PMICs from Wolfson Microlectronics.
 
+config COMMON_CLK_VERSATILE
+	tristate "Clock driver for ARM Reference designs"
+	depends on ARCH_INTEGRATOR || ARCH_REALVIEW
+	---help---
+          Supports clocking on ARM Reference designs Integrator/AP,
+	  Integrator/CP, RealView PB1176, EB, PB11MP and PBX.
+
 endmenu
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5869ea3..cfa7eeb 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_ARCH_MXS)		+= mxs/
 obj-$(CONFIG_ARCH_SOCFPGA)	+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
-obj-$(CONFIG_ARCH_INTEGRATOR)	+= versatile/
+obj-$(CONFIG_COMMON_CLK_VERSATILE) += versatile/
 
 # Chip specific
 obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
diff --git a/drivers/clk/versatile/Makefile b/drivers/clk/versatile/Makefile
index 50cf6a2..c0a0f64 100644
--- a/drivers/clk/versatile/Makefile
+++ b/drivers/clk/versatile/Makefile
@@ -1,3 +1,4 @@
 # Makefile for Versatile-specific clocks
 obj-$(CONFIG_ICST)		+= clk-icst.o
 obj-$(CONFIG_ARCH_INTEGRATOR)	+= clk-integrator.o
+obj-$(CONFIG_ARCH_REALVIEW)	+= clk-realview.o
diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
new file mode 100644
index 0000000..e21a99c
--- /dev/null
+++ b/drivers/clk/versatile/clk-realview.c
@@ -0,0 +1,114 @@
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+
+#include <mach/hardware.h>
+#include <mach/platform.h>
+
+#include "clk-icst.h"
+
+/*
+ * Implementation of the ARM RealView clock trees.
+ */
+
+static void __iomem *sys_lock;
+static void __iomem *sys_vcoreg;
+
+/**
+ * realview_oscvco_get() - get ICST OSC settings for the RealView
+ */
+static struct icst_vco realview_oscvco_get(void)
+{
+	u32 val;
+	struct icst_vco vco;
+
+	val = readl(sys_vcoreg);
+	vco.v = val & 0x1ff;
+	vco.r = (val >> 9) & 0x7f;
+	vco.s = (val >> 16) & 03;
+	return vco;
+}
+
+static void realview_oscvco_set(struct icst_vco vco)
+{
+	u32 val;
+
+	val = readl(sys_vcoreg) & ~0x7ffff;
+	val |= vco.v | (vco.r << 9) | (vco.s << 16);
+
+	/* This magic unlocks the CM VCO so it can be controlled */
+	writel(0xa05f, sys_lock);
+	writel(val, sys_vcoreg);
+	/* This locks the CM again */
+	writel(0, sys_lock);
+}
+
+static const struct icst_params realview_oscvco_params = {
+	.ref		= 24000000,
+	.vco_max	= ICST307_VCO_MAX,
+	.vco_min	= ICST307_VCO_MIN,
+	.vd_min		= 4 + 8,
+	.vd_max		= 511 + 8,
+	.rd_min		= 1 + 2,
+	.rd_max		= 127 + 2,
+	.s2div		= icst307_s2div,
+	.idx2s		= icst307_idx2s,
+};
+
+static const struct clk_icst_desc __initdata realview_icst_desc = {
+	.params = &realview_oscvco_params,
+	.getvco = realview_oscvco_get,
+	.setvco = realview_oscvco_set,
+};
+
+/*
+ * realview_clk_init() - set up the RealView clock tree
+ */
+void __init realview_clk_init(void __iomem *sysbase, bool is_pb1176)
+{
+	struct clk *clk;
+
+	sys_lock = sysbase + REALVIEW_SYS_LOCK_OFFSET;
+	if (is_pb1176)
+		sys_vcoreg = sysbase + REALVIEW_SYS_OSC0_OFFSET;
+	else
+		sys_vcoreg = sysbase + REALVIEW_SYS_OSC4_OFFSET;
+
+
+	/* APB clock dummy */
+	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
+	clk_register_clkdev(clk, "apb_pclk", NULL);
+
+	/* 24 MHz clock */
+	clk = clk_register_fixed_rate(NULL, "clk24mhz", NULL, CLK_IS_ROOT,
+				24000000);
+	clk_register_clkdev(clk, NULL, "dev:uart0");
+	clk_register_clkdev(clk, NULL, "dev:uart1");
+	clk_register_clkdev(clk, NULL, "dev:uart2");
+	clk_register_clkdev(clk, NULL, "fpga:kmi0");
+	clk_register_clkdev(clk, NULL, "fpga:kmi1");
+	clk_register_clkdev(clk, NULL, "fpga:mmc0");
+	clk_register_clkdev(clk, NULL, "dev:ssp0");
+	if (is_pb1176) {
+		/*
+		 * UART3 is on the dev chip in PB1176
+		 * UART4 only exists in PB1176
+		 */
+		clk_register_clkdev(clk, NULL, "dev:uart3");
+		clk_register_clkdev(clk, NULL, "dev:uart4");
+	} else
+		clk_register_clkdev(clk, NULL, "fpga:uart3");
+
+
+	/* 1 MHz clock */
+	clk = clk_register_fixed_rate(NULL, "clk1mhz", NULL, CLK_IS_ROOT,
+				      1000000);
+	clk_register_clkdev(clk, NULL, "sp804");
+
+	/* ICST VCO clock */
+	clk = icst_clk_register(NULL, &realview_icst_desc);
+	clk_register_clkdev(clk, NULL, "dev:clcd");
+	clk_register_clkdev(clk, NULL, "issp:clcd");
+}
diff --git a/include/linux/platform_data/clk-realview.h b/include/linux/platform_data/clk-realview.h
new file mode 100644
index 0000000..2e426a7
--- /dev/null
+++ b/include/linux/platform_data/clk-realview.h
@@ -0,0 +1 @@
+void realview_clk_init(void __iomem *sysbase, bool is_pb1176);
-- 
1.7.11.3
