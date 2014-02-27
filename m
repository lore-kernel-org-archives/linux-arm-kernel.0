From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Feb 2014 20:48:08 +0100
Subject: [PATCH v2 1/4] pci: OF: Fix the conversion of IO ranges into IO
 resources.
In-Reply-To: <20140227193627.GA7773@obsidianresearch.com>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com>
 <20140227191259.GA31753@bart.dudau.co.uk>
 <20140227193627.GA7773@obsidianresearch.com>
Message-ID: <5379319.g8IPYmY2Zo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 12:36:27 Jason Gunthorpe wrote:
> On Thu, Feb 27, 2014 at 07:12:59PM +0000, Liviu Dudau wrote:
> > The outstanding issue is how to fix pci_address_to_pio() as it will not
> > for for range->cpu_addr > IO_SPACE_LIMIT (16MB in my case).
> 
> The default actually looks fine to me, it is the correct behavior for
> systems that actually have a dedicated IO space (like x86) where the
> 'CPU' value for IO is the exact value used in the IO accessor
> instructions. In this case the IO_SPACE_LIMIT test is appropriate.

Right.

> It also looks correct for architectures that use the CPU MMIO address
> as the IO address directly (where IO_SPACE_LIMIT would be 4G)

Are you aware of any that still do? I thought we had stopped doing
that.

> Architectures that use the virtual IO window technique will always
> require a custom pci_address_to_pio implementation.

Hmm, at the moment we only call it from of_address_to_resource(),
which in turn does not get called on PCI devices, and does not
call pci_address_to_pio for 'simple' platform devices. The only
case I can think of where it actually matters is when we have
ISA devices in DT that use an I/O port address in the reg property,
and that case hopefully won't happen on ARM32 or ARM64.

> BTW, something that occured to me after reading the patches:
> 
> For ARM64 you might want to think about doing away with the fixed
> virtual IO window like we see in ARM32. Just use the CPU MMIO address
> directly within the kernel, and implement a ioport_map to setup the MM
> on demand.
> 
> I think the legacy reasons for having all those layers of translation
> are probably not applicable to ARM64, and it is much simpler without
> the extra translation step....
> 
> Arnd, what do you think?

Either I don't like it or I misunderstand you ;-)

Most PCI drivers normally don't call ioport_map or pci_iomap, so
we can't just do it there. If you are thinking of calling ioport_map
for every PCI device that has an I/O BAR and storing the virtual
address in the pci_dev resource, I don't see what that gains us
in terms of complexity, and it will also break /dev/port.

	Arnd
