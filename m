From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 27 Jan 2016 14:33:45 +0000
Subject: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge
 driver to  work on both  Zynq and Microblaze
In-Reply-To: <4734542.KZZp0TeeeM@wuerfel>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <1452620173-4905-4-git-send-email-bharatku@xilinx.com>
 <4734542.KZZp0TeeeM@wuerfel>
Message-ID: <8520D5D51A55D047800579B09414719825873DA8@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver
> to work on both Zynq and Microblaze
> 
> On Tuesday 12 January 2016 23:06:11 Bharat Kumar Gogada wrote:
> > Modifying Xilinx AXI PCIe Host Bridge Soft IP driver to work on both
> > Zynq and Microblaze Architectures.
> > With these modifications drivers/pci/host/pcie-xilinx.c, will work on
> > both Zynq and Microblaze Architectures.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> 
> I think this patch should be split into three, as you are doing three unrelated
> things here.
> 
Agreed, will send as different patches in next series.
> > ---
> > --- a/drivers/pci/host/pcie-xilinx.c
> > +++ b/drivers/pci/host/pcie-xilinx.c
> > @@ -92,7 +92,12 @@
> >  #define ECAM_DEV_NUM_SHIFT		12
> >
> >  /* Number of MSI IRQs */
> > -#define XILINX_NUM_MSI_IRQS		128
> > +#define XILINX_NUM_MSI_IRQS	128
> > +#ifdef CONFIG_ARM
> > +#define TOT_NR_IRQS		XILINX_NUM_MSI_IRQS
> > +#else
> > +#define TOT_NR_IRQS		(NR_IRQS + XILINX_NUM_MSI_IRQS)
> > +#endif
> 
> Something looks wrong here in the microblaze variant. What does NR_IRQS
> have to do with it?
> 
> > @@ -238,15 +243,20 @@ static void xilinx_pcie_destroy_msi(unsigned int
> irq)
> >   */
> >  static int xilinx_pcie_assign_msi(struct xilinx_pcie_port *port)  {
> > +	int irq;
> >  	int pos;
> >
> >  	pos = find_first_zero_bit(msi_irq_in_use, XILINX_NUM_MSI_IRQS);
> > -	if (pos < XILINX_NUM_MSI_IRQS)
> > +	irq = pos;
> > +#ifdef CONFIG_MICROBLAZE
> > +	irq = XILINX_NUM_MSI_IRQS + pos;
> > +#endif
> 
> 
> 	if (IS_ENABLED(CONFIG_MICROBLAZE))
> 		irq = XILINX_NUM_MSI_IRQS + pos;
> 
Agreed.
> > @@ -705,7 +715,9 @@ static int xilinx_pcie_probe(struct
> > platform_device *pdev)  #endif
> >  	pci_scan_child_bus(bus);
> >  	pci_assign_unassigned_bus_resources(bus);
> > +#ifdef CONFIG_ARM
> >  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > +#endif
> >  	pci_bus_add_devices(bus);
> >  	platform_set_drvdata(pdev, port);
> 
> Here it looks like microblaze gets it right. I'm not sure why we still need the
> pci_fixup_irqs() on ARM, but my feeling is that this should be fixed in
> common code.
In arm pci_fixup_irqs is called by pci_common_init_dev (arch/arm/kernel/bios32.c), since this API is removed now, I was calling it separately.

Bharat
