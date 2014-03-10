From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 10 Mar 2014 14:45:19 +0000
Subject: [PATCH v5 1/7] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <201403070124.13139.arnd@arndb.de>
References: <1393948204-11555-1-git-send-email-Liviu.Dudau@arm.com>
 <201403042330.09607.arnd@arndb.de>
 <20140306160442.GG6457@e106497-lin.cambridge.arm.com>
 <201403070124.13139.arnd@arndb.de>
Message-ID: <20140310144519.GU6457@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 12:24:12AM +0000, Arnd Bergmann wrote:
> On Thursday 06 March 2014, Liviu Dudau wrote:
> > On Tue, Mar 04, 2014 at 10:30:09PM +0000, Arnd Bergmann wrote:
> > > On Tuesday 04 March 2014, Liviu Dudau wrote:
> > > > +int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> > > > +{
> > > > +       return 0;
> > > > +}
> > > > +
> > > 
> > > How about returning an error here? You don't actually register the range.
> > 
> > That's not the intention here. I basically want a nop, as by default (read x86)
> > we do nothing with the IO range.
> 
> I think x86 is a bad default though, because that is the exception rather than
> the rule. I also think that on x86, you shouldn't have an entry for the I/O
> space in the "ranges" property since there is no translation, and then we don't
> call this function.
> 
> PCI devices described in DT on x86 would still be able to list their I/O BARs
> in DT, but you don't ever translate them into MMIO ranges.
> 
> 	Arnd
> 

So, if I understand you correctly, you would prefer to fail here and hence stop the
parsing for the x86, rather than pretending everything is OK and going through the
motions?

That was not my original thinking when I've introduced this function here. The main
purpose of the function is to help the correct translation of IO addresses in
pci_address_to_pio(). As Jason has explained very nicely, we have 3 types of
architectures here that we try to support:
  - the ones that have separate IO address space (x86)
  - the ones that have 1:1 mapping between physical IO addresses and logical ports
  - the architectures that memory map the IO addresses in virtual address space
    and then translate the logical addresses into virtual based on a given offset.

For the first two types we don't want to do anything special. Architectures that
fall in the last category will have to provide their own version of this function,
with the arm64 version being generic enough to be used as de facto?

But I can see your point of view as well. I just don't know if that is good enough
for powerpc and microblaze. With the way things are in my patch, they should be able
to switch to of_create_pci_host_bridge() easily*, with your suggestion they will
have to provide their implementation for pci_register_io_range().

We really need to get another architecture converted. If there are no other takers I
will make a stab once the current push towards upstreaming AArch64 hardware support
slows down.

* says the newby with confidence in his voice ;)

Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
