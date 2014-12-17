From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 17 Dec 2014 18:07:23 +0100
Subject: [PATCH] ARM: mvebu: Fix pinctrl configuration for Armada 370 DB
Message-ID: <1418836043-19171-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit b4607572ef86 (ARM: mvebu: remove conflicting muxing on
Armada 370 DB) removes the hog pins muxing. As it is explained in the
commit log it solves a warning a boot time, but more important it also
allows using the Giga port 0 of the board.

Unfortunately in the same time the commit 95d8dafe8554 (arm: mvebu:
move Armada 370/XP pinctrl node definition armada-370-xp.dtsi) was
merged and it introduced again the hog pins muxing. Because of it, the
Giga port 0 of the board is no more usable.

This commit remove again the conflicting muxing (hopefully for the
last time).

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Hi Andrew, Jason and Sebastian,

This commit should be submit as a fix for 3.19.

Actually the problem that it solves (not being able to use the Giga
port 0 on the Armada 370 DB) is in the kernel since 3.14. It was
introduced by the commit was: "49f3822509b74f8c8d0731aeb7ccea065376c9b
ARM: mvebu: add audio support to Armada 370 DB".

For the stable kernel we will need to forward the commit b4607572ef86
(ARM: mvebu: remove conflicting muxing on Armada 370 DB) to the 3.18
kernel.

For the older kernels we will also need to forward fea038ed55ae (ARM:
mvebu: Add proper pin muxing on the Armada 370 DB board).

I will take care of it.

Thanks

Gregory


 arch/arm/boot/dts/armada-370-db.dts | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 1466580be295..70b1943a86b1 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -203,27 +203,3 @@
 		compatible = "linux,spdif-dir";
 	};
 };
-
-&pinctrl {
-	/*
-	 * These pins might be muxed as I2S by
-	 * the bootloader, but it conflicts
-	 * with the real I2S pins that are
-	 * muxed using i2s_pins. We must mux
-	 * those pins to a function other than
-	 * I2S.
-	 */
-	pinctrl-0 = <&hog_pins1 &hog_pins2>;
-	pinctrl-names = "default";
-
-	hog_pins1: hog-pins1 {
-		marvell,pins = "mpp6",  "mpp8", "mpp10",
-			       "mpp12", "mpp13";
-		marvell,function = "gpio";
-	};
-
-	hog_pins2: hog-pins2 {
-		marvell,pins = "mpp5", "mpp7", "mpp9";
-		marvell,function = "gpo";
-	};
-};
-- 
1.9.1
