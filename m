From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Aug 2012 14:16:04 +0200
Subject: [PATCH 4/6] ARM: integrator: initial device tree support
Message-ID: <1345119364-22742-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is initial device tree support for the ARM Integrator family,
we create a very basic device tree, #ifdef out the non-DT machines
when compiling for device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/arm-boards |  12 +++
 arch/arm/boot/dts/integratorap.dts               |  26 ++++++
 arch/arm/boot/dts/integratorcp.dts               |  46 ++++++++++
 arch/arm/mach-integrator/integrator_ap.c         |  77 ++++++++++++----
 arch/arm/mach-integrator/integrator_cp.c         | 112 ++++++++++++++++-------
 5 files changed, 221 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/boot/dts/integratorap.dts
 create mode 100644 arch/arm/boot/dts/integratorcp.dts

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 91f2614..670e80e 100644
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
+FPGA type interrupt controllers, see the fpga-irq binding doc.
+
+
 ARM Versatile Application and Platform Baseboards
 -------------------------------------------------
 ARM's development hardware platform with connectors for customizable
diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
new file mode 100644
index 0000000..a40d1ec0
--- /dev/null
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -0,0 +1,26 @@
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
+	chosen {
+		bootargs = "root=/dev/ram0 console=ttyAM0,38400n8 earlyprintk";
+	};
+
+	pic: pic at 14000000 {
+		compatible = "arm,versatile-fpga-irq";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0x14000000 0x100>;
+		irq-start = <1>;
+		clear-mask = <0xffffffff>;
+		valid-mask = <0x003fffff>;
+	};
+};
diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
new file mode 100644
index 0000000..b6ca10f
--- /dev/null
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -0,0 +1,46 @@
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
+	chosen {
+		bootargs = "root=/dev/ram0 console=ttyAMA0,38400n8 earlyprintk";
+	};
+
+	pic: pic at 14000000 {
+		compatible = "arm,versatile-fpga-irq";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0x14000000 0x100>;
+		irq-start = <1>;
+		clear-mask = <0xffffffff>;
+		valid-mask = <0x1fc003ff>;
+	};
+
+	cic: cic at 10000040 {
+		compatible = "arm,versatile-fpga-irq";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0x10000040 0x100>;
+		irq-start = <32>;
+		clear-mask = <0xffffffff>;
+		valid-mask = <0x00000007>;
+	};
+
+	sic: sic at ca000000 {
+		compatible = "arm,versatile-fpga-irq";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0xca000000 0x100>;
+		irq-start = <35>;
+		clear-mask = <0x00000fff>;
+		valid-mask = <0x00000fff>;
+	};
+};
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index ff966d8..58b0a58 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -34,6 +34,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/clk.h>
 #include <linux/platform_data/clk-integrator.h>
+#include <linux/of_irq.h>
 #include <video/vga.h>
 
 #include <mach/hardware.h>
@@ -161,23 +162,6 @@ static void __init ap_map_io(void)
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
 
@@ -473,6 +457,63 @@ static struct sys_timer ap_timer = {
 	.init		= ap_init_timer,
 };
 
+#ifdef CONFIG_OF
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
+	.timer		= &ap_timer,
+	.init_machine	= ap_init,
+	.restart	= integrator_restart,
+	.dt_compat      = ap_dt_board_compat,
+MACHINE_END
+
+#else
+
+/*
+ * This is where non-devicetree initialization code is collected and stashed
+ * for eventual deletion.
+ */
+
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
@@ -486,3 +527,5 @@ MACHINE_START(INTEGRATOR, "ARM-Integrator")
 	.init_machine	= ap_init,
 	.restart	= integrator_restart,
 MACHINE_END
+
+#endif
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 2b40bc1..0f6dc99 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -23,6 +23,7 @@
 #include <linux/gfp.h>
 #include <linux/mtd/physmap.h>
 #include <linux/platform_data/clk-integrator.h>
+#include <linux/of_irq.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
@@ -53,10 +54,6 @@
 
 #define INTCP_PA_CLCD_BASE		0xc0000000
 
-#define INTCP_VA_CIC_BASE		__io_address(INTEGRATOR_HDR_BASE + 0x40)
-#define INTCP_VA_PIC_BASE		__io_address(INTEGRATOR_IC_BASE)
-#define INTCP_VA_SIC_BASE		__io_address(INTEGRATOR_CP_SIC_BASE)
-
 #define INTCP_ETH_SIZE			0x10
 
 #define INTCP_VA_CTRL_BASE		IO_ADDRESS(INTEGRATOR_CP_CTL_BASE)
@@ -143,37 +140,6 @@ static void __init intcp_map_io(void)
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
@@ -387,6 +353,80 @@ static struct sys_timer cp_timer = {
 	.init		= intcp_timer_init,
 };
 
+#ifdef CONFIG_OF
+
+static const struct of_device_id fpga_irq_of_match[] __initconst = {
+	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
+	{ /* Sentinel */ }
+};
+
+static void __init intcp_init_irq_of(void)
+{
+	of_irq_init(fpga_irq_of_match);
+	integrator_clk_init(true);
+}
+
+static const char * intcp_dt_board_compat[] = {
+	"arm,integrator-cp",
+	NULL,
+};
+
+DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
+	.reserve	= integrator_reserve,
+	.map_io		= intcp_map_io,
+	.nr_irqs	= NR_IRQS_INTEGRATOR_CP,
+	.init_early	= intcp_init_early,
+	.init_irq	= intcp_init_irq_of,
+	.handle_irq	= fpga_handle_irq,
+	.timer		= &cp_timer,
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
+}
+
 MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
@@ -400,3 +440,5 @@ MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	.init_machine	= intcp_init,
 	.restart	= integrator_restart,
 MACHINE_END
+
+#endif
-- 
1.7.11.2
