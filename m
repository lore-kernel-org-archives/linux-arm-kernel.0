From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Fri, 14 Nov 2014 13:50:35 +0200
Subject: [PATCH v5 1/3] of: Add descriptions of thermtrip properties to Tegra
 PMC bindings
In-Reply-To: <1415965837-29331-1-git-send-email-mikko.perttunen@kapsi.fi>
References: <1415965837-29331-1-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <1415965837-29331-2-git-send-email-mikko.perttunen@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Hardware-triggered thermal reset requires configuring the I2C
reset procedure. This configuration is read from the device tree,
so document the relevant properties in the binding documentation.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index 68ac65f..2fd5051 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -47,6 +47,23 @@ Required properties when nvidia,suspend-mode=<0>:
   sleep mode, the warm boot code will restore some PLLs, clocks and then
   bring up CPU0 for resuming the system.
 
+Hardware-triggered thermal reset:
+On Tegra30, Tegra114 and Tegra124, if the 'i2c-thermtrip' subnode exists,
+hardware-triggered thermal reset will be enabled.
+
+Required properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'):
+- nvidia,i2c-controller-id : ID of I2C controller to send poweroff command to. Valid values are
+                             described in section 9.2.148 "APBDEV_PMC_SCRATCH53_0" of the
+                             Tegra K1 Technical Reference Manual.
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
@@ -69,6 +86,15 @@ pmc at 7000f400 {
 / Tegra board dts file
 {
 	...
+	pmc at 7000f400 {
+		i2c-thermtrip {
+			nvidia,i2c-controller-id = <4>;
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
