From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  9 Mar 2016 20:38:59 +0100
Subject: [PATCH] ARM: dts: sun8i-q8-common: Do not set constraints on dc1sw
 regulator
In-Reply-To: <1457552339-400-1-git-send-email-hdegoede@redhat.com>
References: <1457552339-400-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1457552339-400-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

This commit removes the constrains on dc1sw / vcc-lcd fixing this problem
note that dcdc1 itself is contrained to the exact same values, so this
does not change anything.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-q8-common.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
index fce6aa3..982c8ef 100644
--- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
@@ -144,8 +144,6 @@
 };
 
 &reg_dc1sw {
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
 	regulator-name = "vcc-lcd";
 };
 
-- 
2.7.2
