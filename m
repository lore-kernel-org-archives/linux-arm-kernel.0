From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Feb 2013 23:44:14 +0000
Subject: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations
 for Armada XP
In-Reply-To: <20130207170000.GA10834@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302070824.51125.arnd@arndb.de>
 <20130207170000.GA10834@obsidianresearch.com>
Message-ID: <201302072344.14558.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013, Jason Gunthorpe wrote:
> On Thu, Feb 07, 2013 at 08:24:50AM +0000, Arnd Bergmann wrote:
> > >  - The CPU physical address window to use for the IO space
> > >    is set via io-cpu-window, not much choice here, the PCI
> > >    format ranges must be 0 based.
> > 
> > I don't think I understand this part. Why can't you put this into
> > ranges as before?
> > 
> > -       0x81000000 0x00000000 0x00000000  0x00000000  0x0 0xa0000
> > +	0x81000000 0x00000000 0x00000000  0xc0000000  0x0 0xa0000
> 
> The OF PCI core translates 0x81000000 IO space addresess into a 'struct
> resource' tagged with IORESOURCE_IO.
> 
> But 0xc0000000 is not an IORESOURCE_IO address, it is an
> IORESOURCE_MEM address..
> 
> So, I think with the current OF code this has to be 0, otherwise your
> IORESOURCE_IO's end up starting at 0xc000000 - but maybe there is some
> trickyness to work with in here? (Although none of this matters when
> Linux does resource assignment, the OF translation code is never
> enganged)

Yes, I think this is for historic reasons: the PCI binding far
predates the Linux implementation, and I'm sure on MacOS, AIX
and Solaris the PCI drivers did not actually have the same kind
of wrappers for PIO functions that we have on Linux because of
the x86 legacy.

> But I agree, 0xc0000000 seems much better...
> 
> To think about it from a different angle, what would you put in the
> 4th dword on x86? How do you describe the IO numberspace in DT on x86?

I think the best option is to have no translation at all on x86,
leaving 0x81000000 out of the ranges property. I'm not sure if
the authors of the binding actually considered that case though.

	Arnd
