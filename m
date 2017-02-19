From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 19 Feb 2017 22:41:47 +0100
Subject: [PATCH v5 7/9] ARM64: dts: meson-gxbb-p201: fix ethernet support
In-Reply-To: <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
References: <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
 <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170219214149.30418-8-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amlogic's own .dts specifies that the P201 board uses a RMII PHY (with
the reset GPIO being GPIOZ_14).
However our P201 board .dts simply inherits the phy-mode setting from
from meson-gx.dtsi where it defaults to RGMII mode.
Remove all ethernet settings from meson-gxbb-p20x.dtsi as it only
specifies the RGMII pins which are only valid for the P200 board.
Instead we add the ethmac node to the meson-gxbb-p201.dts and configure
the pinctrl property and the phy-mode for an RMII PHY.

An MDIO node (which would also specify the PHY) is not added since we
don't know which PHY is being used (and thus which PHY address would
have to be used).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts  | 11 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi |  6 ------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
index 39bb037a3e47..ae3194663d64 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
@@ -50,3 +50,14 @@
 	compatible = "amlogic,p201", "amlogic,meson-gxbb";
 	model = "Amlogic Meson GXBB P201 Development Board";
 };
+
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_rmii_pins>;
+	pinctrl-names = "default";
+	phy-mode = "rmii";
+
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 4a96e0f6f926..17ebe46e48d4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -144,12 +144,6 @@
 	pinctrl-names = "default";
 };
 
-&ethmac {
-	status = "okay";
-	pinctrl-0 = <&eth_rgmii_pins>;
-	pinctrl-names = "default";
-};
-
 &ir {
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
-- 
2.11.1
