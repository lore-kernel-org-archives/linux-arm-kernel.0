From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 13 Oct 2015 09:28:08 +0200
Subject: [PATCH v3] mtd: nand: pass page number to ecc->write_xxx() methods
In-Reply-To: <20151012233537.GR107187@google.com>
References: <1443765205-8730-1-git-send-email-boris.brezillon@free-electrons.com>
 <20151012233537.GR107187@google.com>
Message-ID: <20151013092808.06f4dcc7@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Mon, 12 Oct 2015 16:35:37 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> On Fri, Oct 02, 2015 at 07:53:25AM +0200, Boris Brezillon wrote:
> > The ->read_xxx() methods are all passed the page number the NAND controller
> > is supposed to read, but ->write_xxx() do not have such a parameter.
> > 
> > This is a problem if we want to properly implement data
> > scrambling/randomization in order to mitigate MLC sensibility to repeated
> > pattern: to prevent bitflips in adjacent pages in the same block we need
> > to avoid repeating the same pattern at the same offset in those pages,
> > hence the randomizer/scrambler engine need to be passed the page value
> > in order to adapt its seed accordingly.
> > 
> > Moreover, adding the page parameter to the ->write_xxx() methods add some
> > consistency to the current API.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > CC: Josh Wu <josh.wu@atmel.com>
> > CC: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > CC: Maxime Ripard <maxime.ripard@free-electrons.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: Huang Shijie <shijie.huang@arm.com>
> > CC: Stefan Agner <stefan@agner.ch>
> > CC: devel at driverdev.osuosl.org
> > CC: linux-arm-kernel at lists.infradead.org
> > CC: linux-kernel at vger.kernel.org
> > ---
> > Changes since v2:
> > - fixed compilation error in the gpmi driver
> > - compile tested all impacted drivers except the bf5xx_nand,
> >   fsl_elbc_nand and fsl_ifc_nand ones
> > 
> > Changes since v1:
> > - rebased on l2-mtd/master
> > - fixed compilation error in the docg4 driver
> > ---
> >  drivers/mtd/nand/atmel_nand.c                 |  6 ++++--
> >  drivers/mtd/nand/bf5xx_nand.c                 |  3 ++-
> >  drivers/mtd/nand/brcmnand/brcmnand.c          |  4 ++--
> >  drivers/mtd/nand/cafe_nand.c                  |  3 ++-
> >  drivers/mtd/nand/denali.c                     |  5 +++--
> >  drivers/mtd/nand/docg4.c                      |  6 +++---
> >  drivers/mtd/nand/fsl_elbc_nand.c              |  4 ++--
> >  drivers/mtd/nand/fsl_ifc_nand.c               |  2 +-
> >  drivers/mtd/nand/gpmi-nand/gpmi-nand.c        |  8 +++----
> >  drivers/mtd/nand/hisi504_nand.c               |  3 ++-
> >  drivers/mtd/nand/lpc32xx_mlc.c                |  3 ++-
> >  drivers/mtd/nand/lpc32xx_slc.c                |  5 +++--
> >  drivers/mtd/nand/nand_base.c                  | 31 ++++++++++++++++++---------
> >  drivers/mtd/nand/omap2.c                      |  3 ++-
> >  drivers/mtd/nand/pxa3xx_nand.c                |  3 ++-
> >  drivers/mtd/nand/sh_flctl.c                   |  3 ++-
> >  drivers/mtd/nand/sunxi_nand.c                 |  5 +++--
> >  drivers/mtd/nand/vf610_nfc.c                  |  2 +-
> >  drivers/staging/mt29f_spinand/mt29f_spinand.c |  3 ++-
> >  include/linux/mtd/nand.h                      |  6 +++---
> >  20 files changed, 66 insertions(+), 42 deletions(-)
> 
> Hmm, am I missing something, or does this not apply to l2-mtd.git or
> linux-next.git?

Hm, actually I based it on l2-mtd but before you applied my cleanup
series, which explains why it does not apply anymore. I'll send a v3
after rebasing on l2-mtd.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
