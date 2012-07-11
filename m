From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Jul 2012 14:10:07 +0800
Subject: mmc: mxs: DEADLOCK
In-Reply-To: <201207101702.52632.marex@denx.de>
References: <4FFC367A.8020100@bluegiga.com> <201207101702.52632.marex@denx.de>
Message-ID: <20120711061005.GF14060@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 05:02:52PM +0200, Marek Vasut wrote:
> Dear Lauri Hintsala,
> 
> [...]
> 
> > --- a/drivers/mmc/host/mxs-mmc.c
> > +++ b/drivers/mmc/host/mxs-mmc.c
> > @@ -278,11 +278,11 @@ static irqreturn_t mxs_mmc_irq_handler(int irq,
> > void *dev_id)
> >   	writel(stat & MXS_MMC_IRQ_BITS,
> >   	       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_CLR);
> > 
> > +	spin_unlock(&host->lock);
> > +
> >   	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
> >   		mmc_signal_sdio_irq(host->mmc);
> > 
> > -	spin_unlock(&host->lock);
> > -
> 
> Spinlock in irq handler is interesting too ;-)
> 
For you information, the following is what I learnt from Arnd when I
was a beginner.

Regards,
Shawn

--- Quote Begins ---

A short form of the strict rules (there are better documentations
out there) is:

* If all users are outside of interrupt or tasklet context,
  use a bare spin_lock().

* If one user is in a tasklet context, use spin_lock() inside
  the tasklet, but spin_lock_bh() outside, to prevent the
  tasklet from interrupting the critical section. Code that
  can be called in either tasklet or regular context needs
  to use spin_lock_bh() as well.

* If one user is in interrupt context, use spin_lock() inside
  of the interrupt handler, but spin_lock_irq() in tasklet
  and normal context (not spin_lock_irqsave()), to prevent
  the interrupt from happening during the critical section.

* Use spin_lock_irqsave() only for functions that can be called
  in either interrupt or non-interrupt context. Most drivers
  don't need this at all.

The simplified rule would be to always use spin_lock_irqsave(),
because that does not require you to understand what you are doing.

My position is that it is better to use the stricter rules, because
that documents that you actually do understand what you are doing ;-)
It's also slightly more efficient, because it avoids having to
save the interrupt status in a variable.

--- Quote Ends ---
