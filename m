From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jun 2013 12:07:46 +0100
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20835253.Agl4DfuI3k@wuerfel>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130609014506.GB10027@obsidianresearch.com>
 <20130611135737.GC3996@localhost> <20835253.Agl4DfuI3k@wuerfel>
Message-ID: <20130612110746.5D6943E0A56@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013 17:26:47 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 11 June 2013 10:57:38 Ezequiel Garcia wrote:
> > Jason, Arnd:
> > 
> > On Sat, Jun 08, 2013 at 07:45:06PM -0600, Jason Gunthorpe wrote:
> > [...]
> > > 
> > > This is the mangling I was referring to. It needs to be the offset
> > > into the target, it can't be something else.
> > > 
> > 
> > I see both of you have explained this already, but I can't seem
> > to catch it yet.
> > 
> > Mind explaining me exaclty *why* "it can't be something else"?
> > IOW, why the window base address cannot be in the 2nd cell,
> > and/or what use cases would this encoding brake?
> 
> Most importantly that would meant that the 'ranges' property
> does not actually reflect the setting in the hardware mbus window,
> which in fact remaps a base address of the upstream bus to address
> zero of the downstream bus, and that address has to be offsettable.
> 
> Taking your example from below:
> 
> ranges = <0x011d0000 0 0xfff00000 0x0100000>; /* BootROM */
> 
> You map the start '0' of the boot rom to 0xfff0000. Your proposal
> would mean setting up the intermediate address space to use the
> same offset that is used on the host side, like 
> 
> ranges = <0x011d0000 0xfff00000 0xfff00000 0x0100000>;
> 
> This essentially you would have to set up the mbus window so the
> bus address subtracts the second cell from the third cell to
> get the child bus address, right?
> 
> One clear example where it would break down is when you have a
> PCI bus window and e.g. map the PCI bus address 0xd0000000 to
> host physical address 0xd0000000. Doing the same calculation
> would mean you need a ranges property like
> 
> ranges = <0x0abc0000 0xa0000000 0xd0000000 0x01000000>;
> 
> so that when setting up the mbus you can subtract 0xd0000000
> from 0xa0000000 and get back (wrapping around through 0) to
> the address 0xd0000000 that you actually want. That would be
> really stupid and illogical.
> 
> Finally, it makes setting up the ranges at boot time extremely
> hard, unless you always want to map each device to the same
> physical address (which is not always possible), because you
> would have to not only change the ranges property of the mbus
> node when you change the window, but also every single 'reg'
> or 'ranges' property in the children referring to it.
> 
> > > I understand your motivation, but this is not a good method of
> > > encoding this in DT.
> > > 
> > > There is nothing especially wrong with updating the ranges at runtime,
> > > but don't use the 2nd cell in the 2dw address to encode the desired
> > > base address.
> > > 
> > 
> > Regarding this, let me confirm your proposed layout using an example.
> > (later on, i'll try the preprocessor on this to make it look better).
> > 
> > mbus {
> > 	compatible = "foo-mbus";
> > 	ranges = < 0xffff0001 0 0xf1000000 0x1000000 /* Internal register entry */
> > 		   0x011d0000 0 0xfff00000 0x0100000 /* BootROM entry with base address */
> > 		   0x012f0000 0 0xe8000000 0x1000000 /* DevBus,NOR entry with base address */
> > 	>;
> > 
> > 	bootrom {
> > 		ranges = <0 0x011d0000 0 0x100000>;
> > 	};
> > 
> > 	devbus-bootcs {
> > 		ranges = <0 0x012f0000 0 0x1000000>;
> > 		nor {
> > 			reg = <0 0x1000000>;
> > 		};
> > 	};
> > };
> > 
> > Is the above correct?
> 
> That looks ok to me, yes. If you have just one device under some of the nodes
> however, I think it's easier use an empty ranges property and do
> 
>  	devbus-bootcs {
>  		ranges;
>  		nor {
>  			reg = <0x012f0000 0 0x1000000>;
>  		};
> 
> The 'ranges' here is most useful if you have multiple devices
> add different offsets. I would also predefine those ranges to
> be as large as possible so you don't have to adapt them when
> the child device grows beyond it.
> 
> > Now, if the above is OK, then the DT looks complete to me. Meaning:
> > 
> > 1. There's no need to update any ranges property at runtime.
> 
> You still have to update the ranges every time you add, remove
> or update a mapping window.
> 
> > 2. There's no need to use an algorithm to 'find' a base address for decoding
> >    windows (such as first-fit as Arnd suggested in another mail).
> >    The base address is already there in the ranges property, so the mbus can
> >    simply allocate the window on that base address.
> > 
> > So, am I right or completely lost?
> 
> Since you already need code to update the ranges property, I think
> it's best to discard the ranges at boot time and create a new mapping
> that just maps the devices you actually want to use. That would make
> it much easier to cope with boot loaders that don't set up the
> mappings in the same way that is listed in the device tree. Just
> put the one entry for the internal-regs in the ranges, since that
> is needed to map do the mbus setup.

It actually seems a bit silly to put the internal regs into the ranges
property at all. It's not like they need to be translated or provided to
any child nodes. Just give the root node a reg property with the correct
base for the internal regs.

As for regenerating the ranges; I have no problem with the kernel
allocating ranges at runtime, but that code should not be creating a new
ranges property and adding it to the tree. The knowledge should be kept
internal to the driver and it should use an of_bus translator
(drivers/of/address.c) to tap into the ranges parsings code.

g.
