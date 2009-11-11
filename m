From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Wed, 11 Nov 2009 18:46:52 +0100
Subject: orion/kirkwood pcie issue still open with 2.6.32-rc6 (marvell
	stock 2.6.22.18 works!)
In-Reply-To: <20091111171916.GC22741@mail.wantstofly.org>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<200911111811.07413.dk-arm-linux@gmx.de>
	<20091111171916.GC22741@mail.wantstofly.org>
Message-ID: <200911111846.52815.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch 11 November 2009 18:19:16 schrieb Lennert Buytenhek:
> On Wed, Nov 11, 2009 at 06:11:07PM +0100, Dieter Kiermaier wrote:
> 
> > > > 00:01.0 Class 0604: Device 11ab:2211 (rev 01)
> > > >         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> > > 
> > > The bridge has been told not to forward MEM transactions to the secondary
> > > side, which explains what you're seeing.
> > 
> > Where can I see that the bridge doesn't want to forward mem transactions?
> > Please could you point me to the entry?
> 
> It's the "Mem" one (surprise! :)).  The minus in "Mem-" indicates that
> the bit is disabled in the Control register.
> 
> The PCIe bridge spec says this about this bit:
> 
> 	Controls the bridge?s response as a target to memory accesses
> 	on the primary interface that address a device that resides
> 	behind the bridge in both the non-prefetchable and prefetchable
> 	memory ranges (see Section 3.1) or targets a memory-mapped
> 	location within the bridge itself (see Section 5.1.2.1).
> 
> 
> > > It's odd that this is happening, as normally pci_enable_bridges()
> > > takes care of enabling I/O and MEM decoding on bridges.
> > > 
> > > What other kernel patches are you using?  And can you put a full boot
> > > log somewhere?
> >
> > I don't use other kernel patches (except changed openrd_base_pci_init()
> > as described in my last post).
> 
> Can you apply this patch and make another boot log?
> 
Bootlog from git u-boot:
http://pastebin.com/d129d38a8

Bootlog from stock u-boot:
http://pastebin.com/d2b91d601

But it looks as the printk's will never reached!

Dieter

> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index cef28a7..fb06be0 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -187,9 +187,14 @@ void pci_enable_bridges(struct pci_bus *bus)
>  	struct pci_dev *dev;
>  	int retval;
>  
> +	printk(KERN_INFO "pci_enable_bridges(%p)\n", bus);
> +
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		printk(KERN_INFO "..considering device %p\n", dev);
>  		if (dev->subordinate) {
> +			printk(KERN_INFO "..has subordinate\n", dev);
>  			if (!pci_is_enabled(dev)) {
> +				printk(KERN_INFO "..enabling\n", dev);
>  				retval = pci_enable_device(dev);
>  				pci_set_master(dev);
>  			}
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b636e24..5ab9028 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -599,6 +599,8 @@ pci_assign_unassigned_resources(void)
>  {
>  	struct pci_bus *bus;
>  
> +	printk(KERN_INFO "pci_assign_unassigned_resources()\n");
> +
>  	/* Depth first, calculate sizes and alignments of all
>  	   subordinate buses. */
>  	list_for_each_entry(bus, &pci_root_buses, node) {
> @@ -606,6 +608,7 @@ pci_assign_unassigned_resources(void)
>  	}
>  	/* Depth last, allocate resources and update the hardware. */
>  	list_for_each_entry(bus, &pci_root_buses, node) {
> +		printk(KERN_INFO "..allocating resources for bus %p\n", bus);
>  		pci_bus_assign_resources(bus);
>  		pci_enable_bridges(bus);
>  	}
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
