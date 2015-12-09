From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 8 Dec 2015 16:36:24 -0800
Subject: [PATCH v2 00/25] mtd: nand: refactor the NAND subsystem (part 1)
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151209003624.GU120110@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 01, 2015 at 12:02:57PM +0100, Boris Brezillon wrote:
> Hello,
> 
> This huge series aims at clarifying the relationship between the mtd and
> nand_chip structures and hiding NAND framework internals to NAND
> controller drivers.
> 
> The first part of the series provide an mtd_to_nand() helper to hide the
> way mtd and nand_chip are linked together.
> 
> The second part of the series embeds the mtd structure into the nand_chip
> one so that NAND controller drivers don't have to bother allocating the
> MTD device and linking it with the NAND chip.
> 
> The last part of the series hides accesses to the chip->priv field behind
> two helper functions.
> 
> This allows removal of some of the boilerplate code done in all NAND
> controller drivers, but most importantly, it unifies a bit the way NAND
> chip structures are instantiated (even though we still have two different
> kinds of drivers: those embedding the nand_chip struct into their private
> nand chip representation, and those allocating two different structures
> and linking them together with the chip->priv field).
> 
> As said in the title, this refactoring is only the first step. I plan to
> rework the NAND controller / NAND chip separation for pretty much the same
> reasons: clarifying the separation between the two concepts, and getting
> rid of more boilerplate code in NAND controller drivers.
> 
> Stay tuned ;-).
> 
> Best Regards,
> 
> Boris
> 
> Changes since v1:
> - dropped already applied patches
> - fixed some typos
> - manually fixed some modifications omitted by the coccinelle scripts
> - manually reworked modifactions done by coccinelle scripts to improve
>   readability and fix coding style issues
> 
> Boris Brezillon (25):
>   ARM: nand: make use of mtd_to_nand() where appropriate

I've sent this (+ the introduction of mtd_to_nand()) in a pull request
to arm-soc, as well as to l2-mtd.git.

>   blackfin: nand: make use of mtd_to_nand() where appropriate
>   cris: nand: make use of mtd_to_nand() where appropriate
>   mips: nand: make use of mtd_to_nand() where appropriate

I've based these on v4.4-rc1 and brought them into l2-mtd.git, in case
any arch/{blackfin,cris,mips}/ people want to pull them in too.

>   sh: nand: make use of mtd_to_nand() where appropriate
>   mtd: nand: make use of mtd_to_nand() in NAND core code
>   mtd: nand: make use of mtd_to_nand() in NAND drivers
>   staging: mt29f_spinand: make use of mtd_to_nand()
>   mtd: nand: embed an mtd_info structure into nand_chip
>   mtd: nand: add nand_to_mtd() helper

Pulled the rest up to here into l2-mtd.git.

>   coccinelle: nand: detect and correct drivers embedding an mtd_info
>     object

I believe Julia had comments on this. That probably would go through the
kbuild tree in the end anyway (?).

>   mtd: nand: use the mtd instance embedded in struct nand_chip

There's still at least one problem in this patch (commented on the
patch). It touches a lot of drivers, so any extra review would be great.

>   mtd: nand: update the documentation to reflect framework changes
>   staging: mt29f_spinand: use the mtd instance embedded in struct
>     nand_chip
>   cris: nand: use the mtd instance embedded in struct nand_chip
>   mtd: nand: update mtd_to_nand()
>   mtd: nand: remove useless mtd->priv = chip assignments
>   cris: nand: remove useless mtd->priv = chip assignments
>   staging: mt29f_spinand: remove useless mtd->priv = chip assignment
>   mtd: nand: simplify nand_dt_init() usage
>   mtd: nand: kill the chip->flash_node field
>   mtd: nand: add helpers to access ->priv
>   ARM: make use of nand_set/get_controller_data() helpers
>   mtd: nand: make use of nand_set/get_controller_data() helpers
>   staging: mt29f_spinand: make use of nand_set/get_controller_data()
>     helpers

All the rest look good to me. I'll wait until I get a good copy of patch
12 before taking them.

Brian

>  Documentation/DocBook/mtdnand.tmpl             |  31 +++---
>  arch/arm/mach-ep93xx/snappercl15.c             |   4 +-
>  arch/arm/mach-ep93xx/ts72xx.c                  |   4 +-
>  arch/arm/mach-imx/mach-qong.c                  |   2 +-
>  arch/arm/mach-ixp4xx/ixdp425-setup.c           |   6 +-
>  arch/arm/mach-omap1/board-nand.c               |   2 +-
>  arch/arm/mach-orion5x/ts78xx-setup.c           |   6 +-
>  arch/arm/mach-pxa/balloon3.c                   |   2 +-
>  arch/arm/mach-pxa/em-x270.c                    |   2 +-
>  arch/arm/mach-pxa/palmtx.c                     |   2 +-
>  arch/blackfin/mach-bf537/boards/stamp.c        |   2 +-
>  arch/blackfin/mach-bf561/boards/acvilon.c      |   2 +-
>  arch/cris/arch-v32/drivers/mach-a3/nandflash.c |   8 +-
>  arch/cris/arch-v32/drivers/mach-fs/nandflash.c |   8 +-
>  arch/mips/alchemy/devboards/db1200.c           |   2 +-
>  arch/mips/alchemy/devboards/db1300.c           |   2 +-
>  arch/mips/alchemy/devboards/db1550.c           |   2 +-
>  arch/mips/pnx833x/common/platform.c            |   2 +-
>  arch/mips/rb532/devices.c                      |   2 +-
>  arch/sh/boards/mach-migor/setup.c              |   2 +-
>  drivers/mtd/nand/ams-delta.c                   |  26 ++---
>  drivers/mtd/nand/atmel_nand.c                  | 118 ++++++++++----------
>  drivers/mtd/nand/au1550nd.c                    |  40 +++----
>  drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h |   1 -
>  drivers/mtd/nand/bcm47xxnflash/main.c          |   9 +-
>  drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c   |  34 +++---
>  drivers/mtd/nand/bf5xx_nand.c                  |  25 ++---
>  drivers/mtd/nand/brcmnand/brcmnand.c           |  54 +++++----
>  drivers/mtd/nand/cafe_nand.c                   |  51 +++++----
>  drivers/mtd/nand/cmx270_nand.c                 |  20 ++--
>  drivers/mtd/nand/cs553x_nand.c                 |  30 +++--
>  drivers/mtd/nand/davinci_nand.c                |  37 ++++---
>  drivers/mtd/nand/denali.c                      |  67 ++++++-----
>  drivers/mtd/nand/denali.h                      |   1 -
>  drivers/mtd/nand/diskonchip.c                  | 148 ++++++++++++-------------
>  drivers/mtd/nand/docg4.c                       |  91 ++++++++-------
>  drivers/mtd/nand/fsl_elbc_nand.c               |  61 +++++-----
>  drivers/mtd/nand/fsl_ifc_nand.c                |  71 ++++++------
>  drivers/mtd/nand/fsl_upm.c                     |  31 +++---
>  drivers/mtd/nand/fsmc_nand.c                   |  69 ++++++------
>  drivers/mtd/nand/gpio.c                        |  19 ++--
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c          |   2 +-
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c         |  67 ++++++-----
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h         |   1 -
>  drivers/mtd/nand/hisi504_nand.c                |  48 ++++----
>  drivers/mtd/nand/jz4740_nand.c                 |  14 +--
>  drivers/mtd/nand/lpc32xx_mlc.c                 |  32 +++---
>  drivers/mtd/nand/lpc32xx_slc.c                 |  42 ++++---
>  drivers/mtd/nand/mpc5121_nfc.c                 |  52 +++++----
>  drivers/mtd/nand/mxc_nand.c                    |  76 +++++++------
>  drivers/mtd/nand/nand_base.c                   | 102 +++++++++--------
>  drivers/mtd/nand/nand_bbt.c                    |  32 +++---
>  drivers/mtd/nand/nand_bch.c                    |   4 +-
>  drivers/mtd/nand/nand_ecc.c                    |   4 +-
>  drivers/mtd/nand/nandsim.c                     |  35 +++---
>  drivers/mtd/nand/ndfc.c                        |  53 ++++-----
>  drivers/mtd/nand/nuc900_nand.c                 |  25 ++---
>  drivers/mtd/nand/omap2.c                       | 109 ++++++++++--------
>  drivers/mtd/nand/orion_nand.c                  |  13 +--
>  drivers/mtd/nand/pasemi_nand.c                 |  21 ++--
>  drivers/mtd/nand/plat_nand.c                   |  16 +--
>  drivers/mtd/nand/pxa3xx_nand.c                 |  70 ++++++------
>  drivers/mtd/nand/r852.c                        |  41 +++----
>  drivers/mtd/nand/r852.h                        |   1 -
>  drivers/mtd/nand/s3c2410.c                     |  32 +++---
>  drivers/mtd/nand/sh_flctl.c                    |   9 +-
>  drivers/mtd/nand/sharpsl.c                     |  23 ++--
>  drivers/mtd/nand/sm_common.c                   |   2 +-
>  drivers/mtd/nand/socrates_nand.c               |  24 ++--
>  drivers/mtd/nand/sunxi_nand.c                  |  40 ++++---
>  drivers/mtd/nand/tmio_nand.c                   |  13 ++-
>  drivers/mtd/nand/txx9ndfmc.c                   |  25 ++---
>  drivers/mtd/nand/vf610_nfc.c                   |   9 +-
>  drivers/mtd/nand/xway_nand.c                   |   4 +-
>  drivers/staging/mt29f_spinand/mt29f_spinand.c  |  19 ++--
>  include/linux/mtd/nand.h                       |  26 ++++-
>  include/linux/mtd/sh_flctl.h                   |   3 +-
>  scripts/coccinelle/api/nand-priv-no-mtd.cocci  |  91 +++++++++++++++
>  78 files changed, 1179 insertions(+), 1097 deletions(-)
>  create mode 100644 scripts/coccinelle/api/nand-priv-no-mtd.cocci
> 
> -- 
> 2.1.4
> 
