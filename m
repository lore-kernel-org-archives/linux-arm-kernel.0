From: kieran.bingham+renesas@ideasonboard.com (Kieran Bingham)
Date: Thu, 22 Mar 2018 20:51:22 +0000
Subject: [PATCH v5] ARM: dts: wheat: Fix ADV7513 address usage
Message-ID: <1521751882-7996-1-git-send-email-kieran.bingham+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The r8a7792 Wheat board has two ADV7513 devices sharing a single I2C
bus, however in low power mode the ADV7513 will reset it's slave maps to
use the hardware defined default addresses.

The ADV7511 driver was adapted to allow the two devices to be registered
correctly - but it did not take into account the fault whereby the
devices reset the addresses.

This results in an address conflict between the device using the default
addresses, and the other device if it is in low-power-mode.

Repair this issue by moving both devices away from the default address
definitions.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
 - Addition to series

v3:
 - Split map register addresses into individual declarations.

v4:
 - Normalise I2C usage

v5:
 - No change from v4 except to repost and drop the [RFT] now that it's tested


Testing on a wheat board shows the addresses correctly assigned, and the
default addresses (0x38, 0x3e, 0x3f which would otherwise conflict) are
shown as actively returning data in low power mode during the scan.
(they return 0)

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- UU -- -- -- UU -- --
30: -- -- -- -- -- -- -- -- 38 UU -- -- -- UU 3e 3f
40: -- -- -- -- -- -- -- -- -- UU -- -- -- UU -- --
50: -- -- -- -- -- -- -- -- -- UU -- -- -- UU -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
---
 arch/arm/boot/dts/r8a7792-wheat.dts | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792-wheat.dts b/arch/arm/boot/dts/r8a7792-wheat.dts
index 293b9e3b3e70..3e9f70e87a60 100644
--- a/arch/arm/boot/dts/r8a7792-wheat.dts
+++ b/arch/arm/boot/dts/r8a7792-wheat.dts
@@ -245,9 +245,16 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
+	/*
+	 * The adv75xx resets its addresses to defaults during low power power
+	 * mode. Because we have two ADV7513 devices on the same bus, we must
+	 * change both of them away from the defaults so that they do not
+	 * conflict.
+	 */
 	hdmi at 3d {
 		compatible = "adi,adv7513";
-		reg = <0x3d>;
+		reg = <0x3d>, <0x2d>, <0x4d>, <0x5d>;
+		reg-names = "main", "cec", "edid", "packet";
 
 		adi,input-depth = <8>;
 		adi,input-colorspace = "rgb";
@@ -277,7 +284,8 @@
 
 	hdmi at 39 {
 		compatible = "adi,adv7513";
-		reg = <0x39>;
+		reg = <0x39>, <0x29>, <0x49>, <0x59>;
+		reg-names = "main", "cec", "edid", "packet";
 
 		adi,input-depth = <8>;
 		adi,input-colorspace = "rgb";
-- 
2.7.4
