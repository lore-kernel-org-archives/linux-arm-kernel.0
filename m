From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Jul 2014 14:12:46 +0200
Subject: [PATCH v3 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <cd73d8a384cc4040a0bbc6afc1f3063d@DM2PR0301MB0783.namprd03.prod.outlook.com>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
 <5615007.cNNjmu3rBK@wuerfel>
 <cd73d8a384cc4040a0bbc6afc1f3063d@DM2PR0301MB0783.namprd03.prod.outlook.com>
Message-ID: <22032517.gk8PRUMaIU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 July 2014 11:58:14 Peter Chen wrote:
> > >
> > > Some people wanted the possibility to set the DMA mask as this USB2 CI
> > > driver does not do specific Berlin operation and can be reused later.
> > > I don't particularly need to call dma_coerce_mask_and_coherent() in my
> > > case, as far as I know.
> > 
> > Ok, just remove the call then and rely on the default mask.
> > 
> > > They can maybe give the restrictions they might want to put on the DMA
> > > mask.
> > 
> > If the restriction is from the bus, it should get handled automatically
> > by the device probe as long as the correct dma-ranges property is there
> > (though we have a small bug there at the moment). If there is a variation
> > of ci13xxx that can't do 32-bit DMA, that should use a different
> > compatible string and pass a fixed mask into dma_set_mask_and_coherent()
> > based on the device.
> > 
> 
> Correct me if my below understanding is wrong please.
> 
> For three chipidea users:
> user_a: don't need dma mask
> user_b: dma mask value is dma_mask_b
> user_c: dma mask value is dma_mask_c
> 
> We don't need to call dma_coerce_mask_and_coherent() at generic chipidea
> glue driver, and set dma-ranges as dma_mask_b at user_b's dts, and set
> dma-ranges as dma_mask_c at user_c's dts.

The dma-ranges property doesn't just encode a dma-mask for a device, but
rather how the children of a bus see the memory address space of the parent.

For traditional reasons we default to assuming that a 32-bit dma_mask
is correct, but there may be multiple reasons why this is not true:

- you have a device connected to a bus that is smaller than 32-bit wide
  (and that would have a dma-ranges property describing that)
- you have a device that has fewer than 32 address lines but is connected
  to a 32-bit upstream bus (hence the dma-ranges describe all 32 bit,
  but the driver must set a smaller mask)
- you have a 64-bit capable device connected to a 32-bit bus: the driver
  will ask for a 64-bit mask, but the dma_set_mask() call refuses this
  because of the bus capabilities.
- you have a 64-bit capable device on a 64-bit capable bus, and the
  dma_set_mask call should succeed.

The mask is definitely never "user" specific, but is a combination of
the device you have and the bus it is connected to.

Things get more complicated when you add in IOMMUs to this, but I'm
skipping this for the sake of limiting the confusion.

	Arnd
