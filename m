From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 3 Sep 2015 12:20:36 +0530
Subject: [PATCH v2 0/6] regulator: Fix pbias regulator enable
Message-ID: <1441263042-12942-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vsel_reg and enable_reg of the pbias regulator descriptor should actually
have the offset from syscon.

However after
"ARM: dts: <platform>: add minimal l4 bus layout with control module
support"
vsel_reg and enable_reg started to have the absolute address because
of address translation that happens due to pbias node made as the
child node of syscon. This breaks the pbias regulator enable.

This series adds the 'offset' to be populated in vsel_reg and enable_reg
in the pbias driver itself.

Changes from v1:
*) Fixed Tony's review comments on adding a 'comment' for adding offset in
   the driver and adding a warning for using platform_get_resource.
*) Added Tony's Acked-by.

Tested these patches against mmc -next in omap4 panda, omap3 beagle xm,
dra72 and omap5 uevm

Kishon Vijay Abraham I (6):
  regulator: pbias: program pbias register offset in pbias driver
  ARM: dts: dra7: use "ti,pbias-dra7" compatible string for pbias
  ARM: dts: omap243x: use "ti,pbias-omap2" compatible string for pbias
  ARM: dts: omap3: use "ti,pbias-omap3" compatible string for pbias
  ARM: dts: omap4: use "ti,pbias-omap4" compatible string for pbias
  ARM: dts: omap5: use "ti,pbias-omap5" compatible string for pbias

 .../bindings/regulator/pbias-regulator.txt         |    7 ++-
 arch/arm/boot/dts/dra7.dtsi                        |    2 +-
 arch/arm/boot/dts/omap2430.dtsi                    |    2 +-
 arch/arm/boot/dts/omap3.dtsi                       |    2 +-
 arch/arm/boot/dts/omap4.dtsi                       |    2 +-
 arch/arm/boot/dts/omap5.dtsi                       |    2 +-
 drivers/regulator/pbias-regulator.c                |   56 +++++++++++++++++---
 7 files changed, 61 insertions(+), 12 deletions(-)

-- 
1.7.9.5
