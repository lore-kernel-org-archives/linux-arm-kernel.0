From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 7 Jul 2014 12:11:33 +0100
Subject: [PATCH v8 4/9] pci: OF: Fix the conversion of IO ranges into IO
 resources.
In-Reply-To: <6122131.ozzYjjjRQi@wuerfel>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <1404240214-9804-5-git-send-email-Liviu.Dudau@arm.com>
 <CAL_JsqJNfB_jynFQK0Ov6A3wqk6LF3abUFEUjhmzipak26sU5w@mail.gmail.com>
 <6122131.ozzYjjjRQi@wuerfel>
Message-ID: <20140707111133.GP6501@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 05, 2014 at 09:46:09PM +0100, Arnd Bergmann wrote:
> On Saturday 05 July 2014 14:25:52 Rob Herring wrote:
> > On Tue, Jul 1, 2014 at 1:43 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > > The ranges property for a host bridge controller in DT describes
> > > the mapping between the PCI bus address and the CPU physical address.
> > > The resources framework however expects that the IO resources start
> > > at a pseudo "port" address 0 (zero) and have a maximum size of IO_SPACE_LIMIT.
> > > The conversion from pci ranges to resources failed to take that into account.
> > 
> > I don't think this change is right. There are 2 resources: the PCI bus
> > addresses and cpu addresses. This function deals with the cpu
> > addresses. Returning pci addresses for i/o and cpu addresses for
> > memory is going to be error prone. We probably need both cpu and pci
> > resources exposed to host controllers.
> > 
> > Making the new function only deal with i/o bus resources and naming it
> > of_pci_range_to_io_resource would be better.
> 
> I think you are correct that this change by itself is will break existing
> drivers that rely on the current behavior of of_pci_range_to_resource,
> but there is also something wrong with the existing implementation:

Either I'm very confused or I've managed to confuse everyone else. The I/O
resources described using CPU addresses *are* using "pseudo" port based
addresses (or at least that is my understanding and my reading of the code).
Can you point me to a function that is expecting the IO resource to have
the start address at the physical address of the mapped space?

I was trying to fix exactly this issue, that you cannot use the resource
structure returned by this function in any call that is expecting an IO
resource.

Rob, you can try this function with two host bridges. Patch [3/9] changes
pci_address_to_pio() to calculate the offset of the range based on already
registed ranges, so the first host bridge will have it's IO resources
starting from zero, but the second host bridge will have .start offseted
by the size of the IO space of the first bridge. That is not a PCI bus
address AFAICT.

Best regards,
Liviu

> 
> of_pci_range_to_resource() at the moment returns a the address in
> cpu address space (i.e. IORESOURCE_MEM) but sets the res->flags
> value to IORESOURCE_IO, which means it doesn't fit into the resource
> tree. Liviu's version gets that part right, and it would be nice
> to fix that eventually, however we do it here.
> 
> 	Arnd
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
