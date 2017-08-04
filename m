From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  4 Aug 2017 15:12:12 +0200
Subject: [PATCH v2 1/2] ARM64: dts: meson-gx: update AO clkc to new bindings
In-Reply-To: <1501852333-3560-1-git-send-email-narmstrong@baylibre.com>
References: <1501852333-3560-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1501852333-3560-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AO clkc needs to be updated to new bindings with an system control parent
node and moving the clkc node as subnode.

Also adds the SoC specific compatible following the bindings requirements.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 14 +++++++++-----
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi  |  4 ++++
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index edd31cf..7b7fbc8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -367,11 +367,15 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
 
-			clkc_AO: clock-controller at 040 {
-				compatible = "amlogic,gx-aoclkc", "amlogic,gxbb-aoclkc";
-				reg = <0x0 0x00040 0x0 0x4>;
-				#clock-cells = <1>;
-				#reset-cells = <1>;
+			sysctrl_AO: sys-ctrl at 0 {
+				compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
+				reg =  <0x0 0x0 0x0 0x100>;
+
+				clkc_AO: clock-controller {
+					compatible = "amlogic,meson-gx-aoclkc";
+					#clock-cells = <1>;
+					#reset-cells = <1>;
+				};
 			};
 
 			sec_AO: ao-secure at 140 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 17d3efd..3e5e895 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -307,6 +307,10 @@
 	};
 };
 
+&clkc_AO {
+	compatible = "amlogic,meson-gxbb-aoclkc", "amlogic,meson-gx-aoclkc";
+};
+
 &ethmac {
 	clocks = <&clkc CLKID_ETH>,
 		 <&clkc CLKID_FCLK_DIV2>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 8d4f316..39bbe3a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -207,6 +207,10 @@
 	};
 };
 
+&clkc_AO {
+	compatible = "amlogic,meson-gxl-aoclkc", "amlogic,meson-gx-aoclkc";
+};
+
 &hdmi_tx {
 	compatible = "amlogic,meson-gxl-dw-hdmi", "amlogic,meson-gx-dw-hdmi";
 	resets = <&reset RESET_HDMITX_CAPB3>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index fe451cc..19a798d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -117,6 +117,10 @@
 	};
 };
 
+&clkc_AO {
+	compatible = "amlogic,meson-gxm-aoclkc", "amlogic,meson-gx-aoclkc";
+};
+
 &saradc {
 	compatible = "amlogic,meson-gxm-saradc", "amlogic,meson-saradc";
 };
-- 
1.9.1
