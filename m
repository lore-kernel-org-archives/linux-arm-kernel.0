From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Mon, 10 Nov 2014 15:12:13 +0200
Subject: [PATCH v4 REPOST 1/5] of: Add descriptions of thermtrip properties to
 Tegra PMC bindings
In-Reply-To: <1415625137-4791-1-git-send-email-mikko.perttunen@kapsi.fi>
References: <1415625137-4791-1-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <1415625137-4791-2-git-send-email-mikko.perttunen@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Hardware-triggered thermal reset requires configuring the I2C
reset procedure. This configuration is read from the device tree,
so document the relevant properties in the binding documentation.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Wei Ni <wni@nvidia.com>
Tested-by: Wei Ni <wni@nvidia.com>
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index 68ac65f..dc13fb0 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -47,6 +47,21 @@ Required properties when nvidia,suspend-mode=<0>:
   sleep mode, the warm boot code will restore some PLLs, clocks and then
   bring up CPU0 for resuming the system.
 
+Hardware-triggered thermal reset:
+On Tegra30, Tegra114 and Tegra124, if the 'i2c-thermtrip' subnode exists,
+hardware-triggered thermal reset will be enabled.
+
+Required properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'):
+- nvidia,i2c-bus : Phandle to I2C bus containing the PMU
+- nvidia,bus-addr : Bus address of the PMU on the I2C bus
+- nvidia,reg-addr : I2C register address to write poweroff command to
+- nvidia,reg-data : Poweroff command to write to PMU
+
+Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'):
+- nvidia,pinmux-id : Pinmux used by the hardware when issuing poweroff command.
+                     Defaults to 0. Valid values are described in section 12.5.2
+                     "Pinmux Support" of the Tegra4 Technical Reference Manual.
+
 Example:
 
 / SoC dts including file
@@ -69,6 +84,15 @@ pmc at 7000f400 {
 / Tegra board dts file
 {
 	...
+	pmc at 7000f400 {
+		i2c-thermtrip {
+			nvidia,i2c-bus = <&pmic_bus>;
+			nvidia,bus-addr = <0x40>;
+			nvidia,reg-addr = <0x36>;
+			nvidia,reg-data = <0x2>;
+		};
+	};
+	...
 	clocks {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.1.3
