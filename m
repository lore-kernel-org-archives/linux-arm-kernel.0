From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 14 Nov 2013 15:53:57 -0300
Subject: [PATCH v4 15/31] mtd: nand: pxa3xx: Use a completion to signal
 device ready
In-Reply-To: <20131114183923.GO9468@ld-irv-0074.broadcom.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383837455-30721-16-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131114183923.GO9468@ld-irv-0074.broadcom.com>
Message-ID: <20131114185356.GA9912@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian,

On Thu, Nov 14, 2013 at 10:39:23AM -0800, Brian Norris wrote:
> On Thu, Nov 07, 2013 at 12:17:19PM -0300, Ezequiel Garcia wrote:
> > --- a/drivers/mtd/nand/pxa3xx_nand.c
> > +++ b/drivers/mtd/nand/pxa3xx_nand.c
> > @@ -863,21 +867,28 @@ static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
> >  {
> >  	struct pxa3xx_nand_host *host = mtd->priv;
> >  	struct pxa3xx_nand_info *info = host->info_data;
> > +	int ret;
> > +
> > +	/* Need to wait? */
> > +	if (!info->is_ready) {
> > +		ret = wait_for_completion_timeout(&info->dev_ready,
> > +				CHIP_DELAY_TIMEOUT);
> > +		if (!ret) {
> > +			dev_err(&info->pdev->dev, "Ready time out!!!\n");
> > +			return NAND_STATUS_FAIL;
> > +		}
> > +		info->is_ready = 1;
> 
> Shouldn't the is_ready=1 line to be above the if (!ret) condition? I
> think you want to set is_ready=1 in either case (success or timeout).
> With this code, any timeout will cause subsequent waitfunc()'s to block,
> even if they are never going to catch an interrupt.
> 

Yes, good catch!

> I think this kind of mistake is easier to make now, since the 'is_ready'
> field isn't properly descriptive any more. It doesn't represent "is the
> device ready"; it represents "is there a pending command on which I need
> to wait". (I don't care if you change the name; I'm just pointing this
> out.)
> 

Yes, I agree. Maybe, "need_wait" or something like that would fit
better. Let me submit a new patch for this one.

> > +	}
> >  
> 
> I think all the other patches up to this one are good. I may push them
> to l2-mtd.git now, unless you object.
> 

Great, thanks a lot for reviewing and for all the feedback!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
