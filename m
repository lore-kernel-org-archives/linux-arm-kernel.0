From: rtivy@ti.com (Tivy, Robert)
Date: Mon, 8 Apr 2013 22:02:40 +0000
Subject: [PATCH v9 4/6] ARM: davinci: Add a remoteproc driver
 implementation for OMAP-L13x DSP
In-Reply-To: <CAK=WgbZme2UkMeP-JB2h3xnmcpzAaYeOcy7gxh60muJ8KZbr_A@mail.gmail.com>
References: <1364521307-1219-1-git-send-email-rtivy@ti.com>
 <1364521307-1219-5-git-send-email-rtivy@ti.com>
 <CAK=WgbZme2UkMeP-JB2h3xnmcpzAaYeOcy7gxh60muJ8KZbr_A@mail.gmail.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C14312302EA@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad at wizery.com]
> Sent: Sunday, April 07, 2013 6:03 AM
> To: Tivy, Robert
> Cc: davinci-linux-open-source; linux-arm; Nori, Sekhar; Rob Landley;
> linux-doc at vger.kernel.org; Grosen, Mark; Ring, Chris
> Subject: Re: [PATCH v9 4/6] ARM: davinci: Add a remoteproc driver
> implementation for OMAP-L13x DSP
> 
> Hi Rob,
> 
> On Fri, Mar 29, 2013 at 4:41 AM, Robert Tivy <rtivy@ti.com> wrote:> +
> > +static int da8xx_rproc_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct da8xx_rproc *drproc;
> > +       struct rproc *rproc;
> > +       struct irq_data *irq_data;
> > +       struct resource *bootreg_res;
> > +       struct resource *chipsig_res;
> > +       struct clk *dsp_clk;
> > +       void __iomem *chipsig;
> > +       void __iomem *bootreg;
> > +       int irq;
> > +       int ret;
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       if (irq < 0) {
> > +               dev_err(dev, "platform_get_irq(pdev, 0) error: %d\n",
> irq);
> > +               return irq;
> > +       }
> > +
> > +       irq_data = irq_get_irq_data(irq);
> > +       if (!irq_data) {
> > +               dev_err(dev, "irq_get_irq_data(%d): NULL\n", irq);
> > +               return -EINVAL;
> > +       }
> > +
> > +       bootreg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!bootreg_res) {
> > +               dev_err(dev,
> > +                       "platform_get_resource(IORESOURCE_MEM, 0):
> NULL\n");
> > +               return -EADDRNOTAVAIL;
> > +       }
> > +
> > +       chipsig_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +       if (!chipsig_res) {
> > +               dev_err(dev,
> > +                       "platform_get_resource(IORESOURCE_MEM, 1):
> NULL\n");
> > +               return -EADDRNOTAVAIL;
> > +       }
> > +
> > +       bootreg = devm_request_and_ioremap(dev, bootreg_res);
> > +       if (!bootreg) {
> > +               dev_err(dev, "unable to map boot register\n");
> > +               return -EADDRNOTAVAIL;
> > +       }
> > +
> > +       chipsig = devm_request_and_ioremap(dev, chipsig_res);
> > +       if (!chipsig) {
> > +               dev_err(dev, "unable to map CHIPSIG register\n");
> > +               return -EADDRNOTAVAIL;
> > +       }
> > +
> > +       dsp_clk = devm_clk_get(dev, NULL);
> > +       if (IS_ERR(dsp_clk)) {
> > +               dev_err(dev, "clk_get error: %ld\n",
> PTR_ERR(dsp_clk));
> > +
> > +               return PTR_RET(dsp_clk);
> > +       }
> > +
> > +       rproc = rproc_alloc(dev, "dsp", &da8xx_rproc_ops,
> da8xx_fw_name,
> > +               sizeof(*drproc));
> > +       if (!rproc)
> > +               return -ENOMEM;
> > +
> > +       drproc = rproc->priv;
> > +       drproc->rproc = rproc;
> > +
> > +       platform_set_drvdata(pdev, rproc);
> > +
> > +       /* everything the ISR needs is now setup, so hook it up */
> > +       ret = devm_request_threaded_irq(dev, irq,
> da8xx_rproc_callback,
> > +               handle_event, 0, "da8xx-remoteproc", rproc);
> > +       if (ret) {
> > +               dev_err(dev, "devm_request_threaded_irq error: %d\n",
> ret);
> > +               goto free_rproc;
> > +       }
> > +
> > +       /*
> > +        * rproc_add() can end up enabling the DSP's clk with the DSP
> > +        * *not* in reset, but da8xx_rproc_start() needs the DSP to
> be
> > +        * held in reset at the time it is called.
> > +        */
> > +       ret = reset_assert(dev);
> > +       if (ret)
> > +               goto free_rproc;
> > +
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
> > +       drproc->dsp_clk = dsp_clk;
> > +
> > +       return 0;
> > +
> > +free_rproc:
> > +       rproc_put(rproc);
> > +
> > +       return ret;
> > +}
> 
> Two small changes please:
> 
> - could you please fix the error path of probe? it seems that some
> resources are taken but not freed in case a failure shows up
> subsequently

I'm not sure what resources you mean?

The platform_get_irq()/irq_get_irq_data()/platform_get_resource() calls don't have "put" counterparts.  The "devm_*" calls get automatically cleaned up (and I wasn't able to find any existing example of some code that actually does the cleanup explicitly).

> - seems like it's safer to set drproc before calling rproc_add
> otherwise you have a small race there

Agreed, will change.

> 
> If you could respin this one quickly it'd be great, thanks!
> 
> Ohad.

Sergei had a comment to change devm_request_and_ioremap() to devm_ioremap_resource(), so I will submit a new patch with your and Sergei's comments applied.

Regards,

- Rob
