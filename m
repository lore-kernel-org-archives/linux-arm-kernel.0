From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 16:36:38 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <20130129154409.GA23505@n2100.arm.linux.org.uk>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291455.49347.arnd@arndb.de>
 <20130129154409.GA23505@n2100.arm.linux.org.uk>
Message-ID: <201301291636.38773.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Russell King - ARM Linux wrote:
> That's a good way to represent it but it fails in a very big way:
> You're stuffing N peripherals down to 3 request lines to the DMA
> engine, and you may want more than 3 of those peripherals to be
> making use of the DMA engine at any one time.
> 
> Before anyone says "you shouldn't be doing this" consider this:
> your typical DMA slave engine already has this structure:
> 
> N DMA channels <---> M DMA requests <---> M peripherals
> 
> where N < M.  In other words, there is already a MUX between the
> peripherals and the DMA engine channels themselves (what do you think
> the "request index" which you have to program into DMA channel control
> registers is doing...

Ok.

> We support this external mux today in the PL080 driver - and we do that
> by having the PL080 driver do the scheduling of virtual DMA channels on
> the actual hardware itself.  The PL080 driver has knowledge that there
> may be some sort of additional muxing layer between it and the
> peripheral.
> 
> As the APIs stand today, you just can't do this without having the
> DMA engine driver itself intimately involved because a layer above
> doesn't really have much clue as to what's going on, and the DMA
> engine stuff itself doesn't layer particularly well.

If the pl080 driver already has code for the mux in it, then it should
handle both of_dma_controller instances in my example. It would
not change anything regarding the binding, which just describes the
way that the hardware is connected. I have not looked at the implementation
of the pl080 driver, but I'd assume we could get away with just having
two separate xlate() functions. It's slightly ugly to have one driver
take responsibility for two device_node:s, but it's not unheard of.
In the probe function for the pl080 node, the driver can walk the
entire device tree to find any mux devices connected to it and
register an of_dma_controller() with its xlate function for those.

Unless you see another issue with this, I'd assume it's all covered
by the new interface, but it also doesn't get better than what we
have today.

	Arnd
