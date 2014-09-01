From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 1 Sep 2014 12:29:40 +0800
Subject: [PATCHv1 6/7] ASoC: dts: sh73a0-kzm9g-reference: To support simple
 card newest style.
In-Reply-To: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1409545781-20530-7-git-send-email-Li.Xiubo@freescale.com>
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
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 18662ae..e689ae3 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -160,15 +160,19 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,format = "left_j";
-		simple-audio-card,cpu {
-			sound-dai = <&sh_fsi2 0>;
-		};
-		simple-audio-card,codec {
-			sound-dai = <&ak4648>;
+
+		simple-audio-card,dai-link {
+			format = "left_j";
 			bitclock-master;
 			frame-master;
-			system-clock-frequency = <11289600>;
+
+			cpu {
+				sound-dai = <&sh_fsi2 0>;
+			};
+			codec {
+				sound-dai = <&ak4648>;
+				system-clock-frequency = <11289600>;
+			};
 		};
 	};
 };
-- 
1.8.4
