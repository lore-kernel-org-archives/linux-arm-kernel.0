From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 May 2016 18:45:58 +0100
Subject: Applied "ASoC: cygnus: Add DT bindings for Broadcom Cygnus audio" to
 the asoc tree
In-Reply-To: <1459277192-10942-2-git-send-email-simran.rai@broadcom.com>
Message-ID: <E1b7njq-00063a-OB@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: cygnus: Add DT bindings for Broadcom Cygnus audio

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 36e5ecc2986f4712d8fdfc05ed1e5d39dda7096d Mon Sep 17 00:00:00 2001
From: Simran Rai <ssimran@broadcom.com>
Date: Tue, 17 May 2016 17:01:07 -0700
Subject: [PATCH] ASoC: cygnus: Add DT bindings for Broadcom Cygnus audio

Add bindings for audio driver in Broadcom Cygnus.

Signed-off-by: Lori Hikichi <lhikichi@broadcom.com>
Signed-off-by: Simran Rai <ssimran@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/brcm,cygnus-audio.txt           | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
new file mode 100644
index 000000000000..b139e66d2a11
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
2.8.1
