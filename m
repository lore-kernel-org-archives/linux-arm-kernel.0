From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 1 Oct 2015 10:17:50 -0700
Subject: [PATCH] mtd: nand: pass page number to ecc->write_xxx() methods
In-Reply-To: <1440436219-31625-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1440436219-31625-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151001171750.GR143959@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 07:10:19PM +0200, Boris Brezillon wrote:
> The ->read_xxx() methods are all passed the page number the NAND controller
> is supposed to read, but ->write_xxx() do not have such a parameter.
> 
> This is a problem if we want to properly implement data
> scrambling/randomization in order to mitigate MLC sensibility to repeated
> pattern: to prevent bitflips in adjacent pages in the same block we need
> to avoid repeating the same pattern at the same offset in those pages,
> hence the randomizer/scrambler engine need to be passed the page value
> in order to adapt its seed accordingly.
> 
> Moreover, adding the page parameter the ->write_xxx() methods add some
> consistency to the current model.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> CC: Josh Wu <josh.wu@atmel.com>
> CC: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> CC: Maxime Ripard <maxime.ripard@free-electrons.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Huang Shijie <shijie.huang@intel.com>
> CC: Bryan Wu <bryan.wu@analog.com>
> CC: devel at driverdev.osuosl.org
> CC: linux-arm-kernel at lists.infradead.org
> CC: linux-kernel at vger.kernel.org
> 
> ---
>  drivers/mtd/nand/atmel_nand.c                 |  6 ++++--
>  drivers/mtd/nand/bf5xx_nand.c                 |  3 ++-
>  drivers/mtd/nand/brcmnand/brcmnand.c          |  4 ++--
>  drivers/mtd/nand/cafe_nand.c                  |  3 ++-
>  drivers/mtd/nand/denali.c                     |  5 +++--
>  drivers/mtd/nand/docg4.c                      |  4 ++--
>  drivers/mtd/nand/fsl_elbc_nand.c              |  4 ++--
>  drivers/mtd/nand/fsl_ifc_nand.c               |  2 +-
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c        |  6 +++---
>  drivers/mtd/nand/hisi504_nand.c               |  3 ++-
>  drivers/mtd/nand/lpc32xx_mlc.c                |  3 ++-
>  drivers/mtd/nand/lpc32xx_slc.c                |  5 +++--
>  drivers/mtd/nand/nand_base.c                  | 31 ++++++++++++++++++---------
>  drivers/mtd/nand/omap2.c                      |  3 ++-
>  drivers/mtd/nand/pxa3xx_nand.c                |  3 ++-
>  drivers/mtd/nand/sh_flctl.c                   |  3 ++-
>  drivers/mtd/nand/sunxi_nand.c                 |  5 +++--
>  drivers/staging/mt29f_spinand/mt29f_spinand.c |  3 ++-
>  include/linux/mtd/nand.h                      |  6 +++---
>  19 files changed, 63 insertions(+), 39 deletions(-)

Tip for rebasing -- I noticed one build failure for docg4:

  drivers/mtd/nand/docg4.c: In function ?docg4_block_markbad?:
  drivers/mtd/nand/docg4.c:1116:2: error: too few arguments to function ?docg4_write_page?
  drivers/mtd/nand/docg4.c:985:12: note: declared here

Brian
