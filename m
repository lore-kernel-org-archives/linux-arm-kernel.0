From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 4 Sep 2015 17:30:23 +0530
Subject: [PATCH v3 0/2] regulator: Fix pbias regulator enable
Message-ID: <1441368025-21182-1-git-send-email-kishon@ti.com>
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

Changes from v2:
*) Squashed all the dt patches into a single patch

Changes from v1:
*) Fixed Tony's review comments on adding a 'comment' for adding offset in
   the driver and adding a warning for using platform_get_resource.
*) Added Tony's Acked-by.

Tested these patches against mmc -next in omap4 panda, omap3 beagle xm,
dra72 and omap5 uevm

Kishon Vijay Abraham I (2):
  regulator: pbias: program pbias register offset in pbias driver
  ARM: dts: <omap2/3/4/5/dra7>: use "ti,pbias-<platform>" compatible
    string for pbias

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
