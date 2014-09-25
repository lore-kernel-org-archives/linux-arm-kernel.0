From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 09:11:35 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140925011647.GB3716@peterchendt>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
 <20140925011647.GB3716@peterchendt>
Message-ID: <3696520.MDUrkdjfGZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014 09:16:48 Peter Chen wrote:
> > +     }
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
> Hi Antoine, the above code may not be needed, since get phy and set dma
> mask are common operation, we can do it at core code, the only thing you
> need to do is something like: dev->dma_mask = DMA_BIT_MASK(32).
> 

Certainly not, doing that would be broken for a number of reasons:

- dev->dma_mask is a pointer, a driver should not reassign that
- the device may have been set up for a bus that requires a smaller mask
  that is already set, changing the mask would cause data corruption
- setting just the dma mask but not coherent mask is wrong
- setting the dma mask can fail, e.g. if the mask is smaller than the
  smallest memory zone, so you have to check the return value.

	Arnd
