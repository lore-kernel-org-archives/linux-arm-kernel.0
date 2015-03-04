From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Wed, 4 Mar 2015 17:18:55 +0100
Subject: [PATCH] mtd: nand: pxa3xx: Switch FIFO draining to jiffies-based
 timeout
In-Reply-To: <20150303101846.GO15668@tarshish>
References: <1425376529-1860-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150303101846.GO15668@tarshish>
Message-ID: <20150304161855.GN4911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Tue, Mar 03, 2015 at 12:18:46PM +0200, Baruch Siach wrote:
> Hi Maxime,
> 
> On Tue, Mar 03, 2015 at 10:55:29AM +0100, Maxime Ripard wrote:
> > Now that the driver handles the FIFO draining in a threaded interrupt, we can
> > base our timeout on jiffies and sleeping, instead of using mdelay.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/mtd/nand/pxa3xx_nand.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> > index 3f09f2e9aeb4..1eb957c347cd 100644
> > --- a/drivers/mtd/nand/pxa3xx_nand.c
> > +++ b/drivers/mtd/nand/pxa3xx_nand.c
> > @@ -496,16 +496,15 @@ static void drain_fifo(struct pxa3xx_nand_info *info, void *data, int len)
> >  		while (len > 8) {
> >  			__raw_readsl(info->mmio_base + NDDB, data, 8);
> >  
> > -			for (timeout = 0;
> > -			     !(nand_readl(info, NDSR) & NDSR_RDDREQ);
> > -			     timeout++) {
> > -				if (timeout >= 5) {
> > +			timeout = jiffies + msecs_to_jiffies(5);
> > +			while (!(nand_readl(info, NDSR) & NDSR_RDDREQ)) {
> > +				if (!time_before(jiffies, timeout)) {
> >  					dev_err(&info->pdev->dev,
> >  						"Timeout on RDDREQ while draining the FIFO\n");
> >  					return;
> >  				}
> >  
> > -				mdelay(1);
> > +				msleep(1);
> >  			}
> 
> You may want to consider using readl_relaxed_poll_timeout() from 
> linux/iopoll.h, which was introduced in v4.0-rc1.

Thanks for pointing this out.

I'll send a new version using this.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150304/06bd1069/attachment-0001.sig>
