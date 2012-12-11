From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 10 Dec 2012 18:18:03 -0700
Subject: [PATCH 3/3] ARM: Orion: Bind the orion timer through DT
In-Reply-To: <1355188683-18208-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1355188683-18208-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <1355188683-18208-3-git-send-email-jgunthorpe@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the common DT code and board support for
kirkwood and dove

- Add the marvell,orion-timer DT node to the DTSI file
- Adjust the call paths for dove/kirkwood_timer_init so it only
  happens on non-dt
- Eliminate redundant logging calls of kirkwood_tclk for simplicity.
  These days the tclk frequency is logged here:
sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474ms
- The DT stanza was choosen to simplify future merging with
  time-armada-370-xp.c

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/boot/dts/dove.dtsi             |    8 ++++++
 arch/arm/boot/dts/kirkwood-dns320.dts   |    3 ++
 arch/arm/boot/dts/kirkwood-lschlv2.dts  |    3 ++
 arch/arm/boot/dts/kirkwood.dtsi         |    9 ++++++
 arch/arm/mach-dove/common.c             |   30 +++++++++++-----------
 arch/arm/mach-kirkwood/board-dt.c       |   10 ++++++-
 arch/arm/mach-kirkwood/common.c         |   42 ++++++++++++++-----------------
 arch/arm/mach-kirkwood/common.h         |    1 -
 arch/arm/plat-orion/include/plat/time.h |    1 +
 arch/arm/plat-orion/time.c              |   32 +++++++++++++++++++++++
 10 files changed, 98 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index b726ba8..da6539b 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -31,6 +31,14 @@
 			reg = <0x20204 0x04>, <0x20214 0x04>;
 		};
 
+		timer at 20300 {
+			compatible = "marvell,orion-timer";
+			reg = <0x20300 0x20>;
+			interrupt-parent = <&bridge_intc>;
+			interrupts = <1>, <2>;
+			clock-frequency = <166666667>;
+                };
+
 		uart0: serial at 12000 {
 			compatible = "ns16550a";
 			reg = <0x12000 0x100>;
diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
index 5bb0bf3..5bffd7c 100644
--- a/arch/arm/boot/dts/kirkwood-dns320.dts
+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
@@ -41,6 +41,9 @@
 	};
 
 	ocp at f1000000 {
+		timer at 20300 {
+			clock-frequency = <166666667>;
+		};
 		serial at 12000 {
 			clock-frequency = <166666667>;
 			status = "okay";
diff --git a/arch/arm/boot/dts/kirkwood-lschlv2.dts b/arch/arm/boot/dts/kirkwood-lschlv2.dts
index 9510c9e..3b68d92 100644
--- a/arch/arm/boot/dts/kirkwood-lschlv2.dts
+++ b/arch/arm/boot/dts/kirkwood-lschlv2.dts
@@ -12,6 +12,9 @@
 	};
 
 	ocp at f1000000 {
+		timer at 20300 {
+			clock-frequency = <166666667>;
+		};
 		serial at 12000 {
 			clock-frequency = <166666667>;
 			status = "okay";
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 854e532..278f8ac 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -47,6 +47,15 @@
 			reg = <0x20110 0x08>;
 		};
 
+		timer at 20300 {
+			compatible = "marvell,orion-timer";
+			reg = <0x20300 0x20>;
+			interrupt-parent = <&bridge_intc>;
+			interrupts = <1>, <2>;
+			/* override clock-frequency in board dts */
+			clock-frequency = <200000000>;
+                };
+
 		serial at 12000 {
 			compatible = "ns16550a";
 			reg = <0x12000 0x100>;
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index b570211..43062ea 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -62,7 +62,6 @@ void __init dove_map_io(void)
 /*****************************************************************************
  * CLK tree
  ****************************************************************************/
-static int dove_tclk;
 
 static DEFINE_SPINLOCK(gating_lock);
 static struct clk *tclk;
@@ -75,6 +74,11 @@ static struct clk __init *dove_register_gate(const char *name,
 				 bit_idx, 0, &gating_lock);
 }
 
+static int __init dove_find_tclk(void)
+{
+	return 166666667;
+}
+
 static void __init dove_clk_init(void)
 {
 	struct clk *usb0, *usb1, *sata, *pex0, *pex1, *sdio0, *sdio1;
@@ -82,7 +86,7 @@ static void __init dove_clk_init(void)
 	struct clk *xor0, *xor1, *ge, *gephy;
 
 	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, CLK_IS_ROOT,
-				       dove_tclk);
+				       dove_find_tclk());
 
 	usb0 = dove_register_gate("usb0", "tclk", CLOCK_GATING_BIT_USB0);
 	usb1 = dove_register_gate("usb1", "tclk", CLOCK_GATING_BIT_USB1);
@@ -232,18 +236,12 @@ void __init dove_i2c_init(void)
  ****************************************************************************/
 void __init dove_init_early(void)
 {
-	orion_time_set_base(TIMER_VIRT_BASE);
-}
-
-static int __init dove_find_tclk(void)
-{
-	return 166666667;
 }
 
 static void __init dove_timer_init(void)
 {
-	dove_tclk = dove_find_tclk();
-	orion_time_init(IRQ_DOVE_BRIDGE_TIMER1, dove_tclk);
+	orion_time_set_base(TIMER_VIRT_BASE);
+	orion_time_init(IRQ_DOVE_BRIDGE_TIMER1, dove_find_tclk());
 }
 
 struct sys_timer dove_timer = {
@@ -340,8 +338,7 @@ void __init dove_sdio1_init(void)
 
 void __init dove_init(void)
 {
-	pr_info("Dove 88AP510 SoC, TCLK = %d MHz.\n",
-		(dove_tclk + 499999) / 1000000);
+	pr_info("Dove 88AP510 SoC\n");
 
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init(0);
@@ -395,8 +392,7 @@ static struct mv643xx_eth_platform_data dove_dt_ge00_data = {
 
 static void __init dove_dt_init(void)
 {
-	pr_info("Dove 88AP510 SoC, TCLK = %d MHz.\n",
-		(dove_tclk + 499999) / 1000000);
+	pr_info("Dove 88AP510 SoC\n");
 
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init(0);
@@ -425,11 +421,15 @@ static const char * const dove_dt_board_compat[] = {
 	NULL
 };
 
+static struct sys_timer dove_dt_timer = {
+	.init = orion_time_init_dt,
+};
+
 DT_MACHINE_START(DOVE_DT, "Marvell Dove (Flattened Device Tree)")
 	.map_io		= dove_map_io,
 	.init_early	= dove_init_early,
 	.init_irq	= orion_dt_init_irq,
-	.timer		= &dove_timer,
+	.timer		= &dove_dt_timer,
 	.init_machine	= dove_dt_init,
 	.restart	= dove_restart,
 	.dt_compat	= dove_dt_board_compat,
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index ecbb26f..c49146c 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -17,8 +17,10 @@
 #include <linux/kexec.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/time.h>
 #include <mach/bridge-regs.h>
 #include <plat/irq.h>
+#include <plat/time.h>
 #include "common.h"
 
 static struct of_device_id kirkwood_dt_match_table[] __initdata = {
@@ -41,7 +43,7 @@ struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
 
 static void __init kirkwood_dt_init(void)
 {
-	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
+	pr_info("Kirkwood: %s\n", kirkwood_id());
 
 	/*
 	 * Disable propagation of mbus errors to the CPU local bus,
@@ -115,12 +117,16 @@ static const char *kirkwood_dt_board_compat[] = {
 	NULL
 };
 
+static struct sys_timer kirkwood_dt_timer = {
+	.init           = orion_time_init_dt,
+};
+
 DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
 	/* Maintainer: Jason Cooper <jason@lakedaemon.net> */
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= orion_dt_init_irq,
-	.timer		= &kirkwood_timer,
+	.timer		= &kirkwood_dt_timer,
 	.init_machine	= kirkwood_dt_init,
 	.restart	= kirkwood_restart,
 	.dt_compat	= kirkwood_dt_board_compat,
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 7398f8b..aeb0458 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -221,13 +221,28 @@ static struct clk __init *kirkwood_register_gate_fn(const char *name,
 
 static struct clk *ge0, *ge1;
 
+/* FIXME: The tclk frequency is in the DT now, this should fetch it from
+ * there. */
+static int __init kirkwood_find_tclk(void)
+{
+	u32 dev, rev;
+
+	kirkwood_pcie_id(&dev, &rev);
+
+	if (dev == MV88F6281_DEV_ID || dev == MV88F6282_DEV_ID)
+		if (((readl(SAMPLE_AT_RESET) >> 21) & 1) == 0)
+			return 200000000;
+
+	return 166666667;
+}
+
 void __init kirkwood_clk_init(void)
 {
 	struct clk *runit, *sata0, *sata1, *usb0, *sdio;
 	struct clk *crypto, *xor0, *xor1, *pex0, *pex1, *audio;
 
 	tclk = clk_register_fixed_rate(NULL, "tclk", NULL,
-				       CLK_IS_ROOT, kirkwood_tclk);
+				       CLK_IS_ROOT,  kirkwood_find_tclk());
 
 	runit = kirkwood_register_gate("runit",  CGC_BIT_RUNIT);
 	ge0 = kirkwood_register_gate("ge0",    CGC_BIT_GE0);
@@ -506,8 +521,6 @@ void __init kirkwood_wdt_init(void)
  ****************************************************************************/
 void __init kirkwood_init_early(void)
 {
-	orion_time_set_base(TIMER_VIRT_BASE);
-
 	/*
 	 * Some Kirkwood devices allocate their coherent buffers from atomic
 	 * context. Increase size of atomic coherent pool to make sure such
@@ -516,26 +529,10 @@ void __init kirkwood_init_early(void)
 	init_dma_coherent_pool_size(SZ_1M);
 }
 
-int kirkwood_tclk;
-
-static int __init kirkwood_find_tclk(void)
-{
-	u32 dev, rev;
-
-	kirkwood_pcie_id(&dev, &rev);
-
-	if (dev == MV88F6281_DEV_ID || dev == MV88F6282_DEV_ID)
-		if (((readl(SAMPLE_AT_RESET) >> 21) & 1) == 0)
-			return 200000000;
-
-	return 166666667;
-}
-
 static void __init kirkwood_timer_init(void)
 {
-	kirkwood_tclk = kirkwood_find_tclk();
-
-	orion_time_init(IRQ_KIRKWOOD_BRIDGE_TIMER1, kirkwood_tclk);
+	orion_time_set_base(TIMER_VIRT_BASE);
+	orion_time_init(IRQ_KIRKWOOD_BRIDGE_TIMER1, kirkwood_find_tclk());
 }
 
 struct sys_timer kirkwood_timer = {
@@ -647,8 +644,7 @@ void __init kirkwood_l2_init(void)
 
 void __init kirkwood_init(void)
 {
-	printk(KERN_INFO "Kirkwood: %s, TCLK=%d.\n",
-		kirkwood_id(), kirkwood_tclk);
+	pr_info("Kirkwood: %s\n", kirkwood_id());
 
 	/*
 	 * Disable propagation of mbus errors to the CPU local bus,
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index bcffd7c..a92fde9 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -120,7 +120,6 @@ void kirkwood_xor0_init(void);
 void kirkwood_xor1_init(void);
 void kirkwood_crypto_init(void);
 
-extern int kirkwood_tclk;
 extern struct sys_timer kirkwood_timer;
 
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
diff --git a/arch/arm/plat-orion/include/plat/time.h b/arch/arm/plat-orion/include/plat/time.h
index c5ccc0a..9a4b142 100644
--- a/arch/arm/plat-orion/include/plat/time.h
+++ b/arch/arm/plat-orion/include/plat/time.h
@@ -14,5 +14,6 @@
 void orion_time_set_base(void __iomem *timer_base);
 
 void orion_time_init(unsigned int irq, unsigned int tclk);
+void __init orion_time_init_dt(void);
 
 #endif
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index da22aa4..600e8ee 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -16,6 +16,8 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <asm/sched_clock.h>
 #include <linux/sched.h>
 #include <plat/time.h>
@@ -199,3 +201,33 @@ orion_time_init(unsigned int irq, unsigned int tclk)
 	orion_clkevt.cpumask = cpumask_of(0);
 	clockevents_register_device(&orion_clkevt);
 }
+
+#ifdef CONFIG_OF
+void __init
+orion_time_init_dt(void)
+{
+	struct device_node *np;
+	int ret;
+	int irq;
+	u32 clk;
+
+	np = of_find_compatible_node(NULL, NULL, "marvell,orion-timer");
+	if (!np)
+		panic("Bad marvell,orion-timer DT block");
+
+	timer_base = of_iomap(np, 0);
+	if (!timer_base)
+		panic("Bad marvell,orion-timer DT block");
+
+	/* We use timer 0 as clocksource, and timer 1 for clockevents */
+	irq = irq_of_parse_and_map(np, 1);
+	if (!irq)
+		panic("Bad marvell,orion-timer DT block");
+
+	ret = of_property_read_u32(np, "clock-frequency", &clk);
+	if (ret < 0 || clk == 0)
+		panic("Bad marvell,orion-timer DT block");
+
+	orion_time_init(irq, clk);
+}
+#endif
-- 
1.7.5.4
