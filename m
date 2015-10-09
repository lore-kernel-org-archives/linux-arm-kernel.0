From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 9 Oct 2015 15:47:37 +0200 (CEST)
Subject: [PATCH v5 1/3] initialize each mbigen device node as a interrupt
 controller.
In-Reply-To: <5610D3BD.1040408@huawei.com>
References: <1443605949-15396-1-git-send-email-majun258@huawei.com>
 <1443605949-15396-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1509302242220.4500@nanos> <5610D3BD.1040408@huawei.com>
Message-ID: <alpine.DEB.2.11.1510091441200.6097@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 4 Oct 2015, majun (F) wrote:
> >> +	info->reg_offset = get_mbigen_vec_reg_addr(info->nid, info->local_pin_offset);
> > 
> > So you fill in a structure with 5 fields and the only information
> > which is ever used is local_pin_offset.
> > 
> > What's the point of this exercise? 
> 
> Besides local_pin_offset , nid, and reg_offset are also useful
> information which will be used in next patch.

This is horrible to review, really.

Split your patches into smaller pieces then. Add the core
functionality and then introduce the other things when you actually
use them.

> > And that msi_irq information comes from where? Nothing in that code
> > initializes it.
> 
> msi_irq is is initialized in next patch.

See above.
 
> > All you ever need from this is local_pin_offset and the base address
> > for that calculation in the eoi callback.
> 
> dev_irq is stored for easily using in next patch when interrupt happened.

Ditto.
 
> >> +
> >> +	/* add this mbigen device into a global list*/
> >> +	spin_lock(&mbigen_device_lock);
> >> +	list_add(&mgn_dev->global_entry, &mbigen_device_list);
> >> +	spin_unlock(&mbigen_device_lock);
> > 
> > And that global list is used whatfor? I can't see anything which makes
> > use of it.
> 
> This global list is used to find out mbigen device when initializing the mbigen
> device as a platform device in next patch.

Sorry, this is unreviewable.
 
> Because there are several mbigen chips in this system, and each mbigen chip also
> contains several mbgien devices.
> 
> I need a list contains all of the mbigen devices which connect to these mbigen
> chips.
> Then, during mbigen chip initializing, we can use this list to find out mbigen devices
> and pass mbigen_device data structure.
> 
> > 
> > That's a complete disaster and I'm not even thinking about looking at
> > the next patch in this series.
> > 
> > Can you please explain in a simple ASCII picture how your irq chip
> > hierarchy looks like and what kind of data you need for each hierarchy
> > level?
> 
> Mbigen chip hardware structure shows as below:
> 
> 		mbigen chip
> |---------------------|-------------------|
> mgn_node0	  mgn_node1		mgn_node2
>  |		 |-------|		|-------|------|
> dev1		dev1    dev2		dev1   dev3   dev4
> 
> 
> 
> Irq chip hierarchy stucture:
> 		
> 	ITS
> 	 |
> 	ITS-pMSI
> 	 | (virq1)
> |--------| -----------------|
> mbigen-device1		mbigen-device2
>  | (virq2)		 | (virq2)
> devices(uart)		device(gmac)

That picture is wrong as it suggests that uart and gmac share the same
virq.
 
> I named virq1 as msi_irq , virq2 as dev-irq and ,virq1 != virq2.
> 
> Each virq2 has a corresponding virq1.

Whatfor?
 
> Mbigen-device is a special hardware.

Everything is special hardware.

> On the one hand, it's a platform device for ITS. We need to
> allocate the msi-irqs for it.(handled in patch 2/3)
> 
> On the other hand, it's a interrupt controller for the devices
> connected to it.(handled in current patch).
>
> To bind these two different irqs, I made a data sutruce named
> mbigen_irq_data which contains some information of this irq,
> including private index, pin_offset, nid, and local_pin_offset.
>
> All these information can help us to find the corresponding reg addr
> and msi_irq quickly.

This is completely wrong. Why would you need two linux virq numbers
for one interrupt?

This needs to be expressed in one hierarchy. mbigen is just a
translator between wired interrupts and MSI, nothing else.

So the hierarchy is:

  mbigen -> ITS-MSI -> ITS -> GIC

No need for extra levels of indirection. Your mbigen irqchip callbacks
are simply doing:

    parent->callback(parent_data);

and you get that for free when using the hierarchy. No need for that
chained interrupt handler either.

Thanks,

	tglx
