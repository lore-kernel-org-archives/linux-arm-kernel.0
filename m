From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  4 Oct 2016 11:46:25 +0200
Subject: [PATCH 12/14] ARM: dts: sun8i: Add audio codec, dai and card for A33
In-Reply-To: <cover.1475569400.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
Message-ID: <0c5caea86dea5e8f8198c61af47983ceb511ff78.1475571575.git.mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the audio codec, dai and a sun8i card to be able to use the
audio stream of the builtin codec on sun8i SoC.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index fd1e1cd..4f8b442 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -43,6 +43,7 @@
  */
 
 #include "sun8i-a23-a33.dtsi"
+#include <dt-bindings/dma/sun4i-a10.h>
 
 / {
 	cpus {
@@ -69,6 +70,12 @@
 		reg = <0x40000000 0x80000000>;
 	};
 
+	sound {
+		compatible = "allwinner,sun8i-audio";
+		allwinner,audio-codec = <&codec>;
+		allwinner,i2s-controller = <&dai>;
+	};
+
 	soc at 01c00000 {
 		tcon0: lcd-controller at 01c0c000 {
 			compatible = "allwinner,sun8i-a33-tcon";
@@ -116,6 +123,32 @@
 			reset-names = "ahb";
 		};
 
+		dai: dai at 01c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun4i-a10-i2s";
+			reg = <0x01c22c00 0x200>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_CODEC>;
+			reset-names = "apb_reset";
+			dmas = <&dma 15>, /* AUDIO_CODEC port */
+				<&dma 15>; /* AUDIO_CODEC port */
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		codec: codec at 01c22e00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-a33-codec";
+			reg = <0x01c22e00 0x400>; /* SUNXI_AUDIO_PBASE + 0x200 */
+			reg-names = "audio";
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "apb", "codec";
+			status = "disabled";
+		};
+
 		fe0: display-frontend at 01e00000 {
 			compatible = "allwinner,sun8i-a33-display-frontend";
 			reg = <0x01e00000 0x20000>;
-- 
2.9.3
