From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Mar 2013 20:11:33 +0100
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130307173736.GA20840@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <201303070337.43288.arnd@arndb.de> <20130307115817.3b3cad20@skate>
 <20130307173736.GA20840@obsidianresearch.com>
Message-ID: <20130307201133.42a6c44b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Thu, 7 Mar 2013 10:37:36 -0700, Jason Gunthorpe wrote:
> On Thu, Mar 07, 2013 at 11:58:17AM +0100, Thomas Petazzoni wrote:
> 
> > Please always think about this PCIe use case when proposing any sort of
> > solution about address decoding windows. Any solution that doesn't take
> > into account the dynamic nature of PCIe windows is simply useless.
> 
> PCIe is not a problem, it continues to use the dynamic interface!
> 
> This is all about how do you connect the DT stanzas that are already
> in the DT to the dynamic window mbus system - and you do that via
> ranges. The ranges only need to cover the needs of the static elements
> of the DT - they do not need to extend beyond to fully dynamic
> elements like PCI-E - those cases are *totally* different and must be
> handled in code.

I still don't see why devices like NOR and PCIe shouldn't be handled in
the same way.

> The reason for this is quite simply to avoid this ugly boiler plate in
> every mbus driver:

Come on "ugly" ? It's three line of basic set up code, and it avoids
hard-coding base addresses in the Device Tree. Not having hard-coded
base addresses is very nice for users porting Linux to new boards using
Marvell SoCs: they don't have to worry about deciding which base
address to use. A given board may have a huge NOR, some other board may
have gazillions of PCIe devices with large memory space requirements,
some other board might have a FPGA requiring a large physical memory
mapping.

With your idea, the guy writing the board .dts file will have to think
about what is the layout of the physical address space to find where
to map his FPGA or its big NOR.

With the really dynamic idea I'm proposing, the guy doesn't have to
worry at all about the base address.

I know you're proposing to make things dynamic by having the mbus
driver patch the Device Tree once the driver figures out an available
range to map a given device. But that doesn't make any sense: why write
in the DT something that will anyway be overwritten later on?

> > 	struct resource nor_resource;
> > 
> > 	/* Get the size of the NOR from DT */
> > 	of_address_to_resource(np, 0, &nor_resource);
> > 
> > 	/* Find an available physical range to map the NOR */
> > 	allocate_resource(&iomem_res, &nor_resource,
> > 			  resource_size(&nor_resource),
> > 			  0, 0, 0, NULL, NULL);
> > 
> > 	/* Create the address decoding window */
> > 	mvebu_mbus_add_window(nor, nor_resource.start,
> > 			      resource_size(&nor_resource));
> > 
> 
> Not only does this violate encapsulate principles, it breaks the DT
> modeling because there is no place in the DT that has the base
> address!!

But why the *heck* do we care about having the base address in the DT.
We don't care *at all*.

The base address is *NOT* a description of the hardware, because it is
completely configurable. Therefore, there is no need to have it in the
Device Tree.

In my opinion, the Device Tree should describe the informations that
the software cannot "guess" by looking at the hardware.

> The PCI system allocates and assigns BAR prior to probing the driver -
> that is the Linux convention. The mbus driver needs to do the same
> thing. The window must be setup prior to calling a child's probe, and
> the DT must be correct at that time.
> 
> > It really strikes me that in the name of the Device Tree, we would have
> > to hardcode in stone things that are inherently dynamic.
> 
> What do you mean? The suggestion is to describe all in-DT elements
> with a ranges like this:
> 
> >    ranges =<MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0xFE000000  0x10000
> 
> Which directly models the HW MBUS system. The target-id is set in
> stone by the SOC, the window size is based on what is described in the
> DT - so there is no need for it to be smaller/larger, and the base
> address can be run-time altered to the true window base by the mbus
> driver.
> 
> There is nothing inherently dynamic that is set in stone. The base
> address *is not set in stone* - it is just refactored out of the
> individual stanzas and placed into a single common place that is easy
> to find pragmatically.
> 
> This is not about PCI-E - PCI-E continues to use the full dynamic
> interface, nothing major changes there.

I still continue to believe that it's a matter of taste, and where you
put the boundary between what should be described in the Device Tree
and what should not.

> > Would it be possible to agree that this driver is a first step that
> > consolidates the existing address decoding code, which doesn't prevent
> > further improvements, and get the driver code merged in this current
> > state (of course, after fixing all the bugs, issues, that will be
> > discovered during review and testing) ?
> 
> I continue to agree with this.

Thanks.

> However, I think Ezequiel's driver should be held up pending a
> decision if mvebu_mbus_add_window is appropriate for it to call.

It is appropriate for it to call, because it's the only and correct way
to set up an address decoding window with the mvebu-mbus driver, just
like it is the only and correct way that will be used by the PCIe
driver.

Adding description of windows in the Device Tree can be added later on,
in a completely DT backward compatible way, and the mvebu-devbus driver
can be adjusted accordingly.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
