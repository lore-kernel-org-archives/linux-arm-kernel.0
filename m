From: s-ghorai@ti.com (Ghorai, Sukumar)
Date: Tue, 27 Jul 2010 19:02:14 +0530
Subject: [PATCH] mmc: failure of block read wait for long time
In-Reply-To: <4C4EDD85.5060606@nokia.com>
References: <1280230066-27612-1-git-send-email-s-ghorai@ti.com>
	<4C4EDD85.5060606@nokia.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E417D80@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter at nokia.com]
> Sent: Tuesday, July 27, 2010 6:52 PM
> To: Ghorai, Sukumar
> Cc: linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] mmc: failure of block read wait for long time
> 
> Sukumar Ghorai wrote:
> >  multi-block read failure retries in single block read one by one. It
> continues
> >  retry of subsequent blocks, even after failure. Application will not be
> able
> >  to decode the interleave data (even if few single block read success).
> >  This patch fixes this problem by returning at the first failure instead
> of
> >  waiting for long duration.
> 
> How can you know what sectors are important to the upper layers?
[Ghorai] 
1. This is obvious either give the complete data to above layer or not. And every protocol follows that.

2. And other scenario, say apps request for to read the 128MB data and it will take quite long time before returning in failure case.

3. it is quite obvious if the read fail for sector(x) it will fail for sector(x+1)

> 
> >
> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> > ---
> >  drivers/mmc/card/block.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> > index cb9fbc8..cfb0827 100644
> > --- a/drivers/mmc/card/block.c
> > +++ b/drivers/mmc/card/block.c
> > @@ -419,7 +419,6 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
> struct request *req)
> >  				spin_lock_irq(&md->lock);
> >  				ret = __blk_end_request(req, -EIO,
> brq.data.blksz);
> >  				spin_unlock_irq(&md->lock);
> > -				continue;
> >  			}
> >  			goto cmd_err;
> >  		}
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

Regards,
Ghorai
