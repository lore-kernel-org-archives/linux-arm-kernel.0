From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 15:06:50 -0700
Subject: [PATCH 2/9] ASoC: cygnus: Update bindings for audio clock changes
In-Reply-To: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow each audio port to select which clock (if any) it wants to use.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 .../bindings/sound/brcm,cygnus-audio.txt           | 70 ++++++++++++++--------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
index b139e66..2ef2f2c 100644
--- a/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
+++ b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
@@ -9,19 +9,28 @@ Required properties:
 		Valid names are "aud" and "i2s_in". "aud" contains a
 		set of DMA, I2S_OUT and SPDIF registers. "i2s_in" contains
 		a set of I2S_IN registers.
-	- clocks: PLL and leaf clocks used by audio ports
-	- assigned-clocks: PLL and leaf clocks
-	- assigned-clock-parents: parent clocks of the assigned clocks
-		(usually the PLL)
-	- assigned-clock-rates: List of clock frequencies of the
-		assigned clocks
-	- clock-names: names of 3 leaf clocks used by audio ports
-		Valid names are "ch0_audio", "ch1_audio", "ch2_audio"
 	- interrupts: audio DMA interrupt number
 
+Optional properties:
+	- assigned-clocks: only valid choice is audiopll
+	- assigned-clock-rates: clock frequency for audiopll
+If none of the ports need an internal master clock then there no need to
+initialize the pll clock.
+
+
 SSP Subnode properties:
-- reg: The index of ssp port interface to use
-	Valid value are 0, 1, 2, or 3 (for spdif)
+Required:
+	- reg: The index of ssp port interface to use
+		Valid value are 0, 1, 2, or 3 (for spdif)
+Optional:
+	- clocks: clock used by audio port
+		  one of the audiopll outputs (see brcm,iproc-clocks.txt).
+	- clock-names: Must be "ssp_clk"
+	- brcm,ssp-clk-mux = Needed if a clock is named and used.  This value is
+			used to program the mux within the audio driver which selects
+			the incoming clock. Here is the mapping.
+			audio_pll   output 0 = 0, output 1 = 1, and output 2 = 2
+
 
 Example:
 	cygnus_audio: audio at 180ae000 {
@@ -30,38 +39,49 @@ Example:
 		#size-cells = <0>;
 		reg = <0x180ae000 0xafd>, <0x180aec00 0x1f8>;
 		reg-names = "aud", "i2s_in";
-		clocks = <&audiopll BCM_CYGNUS_AUDIOPLL_CH0>,
-				<&audiopll BCM_CYGNUS_AUDIOPLL_CH1>,
-				<&audiopll BCM_CYGNUS_AUDIOPLL_CH2>;
-		assigned-clocks = <&audiopll BCM_CYGNUS_AUDIOPLL>,
-							<&audiopll BCM_CYGNUS_AUDIOPLL_CH0>,
-							<&audiopll BCM_CYGNUS_AUDIOPLL_CH1>,
-							<&audiopll BCM_CYGNUS_AUDIOPLL_CH2>;
-		assigned-clock-parents = <&audiopll BCM_CYGNUS_AUDIOPLL>;
-		assigned-clock-rates = <1769470191>,
-								<0>,
-								<0>,
-								<0>;
-		clock-names = "ch0_audio", "ch1_audio", "ch2_audio";
+
+		assigned-clocks = <&audiopll BCM_CYGNUS_AUDIOPLL>;
+		assigned-clock-rates = <1376255989>;
+
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 
 		ssp0: ssp_port at 0 {
 			reg = <0>;
+
+			clocks = <&audiopll BCM_CYGNUS_AUDIOPLL_CH0>;
+			clock-names = "ssp_clk";
+			brcm,ssp-clk-mux = <0>;
+
 			status = "okay";
 		};
 
 		ssp1: ssp_port at 1 {
 			reg = <1>;
-			status = "disabled";
+
+			clocks = <&audiopll BCM_CYGNUS_AUDIOPLL_CH1>;
+			clock-names = "ssp_clk";
+			brcm,ssp-clk-mux = <1>;
+
+			status = "okay";
 		};
 
 		ssp2: ssp_port at 2 {
 			reg = <2>;
-			status = "disabled";
+
+			clocks = <&audiopll BCM_CYGNUS_AUDIOPLL_CH2>;
+			clock-names = "ssp_clk";
+			brcm,ssp-clk-mux = <2>;
+
+			status = "okay";
 		};
 
 		spdif: spdif_port at 3 {
 			reg = <3>;
+
+			clocks = <&audiopll BCM_CYGNUS_AUDIOPLL_CH2>;
+       			clock-names = "ssp_clk";
+			brcm,ssp-clk-mux = <2>;
+
 			status = "disabled";
 		};
 	};
-- 
1.9.1
