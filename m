From: rtivy@ti.com (Tivy, Robert)
Date: Mon, 18 Feb 2013 23:02:55 +0000
Subject: [PATCH v7 1/2] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <CAK=WgbafX++Nj62w7w0UP-eQdFDWq_NGgTWVmnVxUUbe+WycEA@mail.gmail.com>
References: <cover.1359684780.git.rtivy@ti.com>
 <d9e1adbe6b12aab495f0292c4553c5c8f61c70b5.1359684780.git.rtivy@ti.com>
 <CAK=WgbafX++Nj62w7w0UP-eQdFDWq_NGgTWVmnVxUUbe+WycEA@mail.gmail.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C1431209537@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad at wizery.com]
> Sent: Friday, February 15, 2013 12:07 AM
> 
> Hi Rob,
> 
> On Fri, Feb 1, 2013 at 4:24 AM, Robert Tivy <rtivy@ti.com> wrote:
> >  drivers/remoteproc/Kconfig            |   29 ++-
> >  drivers/remoteproc/Makefile           |    1 +
> >  drivers/remoteproc/da8xx_remoteproc.c |  346
> +++++++++++++++++++++++++++++++++
> >  drivers/remoteproc/remoteproc_core.c  |   22 ++-
> 
> It looks like this patch squashes:
> 1. A fix to drivers/remoteproc/Kconfig
> 2. New functionality in remoteproc_core.c
> 3. A new da8xx driver
> 
> These are independent changes, so we better split them up to separate
> patches.

Ok, I will submit separate patches for these.  In doing so, I will have a stand-alone patch for the drivers/remoteproc/Kconfig fix, as well as the driver-related addition to that file in the driver patch.  PCMIIW.

> 
> >  config OMAP_REMOTEPROC
> >         tristate "OMAP remoteproc support"
> > -       depends on EXPERIMENTAL
> ...
> >  config STE_MODEM_RPROC
> >         tristate "STE-Modem remoteproc support"
> > -       depends on EXPERIMENTAL
> 
> These look unrelated to this patch, and it seems that Kees Cook
> submitted these awhile ago so it should probably already be in
> linux-next (haven't looked). I think we can drop these.

OK, will drop.

> 
> > +/**
> > + * handle_event() - inbound virtqueue message workqueue function
> > + *
> > + * This function is registered as a kernel thread and is scheduled
> by the
> > + * kernel handler.
> > + */
> > +static irqreturn_t handle_event(int irq, void *p)
> > +{
> > +       struct rproc *rproc = (struct rproc *)p;
> > +
> > +       /* Process incoming buffers on our vring */
> > +       while (IRQ_HANDLED == rproc_vq_interrupt(rproc, 0))
> > +               ;
> > +
> > +       /* Must allow wakeup of potenitally blocking senders */
> > +       rproc_vq_interrupt(rproc, 1);
> 
> IIRC we agreed on removing this part, and instead adding it to the
> generic remoteproc framework (i.e. Cyril's patch).

I didn't like the idea of having extra overhead when calling the "all virtqueues" version.

We know that we want to call rproc_vq_interrupt(rproc, 1) just once, and don't care about its return value.  If we did
      /* Process incoming buffers on our vring */
      while (IRQ_HANDLED == rproc_vq_interrupt(rproc, -1))
              ;
then that would essentially turn into:
	do {
		ret = IRQ_NONE;
		if (rproc_vq_interrupt(rproc, 0) == IRQ_HANDLED)
			ret = IRQ_HANDLED;
		if (rproc_vq_interrupt(rproc, 1) == IRQ_HANDLED)
			ret = IRQ_HANDLED;
	} while (ret == IRQ_HANDLED);
which will end up calling rproc_vq_interrupt(rproc, 1) too many times.

We have a benchmark goal to keep wrt/ the whole round-trip time of messages and we're currently not even achieving that, so more overhead than today can't be tolerated.

> 
> > +static int da8xx_rproc_start(struct rproc *rproc)
> > +{
> ...
> > +       dsp_clk = devm_clk_get(dev, NULL);
> > +       if (IS_ERR(dsp_clk)) {
> > +               dev_err(dev, "clk_get error: %ld\n",
> PTR_ERR(dsp_clk));
> > +
> > +               return PTR_RET(dsp_clk);
> > +       }
> > +       drproc->dsp_clk = dsp_clk;
> 
> Have you considered doing this in ->probe() instead? Do we need to
> call get/put every time we start/stop the remote processor?

I suppose we don't need to call it every time, I will try moving it to ->probe()

> 
> > +/* kick a virtqueue */
> > +static void da8xx_rproc_kick(struct rproc *rproc, int vqid)
> > +{
> > +       struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc-
> >priv;
> > +       int timed_out;
> > +       unsigned long timeout;
> > +
> > +       timed_out = 0;
> > +       timeout = jiffies + HZ/100;
> > +
> > +       /* Poll for ack from other side first */
> > +       while (readl(drproc->chipsig) & SYSCFG_CHIPSIG2)
> > +               if (time_after(jiffies, timeout)) {
> > +                       if (readl(drproc->chipsig) & SYSCFG_CHIPSIG2)
> {
> > +                               dev_err(rproc->dev.parent,
> > +                                       "failed to receive ack\n");
> > +                               timed_out = 1;
> > +                       }
> > +
> > +                       break;
> > +               }
> 
> This still looks a bit out of place here.
> 
> Kicking should be a fast unilateral action, that doesn't depend on the
> other side.

Ok, I'll drop this complexity.

While that code sorta looks like too much, in a smoothly working system it's just a register read and single "false" if-test, since SYSCFG_CHIPSIG2 will actually never be set there.  If SYSCFG_CHIPSIG2 *is* set then it will likely not unset and the timed_out situation will happen.

> 
> > +static int da8xx_rproc_probe(struct platform_device *pdev)
> > +{
> ...
> > +       ret = rproc_add(rproc);
> > +       if (ret) {
> > +               dev_err(dev, "rproc_add failed: %d\n", ret);
> > +               goto free_rproc;
> > +       }
> > +
> > +       drproc->chipsig = chipsig;
> > +       drproc->bootreg = bootreg;
> > +       drproc->ack_fxn = irq_data->chip->irq_ack;
> > +       drproc->irq_data = irq_data;
> > +       drproc->irq = irq;
> > +
> > +       /* everything the ISR needs is now setup, so hook it up */
> > +       ret = devm_request_threaded_irq(dev, irq,
> da8xx_rproc_callback,
> > +               handle_event, 0, "da8xx-remoteproc", rproc);
> > +       if (ret) {
> > +               dev_err(dev, "devm_request_threaded_irq error: %d\n",
> ret);
> > +               rproc_del(rproc);
> > +               goto free_rproc;
> > +       }
> 
> Shouldn't we be requesting this before we rproc_add() ?

Yeah, that seems to be the more prudent ordering, will switch.
 
> 
> > +static int da8xx_rproc_remove(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct rproc *rproc = platform_get_drvdata(pdev);
> > +       struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc-
> >priv;
> > +       int ret;
> ...
> > +       ret = rproc_del(rproc);
> 
> You can safely remove 'ret' altogether. We will just crash in
> rproc_put if rproc is NULL.

Will do.

> 
> > +       rproc_put(rproc);
> > +
> > +       return ret;
> > +}
> 
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> > index dd3bfaf..e0f703e 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1222,19 +1222,39 @@ struct rproc *rproc_alloc(struct device *dev,
> const char *name,
> >                                 const char *firmware, int len)
> >  {
> >         struct rproc *rproc;
> > +       char *template = "rproc-%s-fw";
> > +       char *p;
> >
> >         if (!dev || !name || !ops)
> >                 return NULL;
> >
> > +       if (!firmware)
> > +               /*
> > +                * Make room for default firmware name (minus %s plus
> '\0').
> > +                * If the caller didn't pass in a firmware name then
> > +                * construct a default name.  We're already glomming
> 'len'
> > +                * bytes onto the end of the struct rproc allocation,
> so do
> > +                * a few more for the default firmware name (but only
> if
> > +                * the caller doesn't pass one).
> > +                */
> > +               len += strlen(name) + strlen(template) - 2 + 1;
> > +
> >         rproc = kzalloc(sizeof(struct rproc) + len, GFP_KERNEL);
> >         if (!rproc) {
> >                 dev_err(dev, "%s: kzalloc failed\n", __func__);
> >                 return NULL;
> >         }
> >
> > +       if (!firmware) {
> > +               p = (char *)rproc + sizeof(struct rproc) + len;
> > +               sprintf(p, template, name);
> 
> Looks like p you're writing to is outside of the rproc memory
> allocation.

Yikes, must have been getting lucky when testing with the default name!

Thanks for the notice, will fix.

Regards,

- Rob

> 
> Thanks,
> Ohad.
