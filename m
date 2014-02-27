From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 27 Feb 2014 13:07:29 -0700
Subject: [PATCH v2 1/4] pci: OF: Fix the conversion of IO ranges into IO
 resources.
In-Reply-To: <5379319.g8IPYmY2Zo@wuerfel>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com>
 <20140227191259.GA31753@bart.dudau.co.uk>
 <20140227193627.GA7773@obsidianresearch.com>
 <5379319.g8IPYmY2Zo@wuerfel>
Message-ID: <20140227200729.GB7773@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 08:48:08PM +0100, Arnd Bergmann wrote:
> > It also looks correct for architectures that use the CPU MMIO address
> > as the IO address directly (where IO_SPACE_LIMIT would be 4G)
> 
> Are you aware of any that still do? I thought we had stopped doing
> that.

I thought ia64 used to, but it has been a long time since I've touched
one...

> > Architectures that use the virtual IO window technique will always
> > require a custom pci_address_to_pio implementation.
> 
> Hmm, at the moment we only call it from of_address_to_resource(),
> which in turn does not get called on PCI devices, and does not
> call pci_address_to_pio for 'simple' platform devices. The only
> case I can think of where it actually matters is when we have
> ISA devices in DT that use an I/O port address in the reg property,
> and that case hopefully won't happen on ARM32 or ARM64.

Sure, I ment, after Liviu's patch it will become required since he is
cleverly using it to figure out what the io mapping the bridge driver
setup before calling the helper.

> > I think the legacy reasons for having all those layers of translation
> > are probably not applicable to ARM64, and it is much simpler without
> > the extra translation step....
> > 
> > Arnd, what do you think?
> 
> Either I don't like it or I misunderstand you ;-)
> 
> Most PCI drivers normally don't call ioport_map or pci_iomap, so
> we can't just do it there. If you are thinking of calling ioport_map

Okay, that was one of the 'legacy reasons'. Certainly lots of drivers
do call pci_iomap, but if you think legacy drivers that don't are
important to ARM64 then it makes sense to use the virtual IO window.

> for every PCI device that has an I/O BAR and storing the virtual
> address in the pci_dev resource, I don't see what that gains us

Mainly we get to drop the fancy dynamic allocation stuff for the fixed
virtual window, and it gives the option to have a 1:1 relationship
between CPU addresses and PCI BARs.

> in terms of complexity, and it will also break /dev/port.

Yes, /dev/port needs updating, it would need to iomap (arguably it
probably should be doing that already anyhow), and the hardwired limit
of 65536 needs to be replaced with the arch's IO limit, but those do
not seem to be fundemental problems with the UAPI??

Jason
