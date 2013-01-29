From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 10:35:30 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <CAKohpomO6tYNYLdMOaJYgqGecXj5KMQprdb=gExi+QuGrtLTzw@mail.gmail.com>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-2-git-send-email-arnd@arndb.de>
 <CAKohpomO6tYNYLdMOaJYgqGecXj5KMQprdb=gExi+QuGrtLTzw@mail.gmail.com>
Message-ID: <201301291035.30265.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Viresh Kumar wrote:
> > diff --git a/Documentation/devicetree/bindings/dma/snps-dma.txt b/Documentation/devicetree/bindings/dma/snps-dma.txt
> > index 5bb3dfb..212d387 100644
> > --- a/Documentation/devicetree/bindings/dma/snps-dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
> > @@ -3,59 +3,62 @@
> >  Required properties:
> >  - compatible: "snps,dma-spear1340"
> >  - reg: Address range of the DMAC registers
> > -- interrupt-parent: Should be the phandle for the interrupt controller
> > -  that services interrupts for this device
> >  - interrupt: Should contain the DMAC interrupt number
> > -- nr_channels: Number of channels supported by hardware
> > -- is_private: The device channels should be marked as private and not for by the
> > -  general purpose DMA channel allocator. False if not passed.
> > +- dma-channels: Number of channels supported by hardware
> > +- dma-requests: Number of DMA request lines supported
> > +- dma-masters: Number of AHB masters supported by the controller
> > +- #dma-cells: must be <3>
> 
> Shouldn't this be 4? Would be better to mention what fields are these,
> right here. I have seen them below though.

Correct. I changed these a couple of times while trying to understand
what the fields are, and I missed this instance. I'm still not sure
whether we actually need all four fields, or what the simplest format
for them would be. This just mirrors what you had in your binding.

> > -bool dw_dma_generic_filter(struct dma_chan *chan, void *param)
> > +/* forward declaration used in filter */
> > +static struct platform_driver dw_driver;
> 
> extern? This is not a declaration but definition.

No. You can have multiple declarations for a static symbol like this,
but only one of them with an initilizer. I usually recommend against
doing this myself, because it's confusing and somewhat bad style, but
it is correct C.

> > -       /*
> > -        * dmaengine framework calls this routine for all channels of all dma
> > -        * controller, until true is returned. If 'param' bus_id is not
> > -        * registered with a dma controller (dw), then there is no need of
> > -        * running below function for all channels of dw.
> > -        *
> > -        * This block of code does this by saving the parameters of last
> > -        * failure. If dw and param are same, i.e. trying on same dw with
> > -        * different channel, return false.
> > -        */
> > -       if ((last_dw == dw) && (last_bus_id == param))
> > +       /* both the driver and the device must match */
> > +        if (chan->device->dev->driver != &dw_driver.driver)
> > +                return false;
> 
> Can this ever happen? Isn't it the case that this routine would be called
> only for dw_dmac?

I think not. AFAIK the filter function will be called for each channel
on each DMA engine until one of them matches.

> > -       while (++i < dw->sd_count) {
> > -               if (!strcmp(dw->sd[i].bus_id, param)) {
> > -                       chan->private = &dw->sd[i];
> > -                       last_dw = NULL;
> > -                       last_bus_id = NULL;
> > +       /* FIXME: memory leak! could we put this into dw_dma_chan? */
> > +       sd = devm_kzalloc(dw->dma.dev, sizeof (*sd), GFP_KERNEL);
> 
> Yes.

Yes it can be in dw_dma_chan or yes it is a memory leak?

> > +static struct dma_chan *dw_dma_xlate(struct of_phandle_args *dma_spec,
> > +                                        struct of_dma *ofdma)
> > +{
> > +       struct dw_dma *dw = ofdma->of_dma_data;
> > +       struct dw_dma_filter_args fargs = {
> > +               .dw = dw,
> > +       };
> > +       dma_cap_mask_t cap;
> > +
> > +       if (dma_spec->args_count != 4)
> 
> args_count contains count of all params leaving the phandle?

That was my interpretation from reading the code, but I have not tried it.

> > +       /* FIXME: This binding is rather clumsy. Can't we use the
> > +          request line numbers here instead? */
> 
> yes.

Ok, Very good. What is the encoding of the registers then?

> > +       fargs.cfg_lo = be32_to_cpup(dma_spec->args+0);
> > +       fargs.cfg_hi = be32_to_cpup(dma_spec->args+1);
> > +       fargs.src = be32_to_cpup(dma_spec->args+2);
> > +       fargs.dst = be32_to_cpup(dma_spec->args+3);
> > +
> > +       dma_cap_zero(cap);
> > +       dma_cap_set(DMA_SLAVE, cap);
> > +       /* FIXME: there should be a simpler way to do this */
> > +       return dma_request_channel(cap, dw_dma_generic_filter, &dma_spec->args[0]);
> 
> don't you need to send &fargs as the last argument?

Right, my mistake.

Thanks a lot for the input. When I fix the above, are actually able
to test the changes, or have you lost access to the hardware when
leaving ST?

	Arnd
