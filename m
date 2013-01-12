From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Jan 2013 09:31:50 +0000
Subject: [PATCH v5 6/9] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <CAK=WgbZVayi-USPCwB3KSbzRQ_oxatznt4d26A8_GpWmay2daA@mail.gmail.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-7-git-send-email-rtivy@ti.com>
 <CAK=WgbZVayi-USPCwB3KSbzRQ_oxatznt4d26A8_GpWmay2daA@mail.gmail.com>
Message-ID: <20130112093149.GP23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 02:26:19PM +0200, Ohad Ben-Cohen wrote:
> > +static int davinci_rproc_start(struct rproc *rproc)
> > +{
> > +       struct platform_device *pdev = to_platform_device(rproc->dev.parent);
> > +       struct device *dev = rproc->dev.parent;
> > +       struct davinci_rproc *drproc = rproc->priv;
> > +       struct clk *dsp_clk;
> > +       struct resource *r;
> > +       unsigned long host1cfg_physaddr;
> > +       unsigned int host1cfg_offset;
> > +       int ret;
> > +
> > +       remoteprocdev = pdev;
> > +
> > +       /* hw requires the start (boot) address be on 1KB boundary */
> > +       if (rproc->bootaddr & 0x3ff) {
> > +               dev_err(dev, "invalid boot address: must be aligned to 1KB\n");
> > +
> > +               return -EINVAL;
> > +       }
> > +
> > +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (IS_ERR_OR_NULL(r)) {

No, this is buggy.  Go and look up to see what the return ranges are
for this function.

> > +               dev_err(dev, "platform_get_resource() error: %ld\n",
> > +                       PTR_ERR(r));
> > +
> > +               return PTR_ERR(r);

Which results in this being a bug.

> > +       }
> > +       host1cfg_physaddr = (unsigned long)r->start;
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       if (irq < 0) {
> > +               dev_err(dev, "platform_get_irq(pdev, 0) error: %d\n", irq);
> > +
> > +               return irq;
> > +       }
> > +
> > +       irq_data = irq_get_irq_data(irq);
> > +       if (IS_ERR_OR_NULL(irq_data)) {

Again, bug.

> > +               dev_err(dev, "irq_get_irq_data(%d) error: %ld\n",
> > +                       irq, PTR_ERR(irq_data));
> > +
> > +               return PTR_ERR(irq_data);

Which results in this being a bug.

> > +       }
> > +       ack_fxn = irq_data->chip->irq_ack;
> > +
> > +       ret = request_threaded_irq(irq, davinci_rproc_callback, handle_event,
> > +               0, "davinci-remoteproc", drproc);
> > +       if (ret) {
> > +               dev_err(dev, "request_threaded_irq error: %d\n", ret);
> > +
> > +               return ret;
> > +       }
> > +
> > +       syscfg0_base = ioremap(host1cfg_physaddr & PAGE_MASK, SZ_4K);
> > +       host1cfg_offset = offset_in_page(host1cfg_physaddr);
> > +       writel(rproc->bootaddr, syscfg0_base + host1cfg_offset);
> > +
> > +       dsp_clk = clk_get(dev, NULL);
> > +       if (IS_ERR_OR_NULL(dsp_clk)) {

And another bug.

> > +               dev_err(dev, "clk_get error: %ld\n", PTR_ERR(dsp_clk));
> > +               ret = PTR_ERR(dsp_clk);

And again, results in this being a bug.

> > +               goto fail;
> > +       }
...
> > +       ret = rproc_add(rproc);
> > +       if (ret)
> > +               goto free_rproc;
> > +
> > +       /*
> > +        * rproc_add() can end up enabling the DSP's clk with the DSP
> > +        * *not* in reset, but davinci_rproc_start() needs the DSP to be
> > +        * held in reset at the time it is called.
> > +        */
> > +       dsp_clk = clk_get(rproc->dev.parent, NULL);
> > +       davinci_clk_reset_assert(dsp_clk);
> > +       clk_put(dsp_clk);

BUG: what if clk_get() fails here?
