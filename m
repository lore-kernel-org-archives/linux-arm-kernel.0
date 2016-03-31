From: simran.rai@broadcom.com (Simran Rai)
Date: Wed, 30 Mar 2016 17:24:44 -0700
Subject: [PATCH v6 1/3] ASoC: cygnus: Add DT bindings for Broadcom Cygnus audio
In-Reply-To: <1459383886-20317-1-git-send-email-simran.rai@broadcom.com>
References: <1459383886-20317-1-git-send-email-simran.rai@broadcom.com>
Message-ID: <1459383886-20317-2-git-send-email-simran.rai@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simran Rai <ssimran@broadcom.com>

Add bindings for audio driver in Broadcom Cygnus.

Signed-off-by: Lori Hikichi <lhikichi@broadcom.com>
Signed-off-by: Simran Rai <ssimran@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../bindings/sound/brcm,cygnus-audio.txt           |   67 ++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
new file mode 100644
index 0000000..b139e66
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
@@ -0,0 +1,67 @@
+BROADCOM Cygnus Audio I2S/TDM/SPDIF controller
+
+Required properties:
+	- compatible : "brcm,cygnus-audio"
+	- #address-cells: 32bit valued, 1 cell.
+	- #size-cells:  32bit valued, 0 cell.
+	- reg : Should contain audio registers location and length
+	- reg-names: names of the registers listed in "reg" property
+		Valid names are "aud" and "i2s_in". "aud" contains a
+		set of DMA, I2S_OUT and SPDIF registers. "i2s_in" contains
+		a set of I2S_IN registers.
+	- clocks: PLL and leaf clocks used by audio ports
+	- assigned-clocks: PLL and leaf clocks
+	- assigned-clock-parents: parent clocks of the assigned clocks
+		(usually the PLL)
+	- assigned-clock-rates: List of clock frequencies of the
+		assigned clocks
+	- clock-names: names of 3 leaf clocks used by audio ports
+		Valid names are "ch0_audio", "ch1_audio", "ch2_audio"
+	- interrupts: audio DMA interrupt number
+
+SSP Subnode properties:
+- reg: The index of ssp port interface to use
+	Valid value are 0, 1, 2, or 3 (for spdif)
+
+Example:
+	cygnus_audio: audio at 180ae000 {
+		compatible = "brcm,cygnus-audio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x180ae000 0xafd>, <0x180aec00 0x1f8>;
+		reg-names = "aud", "i2s_in";
+		clocks = <&audiopll BCM_CYGNUS_AUDIOPLL_CH0>,
+				<&audiopll BCM_CYGNUS_AUDIOPLL_CH1>,
+				<&audiopll BCM_CYGNUS_AUDIOPLL_CH2>;
+		assigned-clocks = <&audiopll BCM_CYGNUS_AUDIOPLL>,
+							<&audiopll BCM_CYGNUS_AUDIOPLL_CH0>,
+							<&audiopll BCM_CYGNUS_AUDIOPLL_CH1>,
+							<&audiopll BCM_CYGNUS_AUDIOPLL_CH2>;
+		assigned-clock-parents = <&audiopll BCM_CYGNUS_AUDIOPLL>;
+		assigned-clock-rates = <1769470191>,
+								<0>,
+								<0>,
+								<0>;
+		clock-names = "ch0_audio", "ch1_audio", "ch2_audio";
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+
+		ssp0: ssp_port at 0 {
+			reg = <0>;
+			status = "okay";
+		};
+
+		ssp1: ssp_port at 1 {
+			reg = <1>;
+			status = "disabled";
+		};
+
+		ssp2: ssp_port at 2 {
+			reg = <2>;
+			status = "disabled";
+		};
+
+		spdif: spdif_port at 3 {
+			reg = <3>;
+			status = "disabled";
+		};
+	};
-- 
1.7.9.5
