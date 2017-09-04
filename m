From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 4 Sep 2017 16:59:48 +0100
Subject: [Question] PCI ACS is broken for ARM SMMU v3?
In-Reply-To: <59AD4812.3020602@hisilicon.com>
References: <59A81B4C.3020402@hisilicon.com> <59AD4812.3020602@hisilicon.com>
Message-ID: <20170904155948.GA20601@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 08:33:22PM +0800, Zhou Wang wrote:
> +to: Lorenzo
> 
> On 2017/8/31 22:21, Zhou Wang wrote:
> > Hi Will and Alex,
> > 
> > pci_request_acs is called in drivers/iommu/arm-smmu-v3.c to set pci_acs_enable.
> > 
> > PCI subsystem tries to enable ACS as below:
> > 
> > 	pci_device_add
> > 		--> pci_init_capabilities
> > 			--> pci_enable_acs
> > 
> > in ACPI PCI driver. However, ACPI PCI driver will be called before SMMU v3 driver,
> > which will lead pci_enable_acs to return directly as pci_acs_enable is not set
> > before SMMU v3 driver loading.
> > 
> > I think this is a bug, what do you think about this problem?

I think that it is a bug that affects OF/ACPI alike. One way of solving
it is requesting ACS at IORT init following appropriate checks (ie
mappings PCI->IOMMU - that would not solve the OF path though). I can
put together a quick fix, the overall problem needs some thinking
though.

Lorenzo
