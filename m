From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 16 Jun 2014 16:57:02 +0200
Subject: [PATCH v3 3/4] ARM: tegra: tegra124: Add XUSB pad controller
In-Reply-To: <1402930623-28886-1-git-send-email-thierry.reding@gmail.com>
References: <1402930623-28886-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1402930623-28886-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The device tree node in the SoC file contains only the resources (such
as registers, resets, ...) but none of the lane assignment information
since that's board specific and belongs in the board file.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- include dt-bindings/pinctrl/pinctrl-tegra-xusb.h so that board files
  don't have to include it explicitly
- remove unneeded #address-cells/#size-cells = <0>
- add padctl label for XUSB pad controller node

 arch/arm/boot/dts/tegra124.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 6e6bc4e8185c..b7cb944b2faa 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -1,6 +1,7 @@
 #include <dt-bindings/clock/tegra124-car.h>
 #include <dt-bindings/gpio/tegra-gpio.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
+#include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
@@ -449,6 +450,15 @@
 		clock-names = "pclk", "clk32k_in";
 	};
 
+	padctl: padctl at 0,7009f000 {
+		compatible = "nvidia,tegra124-xusb-padctl";
+		reg = <0x0 0x7009f000 0x0 0x1000>;
+		resets = <&tegra_car 142>;
+		reset-names = "padctl";
+
+		#phy-cells = <1>;
+	};
+
 	sdhci at 0,700b0000 {
 		compatible = "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0000 0x0 0x200>;
-- 
1.9.2
