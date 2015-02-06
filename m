From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 5 Feb 2015 17:08:35 -0800
Subject: [PATCH v2 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <20150204111028.2f0bd376@bbrezillon>
References: <1422284164-16867-1-git-send-email-maxime.ripard@free-electrons.com>
 <1422284164-16867-2-git-send-email-maxime.ripard@free-electrons.com>
 <20150204111028.2f0bd376@bbrezillon>
Message-ID: <20150206010835.GB30781@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Rob

This patch has conflicts with an ARM64-preparation from Rob. I'd like to
get this patch in first, as it's a bugfix. But I'd like to settle
Boris's comments first.

(Regarding the request to get this into 3.19: not likely. Judging by the
age of the "bug", it's not massively critical, and we have no time. It
can get out through -stable once it's gotten proper review and testing.)

On Wed, Feb 04, 2015 at 11:10:28AM +0100, Boris Brezillon wrote:
> On Mon, 26 Jan 2015 15:56:03 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > The NDDB register holds the data that are needed by the read and write
> > commands.
> > 
> > However, during a read PIO access, the datasheet specifies that after each 32
> > bits read in that register, when BCH is enabled, we have to make sure that the
> > RDDREQ bit is set in the NDSR register.
> > 
> > This fixes an issue that was seen on the Armada 385, and presumably other mvebu
> > SoCs, when a read on a newly erased page would end up in the driver reporting a
> > timeout from the NAND.
> > 
> > Cc: <stable@vger.kernel.org> # v3.14
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/mtd/nand/pxa3xx_nand.c | 45 ++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 39 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> > index 96b0b1d27df1..e6918befb951 100644
> > --- a/drivers/mtd/nand/pxa3xx_nand.c
> > +++ b/drivers/mtd/nand/pxa3xx_nand.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/mtd/partitions.h>
> >  #include <linux/io.h>
> >  #include <linux/irq.h>
> > +#include <linux/jiffies.h>
> >  #include <linux/slab.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > @@ -480,6 +481,38 @@ static void disable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
> >  	nand_writel(info, NDCR, ndcr | int_mask);
> >  }
> >  
> > +static void drain_fifo(struct pxa3xx_nand_info *info, void *data, int len)
> > +{
> > +	u32 *dst = (u32 *)data;
> > +
> > +	if (info->ecc_bch) {
> > +		while (len--) {
> > +			u32 timeout;
> > +
> > +			*dst++ = nand_readl(info, NDDB);
> > +
> > +			/*
> > +			 * According to the datasheet, when reading
> > +			 * from NDDB with BCH enabled, after each 32
> > +			 * bits reads, we have to make sure that the
> > +			 * NDSR.RDDREQ bit is set
> > +			 */
> 
> I know the datasheet says this bit should be checked after each
> transfer, but I wonder if we shouldn't check it before reading the data.
> What happens if you drain all the data available in the FIFO ? Is the
> controller still setting the RDDREQ bit ?
> 
> Moreover, the datasheet says this RDDREQ bit should be checked after
> each 32 bytes (not 32 bits) transfer.
> Testing it after each readl call shouldn't hurt though.

Seems like that could quite possibly kill performance unnecessarily,
couldn't it? But then, PIO is probably not that fast in the first
place...

Brian
