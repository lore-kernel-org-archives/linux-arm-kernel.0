From: haas@computerlinguist.org (Michael Haas)
Date: Fri, 25 Mar 2016 20:04:05 +0100
Subject: [PATCH 1/3] sunxi: A20-OLinuXino-LIME2: Fix ldo3/ldo4 in DTS
Message-ID: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LDO3 and LDO4 are set to regulator-always-on which causes
crashes on my A20-OLinuXino-LIME2 once axp20x-i2c.ko is loaded.

This crash is observed in combination with recent versions
of Das U-Boot starting from their commit
02cc27c74f9b884b538bcd1b93342a4c05b5d608.

>commit 02cc27c74f9b884b538bcd1b93342a4c05b5d608
>Author: Hans de Goede <hdegoede@redhat.com>
>Date:   Sat Oct 3 15:29:24 2015 +0200
>
>    sunxi: power: Change axp209 LDO3 and LDO4 default to disabled
>
>    LDO3 and LDO4 are normally either unused, or used to power csi
>    attached camera sensors, and as such do not need to be enabled at
>    boot time.
>
>    Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>    Acked-by: Ian Campbell <ijc@hellion.org.uk>

Hans de Goede suggests fixing the Linux DTS file via the u-boot list:

>The regulator-always-on will cause both regulators to get turned on,
>but the min / max constraints match the datasheet constrains / the
>absolute min / max values these ldo-s can deliver, not the constraints
>which the board design puts on these.
>
>So now these ldo-s end up getting turned on at whatever voltage
>is the default (which according to the datasheet is unknown),
>where as the schematic says that if these get turned on (which
>is not necessary) they should be run at 2.8V.
>
>This dts file is the only axp209 using dts file which:
>
>1) Does not have proper constraints for LDO3 / LDO4
>2) Uses regulator-always-on; for these
>
>I would suggest fixing both, first you can try making min = max =
>2800000. And if that fixes things, which I expect it will, I would
>also drop the regulator-always-on from the dts, since we really
>only need to turn these on when using the csi interface in which
>case it would be up to the csi driver to explicitly turn them on.

This patch implements the suggested changes. It is not enough
to set the voltage to 2800000 to avoid the crash. Hence, I have
also removed regulator-always-on.

Signed-off-by: Michael Haas <haas@computerlinguist.org>
CC: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index d5c796c..d5ff2e9 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -140,15 +140,13 @@
 			};
 
 			vcc_csi0: ldo3 {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <3500000>;
-				regulator-always-on;
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
 			};
 
 			vcc_csi1: ldo4 {
-				regulator-min-microvolt = <1250000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
 			};
 
 			vdd_cpu: dcdc2 {
-- 
2.7.2
