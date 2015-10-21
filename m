From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 Oct 2015 12:47:07 +0100
Subject: [PATCH v4 6/6] ARM: STiH407: Move over to using the 'reserved-memory'
 API for obtaining DMA memory
In-Reply-To: <1445428027-26174-1-git-send-email-lee.jones@linaro.org>
References: <1445428027-26174-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1445428027-26174-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doing so saves quite a bit of code in the driver.

For more information on the 'reserved-memory' bindings see:

  Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

Suggested-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 46 +++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 15c20b6..27b8efc 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -15,6 +15,36 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gp0_reserved: rproc at 40000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x40000000 0x01000000>;
+			no-map;
+		};
+
+		gp1_reserved: rproc at 41000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x41000000 0x01000000>;
+			no-map;
+		};
+
+		audio_reserved: rproc at 42000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x42000000 0x01000000>;
+			no-map;
+		};
+
+		dmu_reserved: rproc at 43000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x43000000 0x01000000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -651,9 +681,9 @@
 			status		= "okay";
 		};
 
-		st231_gp0: st231-gp0 at 40000000 {
+		st231_gp0: st231-gp0 {
 			compatible	= "st,st231-rproc";
-			reg		= <0x40000000 0x01000000>;
+			memory-region	= <&gp0_reserved>;
 			resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
 			reset-names	= "sw_reset";
 			clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_0>;
@@ -661,9 +691,9 @@
 			st,syscfg	= <&syscfg_core 0x22c>;
 		};
 
-		st231_gp1: st231-gp1 at 41000000 {
+		st231_gp1: st231-gp1 {
 			compatible	= "st,st231-rproc";
-			reg		= <0x41000000 0x01000000>;
+			memory-region	= <&gp1_reserved>;
 			resets		= <&softreset STIH407_ST231_GP1_SOFTRESET>;
 			reset-names	= "sw_reset";
 			clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_1>;
@@ -671,9 +701,9 @@
 			st,syscfg	= <&syscfg_core 0x220>;
 		};
 
-		st231_audio: st231-audio at 42000000 {
+		st231_audio: st231-audio {
 			compatible	= "st,st231-rproc";
-			reg		= <0x42000000 0x01000000>;
+			memory-region	= <&audio_reserved>;
 			resets		= <&softreset STIH407_ST231_AUD_SOFTRESET>;
 			reset-names	= "sw_reset";
 			clocks		= <&clk_s_c0_flexgen CLK_ST231_AUD_0>;
@@ -681,9 +711,9 @@
 			st,syscfg	= <&syscfg_core 0x228>;
 		};
 
-		st231_dmu: st231-dmu at 43000000 {
+		st231_dmu: st231-dmu {
 			compatible	= "st,st231-rproc";
-			reg		= <0x43000000 0x01000000>;
+			memory-region	= <&dmu_reserved>;
 			resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
 			reset-names	= "sw_reset";
 			clocks		= <&clk_s_c0_flexgen CLK_ST231_DMU>;
-- 
1.9.1
