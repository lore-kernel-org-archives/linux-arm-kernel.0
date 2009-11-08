From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Nov 2009 15:41:03 +0000
Subject: [PATCH,RFC] PCI: deal with device incorrectly reporting I/O
	decoding being enabled
In-Reply-To: <20091108152310.GA16033@parisc-linux.org>
References: <20091107135615.GE18639@mail.wantstofly.org>
	<20091107150305.GQ10555@parisc-linux.org>
	<20091108090451.GA20529@n2100.arm.linux.org.uk>
	<20091108152310.GA16033@parisc-linux.org>
Message-ID: <20091108154103.GA27579@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 08, 2009 at 08:23:10AM -0700, Matthew Wilcox wrote:
> On Sun, Nov 08, 2009 at 09:04:51AM +0000, Russell King - ARM Linux wrote:
> > On Sat, Nov 07, 2009 at 08:03:05AM -0700, Matthew Wilcox wrote:
> > > I'm OK with this ... it might provoke bugs in some _other_ piece of hardware,
> > > but that seems pretty unlikely.
> > 
> > Please remember that some ARM hardware only has the capability to read
> > and write full 32-bit quantities of configuration space, which means
> > writing the control register can result in the status register being
> > written as well.
> > 
> > That shouldn't be a problem, but is merely something else to consider
> > which isn't obvious.
> 
> Wow, that's horrid.  You must have to special case each config register
> that's accessed in a 16-bit way, since some bits are 'preserve' and others
> are 'write 1 to clear'.  What a nightmare.

Yes, it's horrid, and it can be found on all IOP ARM stuff, eg:

                val = iop3xx_read(addr);
                if (iop3xx_pci_status())
                        return PCIBIOS_SUCCESSFUL;

                where = (where & 3) * 8;

                if (size == 1)
                        val &= ~(0xff << where);
                else
                        val &= ~(0xffff << where);

                *IOP3XX_OCCDR = val | value << where;

This covers IOP32x, IOP33x, and there's similar code for IOP13xx.

This does mean that if we make this change, we may do more accidental
writes to the status register on such hardware.  Whether that matters
in reality isn't something I can answer - I suspect we can get away
with this without causing problems.

CC'ing Dan for his info: the proposed change@the start of this thread
is to make the write to the command register in pcibios_enable_device()
unconditional.  This will guarantee that IOP platforms to copy-back the
status register on to itself on pci_enable_device(), thereby causing
"write 1 to clear" status bits to be cleared.
