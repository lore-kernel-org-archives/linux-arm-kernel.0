From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 7 Mar 2013 10:37:36 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130307115817.3b3cad20@skate>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <201303070337.43288.arnd@arndb.de> <20130307115817.3b3cad20@skate>
Message-ID: <20130307173736.GA20840@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 11:58:17AM +0100, Thomas Petazzoni wrote:

> Please always think about this PCIe use case when proposing any sort of
> solution about address decoding windows. Any solution that doesn't take
> into account the dynamic nature of PCIe windows is simply useless.

PCIe is not a problem, it continues to use the dynamic interface!

This is all about how do you connect the DT stanzas that are already
in the DT to the dynamic window mbus system - and you do that via
ranges. The ranges only need to cover the needs of the static elements
of the DT - they do not need to extend beyond to fully dynamic
elements like PCI-E - those cases are *totally* different and must be
handled in code.

The reason for this is quite simply to avoid this ugly boiler plate in
every mbus driver:

> 	struct resource nor_resource;
> 
> 	/* Get the size of the NOR from DT */
> 	of_address_to_resource(np, 0, &nor_resource);
> 
> 	/* Find an available physical range to map the NOR */
> 	allocate_resource(&iomem_res, &nor_resource,
> 			  resource_size(&nor_resource),
> 			  0, 0, 0, NULL, NULL);
> 
> 	/* Create the address decoding window */
> 	mvebu_mbus_add_window(nor, nor_resource.start,
> 			      resource_size(&nor_resource));
> 

Not only does this violate encapsulate principles, it breaks the DT
modeling because there is no place in the DT that has the base
address!!

The PCI system allocates and assigns BAR prior to probing the driver -
that is the Linux convention. The mbus driver needs to do the same
thing. The window must be setup prior to calling a child's probe, and
the DT must be correct at that time.

> It really strikes me that in the name of the Device Tree, we would have
> to hardcode in stone things that are inherently dynamic.

What do you mean? The suggestion is to describe all in-DT elements
with a ranges like this:

>    ranges =<MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0xFE000000  0x10000

Which directly models the HW MBUS system. The target-id is set in
stone by the SOC, the window size is based on what is described in the
DT - so there is no need for it to be smaller/larger, and the base
address can be run-time altered to the true window base by the mbus
driver.

There is nothing inherently dynamic that is set in stone. The base
address *is not set in stone* - it is just refactored out of the
individual stanzas and placed into a single common place that is easy
to find pragmatically.

This is not about PCI-E - PCI-E continues to use the full dynamic
interface, nothing major changes there.

> Would it be possible to agree that this driver is a first step that
> consolidates the existing address decoding code, which doesn't prevent
> further improvements, and get the driver code merged in this current
> state (of course, after fixing all the bugs, issues, that will be
> discovered during review and testing) ?

I continue to agree with this.

However, I think Ezequiel's driver should be held up pending a
decision if mvebu_mbus_add_window is appropriate for it to call.

Regards,
Jason
