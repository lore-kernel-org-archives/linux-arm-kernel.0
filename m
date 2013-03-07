From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Mar 2013 11:58:17 +0100
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <201303070337.43288.arnd@arndb.de>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <201303070337.43288.arnd@arndb.de>
Message-ID: <20130307115817.3b3cad20@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 7 Mar 2013 03:37:43 +0000, Arnd Bergmann wrote:
> On Wednesday 06 March 2013, Jason Gunthorpe wrote:
> > On Wed, Mar 06, 2013 at 08:27:10PM +0100, Thomas Petazzoni wrote:
> 
> > Part of the point of all this DT stuff is to give HW designers some
> > reasonable flexability in their HW design without requiring code
> > changes to Linux to boot it. So if Marvell makes a new Armada varient
> > that re-uses all the same pre existing IP, just with different mbus
> > targets, they should be able to make Linux run on it simply by writing
> > a SOC specific firmware and DT.
> 
> Agreed. Further, the device tree should accurately describe the mapping
> of addresses, and we have a lot of infrastructure to do exactly that.

Why should the Device Tree describe something that isn't a description
of the hardware? The mapping of addresses used for address decoding
windows is inherently dynamic.

Do I have to, again, repeat the PCIe discussion? We *cannot* describe
the PCIe address decoding windows in the Device Tree. It is NOT
possible.

We have too many PCIe interfaces (up to 10), too few windows (only 20),
and not enough physical address space, to cover, statically, all
possible combinations of PCIe devices.

In addition, the PCIe bus is very nice because it is dynamic: you
discover devices, how much memory and I/O space they require, and you
set up the windows accordingly.

Please always think about this PCIe use case when proposing any sort of
solution about address decoding windows. Any solution that doesn't take
into account the dynamic nature of PCIe windows is simply useless.

> 
> > > Also, I don't believe that windows should be described in the Device
> > > Tree. My long term plan is rather to make the allocation of the base
> > > address of each window entirely dynamic, because there is absolutely no
> > > reason for those addresses to be fixed in stone in the Device Tree.
> > 
> > How will that work? Device tree necessarily must have CPU addresses
> > for the things it describes. Today we have the problem that those
> > addresses must match the values hard coded into Linux, ie DT is
> > describing what Linux expects, not what the HW provides..
> 
> Exactly.

No, the Device Tree does not need to have CPU addresses.

The hardware description of a NOR is :

 * It is connected to chip-select X
 * Its size is 16 MB
 * Its model/description/characteristics are <foo>

So the NOR would be:

	reg = <0 0x1000000>;
	cs = <3>;

We encode this information in the Device Tree, because they describe
the hardware. Then, in the driver, we do:

	struct resource nor_resource;

	/* Get the size of the NOR from DT */
	of_address_to_resource(np, 0, &nor_resource);

	/* Find an available physical range to map the NOR */
	allocate_resource(&iomem_res, &nor_resource,
			  resource_size(&nor_resource),
			  0, 0, 0, NULL, NULL);

	/* Create the address decoding window */
	mvebu_mbus_add_window(nor, nor_resource.start,
			      resource_size(&nor_resource));

And that's it. The physical address at which the NOR is mapped is *NOT*
a description of the hardware.

We are not hardcoding virtual addresses in the DT, right?

So for the same reason, we should not hardcode the address decoding
windows and their base address into the DT.

Please explain why you think hardcoding in the Device Tree things that
is not a hardware description is a good idea.

> > This idea that Linux should setup windows on its own has moved away
> > from what OF was intended for, I'm not sure there is an overarching
> > plan on how to handle those cases - but hardcoding addresses in Linux
> > and then requiring the DT to match them exactly certainly seems wrong.
> > 
> > As for dynamic allocation, they way to do it via DT is through the
> > ranges property, similar to how I noted. The DT can be modified
> > in-memory, so a dyanmic mbus driver would ignore the CPU target
> > address in the ranges, select its own CPU address and then update the
> > in-memory DT with the corrected value. Everything else would then work
> > properly.
> 
> Yes. We can even use the index of the "ranges" property to refer directly
> to the number of the window, so ranges replaces the kernel internal
> struct mvebu_mbus_mapping.

Doesn't work with PCIe windows that have to be dynamically created.

It really strikes me that in the name of the Device Tree, we would have
to hardcode in stone things that are inherently dynamic.

> Getting the binding right is certainly a priority here, but I also think
> that we don't need to rush the code to use that binding (although having
> the code work would make me more comfortable thinking that the binding
> actually works).

The current binding is just a compatible string, not more. So it can
easily be extended in the future to have more properties below it
giving more configuration details. Of course, I continue to
fundamentally disagree with the proposal you and Jason are making, but
if you want to implement something that does that, it will always be
possible to extend the DT binding in the future.

Also remember that the mvebu-mbus driver has to be compatible with
non-DT platforms. We haven't migrated yet all the SoC families to the
DT, and it will take a bit more time to convert all of them to the
Device Tree.

Would it be possible to agree that this driver is a first step that
consolidates the existing address decoding code, which doesn't prevent
further improvements, and get the driver code merged in this current
state (of course, after fixing all the bugs, issues, that will be
discovered during review and testing) ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
