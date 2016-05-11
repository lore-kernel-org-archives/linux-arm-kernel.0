From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 May 2016 13:23:14 +0800
Subject: [PATCH 2/2] ARM: dts: sun6i: yones-toptech-bs1078-v2: Drop
 constraints on dc1sw regulator
In-Reply-To: <1462944194-6920-1-git-send-email-wens@csie.org>
References: <1462944194-6920-1-git-send-email-wens@csie.org>
Message-ID: <1462944194-6920-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the same issue fixed in commit dcf5341f0150 ("ARM: dts:
sun8i-q8-common: Do not set constraints on dc1sw regulator").
Commit message copied:

dc1sw is an on/off only regulator and as such it cannot have constraints.

This is a limitation of the kernel regulator implementation which resolves
supplies on the first regulator_get(), which is done after applying
constraints, and applying the constrains will fail because it calls
_regulator_get_voltage() and _regulator_do_set_voltage() both of which
will fail on a switch regulator when there is no supply (yet).

This causes registering of all axp22x regulators to fail with the
following errors:

[    1.395249] vcc-lcd: failed to get the current voltage(-22)
[    1.405131] axp20x-regulator axp20x-regulator: Failed to register dc1sw
[    1.412436] axp20x-regulator: probe of axp20x-regulator failed with error -22

This commit removes the constrains on dc1sw / vcc-lcd fixing this problem.
Note that dcdc1 itself is contrained to the exact same values, so this
does not change anything.

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
index 360adfb1e9ca..d6ad6196a768 100644
--- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
@@ -135,8 +135,6 @@
 
 &reg_dc1sw {
 	regulator-name = "vcc-lcd-usb2";
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
 };
 
 &reg_dc5ldo {
-- 
2.8.1
