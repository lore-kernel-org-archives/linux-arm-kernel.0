From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 06 Apr 2014 19:49:53 +1000
Subject: [PATCH v7 1/6] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <20140405001953.GE15806@google.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811272-1547-2-git-send-email-Liviu.Dudau@arm.com>
 <20140405001953.GE15806@google.com>
Message-ID: <1396777793.3671.15.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-04-04 at 18:19 -0600, Bjorn Helgaas wrote:
> > Introduce a pci_register_io_range() helper function that can be used
> > by the architecture code to keep track of the I/O ranges described by the
> > PCI bindings. If the PCI_IOBASE macro is not defined that signals
> > lack of support for PCI and we return an error.
> 
> I don't quite see how you intend to use this, because this series doesn't
> include any non-stub implementation of pci_register_io_range().
> 
> Is this anything like the ia64 strategy I mentioned above?  If so, it would
> be really nice to unify some of this stuff.

We also use two different strategies on ppc32 and ppc64

 - On ppc32, inb/outb turn into an MMIO access to _IO_BASE + port

That _IO_BASE is a variable which is initialized to the ioremapped address
of the IO space MMIO aperture of the first bridge we discover. Then port
numbers are "fixed up" on all other bridges so that the addition _IO_BASE + port
fits the ioremapped address of the IO space on that bridge. A bit messy... and breaks
whenever drivers copy port numbers into variables of the wrong type such as shorts.

 - On ppc64, we have more virtual space, so instead we reserve a range
of address space (fixed) for IO space, it's always the same. Bridges IO spaces
are then mapped into that range, so we always have a positive offset from _IO_BASE
which makes things a bit more robust and less "surprising" than ppc32. Additionally,
the first 64k are reserved. They are only mapped if we see an ISA bridge (which some
older machines have). Otherwise it's left unmapped, so crappy drivers trying to
hard code x86 IO ports will blow up immediately which I deem better than silently
whacking the wrong hardware. In addition, we have a mechanism we use on powernv to
re-route accesses to that first 64k to the power8 built-in LPC bus which can
have some legacy IOs on it such as a UART or a RTC.

Cheers,
Ben.
