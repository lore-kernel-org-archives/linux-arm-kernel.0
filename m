From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Apr 2016 16:07:46 +0100
Subject: [[PATCH v2] 7/8] ARM: dts: STiH407: Move over to using the
 'reserved-memory' API for obtaining DMA memory
In-Reply-To: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
References: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1461251267-14897-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doing so saves quite a bit of code in the driver.

For more information on the 'reserved-memory' bindings see:

  Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

Suggested-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 47 +++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 7cd358b..33de7361 100644
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
@@ -748,9 +778,9 @@
 			status		= "okay";
 		};
 
-		st231_gp0: remote-processor at 40000000 {
+		st231_gp0: remote-processor {
 			compatible	= "st,st231-rproc";
-			reg		= <0x40000000 0x01000000>;
+			memory-region	= <&gp0_reserved>;
 			resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
 			reset-names	= "sw_reset";
 			clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_0>;
@@ -758,9 +788,10 @@
 			st,syscfg	= <&syscfg_core 0x22c>;
 		};
 
-		st231_gp1: remote-processor at 41000000 {
+
+		st231_gp1: remote-processor {
 			compatible	= "st,st231-rproc";
-			reg		= <0x41000000 0x01000000>;
+			memory-region	= <&gp1_reserved>;
 			resets		= <&softreset STIH407_ST231_GP1_SOFTRESET>;
 			reset-names	= "sw_reset";
 			clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_1>;
@@ -768,9 +799,9 @@
 			st,syscfg	= <&syscfg_core 0x220>;
 		};
 
-		st231_audio: remote-processor at 42000000 {
+		st231_audio: remote-processor {
 			compatible	= "st,st231-rproc";
-			reg		= <0x42000000 0x01000000>;
+			memory-region	= <&audio_reserved>;
 			resets		= <&softreset STIH407_ST231_AUD_SOFTRESET>;
 			reset-names	= "sw_reset";
 			clocks		= <&clk_s_c0_flexgen CLK_ST231_AUD_0>;
@@ -778,9 +809,9 @@
 			st,syscfg	= <&syscfg_core 0x228>;
 		};
 
-		st231_dmu: remote-processor at 43000000 {
+		st231_dmu: remote-processor {
 			compatible	= "st,st231-rproc";
-			reg		= <0x43000000 0x01000000>;
+			memory-region	= <&dmu_reserved>;
 			resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
 			reset-names	= "sw_reset";
 			clocks		= <&clk_s_c0_flexgen CLK_ST231_DMU>;
-- 
2.8.0
