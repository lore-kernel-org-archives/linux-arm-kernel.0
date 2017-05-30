From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 30 May 2017 08:12:06 +0000
Subject: [PATCH v9 2/7] PCI: Apply the new generic I/O management on PCI
 IO hosts
In-Reply-To: <20170526212001.GB21531@bhelgaas-glaptop.roam.corp.google.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-3-git-send-email-gabriele.paoloni@huawei.com>
 <20170526212001.GB21531@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40A74D9E@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: 26 May 2017 22:20
> To: Gabriele Paoloni
> Cc: catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
> frowand.list at gmail.com; bhelgaas at google.com; rafael at kernel.org;
> arnd at arndb.de; linux-arm-kernel at lists.infradead.org;
> lorenzo.pieralisi at arm.com; mark.rutland at arm.com; minyard at acm.org;
> benh at kernel.crashing.org; John Garry; linux-kernel at vger.kernel.org;
> xuwei (O); Linuxarm; linux-acpi at vger.kernel.org; zhichang.yuan; linux-
> pci at vger.kernel.org; olof at lixom.net; brian.starkey at arm.com
> Subject: Re: [PATCH v9 2/7] PCI: Apply the new generic I/O management
> on PCI IO hosts
> 
> On Thu, May 25, 2017 at 12:37:23PM +0100, Gabriele Paoloni wrote:
> > From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
> >
> > After introducing the new generic I/O space management(LOGIC_IO), the
> > original PCI MMIO relevant helpers need to be updated based on the
> new
> > interfaces defined in LOGIC_IO.
> > This patch adapts the corresponding code to match the changes
> introduced
> > by LOGIC_IO.
> >
> > Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>        #earlier draft
> 
> Not sure how you plan to merge this, but here's my ack:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Many thanks for your Ack :)

Maybe Arnd can take the whole patchset (or just the lib framework + DT part
leaving the ACPI part to Lorenzo)....?

> 
> If you split this as suggested below, add my ack to all three patches.

Sure I will

> 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b01bd5b..c9fe12b 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> >...
> 
> > -int __weak pci_register_io_range(phys_addr_t addr, resource_size_t
> size)
> > +int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t
> addr,
> > +			resource_size_t	size)
> 
> It's trivial and nit-picky, but I would do the __weak removal in its
> own patch.  It's obviously fine because there's only one
> implementation, but it's unrelated to the main point of this patch.

Agreed

> 
> I would split the signature change (fwnode addition) to a separate
> patch, too, just to make the actual change more obvious, especially
> since that's the only part that crosses subsystems (ACPI, PCI, OF).

Agreed too

> 
> >  {
> > -	int err = 0;
> > -
> > +	int ret = 0;
> >  #ifdef PCI_IOBASE
> > -	struct io_range *range;
> > -	resource_size_t allocated_size = 0;
> > -
> > -	/* check if the range hasn't been previously recorded */
> > -	spin_lock(&io_range_lock);
> > -	list_for_each_entry(range, &io_range_list, list) {
> > -		if (addr >= range->start && addr + size <= range->start +
> size) {
> > -			/* range already registered, bail out */
> > -			goto end_register;
> > -		}
> > -		allocated_size += range->size;
> > -	}
> > -
> > -	/* range not registed yet, check for available space */
> > -	if (allocated_size + size - 1 > IO_SPACE_LIMIT) {
> > -		/* if it's too big check if 64K space can be reserved */
> > -		if (allocated_size + SZ_64K - 1 > IO_SPACE_LIMIT) {
> > -			err = -E2BIG;
> > -			goto end_register;
> > -		}
> > -
> > -		size = SZ_64K;
> > -		pr_warn("Requested IO range too big, new size set to
> 64K\n");
> > -	}
> > +	struct logic_pio_hwaddr *range;
> >
> > -	/* add the range to the list */
> > -	range = kzalloc(sizeof(*range), GFP_ATOMIC);
> > -	if (!range) {
> > -		err = -ENOMEM;
> > -		goto end_register;
> > -	}
> > +	if (!size || addr + size < addr)
> > +		return -EINVAL;
> >
> > -	range->start = addr;
> > +	range = kzalloc(sizeof(*range), GFP_KERNEL);
> > +	if (!range)
> > +		return -ENOMEM;
> 
> Add a blank line here.

Yep I will

Cheers
Gab

> 
> > +	range->fwnode = fwnode;
> >  	range->size = size;
> > +	range->hw_start = addr;
> > +	range->flags = PIO_CPU_MMIO;
> >
> > -	list_add_tail(&range->list, &io_range_list);
> > -
> > -end_register:
> > -	spin_unlock(&io_range_lock);
> > +	ret = logic_pio_register_range(range);
> > +	if (ret)
> > +		kfree(range);
> >  #endif
> >
> > -	return err;
> > +	return ret;
> >  }
