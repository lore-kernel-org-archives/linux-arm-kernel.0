From: harald@ccbib.org (Harald Geyer)
Date: Thu, 15 Mar 2018 16:25:08 +0000
Subject: [PATCHv2 3/5] arm64: dts: allwinner: a64: add simplefb for A64 SoC
In-Reply-To: <20180315162510.11669-1-harald@ccbib.org>
References: <20180315162510.11669-1-harald@ccbib.org>
Message-ID: <20180315162510.11669-4-harald@ccbib.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SoC features two display pipelines, one has a LCD output, the
other has a HDMI output.

Add support for simplefb for the LCD output. Tested on Teres I.

This patch was inspired by work of Icenowy Zheng.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
changes since v1: none

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8401e7f887ff..1b2ef28c42bd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -52,6 +52,26 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+/*
+ * The pipeline mixer0-lcd0 depends on clock CLK_MIXER0 from DE2 CCU.
+ * However there is no support for this clock on A64 yet, so we depend
+ * on the upstream clocks here to keep them (and thus CLK_MIXER0) up.
+ */
+		simplefb_lcd: framebuffer-lcd {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "mixer0-lcd0";
+			clocks = <&ccu CLK_TCON0>,
+				 <&ccu CLK_DE>, <&ccu CLK_BUS_DE>;
+			status = "disabled";
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.11.0
