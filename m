From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 17:59:49 +0900
Subject: [PATCH 08/12] ARM: shmobile: r8a7740: Prepare for reference DT setup
In-Reply-To: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645193-3595-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

We need three steps to prepare for the new Armadillo reference DT board code:
 - Split the device list into r8a7740_early_devices used by the old platform
   data setup (board-armadillo.c) and r8a7740_devices_dt used by both
   setup variants.
 - Introduce new r8a7740_init_delay() to be more flexible about calling
   shmobile_setup_delay().
 - For the generic r8a7740 support, we switch to device tree setup for
   the GIC, the irqpin devices and the I2C controllers.

This is slightly similar to commit 3b00f9342623a5ebc
"ARM: shmobile: sh73a0: Do not use early devices with DT reference"

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi                |  117 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    2 +
 arch/arm/mach-shmobile/setup-r8a7740.c        |   54 ++++++------
 3 files changed, 148 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 798fa35..25dc930 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -18,4 +18,121 @@
 			compatible = "arm,cortex-a9";
 		};
 	};
+
+	gic: interrupt-controller at c2800000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		interrupt-controller;
+		reg = <0xc2800000 0x1000>,
+		      <0xc2000000 0x1000>;
+	};
+
+	/* irqpin0: IRQ0 - IRQ7 */
+	irqpin0: irqpin at e6900000 {
+		compatible = "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xe6900000 4>,
+			<0xe6900010 4>,
+			<0xe6900020 1>,
+			<0xe6900040 1>,
+			<0xe6900060 1>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4>;
+	};
+
+	/* irqpin1: IRQ8 - IRQ15 */
+	irqpin1: irqpin at e6900004 {
+		compatible = "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xe6900004 4>,
+			<0xe6900014 4>,
+			<0xe6900024 1>,
+			<0xe6900044 1>,
+			<0xe6900064 1>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4>;
+	};
+
+	/* irqpin2: IRQ16 - IRQ23 */
+	irqpin2: irqpin at e6900008 {
+		compatible = "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xe6900008 4>,
+			<0xe6900018 4>,
+			<0xe6900028 1>,
+			<0xe6900048 1>,
+			<0xe6900068 1>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4>;
+	};
+
+	/* irqpin3: IRQ24 - IRQ31 */
+	irqpin3: irqpin at e690000c {
+		compatible = "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xe690000c 4>,
+			<0xe690001c 4>,
+			<0xe690002c 1>,
+			<0xe690004c 1>,
+			<0xe690006c 1>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4
+			      0 149 0x4>;
+	};
+
+	i2c0: i2c at fff20000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xfff20000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 201 0x4
+			      0 202 0x4
+			      0 203 0x4
+			      0 204 0x4>;
+	};
+
+	i2c1: i2c at e6c20000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6c20000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 70 0x4
+			      0 71 0x4
+			      0 72 0x4
+			      0 73 0x4>;
+	};
 };
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 19c0423..1cf6869 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -533,11 +533,13 @@ enum {
 };
 
 extern void r8a7740_meram_workaround(void);
+extern void r8a7740_init_delay(void);
 extern void r8a7740_init_irq(void);
 extern void r8a7740_init_irq_of(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
 extern void r8a7740_add_standard_devices(void);
+extern void r8a7740_add_standard_devices_dt(void);
 extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 3a6b6fe..00c5a70 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -517,11 +517,7 @@ static struct platform_device ipmmu_device = {
 	.num_resources  = ARRAY_SIZE(ipmmu_resources),
 };
 
-static struct platform_device *r8a7740_early_devices[] __initdata = {
-	&irqpin0_device,
-	&irqpin1_device,
-	&irqpin2_device,
-	&irqpin3_device,
+static struct platform_device *r8a7740_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -532,6 +528,13 @@ static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&scif7_device,
 	&scifb_device,
 	&cmt10_device,
+};
+
+static struct platform_device *r8a7740_early_devices[] __initdata = {
+	&irqpin0_device,
+	&irqpin1_device,
+	&irqpin2_device,
+	&irqpin3_device,
 	&tmu00_device,
 	&tmu01_device,
 	&tmu02_device,
@@ -951,6 +954,8 @@ void __init r8a7740_add_standard_devices(void)
 	/* add devices */
 	platform_add_devices(r8a7740_early_devices,
 			    ARRAY_SIZE(r8a7740_early_devices));
+	platform_add_devices(r8a7740_devices_dt,
+			    ARRAY_SIZE(r8a7740_devices_dt));
 	platform_add_devices(r8a7740_late_devices,
 			     ARRAY_SIZE(r8a7740_late_devices));
 
@@ -972,6 +977,8 @@ void __init r8a7740_add_early_devices(void)
 {
 	early_platform_add_devices(r8a7740_early_devices,
 				   ARRAY_SIZE(r8a7740_early_devices));
+	early_platform_add_devices(r8a7740_devices_dt,
+				   ARRAY_SIZE(r8a7740_devices_dt));
 
 	/* setup early console here as well */
 	shmobile_setup_console();
@@ -979,33 +986,29 @@ void __init r8a7740_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-void __init r8a7740_add_early_devices_dt(void)
-{
-	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
-
-	early_platform_add_devices(r8a7740_early_devices,
-				   ARRAY_SIZE(r8a7740_early_devices));
-
-	/* setup early console here as well */
-	shmobile_setup_console();
-}
-
 static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
 	{ }
 };
 
 void __init r8a7740_add_standard_devices_dt(void)
 {
-	/* clocks are setup late during boot in the case of DT */
-	r8a7740_clock_init(0);
-
-	platform_add_devices(r8a7740_early_devices,
-			    ARRAY_SIZE(r8a7740_early_devices));
-
+	platform_add_devices(r8a7740_devices_dt,
+			    ARRAY_SIZE(r8a7740_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     r8a7740_auxdata_lookup, NULL);
 }
 
+void __init r8a7740_init_delay(void)
+{
+	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
+};
+
+static void __init r8a7740_generic_init(void)
+{
+	r8a7740_clock_init(0);
+	r8a7740_add_standard_devices_dt();
+}
+
 static const char *r8a7740_boards_compat_dt[] __initdata = {
 	"renesas,r8a7740",
 	NULL,
@@ -1013,9 +1016,10 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.map_io		= r8a7740_map_io,
-	.init_early	= r8a7740_add_early_devices_dt,
-	.init_irq	= r8a7740_init_irq,
-	.init_machine	= r8a7740_add_standard_devices_dt,
+	.init_early	= r8a7740_init_delay,
+	.init_irq	= r8a7740_init_irq_of,
+	.init_machine	= r8a7740_generic_init,
+	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a7740_boards_compat_dt,
 MACHINE_END
 
-- 
1.7.10.4
