From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Sep 2013 08:54:25 +0100
Subject: [PATCH 28/51] DMA-API: sound: fix dma mask handling in a lot
 of drivers
In-Reply-To: <s5h1u4cf2bo.wl%tiwai@suse.de>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm9m-0007ij-ER@rmk-PC.arm.linux.org.uk> <s5h1u4cf2bo.wl%tiwai@suse.de>
Message-ID: <20130926075425.GX25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 09:51:23AM +0200, Takashi Iwai wrote:
> Hi,
> 
> sorry for the lat response, as I've been traveling in the last weeks.
> 
> At Thu, 19 Sep 2013 22:53:02 +0100,
> Russell King wrote:
> > 
> > This code sequence is unsafe in modules:
> > 
> > static u64 mask = DMA_BIT_MASK(something);
> > ...
> > 	if (!dev->dma_mask)
> > 		dev->dma_mask = &mask;
> > 
> > as if a module is reloaded, the mask will be pointing at the original
> > module's mask address, and this can lead to oopses.  Moreover, they
> > all follow this with:
> > 
> > 	if (!dev->coherent_dma_mask)
> > 		dev->coherent_dma_mask = mask;
> > 
> > where 'mask' is the same value as the statically defined mask, and this
> > bypasses the architecture's check on whether the DMA mask is possible.
> > 
> > Fix these issues by using the new dma_coerce_coherent_and_mask()
> > function.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Applied with Mark's ack now.

Which is a very stupid thing to do because you won't have
dma_coerce_coherent_and_mask() in your tree, so all these drivers
will fail to build for you.
