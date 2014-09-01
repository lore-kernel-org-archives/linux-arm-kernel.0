From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 1 Sep 2014 12:29:37 +0800
Subject: [PATCHv1 3/7] ASoC: dts: vf610-twr: To support simple card newest
 style.
In-Reply-To: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1409545781-20530-4-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch depends on the following simple card patch:
===
ASoC: simple-card: Merge single and muti DAI link code.

This patch merge single DAI link and muti-DAI links code together,
and simply the simple-card driver code.

And also do some other improvement:

Since from the DAI format micro SND_SOC_DAIFMT_CBx_CFx, the 'CBx'
mean Codec's bit clock is as master/slave and the 'CFx' mean Codec's
frame clock is as master/slave.

So these same DAI formats should be informed to CPU and CODE DAIs at
the same time. For the Codec driver will set the bit clock and frame
clock as the DAI formats said, but for the CPU driver, if the the
bit clock or frame clock is as Codec master, so it should be set CPU
DAI device as bit clock or frame clock as slave, and vice versa.

The old code will cause confusion, and we should be clear that the
letter 'C' here mean to Codec.
===

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index b8a5e8c..841a45a 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -61,7 +61,6 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,format = "i2s";
 		simple-audio-card,widgets =
 			"Microphone", "Microphone Jack",
 			"Headphone", "Headphone Jack",
@@ -74,17 +73,17 @@
 			"Headphone Jack", "HP_OUT",
 			"Speaker Ext", "LINE_OUT";
 
-		simple-audio-card,cpu {
-			sound-dai = <&sai2>;
-			master-clkdir-out;
+		simple-audio-card,dai-link {
+			format = "i2s";
 			frame-master;
 			bitclock-master;
-		};
 
-		simple-audio-card,codec {
-			sound-dai = <&codec>;
-			frame-master;
-			bitclock-master;
+			cpu {
+				sound-dai = <&sai2>;
+			};
+			codec {
+				sound-dai = <&codec>;
+			};
 		};
 	};
 };
-- 
1.8.4
