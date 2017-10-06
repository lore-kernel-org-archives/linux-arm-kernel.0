From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Fri, 6 Oct 2017 14:27:13 +0000
Subject: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
 behind SMMUv3
In-Reply-To: <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
 <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40C57A73@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shameer

> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: 06 October 2017 15:05
> To: lorenzo.pieralisi at arm.com; marc.zyngier at arm.com;
> sudeep.holla at arm.com; will.deacon at arm.com; robin.murphy at arm.com;
> joro at 8bytes.org; bhelgaas at google.com; Gabriele Paoloni
> Cc: John Garry; iommu at lists.linux-foundation.org; linux-arm-
> kernel at lists.infradead.org; linux-acpi at vger.kernel.org; linux-
> pci at vger.kernel.org; devel at acpica.org; Linuxarm; Wangzhou (B);
> Guohanjun (Hanjun Guo); Shameerali Kolothum Thodi
> Subject: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
> behind SMMUv3
> 
> The HiSilicon erratum 161010801 describes the limitation of
> HiSilicon platforms hip06/hip07 to support the SMMUv3 mappings
> for MSI transactions.
> 
> PCIe controller on these platforms has to differentiate the MSI
> payload against other DMA payload and has to modify the MSI
> payload. This basically makes it difficult for this platforms to
> have a SMMU translation for MSI. In order to workaround this, ARM
> SMMUv3 driver requires a quirk to treat the MSI regions separately.
> Such a quirk is currently missing for DT based systems and therefore
> we need to blacklist the hip06/hip07 PCIe controllers.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

For this patch
Acked-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

> ---
>  drivers/pci/dwc/pcie-hisi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> index a201791..6800747 100644
> --- a/drivers/pci/dwc/pcie-hisi.c
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -270,6 +270,12 @@ static int hisi_pcie_probe(struct platform_device
> *pdev)
>  	struct resource *reg;
>  	int ret;
> 
> +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> +			of_property_read_bool(dev->of_node, "iommu-map")) {
> +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting
> PCIe controllers behind SMMUv3\n");
> +		return -ENODEV;
> +	}
> +
>  	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
>  	if (!hisi_pcie)
>  		return -ENOMEM;
> @@ -340,6 +346,12 @@ static int hisi_pcie_almost_ecam_probe(struct
> platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct pci_ecam_ops *ops;
> 
> +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> +			of_property_read_bool(dev->of_node, "iommu-map")) {
> +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting
> PCIe controllers behind SMMUv3\n");
> +		return -ENODEV;
> +	}
> +
>  	ops = (struct pci_ecam_ops *)of_device_get_match_data(dev);
>  	return pci_host_common_probe(pdev, ops);
>  }
> --
> 1.9.1
> 
