From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 12:03:42 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140930001206.GA11657@peterchendt>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
 <20140930001206.GA11657@peterchendt>
Message-ID: <3366285.QN2R3CQNzG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 08:12:07 Peter Chen wrote:
> > +
> > +     if (dev->of_node) {
> > +             ret = ci_hdrc_usb2_dt_probe(dev, ci_pdata);
> > +             if (ret)
> > +                     goto clk_err;
> > +     } else {
> > +             ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > +             if (ret)
> > +                     goto clk_err;
> > +     }
> 
> My suggestion:
> 
> - call dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)) for both 
> dt and non-dt

No, as I explained before, hardcoding the dma mask is always wrong, don't
do that. Call dma_set_mask_and_coherent and check the return value.
It's not wrong to do that for both DT and ATAGS.

	Arnd
