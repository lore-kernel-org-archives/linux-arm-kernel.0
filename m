From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Wed, 1 Feb 2017 12:29:39 +0000
Subject: [PATCH V6 1/5] LIB: Indirect ISA/LPC port IO introduced
In-Reply-To: <1a1f1e70-b6e7-f3c6-2b86-348b3d28edfe@suse.de>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-2-git-send-email-yuanzhichang@hisilicon.com>
 <5dc0dc9c-124e-398f-a3b2-40059268e859@suse.de>
 <6d5523be-1841-18b9-9b83-6f7e591ed66b@huawei.com>
 <1a1f1e70-b6e7-f3c6-2b86-348b3d28edfe@suse.de>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F9FC04A@lhreml507-mbx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex

> -----Original Message-----
> From: Alexander Graf [mailto:agraf at suse.de]

[...]

> >>
> >> I like the extio idea. That allows us to handle all PIO requests on
> >> platforms that don't have native PIO support via different routes
> >> depending on the region they're in. Unfortunately we now we have 2
> >> frameworks for handling sparse PIO regions: One in extio, one in
> PCI.
> >>
> >> Why don't we just merge the two? Most of the code that has #ifdef
> >> PCI_IOBASE throughout the code base sounds like an ideal candidate
> to
> >> get migrated to extio instead. Then we only have a single framework
> to
> >> worry about ...
> >
> > To be clear, are you suggesting we merge the functionality from
> > pci_register_io_range(), pci_pio_to_address(), pci_address_to_pio()
> into
> > extio, so extio manages all PIO?
> 
> Yes, I guess so.
> 
> > And having a single type of node to
> > register PIO ranges, by amalgamating struct extio_node and io_range
> (as
> > Bjorn mentioned)?
> 
> I'm not quite sure I follow you here. Basically I think you want a
> generic "non-x86 PIO" framework that PCI just plugs into.
> 
> I don't think that necessarily means you want to statically allocate
> regions of that PIO space to separate (pseudo-)devices. Instead,
> everyone shares that space and should be able to fail gracefully if
> some
> space is already occupied.
> 
> > It would make sense. We would be somewhat decoupling PIO from PCI.
> 
> Yes :).
> 
> > I think that other architectures, like PPC, and other code would need
> to
> > be fixed up to handle this.
> 
> I think only PPC, Microblaze and ARM are using this. Grep for
> PCI_IOBASE. It's not that many.
> 
> > We need to consider all the other challenges/obstacles to this.
> 
> Well, getting our abstraction levels right to me sounds like it's worth
> the obstacles.
> 

I have had a quick look and I think it should not be too difficult to
unify the two frameworks.

I'll follow up soon on this thread with a code sketch

Thanks
Gab

[...]
