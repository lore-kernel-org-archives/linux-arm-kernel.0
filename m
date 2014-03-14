From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 14 Mar 2014 18:05:27 +0000
Subject: [PATCH v7 3/3] arm64: Add architecture support for PCI
In-Reply-To: <201403141838.08900.arnd@arndb.de>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811258-1500-4-git-send-email-Liviu.Dudau@arm.com>
 <20140314171457.GK18126@arm.com> <201403141838.08900.arnd@arndb.de>
Message-ID: <20140314180527.GZ6457@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 05:38:08PM +0000, Arnd Bergmann wrote:
> On Friday 14 March 2014, Catalin Marinas wrote:
> > On Fri, Mar 14, 2014 at 03:34:18PM +0000, Liviu Dudau wrote:
> > > --- /dev/null
> > > +++ b/arch/arm64/kernel/pci.c
> > [...]
> > > +int pci_register_io_range(phys_addr_t address, resource_size_t size)
> > [...]
> > > +unsigned long pci_address_to_pio(phys_addr_t address)
> > [...]
> > > +void pcibios_fixup_bus(struct pci_bus *bus)
> > [ actually most of this file ]
> > 
> > Maybe it was raised before already but can we have __weak generic
> > definitions of these functions? They don't seem to be arm64 specific in
> > any way.
> > 
> 
> I would definitely prefer that.
> 
> 	Arnd
> 

I haven't seen any reaction from Bjorn on this, so I threaded carefully on that
subject. I'm new to this so I don't know how to handle this.

To my mind, and looking at the way every architecture has been setup, the pcibios_*
function are intended to be provided by the architecture. No matter how much wishful
thinking we are going to put in here, it will not change the fact that the non-arm64
specific version of pcibios_fixup_bus() that I wrote is not shared by anyone else
and it will remain "for arm64 use only" regardless to where it is placed until the
next architecture comes into the kernel. And even then its adoption is questionable.
If we are looking for simple and common implementations of this function, maybe we
should look at why microblaze and powerpc versions, that are identical, are not being
made the default __weak implementation.

As for the other two functions, I've no special attachment to where they are present
and I'm happy to move them into drivers/pci on the condition that the patchset doesn't
double in size. The reason why I'm weary of touching other architectures in a significant
way is the current lack of engineering bandwidth and way of testing all the architectures.
My low friction approach has been to introduce them in arm64 and then slowly move them
into core (and yes, I know about good intentions and the road to hell.)

Catalin, if you are happy to ask for ACKs from all arch maintainers that might get
affected by our custom version of pci_address_to_pio() before you can pull PCI support
for arm64 then I can propose a new patchset.

Best regards,
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
