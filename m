From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Jun 2017 18:49:48 +0100
Subject: Applied "dt-bindings: stm32: add h7 support for sai" to the asoc tree
In-Reply-To: <1497615384-7407-2-git-send-email-olivier.moysan@st.com>
Message-ID: <E1dLvNU-0005aJ-6G@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   dt-bindings: stm32: add h7 support for sai

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

>From aef86ae38b0579dc147e3b96b1b9523561f79378 Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Fri, 16 Jun 2017 14:16:23 +0200
Subject: [PATCH] dt-bindings: stm32: add h7 support for sai

Document device tree bindings for STM32H7 SAI.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/st,stm32-sai.txt         | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index a0feeed1710e..f1c5ae59e7c9 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -6,7 +6,7 @@ The SAI contains two independent audio sub-blocks. Each sub-block has
 its own clock generator and I/O lines controller.
 
 Required properties:
-  - compatible: Should be "st,stm32f4-sai"
+  - compatible: Should be "st,stm32f4-sai" or "st,stm32h7-sai"
   - reg: Base address and size of SAI common register set.
   - clocks: Must contain phandle and clock specifier pairs for each entry
 	in clock-names.
@@ -47,24 +47,24 @@ sound_card {
 };
 
 sai1: sai1 at 40015800 {
-	compatible = "st,stm32f4-sai";
+	compatible = "st,stm32h7-sai";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges = <0 0x40015800 0x400>;
 	reg = <0x40015800 0x4>;
-	clocks = <&rcc 1 CLK_SAIQ_PDIV>, <&rcc 1 CLK_I2SQ_PDIV>;
+	clocks = <&rcc PLL1_Q>, <&rcc PLL2_P>;
 	clock-names = "x8k", "x11k";
 	interrupts = <87>;
 
-	sai1b: audio-controller at 40015824 {
-		compatible = "st,stm32-sai-sub-b";
-		reg = <0x24 0x1C>;
-		clocks = <&rcc 1 CLK_SAI2>;
+	sai1a: audio-controller at 40015804 {
+		compatible = "st,stm32-sai-sub-a";
+		reg = <0x4 0x1C>;
+		clocks = <&rcc SAI1_CK>;
 		clock-names = "sai_ck";
-		dmas = <&dma2 5 0 0x400 0x0>;
+		dmas = <&dmamux1 1 87 0x400 0x0>;
 		dma-names = "tx";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_sai1b>;
+		pinctrl-0 = <&pinctrl_sai1a>;
 
 		sai1b_port: port {
 			cpu_endpoint: endpoint {
-- 
2.11.0
