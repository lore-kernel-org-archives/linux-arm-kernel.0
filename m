From: ipaton0@gmail.com (Iain Paton)
Date: Sat, 26 Mar 2016 00:58:33 +0000
Subject: [linux-sunxi] [PATCH 1/3] sunxi: A20-OLinuXino-LIME2: Fix
 ldo3/ldo4 in DTS
In-Reply-To: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
Message-ID: <56F5DEB9.7070207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/03/16 19:04, Michael Haas wrote:

> This patch implements the suggested changes. It is not enough
> to set the voltage to 2800000 to avoid the crash. Hence, I have
> also removed regulator-always-on.

NAK.

If setting both min and max to 2800000 isn't working then I'd suggest you're 
just papering over the issue and not actually solving it.

It should be fairly clear that whenever those regulators are turned on by 
some driver you're going to see the same issue, you've just delayed the 
problem by removing the regulator-always-on item.

The real problem here is people monkeying with the regulators without 
understanding what they're doing, bothering to test the results, or caring 
about the consequences.

Anyway, Hans was correct in that the datasheet we have access to says that 
the defaults for these regulators are undefined. 
I suspect that's not the whole story though, if these regulators had random 
values at powerup we'd have seen problems before now. 
Most likely the values we think we know are simply incorrect plus there's 
probably some element of sequencing involved - perhaps LDO4 needs turned on 
first. 
However I don't see sufficient detail in the datasheets to confirm any of 
that, so we shouldn't assume anything.
Electrically on the lime2 LDO3 goes to VCC-PE and LDO4 to VCC-PG. Neither 
groups E or G appear to be connected to anything other than gpio headers, 
so this has little to do with board design, it's something internal to 
the SoC that the datasheet is lacking on detail about.

One of the reasons for the regulator-always-on being in the dts was so that 
the regulator didn't get touched and so didn't break anything.

All said and done, it only takes a minute with a multimeter to determine 
actual defaults. Helpful to have multiple boards to gain some confidence 
that they behave the same, but still basing values like this on tiny 
sample sizes is probably unwise.

Looking at other A20 based boards, Cubieboards for example, shows LDO3/4 
being unused and the VCC-PE/PG pins they power on the lime2 being tied 
directly to 3.3v. No issues there simply because there's no way to mess 
with the power to those blocks.

The patch you really want is something like the one below which works 
on my boards regardless of the presence of regulator-always-on.
Verified on four boards with u-boot 2016.03 and kernel 4.5.0.

Whether you decide to remove regulator-always-on or not is a different 
question, but please use 2.3v, or some other proven working value, for 
ldo3. At least that way you have a fighting chance of the board 
remaining functional when something wants to turn the regulator on.

It's a good bet that the same u-boot change will have implications 
for other boards, if not now then at some future point.

Hans, take note, the schematic is wrong. You shouldn't assume either 
the schematic or you are correct. Ill considered changes to regulators 
can cause real damage to peoples boards.
I know we've discussed regulators before and that my opinion falls on 
deaf ears, but worth one last try..



Author: Iain Paton <ipaton0@gmail.com>
Date:   Fri Mar 25 22:07:55 2016 +0000

sunxi: A20-OLinuXino-LIME2: Update ldo3/ldo4 in DTS

A recent ill-considered u-boot change:

>commit 02cc27c74f9b884b538bcd1b93342a4c05b5d608
>Author: Hans de Goede <hdegoede@redhat.com>
>Date:   Sat Oct 3 15:29:24 2015 +0200
>
>    sunxi: power: Change axp209 LDO3 and LDO4 default to disabled

causes the lime2 to lockup/crash when LDO3/4 are re-enabled by the
kernel.

The AXP209 datasheet shows the powerup values for these regulators 
to be undefined and the 2.8v suggested by the lime2 schematic also 
causes a lockup when the regulators are re-enabled so is obviously 
also incorrect.

Empirical measurement suggests LDO3 @ 2.3v and LDO4 @ 2.8v are the 
actual defaults, but is based on a small sample size. 

Verified to work with u-boot 2016.03, kernel 4.5.0 on four lime2 
boards.

Signed-off-by: Iain Paton <ipaton0@gmail.com>
---

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index d5c796c..e665d22 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -140,14 +140,14 @@
                        };
 
                        vcc_csi0: ldo3 {
-                               regulator-min-microvolt = <700000>;
-                               regulator-max-microvolt = <3500000>;
+                               regulator-min-microvolt = <2300000>;
+                               regulator-max-microvolt = <2300000>;
                                regulator-always-on;
                        };
 
                        vcc_csi1: ldo4 {
-                               regulator-min-microvolt = <1250000>;
-                               regulator-max-microvolt = <3300000>;
+                               regulator-min-microvolt = <2800000>;
+                               regulator-max-microvolt = <2800000>;
                                regulator-always-on;
                        };
 
-- 
