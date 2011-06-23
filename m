From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Jun 2011 12:21:21 +0200
Subject: [PATCH] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <BANLkTi=HYtyZXpZ_Tq+9LEyZ4teYvsRj3Q@mail.gmail.com>
References: <1308556402-10955-1-git-send-email-bs14@csr.com>
	<201106221434.27286.arnd@arndb.de>
	<BANLkTi=HYtyZXpZ_Tq+9LEyZ4teYvsRj3Q@mail.gmail.com>
Message-ID: <201106231221.21432.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 June 2011 09:42:01 Barry Song wrote:
> 2011/6/22 Arnd Bergmann <arnd@arndb.de>:
> > On Wednesday 22 June 2011, Barry Song wrote:
> > If your device tree describes a board with a prima2 SoC on it, and all prima2
> > chips are identical, then ("sirf,uart", "sirf,prima2-uart") is fine. If
> > prima2 is itself a family of chips, you should add a third entry like
> > "sirf,prima2-1234-uart" where 1234 is the model number of that chip.
> 
> i guess we can use ("sirf,uart", "sirf,prima2-uart",
> "sirf,prima2-1500-uart")  for the moment.

Ok.

> >
> > I don't completely understand. If you have actual PCI devices with a
> > proper configuration space in the system, I would strongly suggest that
> > you export the PCI host bridge instead of the individual devices and
> > let the PCI probing code take care of that.
> >
> > Using hardware probing mechanisms is normally preferred, because it
> > means you don't have to list every device in the device tree.
> 
> Due to history reasons, SD controller is using ip core with pci
> interface. and its configuration is hard-coded in IC directly. and
> PrimaII doesn't support external pci devices too. PCI configuration
> and signals of SD are invisible to users and software at all. to
> software, we can't see anything related with pci from SD. when we are
> accessing sd controller, it looks like we are just accessing normal
> memory bus.
> 
> The DMA limitation of 256MB is also due to the design of internal PCI
> bridge. the bridge only can cover below 256MB.

Ok. As a feedback to the hardware designers, maybe you can tell them
that we would very much appreciate being able to probe devices by
looking at hardware registers instead of having to hardcode device
locations for every single board. PCI config space is a well-established
way to do that, so if you already use PCI components it would be
nice to make them visible and compliant.

Obviously, it would also be really nice to not have to worry about
arbitrary restrictions in DMA addresses.

> > I believe we already have a problem with DEBUG_LL as soon as we get
> > to multi-platform kernels.
> >
> >> Another issue is that .init_early(fot this case, it is
> >> sirfsoc_init_clk)  is called earlier than kernel mm init and later
> >> than .map_io(for this case, it is sirfsoc_map_io),  the early static
> >> mapping makes .init_early can access mapped virtual memory too.
> >
> > But does sirfsoc_init_clk have to be called from init_early, or can
> > you do it a bit later?
> 
> The sequence is
> 
> temp mapping of DEBUG uart in head.S -> kernel paging_init() -> static
> mapping of .map_io(build new mapping for uart) ->
> .init_early(prepare clock which .timer will access for this case)  ->
> kernel mm init -> .timer -> arch_initcall
> 
> between mm init and .timer, there are irq/prio_tree init, both seem
> not the right place to prepare clock. if i can move clock init behind
> mm init, ioremap should be ok. Then make codes ugly.

Ok, I see.

I wonder if this is getting better with the common clk handling.

> > Probably yes, it would also make the I/O slower because then you have
> > to alway do bounce-buffering, while now you only have to do it when
> > the user buffer is above 256 MB.
> >
> > You should definitely make sure that the SD device has the correct
> > dma_mask set, which is required for correctness, while the right
> > ARM_DMA_ZONE_SIZE is more a question of performance. When we get to
> > multi-platform kernels, we can then just set the minimum of the
> > configured platforms.
> 
> yes. we should have right dma masking to 256MB. Anyway, DMA bouncing
> is required since data buffers are from filesystem, and they might be
> above 256MB.

Bouncing will only be performed for pages that are actually over
the limit, see __blk_queue_bounce(). If a system doesn't have over
256 MB, there will be no bouncing at all.

> I guess we can define the zone size to 1MB for SiRFPrimaII, then
> result in less chance to cross normal and dma zone?

I don't see how that would help. Just leave it at 256 MB to give the
allocator the most room.

	Arnd
