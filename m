From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 Jul 2014 23:22:00 +0200
Subject: [PATCH v8 4/9] pci: OF: Fix the conversion of IO ranges into IO
 resources.
In-Reply-To: <20140707111133.GP6501@e106497-lin.cambridge.arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <6122131.ozzYjjjRQi@wuerfel>
 <20140707111133.GP6501@e106497-lin.cambridge.arm.com>
Message-ID: <201407072322.00990.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 July 2014, Liviu Dudau wrote:
> On Sat, Jul 05, 2014 at 09:46:09PM +0100, Arnd Bergmann wrote:
> > On Saturday 05 July 2014 14:25:52 Rob Herring wrote:
> > > On Tue, Jul 1, 2014 at 1:43 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > > > The ranges property for a host bridge controller in DT describes
> > > > the mapping between the PCI bus address and the CPU physical address.
> > > > The resources framework however expects that the IO resources start
> > > > at a pseudo "port" address 0 (zero) and have a maximum size of IO_SPACE_LIMIT.
> > > > The conversion from pci ranges to resources failed to take that into account.
> > > 
> > > I don't think this change is right. There are 2 resources: the PCI bus
> > > addresses and cpu addresses. This function deals with the cpu
> > > addresses. Returning pci addresses for i/o and cpu addresses for
> > > memory is going to be error prone. We probably need both cpu and pci
> > > resources exposed to host controllers.
> > > 
> > > Making the new function only deal with i/o bus resources and naming it
> > > of_pci_range_to_io_resource would be better.
> > 
> > I think you are correct that this change by itself is will break existing
> > drivers that rely on the current behavior of of_pci_range_to_resource,
> > but there is also something wrong with the existing implementation:
> 
> Either I'm very confused or I've managed to confuse everyone else. The I/O
> resources described using CPU addresses *are* using "pseudo" port based
> addresses (or at least that is my understanding and my reading of the code).
> Can you point me to a function that is expecting the IO resource to have
> the start address at the physical address of the mapped space?

pci_v3_preinit() in arch/arm/mach-integrator/pci_v3.c for instance takes
the resource returned by of_pci_range_to_resource and programs the
start and size into hardware registers that expect a physical address
as far as I can tell.

> I was trying to fix exactly this issue, that you cannot use the resource
> structure returned by this function in any call that is expecting an IO
> resource.

I looked at the other drivers briefly, and I think you indeed fix the Tegra
driver with this but break the integrator driver as mentioned above.
The other callers of of_pci_range_to_resource() are apparently not
impacted as they recalculate the values they get.

	Arnd
