From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 21 Oct 2016 12:01:01 +0200
Subject: [PATCH v5 5/7] ARM: dts: sun8i-h3: add HDMI audio and video nodes
In-Reply-To: <cover.1477142934.git.moinejf@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
Message-ID: <5911d108c994630d471f7a86cc59466e2b7a0250.1477142934.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
The patch for the A83T DT is not included in this patchset because
the clock driver sunxi-ng does not support the A83T clocks.
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 75a8654..869f3be 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -140,6 +140,16 @@
 		#size-cells = <1>;
 		ranges;
 
+		de: de-controller at 01000000 {
+			compatible = "allwinner,sun8i-h3-display-engine";
+			reg = <0x01000000 0x400000>;
+			clocks = <&ccu CLK_BUS_DE>, <&ccu CLK_DE>;
+			clock-names = "gate", "clock";
+			resets = <&ccu RST_BUS_DE>;
+			ports = <&lcd0_p>;
+			status = "disabled";
+		};
+
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun8i-h3-dma";
 			reg = <0x01c02000 0x1000>;
@@ -149,6 +159,23 @@
 			#dma-cells = <1>;
 		};
 
+		lcd0: lcd-controller at 01c0c000 {
+			compatible = "allwinner,sun8i-a83t-lcd";
+			reg = <0x01c0c000 0x400>;
+			clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_TCON0>;
+			clock-names = "gate", "clock";
+			resets = <&ccu RST_BUS_TCON0>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			lcd0_p: port {
+				lcd0_hdmi: endpoint {
+					remote-endpoint = <&hdmi_lcd0>;
+				};
+			};
+		};
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
@@ -439,6 +466,22 @@
 			status = "disabled";
 		};
 
+		i2s2: i2s at 1c22800 {
+			compatible = "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x60>;
+			clocks = <&ccu CLK_I2S2>;
+			clock-names = "mod";
+			resets = <&ccu RST_BUS_I2S2>;
+			dmas = <&dma 27>;
+			dma-names = "tx";
+			status = "disabled";
+			port {
+				i2s2_hdmi: endpoint {
+					remote-endpoint = <&hdmi_i2s2>;
+				};
+			};
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
@@ -541,6 +584,30 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		hdmi: hdmi at 01ee0000 {
+			compatible = "allwinner,sun8i-h3-hdmi";
+			reg = <0x01ee0000 0x20000>;
+			clocks = <&ccu CLK_HDMI>, <&ccu CLK_HDMI_DDC>;
+			clock-names = "clock", "ddc-clock";
+			resets = <&ccu RST_BUS_HDMI0>, <&ccu RST_BUS_HDMI1>;
+			reset-names = "hdmi0", "hdmi1";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port at 0 {
+				reg = <0>;
+				hdmi_lcd0: endpoint {
+					remote-endpoint = <&lcd0_hdmi>;
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				hdmi_i2s2: endpoint {
+					remote-endpoint = <&i2s2_hdmi>;
+				};
+			};
+		};
+
 		rtc: rtc at 01f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
-- 
2.10.1
