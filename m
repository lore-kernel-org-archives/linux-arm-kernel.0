From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 29 Nov 2011 18:29:19 -0700
Subject: [PATCH V3] arm/tegra: convert tegra20 to GIC devicetree binding
Message-ID: <1322616559-31941-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: pdeschrijver@nvidia.com <pdeschrijver@nvidia.com>

Convert tegra20 IRQ intialization to the GIC devicetree binding. Modify the
interrupt definitions in the dts files according to
Documentation/devicetree/bindings/arm/gic.txt

v3 (swarren):
* Moved of_irq_init() call into board-dt.c to avoid ifdef'ing it.
  - Even with a dummy replacement if !CONFIG_OF, the reference from
    tegra_dt_irq_match[] to gic_of_init() would still have to be ifdef'd
  - It's plausible that tegra_dt_irq_match[] may need to contain more
    entries in the future, and defining what they are seems more suitable
    for board-dt.c than irq.c
v2 (swarren):
* Removed some stale GIC init code from board-dt.c
* Undid some accidental 0x -> 0x0 search/replace.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This depends on:
* The patch in http://comments.gmane.org/gmane.linux.kernel/1221051;
  without that, and with this patch, the system won't boot with DT. 
* My earlier Tegra *.dts cleanup series, although only for context.

 arch/arm/boot/dts/tegra-paz00.dts |    2 +-
 arch/arm/boot/dts/tegra20.dtsi    |   48 ++++++++++++++++++++----------------
 arch/arm/mach-tegra/board-dt.c    |   24 +++++++++---------
 arch/arm/mach-tegra/irq.c         |   10 ++++++-
 4 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index 4f6a8aa..1a1d702 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -27,7 +27,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,nvec";
 		reg = <0x7000C500 0x100>;
-		interrupts = <124>;
+		interrupts = <0 92 0x04>;
 		clock-frequency = <80000>;
 		request-gpios = <&gpio 170 0>;
 		slave-addr = <138>;
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 795b921..db6f562 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -5,9 +5,9 @@
 	interrupt-parent = <&intc>;
 
 	intc: interrupt-controller at 50041000 {
-		compatible = "nvidia,tegra20-gic";
+		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
-		#interrupt-cells = <1>;
+		#interrupt-cells = <3>;
 		reg = < 0x50041000 0x1000 >,
 		      < 0x50040100 0x0100 >;
 	};
@@ -17,7 +17,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000C000 0x100>;
-		interrupts = < 70 >;
+		interrupts = < 0 38 0x04 >;
 	};
 
 	i2c at 7000c400 {
@@ -25,7 +25,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000C400 0x100>;
-		interrupts = < 116 >;
+		interrupts = < 0 84 0x04 >;
 	};
 
 	i2c at 7000c500 {
@@ -33,7 +33,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000C500 0x100>;
-		interrupts = < 124 >;
+		interrupts = < 0 92 0x04 >;
 	};
 
 	i2c at 7000d000 {
@@ -41,7 +41,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000D000 0x200>;
-		interrupts = < 85 >;
+		interrupts = < 0 53 0x04 >;
 	};
 
 	i2s at 70002800 {
@@ -49,7 +49,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002800 0x200>;
-		interrupts = < 45 >;
+		interrupts = < 0 13 0x04 >;
 		dma-channel = < 2 >;
 	};
 
@@ -58,7 +58,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002a00 0x200>;
-		interrupts = < 35 >;
+		interrupts = < 0 3 0x04 >;
 		dma-channel = < 1 >;
 	};
 
@@ -72,7 +72,13 @@
 	gpio: gpio at 6000d000 {
 		compatible = "nvidia,tegra20-gpio";
 		reg = < 0x6000d000 0x1000 >;
-		interrupts = < 64 65 66 67 87 119 121 >;
+		interrupts = < 0 32 0x04
+			       0 33 0x04
+			       0 34 0x04
+			       0 35 0x04
+			       0 55 0x04
+			       0 87 0x04
+			       0 89 0x04 >;
 		#gpio-cells = <2>;
 		gpio-controller;
 	};
@@ -89,79 +95,79 @@
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
-		interrupts = < 68 >;
+		interrupts = < 0 36 0x04 >;
 	};
 
 	serial at 70006040 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
-		interrupts = < 69 >;
+		interrupts = < 0 37 0x04 >;
 	};
 
 	serial at 70006200 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
-		interrupts = < 78 >;
+		interrupts = < 0 46 0x04 >;
 	};
 
 	serial at 70006300 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
-		interrupts = < 122 >;
+		interrupts = < 0 90 0x04 >;
 	};
 
 	serial at 70006400 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
-		interrupts = < 123 >;
+		interrupts = < 0 91 0x04 >;
 	};
 
 	sdhci at c8000000 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000000 0x200>;
-		interrupts = < 46 >;
+		interrupts = < 0 14 0x04 >;
 	};
 
 	sdhci at c8000200 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000200 0x200>;
-		interrupts = < 47 >;
+		interrupts = < 0 15 0x04 >;
 	};
 
 	sdhci at c8000400 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000400 0x200>;
-		interrupts = < 51 >;
+		interrupts = < 0 19 0x04 >;
 	};
 
 	sdhci at c8000600 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000600 0x200>;
-		interrupts = < 63 >;
+		interrupts = < 0 31 0x04 >;
 	};
 
 	usb at c5000000 {
 		compatible = "nvidia,tegra20-ehci", "usb-ehci";
 		reg = <0xc5000000 0x4000>;
-		interrupts = < 52 >;
+		interrupts = < 0 20 0x04 >;
 		phy_type = "utmi";
 	};
 
 	usb at c5004000 {
 		compatible = "nvidia,tegra20-ehci", "usb-ehci";
 		reg = <0xc5004000 0x4000>;
-		interrupts = < 53 >;
+		interrupts = < 0 21 0x04 >;
 		phy_type = "ulpi";
 	};
 
 	usb at c5008000 {
 		compatible = "nvidia,tegra20-ehci", "usb-ehci";
 		reg = <0xc5008000 0x4000>;
-		interrupts = < 129 >;
+		interrupts = < 0 97 0x04 >;
 		phy_type = "utmi";
 	};
 };
diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index 6e35417..6a460a2 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -52,6 +52,17 @@ void seaboard_pinmux_init(void);
 void trimslice_pinmux_init(void);
 void ventana_pinmux_init(void);
 
+static const struct of_device_id tegra_dt_irq_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init },
+	{ }
+};
+
+void __init tegra_dt_init_irq(void)
+{
+	tegra_init_irq();
+	of_irq_init(tegra_dt_irq_match);
+}
+
 struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC1_BASE, "sdhci-tegra.0", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC2_BASE, "sdhci-tegra.1", NULL),
@@ -87,11 +98,6 @@ static struct of_device_id tegra_dt_match_table[] __initdata = {
 	{}
 };
 
-static struct of_device_id tegra_dt_gic_match[] __initdata = {
-	{ .compatible = "nvidia,tegra20-gic", },
-	{}
-};
-
 static struct {
 	char *machine;
 	void (*init)(void);
@@ -105,14 +111,8 @@ static struct {
 
 static void __init tegra_dt_init(void)
 {
-	struct device_node *node;
 	int i;
 
-	node = of_find_matching_node_by_address(NULL, tegra_dt_gic_match,
-						TEGRA_ARM_INT_DIST_BASE);
-	if (node)
-		irq_domain_add_simple(node, INT_GIC_BASE);
-
 	tegra_clk_init_from_table(tegra_dt_clk_init_table);
 
 	/*
@@ -145,7 +145,7 @@ static const char * tegra_dt_board_compat[] = {
 DT_MACHINE_START(TEGRA_DT, "nVidia Tegra (Flattened Device Tree)")
 	.map_io		= tegra_map_common_io,
 	.init_early	= tegra_init_early,
-	.init_irq	= tegra_init_irq,
+	.init_irq	= tegra_dt_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.timer		= &tegra_timer,
 	.init_machine	= tegra_dt_init,
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 8ad82af..4e1afcd 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include <asm/hardware/gic.h>
 
@@ -125,6 +126,11 @@ void __init tegra_init_irq(void)
 	gic_arch_extn.irq_unmask = tegra_unmask;
 	gic_arch_extn.irq_retrigger = tegra_retrigger;
 
-	gic_init(0, 29, IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE),
-		 IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
+	/*
+	 * Check if there is a devicetree present, since the GIC will be
+	 * initialized elsewhere under DT.
+	 */
+	if (!of_have_populated_dt())
+		gic_init(0, 29, IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE),
+			IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
 }
-- 
1.7.0.4
