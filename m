From: stefan@agner.ch (Stefan Agner)
Date: Wed, 10 Feb 2016 16:02:25 -0800
Subject: [PATCH 1/2] ARM: dts: vf610twr: assign Ethernet clock explicitly
Message-ID: <1455148946-26903-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign Ethernet clock parents explicitly. The VF610 Tower Board
uses the external Ethernet clock input which is connected to
a 50MHz clock.

The Vybrid SoC has two ethernet interfaces (fec0 and fec1) which
use the same clock source (VF610_CLK_ENET). Therefore this parent
configuration affects multiple consumer devices and need to be
specified in the clock provider node.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
So far we rely on the boot loader to configure this, however it
can be problematic e.g. for suspend/resume...

--
Stefan

 arch/arm/boot/dts/vf610-twr.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 5438ee4..8419c06 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -96,6 +96,10 @@
 &clks {
 	clocks = <&sxosc>, <&fxosc>, <&enet_ext>, <&audio_ext>;
 	clock-names = "sxosc", "fxosc", "enet_ext", "audio_ext";
+	assigned-clocks = <&clks VF610_CLK_ENET_SEL>,
+			  <&clks VF610_CLK_ENET_TS_SEL>;
+	assigned-clock-parents = <&clks VF610_CLK_ENET_EXT>,
+				 <&clks VF610_CLK_ENET_EXT>;
 };
 
 &dspi0 {
-- 
2.7.1
