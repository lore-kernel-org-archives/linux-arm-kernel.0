From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Jun 2013 00:24:23 -0700
Subject: [PATCH 2/4] mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in
 idle mode
In-Reply-To: <CAPDyKFq+==Bca+AaZwD=A5v6HzL8ShKatq+8U-S=atZUFh8=rQ@mail.gmail.com>
References: <20130607214557.18581.75288.stgit@localhost>
 <20130607214952.18581.90049.stgit@localhost>
 <CAPDyKFq+==Bca+AaZwD=A5v6HzL8ShKatq+8U-S=atZUFh8=rQ@mail.gmail.com>
Message-ID: <20130620072422.GG5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [130614 04:55]:
> On 7 June 2013 23:49, Tony Lindgren <tony@atomide.com> wrote:
> > From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> > +{
> > +       struct omap_hsmmc_host *host = mmc_priv(mmc);
> > +       u32 irq_mask;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&host->irq_lock, flags);
> > +
> > +       if (host->sdio_irq_en == enable) {
> > +               dev_dbg(host->dev, "en/disable:%d already set", enable);
> > +               spin_unlock_irqrestore(&host->irq_lock, flags);
> > +               return;
> > +       }
> > +
> 
> Hi Tony/Andreas,
> 
> I belive a "pm_runtime_get_sync" would be needed here, outside the
> spinlock ofcourse. Before returning from this function, obviusly
> return the references by a pm_runtime_put* in some form.
> 
> Then you will be able to remove the "active_pinmux" variable entirely,
> since you know the runtime callbacks is the only place were you need
> to handle the gpio irq enable|disable.

Thanks for the review, that's a good point. I'll check this as
soon as I have a chance.

Regards,

Tony
