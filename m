From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 19 Oct 2017 00:29:22 +0200
Subject: [RFC 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
References: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
Message-ID: <20171019002922.5ab978ed@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

On Wed, 18 Oct 2017 16:36:17 +0200
Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Hi,
> 
> This series adds the implementation of the NAND framework ->exec_op()
> interface with all the related hooks and helpers. The reasons for adding
> it are explained in details in the commit log "mtd: nand: add
>  ->exec_op() implementation", but mostly it will ease later expansion of  
> the framework, as well as the implementation of new vendor specific
> commands, and should also ease driver development.

Still need to review patch 6, but I'd like to say I'm really happy to
see that happen, finally. Hopefully that will help us make the NAND
framework a bit easier to maintain and allow us to support advanced
NAND features without having to patch all NAND controller drivers every
time we add a new vendor specific operation. I also have in mind a few
NAND controller drivers that have been rejected because they were not
fitting in the ->cmd_ctrl() approach and I didn't want to add more
drivers with their own partially implemented/broken ->cmdfunc() method.

Kudos for the work you've done, and I hope we'll get reviews from other
active NAND driver maintainers/contributors. To all NAND driver
maintainers: note that the long term goal is to get rid of
->cmd_ctrl()/cmdfunc()/read/write_buf/byte/word() entirely and replace
them with a single ->exec_op() hook. Please let us know if you need
extra things that are not yet exposed in nand_op_instr/nand_op_parser
or if you would like things to be done differently.

Thanks,

Boris

> 
> The series contains as well the reworked NAND controller driver from
> Marvell.
> 
> A lot of comments are written to explain how to use the new API and the
> Marvell driver shows how to implement it. A proper external
> documentation is being written and will later be submitted.
> 
> It also changes the device tree NAND node definition for all platforms
> referring to the Marvell driver to use the new bindings. They are more
> hierarchical and fit the real organization of the hardware, by having
> NAND partitions that are part of NAND chip nodes, themselves part of
> the NAND controller node.
> 
> See the commit log of "mtd: nand: add reworked Marvell NAND controller
> driver" for details about why a completely new driver is needed.
> 
> As this series changes several core functions and also directly touches
> multiple controller drivers, it would be great to have reviews and tests
> from the concerned maintainers. Only PXA3xx SoCs are not supported yet
> (explaining the RFC) as having a local board to test is really needed.
> 
> Thank you,
> Miqu?l
> 
> 
> Boris Brezillon (2):
>   mtd: nand: provide several helpers to do common NAND operations
>   mtd: nand: force drivers to explicitly send READ/PROG commands
> 
> Miquel Raynal (10):
>   mtd: nand: use a static data_interface in the nand_chip structure
>   mtd: nand: add ->exec_op() implementation
>   dt-bindings: mtd: add Marvell NAND controller documentation
>   mtd: nand: add reworked Marvell NAND controller driver
>   ARM: dts: armada-370-xp: use reworked NAND controller driver
>   ARM: dts: armada-375: use reworked NAND controller driver
>   ARM: dts: armada-38x: use reworked NAND controller driver
>   ARM: dts: armada-39x: use reworked NAND controller driver
>   ARM: dts: pxa: use reworked NAND controller driver
>   ARM64: dts: marvell: use reworked NAND controller driver on Armada
>     7K/8K
> 
>  .../devicetree/bindings/mtd/marvell-nand.txt       |   95 +
>  arch/arm/boot/dts/armada-370-db.dts                |   56 +-
>  arch/arm/boot/dts/armada-370-dlink-dns327l.dts     |  119 +-
>  arch/arm/boot/dts/armada-370-mirabox.dts           |   50 +-
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts     |   89 +-
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts     |   89 +-
>  arch/arm/boot/dts/armada-370-rd.dts                |   51 +-
>  arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |   63 +-
>  arch/arm/boot/dts/armada-370-xp.dtsi               |    6 +-
>  arch/arm/boot/dts/armada-375-db.dts                |   49 +-
>  arch/arm/boot/dts/armada-375.dtsi                  |    6 +-
>  arch/arm/boot/dts/armada-385-db-ap.dts             |   68 +-
>  arch/arm/boot/dts/armada-385-linksys-caiman.dts    |  129 +-
>  arch/arm/boot/dts/armada-385-linksys-cobra.dts     |  129 +-
>  arch/arm/boot/dts/armada-385-linksys-rango.dts     |  141 +-
>  arch/arm/boot/dts/armada-385-linksys-shelby.dts    |  129 +-
>  arch/arm/boot/dts/armada-385-linksys.dtsi          |   15 +-
>  arch/arm/boot/dts/armada-388-db.dts                |   54 +-
>  arch/arm/boot/dts/armada-38x.dtsi                  |    6 +-
>  arch/arm/boot/dts/armada-390-db.dts                |   65 +-
>  arch/arm/boot/dts/armada-395-gp.dts                |   73 +-
>  arch/arm/boot/dts/armada-398-db.dts                |   59 +-
>  arch/arm/boot/dts/armada-39x.dtsi                  |    6 +-
>  arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |    1 -
>  arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |    1 -
>  arch/arm/boot/dts/armada-xp-db.dts                 |    1 -
>  arch/arm/boot/dts/armada-xp-gp.dts                 |    1 -
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |    1 -
>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |  155 +-
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |   89 +-
>  arch/arm/boot/dts/pxa3xx.dtsi                      |    6 +-
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts     |   47 +-
>  .../boot/dts/marvell/armada-cp110-master.dtsi      |    6 +-
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |    6 +-
>  drivers/mtd/nand/Kconfig                           |   11 +
>  drivers/mtd/nand/Makefile                          |    1 +
>  drivers/mtd/nand/atmel/nand-controller.c           |    9 +-
>  drivers/mtd/nand/bf5xx_nand.c                      |    6 +-
>  drivers/mtd/nand/brcmnand/brcmnand.c               |   20 +-
>  drivers/mtd/nand/cafe_nand.c                       |   20 +-
>  drivers/mtd/nand/denali.c                          |  109 +-
>  drivers/mtd/nand/diskonchip.c                      |    4 +-
>  drivers/mtd/nand/docg4.c                           |   19 +-
>  drivers/mtd/nand/fsl_elbc_nand.c                   |    6 +-
>  drivers/mtd/nand/fsl_ifc_nand.c                    |    6 +-
>  drivers/mtd/nand/fsmc_nand.c                       |    5 +-
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |   76 +-
>  drivers/mtd/nand/hisi504_nand.c                    |    9 +-
>  drivers/mtd/nand/jz4740_nand.c                     |   16 +-
>  drivers/mtd/nand/lpc32xx_mlc.c                     |    7 +-
>  drivers/mtd/nand/lpc32xx_slc.c                     |   33 +-
>  drivers/mtd/nand/marvell_nand.c                    | 2384 ++++++++++++++++++++
>  drivers/mtd/nand/mtk_nand.c                        |   21 +-
>  drivers/mtd/nand/nand_base.c                       | 2020 ++++++++++++++---
>  drivers/mtd/nand/nand_hynix.c                      |  106 +-
>  drivers/mtd/nand/nand_micron.c                     |   50 +-
>  drivers/mtd/nand/nand_timings.c                    |   23 +-
>  drivers/mtd/nand/omap2.c                           |    8 +-
>  drivers/mtd/nand/pxa3xx_nand.c                     |    8 +-
>  drivers/mtd/nand/qcom_nandc.c                      |   16 +-
>  drivers/mtd/nand/r852.c                            |   11 +-
>  drivers/mtd/nand/sh_flctl.c                        |    6 +-
>  drivers/mtd/nand/sunxi_nand.c                      |   97 +-
>  drivers/mtd/nand/tango_nand.c                      |   27 +-
>  drivers/mtd/nand/tmio_nand.c                       |    5 +-
>  drivers/mtd/nand/vf610_nfc.c                       |    6 +-
>  drivers/staging/mt29f_spinand/mt29f_spinand.c      |    7 +-
>  include/linux/mtd/rawnand.h                        |  391 +++-
>  68 files changed, 5980 insertions(+), 1424 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
>  create mode 100644 drivers/mtd/nand/marvell_nand.c
> 
