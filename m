From: fcooper@ti.com (Franklin S Cooper Jr.)
Date: Wed, 6 Apr 2016 18:33:03 -0500
Subject: [PATCH 00/12] mtd: get rid of of_mtd.{c,h} and of_get_nand_xx()
In-Reply-To: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <57059CAF.3030002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/01/2016 07:54 AM, Boris Brezillon wrote:
> Hello,
> 
> of_mtd.{h,c} are providing the of_get_nand_xxx() helpers to help NAND
> controller drivers parse some generic NAND DT properties.
> An infrastructure has recently been added to NAND core to automatically
> parse those properties when nand_scan_ident() is called, thus removing
> the need for NAND controller drivers to manually parse them.
> 
> This series modifies drivers still making use of those helpers to rely
> on NAND core initialization, and get rid of the of_mtd.{c,h} files by
> moving the of_get_nand_xx() helpers into nand_base.c.
> 

Nothing broke when I ran some NAND tests on my AM335x GP EVM (OMAP SOC).
Tested-by: Franklin S Cooper Jr. <fcooper@ti.com>

> Best Regards,
> 
> Boris
> 
> Boris Brezillon (12):
>   mtd: nand: remove unneeded of_mtd.h inclusions
>   mtd: nand: atmel: rely on generic DT parsing done in nand_scan_ident()
>   mtd: nand: omap2: rely on generic DT parsing done in nand_scan_ident()
>   mtd: nand: brcm: rely on generic DT parsing done in nand_scan_ident()
>   mtd: nand: davinci: rely on generic DT parsing done in
>     nand_scan_ident()
>   mtd: nand: gpmi: rely on generic DT parsing done in nand_scan_ident()
>   mtd: nand: hisi504: rely on generic DT parsing done in
>     nand_scan_ident()
>   mtd: nand: lpc32xx: rely on generic DT parsing done in
>     nand_scan_ident()
>   mtd: nand: mxc: rely on generic DT parsing done in nand_scan_ident()
>   mtd: nand: pxa3xx: rely on generic DT parsing done in
>     nand_scan_ident()
>   mtd: nand: sh_flctl: rely on generic DT parsing done in
>     nand_scan_ident()
>   mtd: nand: move of_get_nand_xxx() helpers into nand_base.c
> 
>  drivers/memory/omap-gpmc.c             |   7 --
>  drivers/mtd/nand/atmel_nand.c          | 133 +++++++++++++++-------------
>  drivers/mtd/nand/brcmnand/brcmnand.c   |   5 +-
>  drivers/mtd/nand/davinci_nand.c        |  85 +++++++++---------
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |  21 +++--
>  drivers/mtd/nand/hisi504_nand.c        |  14 +--
>  drivers/mtd/nand/jz4780_nand.c         |   1 -
>  drivers/mtd/nand/lpc32xx_mlc.c         |   1 -
>  drivers/mtd/nand/lpc32xx_slc.c         |  24 ++---
>  drivers/mtd/nand/mxc_nand.c            |  50 +++++------
>  drivers/mtd/nand/nand_base.c           |  99 ++++++++++++++++++++-
>  drivers/mtd/nand/omap2.c               |   9 +-
>  drivers/mtd/nand/pxa3xx_nand.c         |  28 +++---
>  drivers/mtd/nand/qcom_nandc.c          |   1 -
>  drivers/mtd/nand/sh_flctl.c            |  31 +++----
>  drivers/mtd/nand/sunxi_nand.c          |   1 -
>  drivers/mtd/nand/vf610_nfc.c           |   1 -
>  drivers/of/Makefile                    |   1 -
>  drivers/of/of_mtd.c                    | 155 ---------------------------------
>  include/linux/of_mtd.h                 |  56 ------------
>  20 files changed, 291 insertions(+), 432 deletions(-)
>  delete mode 100644 drivers/of/of_mtd.c
>  delete mode 100644 include/linux/of_mtd.h
> 
