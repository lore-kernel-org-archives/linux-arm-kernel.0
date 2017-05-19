From: broonie@kernel.org (Mark Brown)
Date: Fri, 19 May 2017 18:37:36 +0100
Subject: Applied "ASoC: stm32: Document STM32 I2S bindings" to the asoc tree
In-Reply-To: <1495120793-11687-2-git-send-email-olivier.moysan@st.com>
Message-ID: <E1dBlqK-00057c-5h@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: Document STM32 I2S bindings

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

>From da23173d5c6558b7435e71a4ad947390a9012c6c Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Thu, 18 May 2017 17:19:51 +0200
Subject: [PATCH] ASoC: stm32: Document STM32 I2S bindings

Add documentation of device tree bindings for STM32 SPI/I2S.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/st,stm32-i2s.txt     | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt b/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
new file mode 100644
index 000000000000..4bda52042402
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
@@ -0,0 +1,62 @@
+STMicroelectronics STM32 SPI/I2S Controller
+
+The SPI/I2S block supports I2S/PCM protocols when configured on I2S mode.
+Only some SPI instances support I2S.
+
+Required properties:
+  - compatible: Must be "st,stm32h7-i2s"
+  - reg: Offset and length of the device's register set.
+  - interrupts: Must contain the interrupt line id.
+  - clocks: Must contain phandle and clock specifier pairs for each entry
+	in clock-names.
+  - clock-names: Must contain "i2sclk", "pclk", "x8k" and "x11k".
+	"i2sclk": clock which feeds the internal clock generator
+	"pclk": clock which feeds the peripheral bus interface
+	"x8k": I2S parent clock for sampling rates multiple of 8kHz.
+	"x11k": I2S parent clock for sampling rates multiple of 11.025kHz.
+  - dmas: DMA specifiers for tx and rx dma.
+    See Documentation/devicetree/bindings/dma/stm32-dma.txt.
+  - dma-names: Identifier for each DMA request line. Must be "tx" and "rx".
+  - pinctrl-names: should contain only value "default"
+  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
+
+Optional properties:
+  - resets: Reference to a reset controller asserting the reset controller
+
+The device node should contain one 'port' child node with one child 'endpoint'
+node, according to the bindings defined in Documentation/devicetree/bindings/
+graph.txt.
+
+Example:
+sound_card {
+	compatible = "audio-graph-card";
+	dais = <&i2s2_port>;
+};
+
+i2s2: audio-controller at 40003800 {
+	compatible = "st,stm32h7-i2s";
+	reg = <0x40003800 0x400>;
+	interrupts = <36>;
+	clocks = <&rcc PCLK1>, <&rcc SPI2_CK>, <&rcc PLL1_Q>, <&rcc PLL2_P>;
+	clock-names = "pclk", "i2sclk",  "x8k", "x11k";
+	dmas = <&dmamux2 2 39 0x400 0x1>,
+           <&dmamux2 3 40 0x400 0x1>;
+	dma-names = "rx", "tx";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2s2>;
+
+	i2s2_port: port at 0 {
+		cpu_endpoint: endpoint {
+			remote-endpoint = <&codec_endpoint>;
+			format = "i2s";
+		};
+	};
+};
+
+audio-codec {
+	codec_port: port at 0 {
+		codec_endpoint: endpoint {
+			remote-endpoint = <&cpu_endpoint>;
+		};
+	};
+};
-- 
2.11.0
