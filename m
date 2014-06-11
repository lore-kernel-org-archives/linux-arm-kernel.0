From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 11 Jun 2014 09:35:25 +0200
Subject: [RFC PATCH] dma: at_xdmac: creation of the atmel eXtended DMA
 Controller driver
In-Reply-To: <6544148.4RKn2Y8vCE@wuerfel>
References: <1401179736-8235-1-git-send-email-ludovic.desroches@atmel.com>
 <20140610154118.GA4254@lukather> <6544148.4RKn2Y8vCE@wuerfel>
Message-ID: <20140611073525.GQ1701@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 09:15:14PM +0200, Arnd Bergmann wrote:
> On Tue, May 27, 2014 at 10:35:36AM +0200, Ludovic Desroches wrote:
> > +static struct dma_chan *at_xdmac_xlate(struct of_phandle_args *dma_spec,
> > +                                    struct of_dma *of_dma)
> > +{
> > +     struct at_xdmac_chan    *atchan;
> > +     struct dma_chan         *chan;
> > +     dma_cap_mask_t          mask;
> > +     struct platform_device  *pdev = of_find_device_by_node(dma_spec->np);
> 
> No need to search through all the device nodes, you can look up the
> device from of_dma->of_dma_data.

Thanks for the tip.

> 
> > +     if (dma_spec->args_count != 2) {
> > +             dev_err(&pdev->dev, "dma phandler args: bad number of args\n");
> > +             return NULL;
> > +     }
> > +
> > +     dma_cap_zero(mask);
> > +     dma_cap_set(DMA_SLAVE, mask);
> > +     chan = dma_request_channel(mask, NULL, NULL);
> > +     if (!chan) {
> > +             dev_err(&pdev->dev, "can't get a dma channel\n");
> > +             return NULL;
> > +     }
> 
> You must use dma_get_any_slave_channel. dma_request_channel gives you a
> channel from a random dma engine that is present in the system, not
> necessarily the one you are managing here.

It is planned to use dma_get_any_slave_channel but currently I am doing
tests on a 3.10 kernel that's why I am still using dma_request_channel.

> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
