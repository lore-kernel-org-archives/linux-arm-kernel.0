From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 30 Sep 2014 20:39:34 +0800
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <3366285.QN2R3CQNzG@wuerfel>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
 <20140930001206.GA11657@peterchendt> <3366285.QN2R3CQNzG@wuerfel>
Message-ID: <20140930123933.GA25395@peterchendt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 12:03:42PM +0200, Arnd Bergmann wrote:
> On Tuesday 30 September 2014 08:12:07 Peter Chen wrote:
> > > +
> > > +     if (dev->of_node) {
> > > +             ret = ci_hdrc_usb2_dt_probe(dev, ci_pdata);
> > > +             if (ret)
> > > +                     goto clk_err;
> > > +     } else {
> > > +             ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > > +             if (ret)
> > > +                     goto clk_err;
> > > +     }
> > 
> > My suggestion:
> > 
> > - call dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)) for both 
> > dt and non-dt
> 
> No, as I explained before, hardcoding the dma mask is always wrong, don't
> do that. Call dma_set_mask_and_coherent and check the return value.
> It's not wrong to do that for both DT and ATAGS.
> 

Thanks, Arnd. I had not thought setting dma mask is so complicated, yes, it
should check the return value, two things to confirm:

- dma_coerce_mask_and_coherent or dma_set_mask_and_coherent, the only difference
of these two API is the first one do "dev->dma_mask = &dev->coherent_dma_mask;"
The reason you suggest choosing dma_set_mask_and_coherent is you do not want
assign dev->dma_mask?
- The second parameter for dma_set_mask_and_coherent is DMA_BIT_MASK(32), is it
ok?

I just a little confused of what's the operation is "hardcoding the dma mask"?

-- 
Best Regards,
Peter Chen
