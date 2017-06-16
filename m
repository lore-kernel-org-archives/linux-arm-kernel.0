From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Jun 2017 18:50:10 +0100
Subject: Applied "dt-bindings: stm32: sai: fix DT example" to the asoc tree
In-Reply-To: <1497615334-7156-2-git-send-email-olivier.moysan@st.com>
Message-ID: <E1dLvNq-0005iB-7G@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   dt-bindings: stm32: sai: fix DT example

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

>From 4c1458584c9a5ac3f9e174e80a986fe5a2bfd07b Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Fri, 16 Jun 2017 14:15:28 +0200
Subject: [PATCH] dt-bindings: stm32: sai: fix DT example

Correct the device tree example.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/st,stm32-sai.txt     | 25 +++++++++-------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index c59a3d779e06..a0feeed1710e 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -36,6 +36,10 @@ SAI subnodes required properties:
   - pinctrl-names: should contain only value "default"
   - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
 
+The device node should contain one 'port' child node with one child 'endpoint'
+node, according to the bindings defined in Documentation/devicetree/bindings/
+graph.txt.
+
 Example:
 sound_card {
 	compatible = "audio-graph-card";
@@ -46,16 +50,15 @@ sai1: sai1 at 40015800 {
 	compatible = "st,stm32f4-sai";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	ranges;
+	ranges = <0 0x40015800 0x400>;
 	reg = <0x40015800 0x4>;
 	clocks = <&rcc 1 CLK_SAIQ_PDIV>, <&rcc 1 CLK_I2SQ_PDIV>;
 	clock-names = "x8k", "x11k";
 	interrupts = <87>;
 
 	sai1b: audio-controller at 40015824 {
-		#sound-dai-cells = <0>;
 		compatible = "st,stm32-sai-sub-b";
-		reg = <0x40015824 0x1C>;
+		reg = <0x24 0x1C>;
 		clocks = <&rcc 1 CLK_SAI2>;
 		clock-names = "sai_ck";
 		dmas = <&dma2 5 0 0x400 0x0>;
@@ -63,18 +66,10 @@ sai1: sai1 at 40015800 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sai1b>;
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			sai1b_port: port at 0 {
-				reg = <0>;
-				cpu_endpoint: endpoint {
-					remote-endpoint = <&codec_endpoint>;
-					audio-graph-card,format = "i2s";
-					audio-graph-card,bitclock-master = <&codec_endpoint>;
-					audio-graph-card,frame-master = <&codec_endpoint>;
-				};
+		sai1b_port: port {
+			cpu_endpoint: endpoint {
+				remote-endpoint = <&codec_endpoint>;
+				format = "i2s";
 			};
 		};
 	};
-- 
2.11.0
