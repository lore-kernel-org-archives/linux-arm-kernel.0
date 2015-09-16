From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Sep 2015 11:05:29 +0800
Subject: [PATCH 0/3] regulators: axp20x: Rename AXP221 DC1SW and DC5LDO supply
 names
Message-ID: <1442372732-27434-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series renames regulator supply names for DC1SW and DC5LDO for
the AXP221. These 2 are secondary outputs for DCDC1 and DCDC5 buck
regulators, respectively, so they are connected to them internally.
There's no external input pin to name the supplies after.

When I originally did the support, I used the parent regulator's name
for the supply name. However this results in a misleading dts:

	axp221: pmic at 68 {
		dcdc1-supply = <&dcdc1>;
		dcdc5-supply = <&dcdc5>;

		dcdc1: dcdc1 {
			...
		};

		...
	};

At first glance, one might interpret it as "DCDC1 supplies itself".
Indeed, Maxime raised this issue.

This series renames the supply names to the regulator names themselves,
or "dc1sw-supply" and "dc5ldo-supply" respectively:

	axp221: pmic at 68 {
		dc1sw-supply = <&dcdc1>;
		dc5ldo-supply = <&dcdc5>;
		...
	};

Renaming these shouldn't result in any problems in the real world.
All the board designs we've seen have DCDC1 supplying a common 3/3.3V
rail, and DCDC5 supplying 1.5V for DDR3 SDRAM. These 2 would have
"always-on" set, so even if the rename results in the secondary
regulator outputs being decoupled from the primary in the software
implementation, it would just be a representation issue. Function-wise,
it would function as before. On the Linux side, no one is actually
using the secondary outputs yet.

Patch 1 renames the supply names in the axp20x DT bindings.

Patch 2 updates the axp20x regulator driver.

Patch 3 updates the only dts, the Hummingbird A31, that uses these
bindings.

If everything's ok, could we merge the first 2 patches through the
regulator tree, and the 3rd through the sunxi tree?

Thanks.


Regards,
ChenYu


Chen-Yu Tsai (3):
  mfd: axp20x: Rename supply names for AXP221 DC1SW and DC5LDO
    regulators
  regulators: axp20x: Rename supply names for AXP221 DC1SW and DC5LDO
  ARM: dts: sun6i: hummingbird: Rename AXP221 DC1SW and DC5LDO supply
    names

 Documentation/devicetree/bindings/mfd/axp20x.txt | 4 ++--
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts      | 4 ++--
 drivers/regulator/axp20x-regulator.c             | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.5.1
