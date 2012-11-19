From: zonque@gmail.com (Daniel Mack)
Date: Mon, 19 Nov 2012 23:29:13 +0800
Subject: [PATCH v4 0/3] OMAP GPMC DT bindings
Message-ID: <1353338956-19420-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series of patches to support GPMC peripherals on OMAP boards.

Depends on Linus' master +
omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)

The only supported peripheral for now is NAND, but other types would be
easy to add.

Version 2 addresses details pointed out by Jon Hunter, Afzal Mohammed
and Rob Herring:

 - add "reg" and "ti,hwmod" properties to Documentation
 - use generic of_mtd functions and the property names defined by them,
   namely "nand-bus-width" and "nand-ecc-mode"
 - reduce the default register space size in the Documentation to 8K,
   as found in the hwmod code
 - switch to a DT layout based on ranges and address translation.
   Although this property is not currently looked at as long as the
   handling code still uses the runtime calculation methods, we now
   have these values in the bindings, eventually allowing us to
   switch the implementation with less pain.

Version 3 includes fixes pointed out by Jon Hunter:

 - better documentation of the 'ranges' property to describe the
   fact that it's representing the CS lines
 - GPMC_CS_CONFIGx -> GPMC_CONFIGx in comments
 - drop interrupt-parent from example bindings
 - add of_node_put() at the end of the child iteration

Version 4 fixes compilation for !CONFIG_MTD_NAND and includes more
details from Jon Hunter and Avinash, Philip:

 - Add "num-cs" and "num-waitpins" properties, which will eventually
   be used to get rid of GPMC_CS_NUM
 - Better description of generic nand DT properties
 - Dropped patch 3/4 as an equivalent fix was already merged
 - Added ti,nand-ecc-use-elm property

Daniel Mack (3):
  mtd: omap-nand: pass device_node in platform data
  ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
  ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND

 .../devicetree/bindings/mtd/gpmc-nand.txt          |  84 ++++++++++
 arch/arm/mach-omap2/gpmc-nand.c                    |   9 +-
 arch/arm/mach-omap2/gpmc.c                         | 170 +++++++++++++++++++++
 drivers/mtd/nand/omap2.c                           |   4 +-
 include/linux/platform_data/mtd-nand-omap2.h       |   2 +
 5 files changed, 264 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt

-- 
1.7.11.7
