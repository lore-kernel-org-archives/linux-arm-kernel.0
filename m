From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Thu, 8 Jun 2017 09:09:28 +0000
Subject: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
In-Reply-To: <20170608084851.GA8607@red-moon>
References: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
 <20170531143213.82100-3-shameerali.kolothum.thodi@huawei.com>
 <20170606135623.GB20126@red-moon>
 <5FC3163CFD30C246ABAA99954A238FA838362082@FRAEML521-MBX.china.huawei.com>
 <20170608084851.GA8607@red-moon>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838363D5D@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi at arm.com]
> Sent: Thursday, June 08, 2017 9:49 AM
> To: Shameerali Kolothum Thodi
> Cc: marc.zyngier at arm.com; sudeep.holla at arm.com; will.deacon at arm.com;
> robin.murphy at arm.com; hanjun.guo at linaro.org; Gabriele Paoloni; John
> Garry; iommu at lists.linux-foundation.org; linux-arm-
> kernel at lists.infradead.org; linux-acpi at vger.kernel.org; devel at acpica.org;
> Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> Subject: Re: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
> erratum 161010801
> 
> On Tue, Jun 06, 2017 at 03:01:36PM +0000, Shameerali Kolothum Thodi
> wrote:
> 
> [...]
> 
> > > > +	irq_dom = pci_msi_get_device_domain(to_pci_dev(dev));
> > > > +	if (irq_dom) {
> > > > +		int	ret;
> > > > +		u32	rid;
> > > > +
> > > > +		rid = pci_msi_domain_get_msi_rid(irq_dom,
> > > to_pci_dev(dev));
> > > > +		ret = iort_dev_find_its_base(dev, rid, 0, &base);
> > >
> > > Well, here we use ITS id 0 which is fine as long as code in IORT
> > > uses the same policy for getting the irq_domain (ie we want to
> > > reserve the ITS address space that is actually used by the device to
> > > send IRQs not a a different one) it is just a heads-up because I find this
> confusing.
> >
> > Ok. Just to make it clear, 0 is the index into the ITS identifier
> > list.  I noted that iort_get_device_domain() uses index 0 while
> > retrieving the ITS identifier.  May be use the same approach here as
> > well? ie, remove the index from function call?
> >
> > I am not sure, how we can get the index info  though theoretically It
> > is possible for the ITS group node having multiple ITSs.
> 
> Actually I think it would make sense to reserve ALL ITS regions a device may
> be mapped to instead of just index 0 (ie in your case it is equivalent); this
> leaves us some leeway as to choose which ITS the device will be actually
> mapped to and this code does not have to care.

Ok. That make sense. Just a quick one, is it ok to add another helper function in
iort code to retrieve the its->its_count then? 

Thanks,
Shameer
