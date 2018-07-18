From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 18 Jul 2018 20:46:28 +0800
Subject: [PATCH v3 07/18] arm64: dts: allwinner: a64: Add tcon1 HDMI
 pipeline
In-Reply-To: <20180718105458.22304-8-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
 <20180718105458.22304-8-jagan@amarulasolutions.com>
Message-ID: <651D2B3B-FD6A-49DE-A11F-2A5119114AFC@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?18? GMT+08:00 ??6:54:47, Jagan Teki <jagan@amarulasolutions.com> ??:
>HDMI on Allwinner A64 similar behaviour like H3 with
>PHY of two clock parents (pll-0, pll-1) connected via
>second mixer and tcon.
>
>Add all require entries needed for HDMI to function.
>
>Note, that Figure 3-3.Module Clock Diagram also showing
>HDMI connected via TCON0 with PLL_VIDEO0. this can be add
>it in future once we have mixer0 pipeline.
>
>Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>---
>Changes for v3:
>- Squash all pipeline components in one patch
>- Add status for mixer1 and tcon1
>Changes for v2:
>- Change compatibles and other based on previous patch changes
>
> arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 110 ++++++++++++++++++
> 1 file changed, 110 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>index 840753432ea5..572569d8b577 100644
>--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>@@ -112,6 +112,12 @@
> 		};
> 	};
> 
>+	de: display-engine {
>+		compatible = "allwinner,sun50i-a64-display-engine";
>+		allwinner,pipelines = <&mixer1>;
>+		status = "disabled";
>+	};
>+
> 	osc24M: osc24M_clk {
> 		#clock-cells = <0>;
> 		compatible = "fixed-clock";
>@@ -196,6 +202,30 @@
> 			};
> 		};
> 
>+		mixer1: mixer at 1200000 {
>+			compatible = "allwinner,sun50i-a64-de2-mixer-1";
>+			reg = <0x01200000 0x100000>;
>+			clocks = <&display_clocks CLK_BUS_MIXER1>,
>+				 <&display_clocks CLK_MIXER1>;
>+			clock-names = "bus",
>+				      "mod";
>+			resets = <&display_clocks RST_WB>;
>+			status = "disabled";
>+
>+			ports {
>+				#address-cells = <1>;
>+				#size-cells = <0>;
>+
>+				mixer1_out: port at 1 {
>+					reg = <1>;
>+
>+					mixer1_out_tcon1: endpoint {
>+						remote-endpoint = <&tcon1_in_mixer1>;
>+					};
>+				};
>+			};
>+		};
>+

It should be subnode of DE2 bus to get the SRAM access
managed by that driver.

> 		syscon: syscon at 1c00000 {
> 			compatible = "allwinner,sun50i-a64-system-control";
> 			reg = <0x01c00000 0x1000>;
>@@ -228,6 +258,42 @@
> 			#dma-cells = <1>;
> 		};
> 
>+		tcon1: lcd-controller at 1c0d000 {
>+			compatible = "allwinner,sun50i-a64-tcon-tv",
>+				     "allwinner,sun8i-a83t-tcon-tv";
>+			reg = <0x01c0d000 0x1000>;
>+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>+			clocks = <&ccu CLK_BUS_TCON1>, <&ccu CLK_TCON1>;
>+			clock-names = "ahb", "tcon-ch1";
>+			resets = <&ccu RST_BUS_TCON1>;
>+			reset-names = "lcd";
>+			status = "disabled";
>+
>+			ports {
>+				#address-cells = <1>;
>+				#size-cells = <0>;
>+
>+				tcon1_in: port at 0 {
>+					reg = <0>;
>+
>+					tcon1_in_mixer1: endpoint {
>+						remote-endpoint = <&mixer1_out_tcon1>;
>+					};
>+				};
>+
>+				tcon1_out: port at 1 {
>+					#address-cells = <1>;
>+					#size-cells = <0>;
>+					reg = <1>;
>+
>+					tcon1_out_hdmi: endpoint at 1 {
>+						reg = <1>;
>+						remote-endpoint = <&hdmi_in_tcon1>;
>+					};
>+				};
>+			};
>+		};
>+
> 		mmc0: mmc at 1c0f000 {
> 			compatible = "allwinner,sun50i-a64-mmc";
> 			reg = <0x01c0f000 0x1000>;
>@@ -688,6 +754,50 @@
> 			status = "disabled";
> 		};
> 
>+		hdmi: hdmi at 1ee0000 {
>+			compatible = "allwinner,sun50i-a64-dw-hdmi",
>+				     "allwinner,sun8i-a83t-dw-hdmi";
>+			reg = <0x01ee0000 0x10000>;
>+			reg-io-width = <1>;
>+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
>+			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
>+				 <&ccu CLK_HDMI>;
>+			clock-names = "iahb", "isfr", "tmds";
>+			resets = <&ccu RST_BUS_HDMI1>;
>+			reset-names = "ctrl";
>+			phys = <&hdmi_phy>;
>+			phy-names = "hdmi-phy";
>+			status = "disabled";
>+
>+			ports {
>+				#address-cells = <1>;
>+				#size-cells = <0>;
>+
>+				hdmi_in: port at 0 {
>+					reg = <0>;
>+
>+					hdmi_in_tcon1: endpoint {
>+						remote-endpoint = <&tcon1_out_hdmi>;
>+					};
>+				};
>+
>+				hdmi_out: port at 1 {
>+					reg = <1>;
>+				};
>+			};
>+		};
>+
>+		hdmi_phy: hdmi-phy at 1ef0000 {
>+			compatible = "allwinner,sun50i-a64-hdmi-phy";
>+			reg = <0x01ef0000 0x10000>;
>+			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
>+				 <&ccu CLK_PLL_VIDEO0>, <&ccu CLK_PLL_VIDEO1>;
>+			clock-names = "bus", "mod", "pll-0", "pll-1";
>+			resets = <&ccu RST_BUS_HDMI0>;
>+			reset-names = "phy";
>+			#phy-cells = <0>;
>+		};
>+
> 		rtc: rtc at 1f00000 {
> 			compatible = "allwinner,sun6i-a31-rtc";
> 			reg = <0x01f00000 0x54>;
