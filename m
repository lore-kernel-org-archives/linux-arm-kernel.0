From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 29 Nov 2016 11:12:15 +0100
Subject: [PATCH v7 6/8] ARM: dts: sun8i-h3: add HDMI video nodes
In-Reply-To: <cover.1480414715.git.moinejf@free.fr>
References: <cover.1480414715.git.moinejf@free.fr>
Message-ID: <431252931ed44a3bafaba80843bb4066ab73ed9e.1480414715.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
Note 1:
 The DE clock is not set in the driver. Instead, it is set at system
 startup time by 'assigned-clocks', but there is a problem in sunxi-ng
 which uses readl_relaxed_poll_timeout(), and, as noticed by
 Ond??ej Jirman, this function is not available at startup time.
 The fix of this problem is not part of this patchset series.
Note 2:
 The DE clock is set to a high enough rate (432MHz). It seems that
 this is needed to handle 4K video.
 But, as the proposed DE driver does not treat yet 4K video, the clock
 could be set to a lower rate. For example, the default rate for the A83T
 is 250MHz (no 4K video).
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 65 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index fca66bf..1aa087d 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -140,6 +140,16 @@
 		#size-cells = <1>;
 		ranges;
 
+		de: de-controller at 01000000 {
+			compatible = "allwinner,sun8i-h3-display-engine";
+			reg = <0x01000000 0x400000>;
+			clocks = <&ccu CLK_BUS_DE>, <&ccu CLK_DE>;
+			clock-names = "bus", "clock";
+			resets = <&ccu RST_BUS_DE>;
+			ports = <&tcon0_p>, <&tcon1_p>;
+			status = "disabled";
+		};
+
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun8i-h3-dma";
 			reg = <0x01c02000 0x1000>;
@@ -149,6 +159,37 @@
 			#dma-cells = <1>;
 		};
 
+		tcon0: lcd-controller at 01c0c000 {
+			compatible = "allwinner,sun8i-a83t-tcon";
+			reg = <0x01c0c000 0x400>;
+			clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_TCON0>;
+			clock-names = "bus", "clock";
+			resets = <&ccu RST_BUS_TCON0>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			tcon0_p: port {
+				tcon0_hdmi: endpoint {
+					remote-endpoint = <&hdmi_tcon0>;
+				};
+			};
+		};
+
+		/* not used */
+		tcon1: lcd-controller at 01c0d000 {
+			compatible = "allwinner,sun8i-h3-tcon";
+			reg = <0x01c0d000 0x400>;
+			clocks = <&ccu CLK_BUS_TCON1>,
+				 <&ccu CLK_TCON0>;	/* no clock */
+			clock-names = "bus", "clock";
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			tcon1_p: port {
+				endpoint {
+					/* empty */
+				};
+			};
+		};
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
@@ -314,6 +355,11 @@
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+
+			assigned-clocks = <&ccu CLK_PLL_DE>,
+					  <&ccu CLK_DE>;
+			assigned-clock-rates =  <864000000>,
+						<432000000>;
 		};
 
 		pio: pinctrl at 01c20800 {
@@ -567,6 +613,25 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		hdmi: hdmi at 01ee0000 {
+			compatible = "allwinner,sun8i-h3-hdmi";
+			reg = <0x01ee0000 0x20000>;
+			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI>,
+				 <&ccu CLK_HDMI_DDC>;
+			clock-names = "bus", "clock", "ddc-clock";
+			resets = <&ccu RST_BUS_HDMI0>, <&ccu RST_BUS_HDMI1>;
+			reset-names = "hdmi0", "hdmi1";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port at 0 {			/* video */
+				reg = <0>;
+				hdmi_tcon0: endpoint {
+					remote-endpoint = <&tcon0_hdmi>;
+				};
+			};
+		};
+
 		rtc: rtc at 01f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
-- 
2.10.2
