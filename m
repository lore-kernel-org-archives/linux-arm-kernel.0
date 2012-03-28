From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 28 Mar 2012 16:33:51 +0200
Subject: [PATCH v5 09/16] pwm: tegra: Add device tree support
In-Reply-To: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1332945238-14897-10-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add auxdata to instantiate the PWFM controller from a device tree,
include the corresponding nodes in the dtsi files for Tegra 20 and
Tegra 30 and add binding documentation.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---
Changes in v5:
- rename tegra-pwm.txt to nvidia,tegra20-pwm.txt

Changes in v4:
- add DT binding documentation
- allow nvidia,tegra20-pwm as fallback for nvidia,tegra30-pwm
- export OF device table (for module auto-loading)

Changes in v3:
- add missing include for mach/iomap.h

 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |   18 ++++++++++++++++++
 arch/arm/boot/dts/tegra20.dtsi                     |    6 ++++++
 arch/arm/boot/dts/tegra30.dtsi                     |    6 ++++++
 arch/arm/mach-tegra/board-dt-tegra20.c             |    1 +
 arch/arm/mach-tegra/board-dt-tegra30.c             |    3 +++
 drivers/pwm/pwm-tegra.c                            |   11 +++++++++++
 6 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
new file mode 100644
index 0000000..bbbeedb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -0,0 +1,18 @@
+Tegra SoC PWFM controller
+
+Required properties:
+- compatible: should be one of:
+  - "nvidia,tegra20-pwm"
+  - "nvidia,tegra30-pwm"
+- reg: physical base address and length of the controller's registers
+- #pwm-cells: On Tegra the number of cells used to specify a PWM is 2. The
+  first cell specifies the per-chip index of the PWM to use and the second
+  cell is the duty cycle in nanoseconds.
+
+Example:
+
+	pwm: pwm at 7000a000 {
+		compatible = "nvidia,tegra20-pwm";
+		reg = <0x7000a000 0x100>;
+		#pwm-cells = <2>;
+	};
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 108e894..55b28fd 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -154,6 +154,12 @@
 		interrupts = < 0 91 0x04 >;
 	};
 
+	pwm: pwm at 7000a000 {
+		compatible = "nvidia,tegra20-pwm";
+		reg = <0x7000a000 0x100>;
+		#pwm-cells = <2>;
+	};
+
 	emc at 7000f400 {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 62a7b39..3fa5211 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -154,6 +154,12 @@
 		interrupts = < 0 91 0x04 >;
 	};
 
+	pwm: pwm at 7000a000 {
+		compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";
+		reg = <0x7000a000 0x100>;
+		#pwm-cells = <2>;
+	};
+
 	sdhci at 78000000 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000000 0x200>;
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index e20b419..2180954 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -73,6 +73,7 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 		       &tegra_ehci2_device.dev.platform_data),
 	OF_DEV_AUXDATA("nvidia,tegra20-ehci", TEGRA_USB3_BASE, "tegra-ehci.2",
 		       &tegra_ehci3_device.dev.platform_data),
+	OF_DEV_AUXDATA("nvidia,tegra20-pwm", TEGRA_PWFM_BASE, "tegra-pwm", NULL),
 	{}
 };
 
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 5f7c03e..5e1180f 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -33,6 +33,8 @@
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
 
+#include <mach/iomap.h>
+
 #include "board.h"
 #include "clock.h"
 
@@ -51,6 +53,7 @@ struct of_dev_auxdata tegra30_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-i2c", 0x7000C500, "tegra-i2c.2", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-i2c", 0x7000C700, "tegra-i2c.3", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-i2c", 0x7000D000, "tegra-i2c.4", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-pwm", TEGRA_PWFM_BASE, "tegra-pwm", NULL),
 	{}
 };
 
diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 2219be1..981f28a 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -239,9 +239,20 @@ static int __devexit tegra_pwm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id tegra_pwm_of_match[] = {
+	{ .compatible = "nvidia,tegra20-pwm" },
+	{ .compatible = "nvidia,tegra30-pwm" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
+#endif
+
 static struct platform_driver tegra_pwm_driver = {
 	.driver = {
 		.name = "tegra-pwm",
+		.of_match_table = of_match_ptr(tegra_pwm_of_match),
 	},
 	.probe = tegra_pwm_probe,
 	.remove = __devexit_p(tegra_pwm_remove),
-- 
1.7.9.4
