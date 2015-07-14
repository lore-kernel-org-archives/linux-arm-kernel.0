From: adam.yh.lee@gmail.com (Adam YH Lee)
Date: Tue, 14 Jul 2015 11:17:24 -0700
Subject: [PATCH V2] arm:DTS Correct audio input route & set mic bias
Message-ID: <1436897844-6908-1-git-send-email-adam.yh.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio-in was incorrectly routed to Line In. It should be Mic3L as per
schematic.

Using mic-bias voltage at 2.0v (<0x1>) does not work for some reason. There
is no voltage seen on micbias (R127). Mic-bias voltage of 2.5v (<0x2>) works.
I see voltage of 2.475v across GND and micbias.

With these changes, I can record audio with a pair of proliferate TRRS earbuds.

Signed-off-by: Adam YH Lee <adam.yh.lee@gmail.com>
---
 arch/arm/boot/dts/am335x-pepper.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index d627dc6..73b4cc3 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -74,6 +74,7 @@
 	audio_codec: tlv320aic3106 at 1b {
 		compatible = "ti,tlv320aic3106";
 		reg = <0x1b>;
+		ai3x-micbias-vg = <0x2>;
 	};
 
 	accel: lis331dlh at 1d {
@@ -152,7 +153,7 @@
 	ti,audio-routing =
 		"Headphone Jack",	"HPLOUT",
 		"Headphone Jack",	"HPROUT",
-		"LINE1L",		"Line In";
+		"MIC3L",		"Mic3L Switch";
 };
 
 &mcasp0 {
-- 
2.1.4
