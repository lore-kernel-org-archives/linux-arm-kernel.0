From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Jun 2017 12:16:38 +0100
Subject: Applied "ASoC: stm32: Add DT bindings for SPDIFRX interface" to the
 asoc tree
In-Reply-To: <1497621452-615-2-git-send-email-olivier.moysan@st.com>
Message-ID: <E1dNdck-0004E4-6T@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: Add DT bindings for SPDIFRX interface

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

>From 0507cb0226acfd7ba114c59f6a76fdc7a1c6b01e Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Tue, 20 Jun 2017 11:58:46 +0200
Subject: [PATCH] ASoC: stm32: Add DT bindings for SPDIFRX interface

Add documentation of device tree bindings for the
STM32 SPDIFRX interface.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/st,stm32-spdifrx.txt | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
new file mode 100644
index 000000000000..33826f2459fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
@@ -0,0 +1,56 @@
+STMicroelectronics STM32 S/PDIF receiver (SPDIFRX).
+
+The SPDIFRX peripheral, is designed to receive an S/PDIF flow compliant with
+IEC-60958 and IEC-61937.
+
+Required properties:
+  - compatible: should be "st,stm32h7-spdifrx"
+  - reg: cpu DAI IP base address and size
+  - clocks: must contain an entry for kclk (used as S/PDIF signal reference)
+  - clock-names: must contain "kclk"
+  - interrupts: cpu DAI interrupt line
+  - dmas: DMA specifiers for audio data DMA and iec control flow DMA
+    See STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt
+  - dma-names: two dmas have to be defined, "rx" and "rx-ctrl"
+
+Optional properties:
+  - resets: Reference to a reset controller asserting the SPDIFRX
+
+The device node should contain one 'port' child node with one child 'endpoint'
+node, according to the bindings defined in Documentation/devicetree/bindings/
+graph.txt.
+
+Example:
+spdifrx: spdifrx at 40004000 {
+	compatible = "st,stm32h7-spdifrx";
+	reg = <0x40004000 0x400>;
+	clocks = <&rcc SPDIFRX_CK>;
+	clock-names = "kclk";
+	interrupts = <97>;
+	dmas = <&dmamux1 2 93 0x400 0x0>,
+	       <&dmamux1 3 94 0x400 0x0>;
+	dma-names = "rx", "rx-ctrl";
+	pinctrl-0 = <&spdifrx_pins>;
+	pinctrl-names = "default";
+
+	spdifrx_port: port {
+		cpu_endpoint: endpoint {
+			remote-endpoint = <&codec_endpoint>;
+		};
+	};
+};
+
+spdif_in: spdif-in {
+	compatible = "linux,spdif-dir";
+
+	codec_port: port {
+		codec_endpoint: endpoint {
+			remote-endpoint = <&cpu_endpoint>;
+		};
+	};
+};
+
+soundcard {
+	compatible = "audio-graph-card";
+	dais = <&spdifrx_port>;
+};
-- 
2.11.0
