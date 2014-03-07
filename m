From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Mar 2014 01:24:12 +0100
Subject: [PATCH v5 1/7] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <20140306160442.GG6457@e106497-lin.cambridge.arm.com>
References: <1393948204-11555-1-git-send-email-Liviu.Dudau@arm.com>
 <201403042330.09607.arnd@arndb.de>
 <20140306160442.GG6457@e106497-lin.cambridge.arm.com>
Message-ID: <201403070124.13139.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 March 2014, Liviu Dudau wrote:
> On Tue, Mar 04, 2014 at 10:30:09PM +0000, Arnd Bergmann wrote:
> > On Tuesday 04 March 2014, Liviu Dudau wrote:
> > > +int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> > > +{
> > > +       return 0;
> > > +}
> > > +
> > 
> > How about returning an error here? You don't actually register the range.
> 
> That's not the intention here. I basically want a nop, as by default (read x86)
> we do nothing with the IO range.

I think x86 is a bad default though, because that is the exception rather than
the rule. I also think that on x86, you shouldn't have an entry for the I/O
space in the "ranges" property since there is no translation, and then we don't
call this function.

PCI devices described in DT on x86 would still be able to list their I/O BARs
in DT, but you don't ever translate them into MMIO ranges.

	Arnd
