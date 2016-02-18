From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 18 Feb 2016 13:20:38 +0000
Subject: [Linaro-acpi] [PATCH V5 01/15] ACPI: MCFG: Move mmcfg_list
 management to drivers/acpi
In-Reply-To: <56C5B83F.4010602@huawei.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-2-git-send-email-tn@semihalf.com>
 <56C5B83F.4010602@huawei.com>
Message-ID: <20160218132038.GA13229@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 08:25:35PM +0800, liudongdong (C) wrote:

[...]

> >+/*
> >+ * Map a pci_mmcfg_region, can be overrriden by arch
> >+ */
> >+int __weak pci_mmconfig_map_resource(struct device *dev,
> >+	struct pci_mmcfg_region *mcfg)
> >+{
> >+	struct resource *tmp;
> >+	void __iomem *vaddr;
> >+
> >+	tmp = insert_resource_conflict(&iomem_resource, &mcfg->res);
> >+	if (tmp) {
> >+		dev_warn(dev, "MMCONFIG %pR conflicts with %s %pR\n",
> >+			&mcfg->res, tmp->name, tmp);
> >+		return -EBUSY;
> >+	}
> >+
> >+	vaddr =  ioremap(mcfg->res.start, resource_size(&mcfg->res));
               ^^
	       while at it, stray white space

> >+	if (!vaddr) {
> >+		release_resource(&mcfg->res);
> >+		return -ENOMEM;
> >+	}
> >+
> >+	mcfg->virt = vaddr;
> Here should be changed to
> 	mcfg->virt = vaddr - PCI_MMCFG_BUS_OFFSET(mcfg->start_bus);
> 
> or when pcie host "start_bus" is not 0, the configuraion access will be wrong.
Well spotted, thanks.

Lorenzo
