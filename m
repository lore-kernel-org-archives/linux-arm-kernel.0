From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Oct 2011 17:57:59 +0200
Subject: [PATCH 1/3 v3] ARM Realview PCIX map include file changes
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA47375AC17BD@GEORGE.Emea.Arm.com>
References: <20110822130507.23830.26191.stgit@e102602-lin.cambridge.arm.com>
	<20111006142350.GD26349@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA47375AC17BD@GEORGE.Emea.Arm.com>
Message-ID: <201110061757.59232.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 October 2011, Colin Tuckley wrote:
> Ah, that wasn't clear from the original email - I was making the changes incrementally and testing as I went.
> 
> > This is how it works:
> >
> > 1. The PCI IO window is supposed to be 64K in size.
> 
> Yes, that bit was obvious after a bit of thought. I suspect the original value was just a cut 'n paste error.
> 
> > 2. "pcibios_min_io" sets the minimum offset into the PCI IO window
> > which
> >    PCI IO BARs should be assigned.  It is assumed that a PCI IO BAR
> > value
> >    of 0 corresponds with the virtual base address of this window.
> > 3. inb() et.al. take the PCI IO offset and not the physical address
> > nor the virtual address of the desired access.
> 
> That seems sensible.
> 
> However, after changing both __io() and pcibios_min_io as Arnd suggested
> the boot still hangs after " Uncompressing Linux... done, booting the kernel."

No idea. If you send me the full patch, I'll have a look if I can spot
something odd. I can very much recommend debugging this in qemu,
which should support booting your kernels and provide you a
gdb interface to see what's going on.

I noticed that the original code (without your patch) describes a 4KB
I/O space window. Maybe there is a hardware limitation and you actually
have to set PCIBIOS_MIN_IO to zero and IO_SPACE_LIMIT to 0xFFF.
This would however be a fairly unusual hw quirk.
 
> I did notice that there seems to have been some code changes and
> refactoring in the pci sub-system between 3.1 and 2.6.38 where I 
> was testing before. Are there any significant changes I should be 
> aware of?

Nothing major, no. There are always patches going in there, but
the fundamental bits stay very stable.

	Arnd
