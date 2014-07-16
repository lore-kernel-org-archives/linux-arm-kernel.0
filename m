From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Jul 2014 12:14:02 +0200
Subject: [PATCH v3 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140716091533.GB28151@kwain>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
 <42036198.zWkqnus6xa@wuerfel> <20140716091533.GB28151@kwain>
Message-ID: <5615007.cNNjmu3rBK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 July 2014 11:15:33 Antoine T?nart wrote:
> 
> On Wed, Jul 16, 2014 at 10:41:10AM +0200, Arnd Bergmann wrote:
> > On Wednesday 16 July 2014 10:26:01 Antoine T?nart wrote:
> > > +
> > > +       if (priv->dma_mask) {
> > > +               ret = dma_coerce_mask_and_coherent(&pdev->dev, priv->dma_mask);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > > 
> > 
> > As mentioned in my comment for the binding, this is the wrong way to do it.
> > Russell has in the past converted all drivers that did this manually to 
> > do dma_coerce_mask_and_coherent() so we can spot them more easily, but we
> > should really be doing this better for new drivers.
> > 
> > Can you describe what the restriction is that you want to put on the dma mask?
> 
> Some people wanted the possibility to set the DMA mask as this USB2 CI
> driver does not do specific Berlin operation and can be reused later.
> I don't particularly need to call dma_coerce_mask_and_coherent() in my
> case, as far as I know.

Ok, just remove the call then and rely on the default mask.
 
> They can maybe give the restrictions they might want to put on the DMA
> mask.

If the restriction is from the bus, it should get handled automatically
by the device probe as long as the correct dma-ranges property is there
(though we have a small bug there at the moment). If there is a variation
of ci13xxx that can't do 32-bit DMA, that should use a different compatible
string and pass a fixed mask into dma_set_mask_and_coherent() based on
the device.

	Arnd
