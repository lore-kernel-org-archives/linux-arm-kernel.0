From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Mar 2017 16:53:00 +0800
Subject: [PATCH 2/3] arm64: dts: zte: add vou and hdmi devices for zx296718
In-Reply-To: <1490086381-17030-1-git-send-email-shawnguo@kernel.org>
References: <1490086381-17030-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1490086381-17030-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds VOU DPC device and enables HDMI support, which includes both
display and audio through SPDIF interface.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718-evb.dts | 20 ++++++++++++++
 arch/arm64/boot/dts/zte/zx296718.dtsi    | 46 ++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718-evb.dts b/arch/arm64/boot/dts/zte/zx296718-evb.dts
index 238311b4cf0f..bb900d2bbcfb 100644
--- a/arch/arm64/boot/dts/zte/zx296718-evb.dts
+++ b/arch/arm64/boot/dts/zte/zx296718-evb.dts
@@ -57,16 +57,36 @@
 		reg = <0x40000000 0x40000000>;
 	};
 
+	sound0 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "zx_snd_spdif0";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif0>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+	};
 };
 
 &emmc {
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
 &sd1 {
 	status = "okay";
 };
 
+&spdif0 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 921f3ec52a1a..7b2bb962daf1 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -366,6 +366,40 @@
 			#clock-cells = <1>;
 		};
 
+		vou: vou at 1440000 {
+			compatible = "zte,zx296718-vou";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1440000 0x10000>;
+
+			dpc: dpc at 0 {
+				compatible = "zte,zx296718-dpc";
+				reg = <0x0000 0x1000>, <0x1000 0x1000>,
+				      <0x5000 0x1000>, <0x6000 0x1000>,
+				      <0xa000 0x1000>;
+				reg-names = "osd", "timing_ctrl",
+					    "dtrc", "vou_ctrl",
+					    "otfppu";
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&topcrm VOU_ACLK>, <&topcrm VOU_PPU_WCLK>,
+					 <&topcrm VOU_MAIN_WCLK>, <&topcrm VOU_AUX_WCLK>;
+				clock-names = "aclk", "ppu_wclk",
+					      "main_wclk", "aux_wclk";
+			};
+
+			hdmi: hdmi at c000 {
+				compatible = "zte,zx296718-hdmi";
+				reg = <0xc000 0x4000>;
+				interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&topcrm HDMI_OSC_CEC>,
+					 <&topcrm HDMI_OSC_CLK>,
+					 <&topcrm HDMI_XCLK>;
+				clock-names = "osc_cec", "osc_clk", "xclk";
+				#sound-dai-cells = <0>;
+				status = "disabled";
+			};
+		};
+
 		topcrm: clock-controller at 1461000 {
 			compatible = "zte,zx296718-topcrm";
 			reg = <0x01461000 0x1000>;
@@ -403,6 +437,18 @@
 			reg = <0x01480000 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		spdif0: spdif at 1488000 {
+			compatible = "zte,zx296702-spdif";
+			reg = <0x1488000 0x1000>;
+			clocks = <&audiocrm AUDIO_SPDIF0_WCLK>;
+			clock-names = "tx";
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			#sound-dai-cells = <0>;
+			dmas = <&dma 30>;
+			dma-names = "tx";
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.9.1
