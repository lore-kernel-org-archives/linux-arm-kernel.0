From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 11 Jun 2013 16:58:41 -0600
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <4160363.LWJuHATm2F@wuerfel>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20835253.Agl4DfuI3k@wuerfel>
 <20130611215023.GA12649@obsidianresearch.com>
 <4160363.LWJuHATm2F@wuerfel>
Message-ID: <20130611225841.GA13892@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 12:34:14AM +0200, Arnd Bergmann wrote:

> a significant waste of physical address space, because the (per-soc)
> ranges property has to be set up for the largest possible external
> device connected to the bus, but the mbus window only needs to cover the
> device that is actually connected.

Yes, but perhaps that is a good argument to not put the ranges in the
dtsi?
 
> I think we have to walk the entire tree of devices underneath mbus,
> at least any device node that has a 'reg' property, following children
> of any device node with a 'ranges' property. We might need to
> add a variant of of_get_address() that does a partial translation
> up to a given node (the mbus) instead of all the way to the root.

Hum, how complex do you think this is? Run down the entire tree,
translate every regs and maintain a max offset for every target id.

> > then dynamic assignment of that window
> > makes sense to me. (however, this also looks a bit tricky, how do you
> > avoid hitting the PCI-E window reservations, for instance?)
> 
> The PCI-E window would have 'ranges' but no 'regs', so we automatically
> skip it.

The trouble is not skipping PCI-E when parsing the dt. When the
kernel goes to make a dynamic window allocation it needs to exclude
the address space reserved for the PCI-E aperture.

The mbus driver starts before the PCI-E driver, so how can this be
resolved? Hardwire specialness about PCI-E into mbus?
Make the PCI-E aperture fully dynamic?

Starting to be pretty complex - for what gain?

> > I'm not sure there is a good reason to reject the address map in the
> > DT?
> 
> You mean keep all windows that are listed by the boot loader but
> reassign the others? I guess it would be simpler but may result in
> a less optimal address map.

Sure, but what does a more optimal address map get you?

 1) More space to map SDRAM - however - the SDRAM map is controlled
    exclusively by the bootloader and the kernel doesn't have the
    information or the code to mess with it - so this isn't possible
 2) More space for the PCI-E aperture - this is entirely controlled by
    the kernel, but today we are using the pre-set allocation from the
    DT, so it doesn't matter how tightly the rest of the stuff is packed.

To me, it feels like alot of complex trouble to do actual dynamic
allocation, and I don't really see any gain.

Jason
