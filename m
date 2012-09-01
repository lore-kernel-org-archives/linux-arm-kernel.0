From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat,  1 Sep 2012 05:55:56 +0200
Subject: [PATCH 4/6 v2] ARM: integrator: initial device tree support
In-Reply-To: <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is initial device tree support for the ARM Integrator family,
we create a very basic device tree, #ifdef out the non-DT machines
when compiling for device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Also switch over clocksource and clockevent to device tree.
  Else the IRQ mapping goes bananas.
---
 Documentation/devicetree/bindings/arm/arm-boards |  12 ++
 arch/arm/boot/dts/integratorap.dts               |  51 ++++++++
 arch/arm/boot/dts/integratorcp.dts               |  69 ++++++++++
 arch/arm/mach-integrator/integrator_ap.c         | 137 ++++++++++++++++----
 arch/arm/mach-integrator/integrator_cp.c         | 152 ++++++++++++++++-------
 5 files changed, 353 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm/boot/dts/integratorap.dts
 create mode 100644 arch/arm/boot/dts/integratorcp.dts

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 91f2614..fc81a7d 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -1,3 +1,15 @@
+ARM Integrator/AP (Application Platform) and Integrator/CP (Compact Platform)
+-----------------------------------------------------------------------------
+ARM's oldest Linux-supported platform with connectors for different core
+tiles of ARMv4, ARMv5 and ARMv6 type.
+
+Required properties (in root node):
+	compatible = "arm,integrator-ap";  /* Application Platform */
+	compatible = "arm,integrator-cp";  /* Compact Platform */
+
+FPGA type interrupt controllers, see the versatile-fpga-irq binding doc.
+
+
 ARM Versatile Application and Platform Baseboards
 -------------------------------------------------
 ARM's development hardware platform with connectors for customizable
diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
new file mode 100644
index 0000000..928a7be
--- /dev/null
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -0,0 +1,51 @@
+/*
+ * Device Tree for the ARM Integrator/AP platform
+ */
+
+/dts-v1/;
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "ARM Integrator/AP";
+	compatible = "arm,integrator-ap";
+	ranges;
+
+	aliases {
+		arm,integrator-clocksource = &timer2;
+		arm,integrator-clockevent = &timer1;
+	};
+
+	chosen {
+		bootargs = "root=/dev/ram0 console=ttyAM0,38400n8 earlyprintk";
+	};
+
+	timer0: timer at 13000000 {
+		compatible = "arm,integrator-timer";
+		reg = <0x13000000 0x100>;
+		interrupt-parent = <&pic>;
+		interrupts = <5>;
+	};
+
+	timer1: timer at 13000100 {
+		compatible = "arm,integrator-timer";
+		reg = <0x13000100 0x100>;
+		interrupt-parent = <&pic>;
+		interrupts = <6>;
+	};
+
+	timer2: timer at 13000200 {
+		compatible = "arm,integrator-timer";
+		reg = <0x13000200 0x100>;
+		interrupt-parent = <&pic>;
+		interrupts = <7>;
+	};
+
+	pic: pic at 14000000 {
+		compatible = "arm,versatile-fpga-irq";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0x14000000 0x100>;
+		clear-mask = <0xffffffff>;
+		valid-mask = <0x003fffff>;
+	};
+};
diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
new file mode 100644
index 0000000..8fad5a1
--- /dev/null
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -0,0 +1,69 @@
+/*
+ * Device Tree for the ARM Integrator/CP platform
+ */
+
+/dts-v1/;
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "ARM Integrator/CP";
+	compatible = "arm,integrator-cp";
+	ranges;
+
+	aliases {
+		arm,integrator-clocksource = &timer2;
+		arm,integrator-clockevent = &timer1;
+	};
+
+	chosen {
+		bootargs = "root=/dev/ram0 console=ttyAMA0,38400n8 earlyprintk";
+	};
+
+	timer0: timer at 13000000 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0x13000000 0x100>;
+		interrupt-parent = <&pic>;
+		interrupts = <5>;
+	};
+
+	timer1: timer at 13000100 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0x13000100 0x100>;
+		interrupt-parent = <&pic>;
+		interrupts = <6>;
+	};
+
+	timer2: timer at 13000200 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0x13000200 0x100>;
+		interrupt-parent = <&pic>;
+		interrupts = <7>;
+	};
+
+	pic: pic at 14000000 {
+		compatible = "arm,versatile-fpga-irq";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0x14000000 0x100>;
+		clear-mask = <0xffffffff>;
+		valid-mask = <0x1fc003ff>;
+	};
+
+	cic: cic at 10000040 {
+		compatible = "arm,versatile-fpga-irq";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0x10000040 0x100>;
+		clear-mask = <0xffffffff>;
+		valid-mask = <0x00000007>;
+	};
+
+	sic: sic at ca000000 {
+		compatible = "arm,versatile-fpga-irq";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0xca000000 0x100>;
+		clear-mask = <0x00000fff>;
+		valid-mask = <0x00000fff>;
+	};
+};
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index ff966d8..26d4d8c 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -34,6 +34,8 @@
 #include <linux/mtd/physmap.h>
 #include <linux/clk.h>
 #include <linux/platform_data/clk-integrator.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
 #include <video/vga.h>
 
 #include <mach/hardware.h>
@@ -161,23 +163,6 @@ static void __init ap_map_io(void)
 	vga_base = PCI_MEMORY_VADDR;
 }
 
-#define INTEGRATOR_SC_VALID_INT	0x003fffff
-
-static void __init ap_init_irq(void)
-{
-	/* Disable all interrupts initially. */
-	/* Do the core module ones */
-	writel(-1, VA_CMIC_BASE + IRQ_ENABLE_CLEAR);
-
-	/* do the header card stuff next */
-	writel(-1, VA_IC_BASE + IRQ_ENABLE_CLEAR);
-	writel(-1, VA_IC_BASE + FIQ_ENABLE_CLEAR);
-
-	fpga_irq_init(VA_IC_BASE, "SC", IRQ_PIC_START,
-		-1, INTEGRATOR_SC_VALID_INT, NULL);
-	integrator_clk_init(false);
-}
-
 #ifdef CONFIG_PM
 static unsigned long ic_irq_enable;
 
@@ -330,9 +315,9 @@ static u32 notrace integrator_read_sched_clock(void)
 	return -readl((void __iomem *) TIMER2_VA_BASE + TIMER_VALUE);
 }
 
-static void integrator_clocksource_init(unsigned long inrate)
+static void integrator_clocksource_init(unsigned long inrate,
+					void __iomem *base)
 {
-	void __iomem *base = (void __iomem *)TIMER2_VA_BASE;
 	u32 ctrl = TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC;
 	unsigned long rate = inrate;
 
@@ -349,7 +334,7 @@ static void integrator_clocksource_init(unsigned long inrate)
 	setup_sched_clock(integrator_read_sched_clock, 16, rate);
 }
 
-static void __iomem * const clkevt_base = (void __iomem *)TIMER1_VA_BASE;
+static void __iomem * clkevt_base;
 
 /*
  * IRQ handler for the timer
@@ -421,11 +406,13 @@ static struct irqaction integrator_timer_irq = {
 	.dev_id		= &integrator_clockevent,
 };
 
-static void integrator_clockevent_init(unsigned long inrate)
+static void integrator_clockevent_init(unsigned long inrate,
+				void __iomem *base, int irq)
 {
 	unsigned long rate = inrate;
 	unsigned int ctrl = 0;
 
+	clkevt_base = base;
 	/* Calculate and program a divisor */
 	if (rate > 0x100000 * HZ) {
 		rate /= 256;
@@ -437,7 +424,7 @@ static void integrator_clockevent_init(unsigned long inrate)
 	timer_reload = rate / HZ;
 	writel(ctrl, clkevt_base + TIMER_CTRL);
 
-	setup_irq(IRQ_TIMERINT1, &integrator_timer_irq);
+	setup_irq(irq, &integrator_timer_irq);
 	clockevents_config_and_register(&integrator_clockevent,
 					rate,
 					1,
@@ -448,9 +435,89 @@ void __init ap_init_early(void)
 {
 }
 
+#ifdef CONFIG_OF
+
+static void __init ap_init_timer_of(void)
+{
+	struct device_node *node;
+	const char *path;
+	void __iomem *base;
+	int err;
+	int irq;
+	struct clk *clk;
+	unsigned long rate;
+
+	clk = clk_get_sys("ap_timer", NULL);
+	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
+	rate = clk_get_rate(clk);
+
+	err = of_property_read_string(of_aliases,
+				"arm,integrator-clocksource", &path);
+	if (WARN_ON(err))
+		return;
+	node = of_find_node_by_path(path);
+	base = of_iomap(node, 0);
+	if (WARN_ON(!base))
+		return;
+	writel(0, base + TIMER_CTRL);
+	integrator_clocksource_init(rate, base);
+
+	err = of_property_read_string(of_aliases,
+				"arm,integrator-clockevent", &path);
+	if (WARN_ON(err))
+		return;
+	node = of_find_node_by_path(path);
+	base = of_iomap(node, 0);
+	if (WARN_ON(!base))
+		return;
+	irq = irq_of_parse_and_map(node, 0);
+	writel(0, base + TIMER_CTRL);
+	integrator_clockevent_init(rate, base, irq);
+}
+
+static struct sys_timer ap_of_timer = {
+	.init		= ap_init_timer_of,
+};
+
+static const struct of_device_id fpga_irq_of_match[] __initconst = {
+	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
+	{ /* Sentinel */ }
+};
+
+static void __init ap_init_irq_of(void)
+{
+	/* disable core module IRQs */
+	writel(0xffffffffU, VA_CMIC_BASE + IRQ_ENABLE_CLEAR);
+	of_irq_init(fpga_irq_of_match);
+	integrator_clk_init(false);
+}
+
+static const char * ap_dt_board_compat[] = {
+	"arm,integrator-ap",
+	NULL,
+};
+
+DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
+	.reserve	= integrator_reserve,
+	.map_io		= ap_map_io,
+	.nr_irqs	= NR_IRQS_INTEGRATOR_AP,
+	.init_early	= ap_init_early,
+	.init_irq	= ap_init_irq_of,
+	.handle_irq	= fpga_handle_irq,
+	.timer		= &ap_of_timer,
+	.init_machine	= ap_init,
+	.restart	= integrator_restart,
+	.dt_compat      = ap_dt_board_compat,
+MACHINE_END
+
+#else
+
 /*
- * Set up timer(s).
+ * This is where non-devicetree initialization code is collected and stashed
+ * for eventual deletion.
  */
+
 static void __init ap_init_timer(void)
 {
 	struct clk *clk;
@@ -465,14 +532,32 @@ static void __init ap_init_timer(void)
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
-	integrator_clocksource_init(rate);
-	integrator_clockevent_init(rate);
+	integrator_clocksource_init(rate, (void __iomem *)TIMER2_VA_BASE);
+	integrator_clockevent_init(rate, (void __iomem *)TIMER1_VA_BASE,
+				IRQ_TIMERINT1);
 }
 
 static struct sys_timer ap_timer = {
 	.init		= ap_init_timer,
 };
 
+#define INTEGRATOR_SC_VALID_INT	0x003fffff
+
+static void __init ap_init_irq(void)
+{
+	/* Disable all interrupts initially. */
+	/* Do the core module ones */
+	writel(-1, VA_CMIC_BASE + IRQ_ENABLE_CLEAR);
+
+	/* do the header card stuff next */
+	writel(-1, VA_IC_BASE + IRQ_ENABLE_CLEAR);
+	writel(-1, VA_IC_BASE + FIQ_ENABLE_CLEAR);
+
+	fpga_irq_init(VA_IC_BASE, "SC", IRQ_PIC_START,
+		-1, INTEGRATOR_SC_VALID_INT, NULL);
+	integrator_clk_init(false);
+}
+
 MACHINE_START(INTEGRATOR, "ARM-Integrator")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
@@ -486,3 +571,5 @@ MACHINE_START(INTEGRATOR, "ARM-Integrator")
 	.init_machine	= ap_init,
 	.restart	= integrator_restart,
 MACHINE_END
+
+#endif
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 2b40bc1..e7f2fb6 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -23,6 +23,8 @@
 #include <linux/gfp.h>
 #include <linux/mtd/physmap.h>
 #include <linux/platform_data/clk-integrator.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
@@ -53,10 +55,6 @@
 
 #define INTCP_PA_CLCD_BASE		0xc0000000
 
-#define INTCP_VA_CIC_BASE		__io_address(INTEGRATOR_HDR_BASE + 0x40)
-#define INTCP_VA_PIC_BASE		__io_address(INTEGRATOR_IC_BASE)
-#define INTCP_VA_SIC_BASE		__io_address(INTEGRATOR_CP_SIC_BASE)
-
 #define INTCP_ETH_SIZE			0x10
 
 #define INTCP_VA_CTRL_BASE		IO_ADDRESS(INTEGRATOR_CP_CTL_BASE)
@@ -143,37 +141,6 @@ static void __init intcp_map_io(void)
 	iotable_init(intcp_io_desc, ARRAY_SIZE(intcp_io_desc));
 }
 
-static void __init intcp_init_irq(void)
-{
-	u32 pic_mask, cic_mask, sic_mask;
-
-	/* These masks are for the HW IRQ registers */
-	pic_mask = ~((~0u) << (11 - IRQ_PIC_START));
-	pic_mask |= (~((~0u) << (29 - 22))) << 22;
-	cic_mask = ~((~0u) << (1 + IRQ_CIC_END - IRQ_CIC_START));
-	sic_mask = ~((~0u) << (1 + IRQ_SIC_END - IRQ_SIC_START));
-
-	/*
-	 * Disable all interrupt sources
-	 */
-	writel(0xffffffff, INTCP_VA_PIC_BASE + IRQ_ENABLE_CLEAR);
-	writel(0xffffffff, INTCP_VA_PIC_BASE + FIQ_ENABLE_CLEAR);
-	writel(0xffffffff, INTCP_VA_CIC_BASE + IRQ_ENABLE_CLEAR);
-	writel(0xffffffff, INTCP_VA_CIC_BASE + FIQ_ENABLE_CLEAR);
-	writel(sic_mask, INTCP_VA_SIC_BASE + IRQ_ENABLE_CLEAR);
-	writel(sic_mask, INTCP_VA_SIC_BASE + FIQ_ENABLE_CLEAR);
-
-	fpga_irq_init(INTCP_VA_PIC_BASE, "PIC", IRQ_PIC_START,
-		      -1, pic_mask, NULL);
-
-	fpga_irq_init(INTCP_VA_CIC_BASE, "CIC", IRQ_CIC_START,
-		      -1, cic_mask, NULL);
-
-	fpga_irq_init(INTCP_VA_SIC_BASE, "SIC", IRQ_SIC_START,
-		      IRQ_CP_CPPLDINT, sic_mask, NULL);
-	integrator_clk_init(true);
-}
-
 /*
  * Flash handling.
  */
@@ -356,17 +323,114 @@ static void __init intcp_init_early(void)
 #endif
 }
 
-static void __init intcp_init(void)
+static void __init intcp_timer_init_of(void)
+{
+	struct device_node *node;
+	const char *path;
+	void __iomem *base;
+	int err;
+	int irq;
+
+	err = of_property_read_string(of_aliases,
+				"arm,integrator-clocksource", &path);
+	if (WARN_ON(err))
+		return;
+	node = of_find_node_by_path(path);
+	base = of_iomap(node, 0);
+	if (WARN_ON(!base))
+		return;
+	writel(0, base + TIMER_CTRL);
+	sp804_clocksource_init(base, node->name);
+
+	err = of_property_read_string(of_aliases,
+				"arm,integrator-clockevent", &path);
+	if (WARN_ON(err))
+		return;
+	node = of_find_node_by_path(path);
+	base = of_iomap(node, 0);
+	if (WARN_ON(!base))
+		return;
+	irq = irq_of_parse_and_map(node, 0);
+	writel(0, base + TIMER_CTRL);
+	sp804_clockevents_init(base, irq, node->name);
+}
+
+static struct sys_timer cp_of_timer = {
+	.init		= intcp_timer_init_of,
+};
+
+#ifdef CONFIG_OF
+
+static const struct of_device_id fpga_irq_of_match[] __initconst = {
+	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
+	{ /* Sentinel */ }
+};
+
+static void __init intcp_init_irq_of(void)
 {
-	int i;
+	of_irq_init(fpga_irq_of_match);
+	integrator_clk_init(true);
+}
 
-	platform_add_devices(intcp_devs, ARRAY_SIZE(intcp_devs));
+static const char * intcp_dt_board_compat[] = {
+	"arm,integrator-cp",
+	NULL,
+};
 
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
-		struct amba_device *d = amba_devs[i];
-		amba_device_register(d, &iomem_resource);
-	}
-	integrator_init(true);
+DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
+	.reserve	= integrator_reserve,
+	.map_io		= intcp_map_io,
+	.nr_irqs	= NR_IRQS_INTEGRATOR_CP,
+	.init_early	= intcp_init_early,
+	.init_irq	= intcp_init_irq_of,
+	.handle_irq	= fpga_handle_irq,
+	.timer		= &cp_of_timer,
+	.init_machine	= intcp_init,
+	.restart	= integrator_restart,
+	.dt_compat      = intcp_dt_board_compat,
+MACHINE_END
+
+#else
+
+/*
+ * This is where non-devicetree initialization code is collected and stashed
+ * for eventual deletion.
+ */
+
+#define INTCP_VA_CIC_BASE		__io_address(INTEGRATOR_HDR_BASE + 0x40)
+#define INTCP_VA_PIC_BASE		__io_address(INTEGRATOR_IC_BASE)
+#define INTCP_VA_SIC_BASE		__io_address(INTEGRATOR_CP_SIC_BASE)
+
+static void __init intcp_init_irq(void)
+{
+	u32 pic_mask, cic_mask, sic_mask;
+
+	/* These masks are for the HW IRQ registers */
+	pic_mask = ~((~0u) << (11 - IRQ_PIC_START));
+	pic_mask |= (~((~0u) << (29 - 22))) << 22;
+	cic_mask = ~((~0u) << (1 + IRQ_CIC_END - IRQ_CIC_START));
+	sic_mask = ~((~0u) << (1 + IRQ_SIC_END - IRQ_SIC_START));
+
+	/*
+	 * Disable all interrupt sources
+	 */
+	writel(0xffffffff, INTCP_VA_PIC_BASE + IRQ_ENABLE_CLEAR);
+	writel(0xffffffff, INTCP_VA_PIC_BASE + FIQ_ENABLE_CLEAR);
+	writel(0xffffffff, INTCP_VA_CIC_BASE + IRQ_ENABLE_CLEAR);
+	writel(0xffffffff, INTCP_VA_CIC_BASE + FIQ_ENABLE_CLEAR);
+	writel(sic_mask, INTCP_VA_SIC_BASE + IRQ_ENABLE_CLEAR);
+	writel(sic_mask, INTCP_VA_SIC_BASE + FIQ_ENABLE_CLEAR);
+
+	fpga_irq_init(INTCP_VA_PIC_BASE, "PIC", IRQ_PIC_START,
+		      -1, pic_mask, NULL);
+
+	fpga_irq_init(INTCP_VA_CIC_BASE, "CIC", IRQ_CIC_START,
+		      -1, cic_mask, NULL);
+
+	fpga_irq_init(INTCP_VA_SIC_BASE, "SIC", IRQ_SIC_START,
+		      IRQ_CP_CPPLDINT, sic_mask, NULL);
+
+	integrator_clk_init(true);
 }
 
 #define TIMER0_VA_BASE __io_address(INTEGRATOR_TIMER0_BASE)
@@ -400,3 +464,5 @@ MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	.init_machine	= intcp_init,
 	.restart	= integrator_restart,
 MACHINE_END
+
+#endif
-- 
1.7.11.4
