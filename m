From: matthew@wil.cx (Matthew Wilcox)
Date: Sun, 8 Nov 2009 09:15:42 -0700
Subject: [PATCH,RFC] PCI: deal with device incorrectly reporting I/O
	decoding being enabled
In-Reply-To: <20091108154103.GA27579@n2100.arm.linux.org.uk>
References: <20091107135615.GE18639@mail.wantstofly.org>
	<20091107150305.GQ10555@parisc-linux.org>
	<20091108090451.GA20529@n2100.arm.linux.org.uk>
	<20091108152310.GA16033@parisc-linux.org>
	<20091108154103.GA27579@n2100.arm.linux.org.uk>
Message-ID: <20091108161542.GB16033@parisc-linux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 08, 2009 at 03:41:03PM +0000, Russell King - ARM Linux wrote:
> On Sun, Nov 08, 2009 at 08:23:10AM -0700, Matthew Wilcox wrote:
> > On Sun, Nov 08, 2009 at 09:04:51AM +0000, Russell King - ARM Linux wrote:
> > > Please remember that some ARM hardware only has the capability to read
> > > and write full 32-bit quantities of configuration space, which means
> > > writing the control register can result in the status register being
> > > written as well.
> > > 
> > > That shouldn't be a problem, but is merely something else to consider
> > > which isn't obvious.
> > 
> > Wow, that's horrid.  You must have to special case each config register
> > that's accessed in a 16-bit way, since some bits are 'preserve' and others
> > are 'write 1 to clear'.  What a nightmare.
> 
> Yes, it's horrid, and it can be found on all IOP ARM stuff, eg:
> 
>                 val = iop3xx_read(addr);
>                 if (iop3xx_pci_status())
>                         return PCIBIOS_SUCCESSFUL;
> 
>                 where = (where & 3) * 8;
> 
>                 if (size == 1)
>                         val &= ~(0xff << where);
>                 else
>                         val &= ~(0xffff << where);
> 
>                 *IOP3XX_OCCDR = val | value << where;
> 
> This covers IOP32x, IOP33x, and there's similar code for IOP13xx.
> 
> This does mean that if we make this change, we may do more accidental
> writes to the status register on such hardware.  Whether that matters
> in reality isn't something I can answer - I suspect we can get away
> with this without causing problems.

You can fix this for the status register like so:

                val = iop3xx_read(addr);
                if (iop3xx_pci_status())
                        return PCIBIOS_SUCCESSFUL;

+		/* Don't clear the RW1C bits in the Status register */
+		if (where == PCI_COMMAND)
+			val &= 0xffff;

                where = (where & 3) * 8;

                if (size == 1)
                        val &= ~(0xff << where);
                else
                        val &= ~(0xffff << where);

                *IOP3XX_OCCDR = val | value << where;

Unfortunately, this status register is not the only one with RW1C, RW1CS
or RsvdZ bits.  There's the Secondary Status Register (for bridges), a
dozen PCIe Status Registers, the Dynamic Power Allocation Status Register,
the Power Management Control/Status Register ... SHPC defines a RW1C
bit in a register, not sure if we'll hit that case.  I bet there's others.

I can only hope that in general, one does not find many PCI devices
attached to an IOP3xx.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
