From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 9 May 2016 16:49:20 -0500
Subject: [PATCH 0/6] ARM: OMAP3: Convert OMAP3 PM code to use generic sram
 driver
Message-ID: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This series adds support for OMAP3 platforms to use the generic SRAM driver
at drivers/misc/sram.c. It depends on the patches sent here [1], which were
sent as an RFC so if that series does not get accepted we will need to find
a different method of marking SRAM region as executable so this series will
need to change slightly.

The idea of this series is to add the ocmcram nodes to the DT files before
converting the pm34xx to use the genalloc API allocate space for the
sleep34xx.S code so that we do not break PM. After we do the conversion
we can drop the legacy mach-omap2 SRAM code for OMAP3 as we no longer will
have any dependency on it.

Tested suspend and off-mode on omap3-beaglexm and omap3-n900, cpuidle works
fine as well.

Regards,
Dave

[1] http://lkml.iu.edu/hypermail/linux/kernel/1605.1/01069.html

Dave Gerlach (6):
  Documentation: sram: ti: Add TI SRAM bindings
  ARM: dts: omap3: Add ocmcram node
  ARM: dts: omap3-n900: Add secure reserved region to ocmcram node
  ARM: OMAP2+: pm34xx: Convert to use generic sram driver for idle code
  ARM: OMAP2+: Remove legacy sram init code for omap3 platforms
  ARM: OMAP2+: sram: remove legacy OMAP3 code

 Documentation/devicetree/bindings/sram/ti-sram.txt | 47 +++++++++++
 arch/arm/boot/dts/omap3-n900.dts                   |  7 ++
 arch/arm/boot/dts/omap3.dtsi                       | 11 +++
 arch/arm/mach-omap2/pdata-quirks.c                 |  3 +-
 arch/arm/mach-omap2/pm34xx.c                       | 98 ++++++++++++++++++----
 arch/arm/mach-omap2/sram.c                         | 23 -----
 6 files changed, 147 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sram/ti-sram.txt

-- 
2.7.3
