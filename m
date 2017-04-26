From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Apr 2017 16:50:33 +0100
Subject: Applied "ASoC: stm32: add bindings for SAI" to the asoc tree
In-Reply-To: <1491837596-2924-2-git-send-email-olivier.moysan@st.com>
Message-ID: <E1d3PD7-0002Rd-JM@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: add bindings for SAI

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

>From b45c4f117b002a902e8b9f52eaf542e3e82c36a8 Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Mon, 10 Apr 2017 17:19:55 +0200
Subject: [PATCH] ASoC: stm32: add bindings for SAI

This patch adds documentation of device tree bindings for the
STM32 SAI ASoC driver.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/st,stm32-sai.txt     | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
new file mode 100644
index 000000000000..c59a3d779e06
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -0,0 +1,89 @@
+STMicroelectronics STM32 Serial Audio Interface (SAI).
+
+The SAI interface (Serial Audio Interface) offers a wide set of audio protocols
+as I2S standards, LSB or MSB-justified, PCM/DSP, TDM, and AC'97.
+The SAI contains two independent audio sub-blocks. Each sub-block has
+its own clock generator and I/O lines controller.
+
+Required properties:
+  - compatible: Should be "st,stm32f4-sai"
+  - reg: Base address and size of SAI common register set.
+  - clocks: Must contain phandle and clock specifier pairs for each entry
+	in clock-names.
+  - clock-names: Must contain "x8k" and "x11k"
+	"x8k": SAI parent clock for sampling rates multiple of 8kHz.
+	"x11k": SAI parent clock for sampling rates multiple of 11.025kHz.
+  - interrupts: cpu DAI interrupt line shared by SAI sub-blocks
+
+Optional properties:
+  - resets: Reference to a reset controller asserting the SAI
+
+SAI subnodes:
+Two subnodes corresponding to SAI sub-block instances A et B can be defined.
+Subnode can be omitted for unsused sub-block.
+
+SAI subnodes required properties:
+  - compatible: Should be "st,stm32-sai-sub-a" or "st,stm32-sai-sub-b"
+	for SAI sub-block A or B respectively.
+  - reg: Base address and size of SAI sub-block register set.
+  - clocks: Must contain one phandle and clock specifier pair
+	for sai_ck which feeds the internal clock generator.
+  - clock-names: Must contain "sai_ck".
+  - dmas: see Documentation/devicetree/bindings/dma/stm32-dma.txt
+  - dma-names: identifier string for each DMA request line
+	"tx": if sai sub-block is configured as playback DAI
+	"rx": if sai sub-block is configured as capture DAI
+  - pinctrl-names: should contain only value "default"
+  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
+
+Example:
+sound_card {
+	compatible = "audio-graph-card";
+	dais = <&sai1b_port>;
+};
+
+sai1: sai1 at 40015800 {
+	compatible = "st,stm32f4-sai";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+	reg = <0x40015800 0x4>;
+	clocks = <&rcc 1 CLK_SAIQ_PDIV>, <&rcc 1 CLK_I2SQ_PDIV>;
+	clock-names = "x8k", "x11k";
+	interrupts = <87>;
+
+	sai1b: audio-controller at 40015824 {
+		#sound-dai-cells = <0>;
+		compatible = "st,stm32-sai-sub-b";
+		reg = <0x40015824 0x1C>;
+		clocks = <&rcc 1 CLK_SAI2>;
+		clock-names = "sai_ck";
+		dmas = <&dma2 5 0 0x400 0x0>;
+		dma-names = "tx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sai1b>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sai1b_port: port at 0 {
+				reg = <0>;
+				cpu_endpoint: endpoint {
+					remote-endpoint = <&codec_endpoint>;
+					audio-graph-card,format = "i2s";
+					audio-graph-card,bitclock-master = <&codec_endpoint>;
+					audio-graph-card,frame-master = <&codec_endpoint>;
+				};
+			};
+		};
+	};
+};
+
+audio-codec {
+	codec_port: port {
+		codec_endpoint: endpoint {
+			remote-endpoint = <&cpu_endpoint>;
+		};
+	};
+};
-- 
2.11.0
