From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 5 Jan 2014 15:06:03 +0100
Subject: [PATCHv9] dmaengine: Add support for BCM2835
In-Reply-To: <CABDT8WzhpH2yX=HD9wsx+bN17Qp0hLX45-VMF0a3RAiwWx7F4Q@mail.gmail.com>
References: <52C5A6A3.8000405@koalo.de> <1964639.FVztRK0HBK@wuerfel>
 <CABDT8WzhpH2yX=HD9wsx+bN17Qp0hLX45-VMF0a3RAiwWx7F4Q@mail.gmail.com>
Message-ID: <201401051506.03481.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 04 January 2014, Florian Meier wrote:
> On 02.01.2014 19:03, Arnd Bergmann wrote:
> > On Thursday 02 January 2014 18:49:23 Florian Meier wrote:
> >> Add support for DMA controller of BCM2835 as used in the Raspberry Pi.
> >> Currently it only supports cyclic DMA.
> >
> > Looks very nice. Just a few details I noticed:
> >
> >> +#if defined(CONFIG_OF)
> >> +static const struct of_device_id bcm2835_dma_of_match[] = {
> >> + { .compatible = "brcm,bcm2835-dma", },
> >> + {},
> >> +};
> >> +MODULE_DEVICE_TABLE(of, bcm2835_dma_of_match);
> >> +#endif
> >
> > I doubt we are going to see non-DT versions of this driver, so the #ifdef
> > can just get removed here.
> 
> As already explained in previous versions of this patch thread, there is
> a non-DT version in a downstream kernel and the more I make this patch
> incompatible with non-DT, the harder it gets to upstream the remaining
> stuff. I hope this is not something that blocks this driver from getting
> accepted.

In this case, that's certainly not an excuse unless you are worried about
400 bytes of .rodata in one driver and there are no side-effects of having
the device ID listed when it's not used. Even if it made a real difference
to another project, you'd need a much better excuse -- if you are worried
about compatibility between mainline and some downstream kernel, how about
changing that downstream kernel to use DT?

> > [...]
> > This can now be simplified using the dma_get_any_slave_channel() interface
> > taht Stephen Warren introduced.
> > [...]
> > dma_set_mask_and_coherent()
> 
> Sigh, the API is developing faster than I can keep track with updating
> this patch. I hope some day I will be faster....
> When Russell told me about the second one before, it hoped that I can
> avoid merging different trees on my own, but it seems that you want me
> to do that ;-)

The dma_get_any_slave_channel() change is probably my fault. I suggested
both the initial dma_get_slave_channel() API and this one because the
original approach turned out too complicated. If dma_set_mask_and_coherent().

I don't think you have to merge other trees, to get both APIs, they should
already be part of the dma-slave tree that your patch would get merged
into. If not, we can probably come up with a different solution. The
dma_set_mask_and_coherent() suggestion is not as important as the
dma_get_any_slave_channel() one, if you have to choose between them.

> >> + if (pdev->dev.of_node) {
> >> + /* Device-tree DMA controller registration */
> >> + rc = of_dma_controller_register(pdev->dev.of_node,
> >> + bcm2835_dma_xlate, od);
> >> + if (rc) {
> >> + dev_err(&pdev->dev, "Failed to register DMA controller\n");
> >> + goto err_no_dma;
> >> + }
> >> + }
> >
> > If pdev->dev.of_node isn't set, you didn't get here, so the if() can be removed.
> 
> Why not? (In the case of non-DT initialization)

The code I quoted is right after these lines:

+       /* Request DMA channel mask from device tree */
+       if (of_property_read_u32(pdev->dev.of_node,
+                       "brcm,dma-channel-mask",
+                       &chans_available)) {
+               dev_err(&pdev->dev, "Failed to get channel mask\n");
+               rc = -EINVAL;
+               goto err_no_dma;
+       }

If DT is disabled or not used, you return -EINVAL here.

	Arnd
