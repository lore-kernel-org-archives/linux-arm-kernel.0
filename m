From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 18 Sep 2017 16:58:31 +0530
Subject: [PATCH v5 3/5] ARM: dts: imx6qdl-icore-rqs: Switch to use
 simple-audio-card
In-Reply-To: <1505734113-9708-1-git-send-email-jteki@openedev.com>
References: <1505734113-9708-1-git-send-email-jteki@openedev.com>
Message-ID: <1505734113-9708-3-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

This patch replace fsl,imx-audio-sgtl5000 and use simple-audio-card
for Engicam i.CoreM6 RQS QDL platform boards.

This patch also fix, pinctrl_adumux.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
- Update commit message
- Add adumux
- Update simple-audio-card,widgets
- Add ssi1 fsl,mode
- Add #sound-dai-cells in codec
Changes for v4:
- None
Changes for v3:
- Newly added

 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 60 +++++++++++++++++++++++++-------
 arch/arm/boot/dts/imx6qdl-icore.dtsi     |  4 +--
 2 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index e196d1b..e97002b 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -41,6 +41,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/imx6qdl-clock.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
 	memory {
@@ -120,28 +121,61 @@
 	};
 
 	sound {
-		compatible = "fsl,imx-audio-sgtl5000";
-		model = "imx-audio-sgtl5000";
-		ssi-controller = <&ssi1>;
-		audio-codec = <&sgtl5000>;
-		audio-routing =
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx6qdl-icore-rqs-sgtl5000";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Headphone", "Headphone Jack",
+			"Line", "Line In Jack",
+			"Speaker", "Line Out Jack",
+			"Speaker", "Ext Spk";
+		simple-audio-card,routing =
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias",
 			"Headphone Jack", "HP_OUT";
-		mux-int-port = <1>;
-		mux-ext-port = <4>;
-	};
-};
 
-&clks {
-	assigned-clocks = <&clks IMX6QDL_CLK_LVDS2_SEL>;
-	assigned-clock-parents = <&clks IMX6QDL_CLK_OSC>;
+		simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
+	};
 };
 
 &audmux {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_audmux>;
 	status = "okay";
+
+	audmux_ssi1 {
+		fsl,audmux-port = <MX51_AUDMUX_PORT1_SSI0>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TFSEL(MX51_AUDMUX_PORT4) |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR |
+			IMX_AUDMUX_V2_PTCR_TCSEL(MX51_AUDMUX_PORT4) |
+			IMX_AUDMUX_V2_PTCR_SYN)
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT4)
+		>;
+	};
+
+	audmux_aud4 {
+		fsl,audmux-port = <MX51_AUDMUX_PORT4>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT1_SSI0)
+		>;
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6QDL_CLK_LVDS2_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_OSC>;
 };
 
 &fec {
@@ -189,6 +223,7 @@
 	status = "okay";
 
 	sgtl5000: codec at a {
+		#sound-dai-cells = <0>;
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
@@ -206,6 +241,7 @@
 };
 
 &ssi1 {
+	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 9682ae2..a1b469c 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -269,8 +269,8 @@
 	pinctrl_audmux: audmux {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
-			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD 0x110b0
-			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS  0x130b0
+			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x110b0
+			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS 0x130b0
 			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
 		>;
 	};
-- 
2.7.4
