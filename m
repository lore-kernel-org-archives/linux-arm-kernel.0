From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Dec 2017 07:09:30 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
Message-ID: <20171214070930.0b885f6d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu,  7 Dec 2017 21:18:02 +0100
Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Hi,
> 
> After the addition of the NAND framework ->exec_op() interface (see [1]
> for the series preparing it and [2] for the last version of the
> core-side implementation of ->exec_op() itself), this series replaces
> the current Marvell NAND controller driver pxa3xx_nand.c with a rework
> called marvell_nand.c.
> 
> Aside the fact that it drops the big state machine, improves the overall
> speed and implements raw accesses, it is the first driver-side
> implementation of the ->exec_op() interface and may be used as reference
> for latter reworks of the same type.
> 
> One may find more detail about why a completely new driver is needed in
> the commit log of:
> 
>     "mtd: nand: add reworked Marvell NAND controller driver"
> 
> The series also changes the device tree NAND node definition for all
> platforms referring to the Marvell driver to use the new bindings. They
> are more hierarchical and fit the real organization of the hardware, by
> having NAND partitions that are part of NAND chip nodes, themselves part
> of the NAND controller node.
> 
> These changes have been tested on:
>    - PXA3xx platform with a CM-X300 board (2kiB page NAND, 1b/512B
>      strength, Hamming ECC engine) [32 bits]
>    - Armada 385 DB AP (4kiB page NAND, 4b/512B, BCH ECC engine) [32 bits]
>    - Armada 398 DB (4kiB page NAND, 8b/512B, BCH ECC engine using a layout
>      with a last chunk different than the others) [32 bits]
>    - Armada 7040 DB and Armada 8040 DB (4kiB page NAND, 4b/512B, BCH ECC
>      engine) [64 bits]
> 
> Robert, it would be great if you could also do more testing on PXA and
> validate this driver. If needed, a branch ready to be tested is
> available at [3]. It is based on nand/next and has all the changes
> brought by the previously mentionned series as well as this one.

Robert, do you think you'll have some time to test Miquel's branch on
your PXA boards? Miquel already tested on one of these boards (CM-X300),
but we'd like to have other testers. Also feel free to review the
driver if have the time.

Thanks,

Boris

> 
> Thank you,
> Miqu?l
> 
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg619633.html
> [2] http://lists.infradead.org/pipermail/linux-mtd/2017-December/077965.html
> [3] https://github.com/miquelraynal/linux/tree/marvell/nand-next/nfc-rework
> 
> Miquel Raynal (12):
>   dt-bindings: mtd: add Marvell NAND controller documentation
>   mtd: nand: add reworked Marvell NAND controller driver
>   mtd: nand: replace pxa3xx_nand driver by its rework called
>     marvell_nand
>   dt-bindings: mtd: remove pxa3xx NAND controller documentation
>   mtd: nand: remove useless fields from pxa3xx NAND platform data
>   ARM: dts: armada-370-xp: use reworked NAND controller driver
>   ARM: dts: armada-375: use reworked NAND controller driver
>   ARM: dts: armada-38x: use reworked NAND controller driver
>   ARM: dts: armada-39x: use reworked NAND controller driver
>   ARM: dts: pxa: use reworked NAND controller driver
>   ARM64: dts: marvell: use reworked NAND controller driver on Armada 7K
>   ARM64: dts: marvell: use reworked NAND controller driver on Armada 8K
> 
>  .../devicetree/bindings/mtd/marvell-nand.txt       |   84 +
>  .../devicetree/bindings/mtd/pxa3xx-nand.txt        |   50 -
>  arch/arm/boot/dts/armada-370-db.dts                |   57 +-
>  arch/arm/boot/dts/armada-370-dlink-dns327l.dts     |  120 +-
>  arch/arm/boot/dts/armada-370-mirabox.dts           |   51 +-
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts     |   90 +-
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts     |   90 +-
>  arch/arm/boot/dts/armada-370-rd.dts                |   52 +-
>  arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |   64 +-
>  arch/arm/boot/dts/armada-370-xp.dtsi               |    6 +-
>  arch/arm/boot/dts/armada-375-db.dts                |   50 +-
>  arch/arm/boot/dts/armada-375.dtsi                  |    6 +-
>  arch/arm/boot/dts/armada-385-db-ap.dts             |   69 +-
>  arch/arm/boot/dts/armada-385-linksys-caiman.dts    |  129 +-
>  arch/arm/boot/dts/armada-385-linksys-cobra.dts     |  129 +-
>  arch/arm/boot/dts/armada-385-linksys-rango.dts     |  141 +-
>  arch/arm/boot/dts/armada-385-linksys-shelby.dts    |  129 +-
>  arch/arm/boot/dts/armada-385-linksys.dtsi          |   16 +-
>  arch/arm/boot/dts/armada-388-db.dts                |   55 +-
>  arch/arm/boot/dts/armada-38x.dtsi                  |    6 +-
>  arch/arm/boot/dts/armada-390-db.dts                |   66 +-
>  arch/arm/boot/dts/armada-395-gp.dts                |   74 +-
>  arch/arm/boot/dts/armada-398-db.dts                |   60 +-
>  arch/arm/boot/dts/armada-39x.dtsi                  |    6 +-
>  arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |    2 +-
>  arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |    2 +-
>  arch/arm/boot/dts/armada-xp-db.dts                 |    2 +-
>  arch/arm/boot/dts/armada-xp-gp.dts                 |    2 +-
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |    2 +-
>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |  156 +-
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |   90 +-
>  arch/arm/boot/dts/pxa3xx.dtsi                      |    6 +-
>  arch/arm/configs/cm_x300_defconfig                 |    2 +-
>  arch/arm/configs/mvebu_v7_defconfig                |    2 +-
>  arch/arm/configs/pxa3xx_defconfig                  |    3 +-
>  arch/arm/configs/pxa_defconfig                     |    2 +-
>  arch/arm/configs/raumfeld_defconfig                |    2 +-
>  arch/arm/mach-mmp/ttc_dkb.c                        |    4 +-
>  arch/arm/mach-pxa/cm-x300.c                        |    8 +-
>  arch/arm/mach-pxa/colibri-pxa3xx.c                 |    8 +-
>  arch/arm/mach-pxa/colibri.h                        |    2 +-
>  arch/arm/mach-pxa/littleton.c                      |   10 +-
>  arch/arm/mach-pxa/mxm8x10.c                        |   10 +-
>  arch/arm/mach-pxa/raumfeld.c                       |    6 +-
>  arch/arm/mach-pxa/zylonite.c                       |   10 +-
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts     |   52 +-
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts     |   46 +-
>  .../boot/dts/marvell/armada-cp110-master.dtsi      |    8 +-
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |   10 +-
>  drivers/mtd/nand/Kconfig                           |   12 +
>  drivers/mtd/nand/Makefile                          |    2 +-
>  drivers/mtd/nand/marvell_nand.c                    | 2950 ++++++++++++++++++++
>  drivers/mtd/nand/pxa3xx_nand.c                     | 2104 --------------
>  include/linux/platform_data/mtd-nand-pxa3xx.h      |   43 +-
>  54 files changed, 4093 insertions(+), 3065 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
>  delete mode 100644 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
>  create mode 100644 drivers/mtd/nand/marvell_nand.c
>  delete mode 100644 drivers/mtd/nand/pxa3xx_nand.c
> 
