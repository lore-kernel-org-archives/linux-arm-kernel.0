From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 19:42:40 +0100
Subject: [PATCH V3 13/15] ARM: dts: Exynos4 and Odroid X2/U3 sound device nodes
 update
In-Reply-To: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1421260962-16892-14-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock related properties are added to the Exynos4 I2S device nodes
so they can be referred to as clock providers. Missing i2s_opclk1
clock is added to the I2S0 node and clock properties are added
to the MAX98090 codec node to allow it to control/read frequency
of the MCLK clock directly.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi                  |    6 ++++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |    8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index b8168f1..38d8f68 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -61,6 +61,8 @@
 		reg = <0x03830000 0x100>;
 		clocks = <&clock_audss EXYNOS_I2S_BUS>;
 		clock-names = "iis";
+		#clock-cells = <1>;
+		clock-output-names = "i2s_cdclk0";
 		dmas = <&pdma0 12>, <&pdma0 11>, <&pdma0 10>;
 		dma-names = "tx", "rx", "tx-sec";
 		samsung,idma-addr = <0x03000000>;
@@ -372,6 +374,8 @@
 		reg = <0x13960000 0x100>;
 		clocks = <&clock CLK_I2S1>;
 		clock-names = "iis";
+		#clock-cells = <1>;
+		clock-output-names = "i2s_cdclk1";
 		dmas = <&pdma1 12>, <&pdma1 11>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -382,6 +386,8 @@
 		reg = <0x13970000 0x100>;
 		clocks = <&clock CLK_I2S2>;
 		clock-names = "iis";
+		#clock-cells = <1>;
+		clock-output-names = "i2s_cdclk2";
 		dmas = <&pdma0 14>, <&pdma0 13>;
 		dma-names = "tx", "rx";
 		status = "disabled";
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 3fbf588..c26b9fb 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -7,6 +7,7 @@
  * published by the Free Software Foundation.
 */
 
+#include <dt-bindings/sound/samsung-i2s.h>
 #include <dt-bindings/input/input.h>
 #include "exynos4412.dtsi"
 
@@ -37,8 +38,9 @@
 		pinctrl-names = "default";
 		status = "okay";
 		clocks = <&clock_audss EXYNOS_I2S_BUS>,
-			 <&clock_audss EXYNOS_DOUT_AUD_BUS>;
-		clock-names = "iis", "i2s_opclk0";
+			 <&clock_audss EXYNOS_DOUT_AUD_BUS>,
+			 <&clock_audss EXYNOS_SCLK_I2S>;
+		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
 	};
 
 	sound: sound {
@@ -373,6 +375,8 @@
 			reg = <0x10>;
 			interrupt-parent = <&gpx0>;
 			interrupts = <0 0>;
+			clocks = <&i2s0 CLK_I2S_CDCLK>;
+			clock-names = "mclk";
 		};
 	};
 
-- 
1.7.9.5
