From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 10:50:50 +0900
Subject: [PATCH 3/4] ARM: mach-shmobile: r8a7779: Minimal setup using DT
In-Reply-To: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
References: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359597051-32700-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow a minimal setup of the r8a7779 SoC using a flattened device tree.
In particular, configure the i2c and ethernet controllers using a
flattened device tree.

SCI serial controller and TMU clock source, whose drivers do not yet
support configuration using a flattened device tree, are still configured
using C code in order to allow booting of a board with this SoC.

The ethernet controller also requires a regulator which is a board property.
A sample snippet DT for the marzen board is as follows:

/dts-v1/;
/include/ "r8a7779.dtsi"

/ {
	fixedregulator3v3: fixedregulator at 0 {
		compatible = "regulator-fixed";
		regulator-name = "fixed-3.3V";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
		regulator-boot-on;
		regulator-always-on;
	};
};

&lan0 {
	vddvario-supply = <&fixedregulator3v3>;
	vdd33a-supply = <&fixedregulator3v3>;
};

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi               |   45 ++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    2 +
 arch/arm/mach-shmobile/setup-r8a7779.c       |   58 +++++++++++++++++++++++---
 3 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index eadc12e..9564040 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -37,4 +37,49 @@
                 reg = <0xf0001000 0x1000>,
                       <0xf0000100 0x100>;
         };
+
+	i2c0: i2c at 0xffc70000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xffc70000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 79 0x4>;
+	};
+
+	i2c1: i2c at 0xffc71000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xffc71000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 82 0x4>;
+	};
+
+	i2c2: i2c at 0xffc72000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xffc72000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 80 0x4>;
+	};
+
+	i2c3: i2c at 0xffc73000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xffc73000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 81 0x4>;
+	};
+
+	lan0: lan0 at 18000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x18000000 0x100>;
+		phy-mode = "mii";
+		interrupt-parent = <&gic>;
+		interrupts = <0 28 0x4>;
+		reg-io-width = <4>;
+	};
 };
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 8ef7ebb..4b85b18 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -67,7 +67,9 @@ extern void r8a7779_init_irq_dt(void);
 extern void r8a7779_map_io(void);
 extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
+extern void r8a7779_add_early_devices_dt(void);
 extern void r8a7779_add_standard_devices(void);
+extern void r8a7779_add_standard_devices_dt(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index c54ff9b..d4818c2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -321,7 +321,7 @@ static struct platform_device i2c3_device = {
 	.num_resources	= ARRAY_SIZE(rcar_i2c3_res),
 };
 
-static struct platform_device *r8a7779_early_devices[] __initdata = {
+static struct platform_device *r8a7779_early_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -330,15 +330,15 @@ static struct platform_device *r8a7779_early_devices[] __initdata = {
 	&scif5_device,
 	&tmu00_device,
 	&tmu01_device,
+};
+
+static struct platform_device *r8a7779_early_devices[] __initdata = {
 	&i2c0_device,
 	&i2c1_device,
 	&i2c2_device,
 	&i2c3_device,
 };
 
-static struct platform_device *r8a7779_late_devices[] __initdata = {
-};
-
 void __init r8a7779_add_standard_devices(void)
 {
 #ifdef CONFIG_CACHE_L2X0
@@ -349,10 +349,10 @@ void __init r8a7779_add_standard_devices(void)
 
 	r8a7779_init_pm_domains();
 
+	platform_add_devices(r8a7779_early_devices_dt,
+			    ARRAY_SIZE(r8a7779_early_devices_dt));
 	platform_add_devices(r8a7779_early_devices,
 			    ARRAY_SIZE(r8a7779_early_devices));
-	platform_add_devices(r8a7779_late_devices,
-			    ARRAY_SIZE(r8a7779_late_devices));
 }
 
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
@@ -367,6 +367,8 @@ void __init r8a7779_earlytimer_init(void)
 
 void __init r8a7779_add_early_devices(void)
 {
+	early_platform_add_devices(r8a7779_early_devices_dt,
+				   ARRAY_SIZE(r8a7779_early_devices_dt));
 	early_platform_add_devices(r8a7779_early_devices,
 				   ARRAY_SIZE(r8a7779_early_devices));
 
@@ -386,3 +388,47 @@ void __init r8a7779_add_early_devices(void)
 	 * command line in case of the marzen board.
 	 */
 }
+
+#ifdef CONFIG_USE_OF
+void __init r8a7779_add_early_devices_dt(void)
+{
+	shmobile_setup_delay(1000, 2, 4); /* Cortex-A9 @ 1000MHz */
+
+	early_platform_add_devices(r8a7779_early_devices_dt,
+				   ARRAY_SIZE(r8a7779_early_devices_dt));
+
+	/* Early serial console setup is not included here.
+	 * See comment in r8a7779_add_early_devices().
+	 */
+}
+
+static const struct of_dev_auxdata r8a7779_auxdata_lookup[] __initconst = {
+	{},
+};
+
+void __init r8a7779_add_standard_devices_dt(void)
+{
+	/* clocks are setup late during boot in the case of DT */
+	r8a7779_clock_init();
+
+	platform_add_devices(r8a7779_early_devices_dt,
+			    ARRAY_SIZE(r8a7779_early_devices_dt));
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     r8a7779_auxdata_lookup, NULL);
+}
+
+static const char *r8a7779_compat_dt[] __initdata = {
+	"renesas,r8a7779",
+	NULL,
+};
+
+DT_MACHINE_START(SH73A0_DT, "Generic R8A7779 (Flattened Device Tree)")
+	.map_io		= r8a7779_map_io,
+	.init_early	= r8a7779_add_early_devices_dt,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= r8a7779_init_irq_dt,
+	.init_machine	= r8a7779_add_standard_devices_dt,
+	.init_time	= shmobile_timer_init,
+	.dt_compat	= r8a7779_compat_dt,
+MACHINE_END
+#endif /* CONFIG_USE_OF */
-- 
1.7.10.4
