From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 12 Feb 2014 11:19:13 -0700
Subject: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
In-Reply-To: <20140212181015.GJ29132@mudshark.cambridge.arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <3460536.Sh23gjDa6X@wuerfel>
 <20140205190947.GA22297@mudshark.cambridge.arm.com>
 <3724624.kd9jZNUiTF@wuerfel>
 <20140207114607.GE5976@mudshark.cambridge.arm.com>
 <20140207175410.GC16263@obsidianresearch.com>
 <20140212181015.GJ29132@mudshark.cambridge.arm.com>
Message-ID: <20140212181913.GA16428@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 06:10:15PM +0000, Will Deacon wrote:

> > AFAIK, the job is fairly simple, when you call pci_add_resource_offset
> > for memory compute the offset from 
> >   of_pci_range.pci_addr - of_pci_range.cpu_addr
> > 
> > (or is it the other way around ?)
> 
> I think it's the other way round: bus = cpu - offset, then Arnd's example of
> PCI bus 0 works out as: 0 = cpu - pci->mem_start.

That looks right to me

> I added that to my driver, but I get some weird looking bus addresses in
> dmesg:
> 
> [    0.307585] pci-arm-generic 40000000.pci: PCI host bridge to bus 0000:00
> [    0.307601] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    0.307615] pci_bus 0000:00: root bus resource [mem 0x00000000-0x3effffff] (bus address [0xffffffffbf000000-0xfffffffffdffffff])
> 
> Looking at drivers/pci/probe.c, it seems to think that res->start - offset
> gives a bus address, which implies that the resources are indeed *CPU*
> addresses.
> 
> Are you sure pci_add_resource_offset wants bus addresses?

Sorry, I wasn't clear: It accepts a cpu address in the struct
resource and an offset to convert back to a bus address.

You should compute 0 as the offset in the normal case, ie
of_pci_range.pci_addr and of_pci_range.cpu_addr should be identical,
which depends on the DT ranges being correct..

Jason
