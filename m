From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 24 Aug 2017 17:48:34 +0100
Subject: [PATCH 2/3] pci: designware: add separate driver for the MSI part
 of the RC
In-Reply-To: <20170821192907.8695-3-ard.biesheuvel@linaro.org>
References: <20170821192907.8695-1-ard.biesheuvel@linaro.org>
 <20170821192907.8695-3-ard.biesheuvel@linaro.org>
Message-ID: <e1f5e20d-929f-db8d-1c60-181698e678f0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 21/08/17 20:29, Ard Biesheuvel wrote:
[...]
> +static int dw_pcie_msi_probe(struct platform_device *pdev)
> +{
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(pdev->dev.of_node);

Mini-nit: since fairly recently (f94277af03ea) dev->fwnode should
already be set appropriately by of_platform_device_create(), so you
should be able to make this entirely firmware-agnostic if you like.

Robin.

> +	struct device *dev = &pdev->dev;
> +	struct dw_pcie_msi *dw_msi;
> +	struct resource *res;
> +
> +	dw_msi = devm_kzalloc(dev, sizeof(*dw_msi), GFP_KERNEL);
> +	if (!dw_msi)
> +		return -ENOMEM;
> +
> +	/* get the control register and map it */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dw_msi->regbase = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(dw_msi->regbase))
> +		return PTR_ERR(dw_msi->regbase);
> +
> +	/* get the wired interrupt that gets raised when we receive an MSI */
> +	dw_msi->irq = platform_get_irq(pdev, 0);
> +	if (dw_msi->irq <= 0) {
> +		pr_err("Failed to map IRQ\n");
> +		return -ENXIO;
> +	}
> +
> +	dw_msi->irqd = irq_domain_create_linear(fwnode, MAX_MSI_IRQS,
> +						&irq_dom_ops, dw_msi);
> +	if (!dw_msi->irqd) {
> +		dev_err(dev, "Failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	dw_msi->msid = pci_msi_create_irq_domain(fwnode, &dw_pcie_msi_dom_info,
> +						 dw_msi->irqd);
> +	if (!dw_msi->msid) {
> +		dev_err(dev, "Failed to create MSI domain\n");
> +		irq_domain_remove(dw_msi->irqd);
> +		return -ENOMEM;
> +	}
> +
> +	irq_set_chained_handler_and_data(dw_msi->irq, dw_pcie_msi_isr, dw_msi);
> +	platform_set_drvdata(pdev, dw_msi);
> +
> +	/* program the msi_data */
> +	writel_relaxed(lower_32_bits(virt_to_phys(&dw_msi->doorbell)),
> +		       dw_msi->regbase + PCIE_MSI_ADDR_LO);
> +	writel_relaxed(upper_32_bits(virt_to_phys(&dw_msi->doorbell)),
> +		       dw_msi->regbase + PCIE_MSI_ADDR_HI);
> +
> +	return 0;
> +}
> +
> +static int dw_pcie_msi_remove(struct platform_device *pdev)
> +{
> +	struct dw_pcie_msi *dw_msi = platform_get_drvdata(pdev);
> +
> +	irq_set_chained_handler_and_data(dw_msi->irq, NULL, NULL);
> +	irq_domain_remove(dw_msi->msid);
> +	irq_domain_remove(dw_msi->irqd);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dw_pcie_dw_msi_of_match[] = {
> +	{ .compatible = "snps,dw-pcie-msi" },
> +	{ },
> +};
> +
> +static struct platform_driver pci_dw_msi_driver = {
> +	.driver.name			= "pcie-designware-msi",
> +	.driver.of_match_table		= dw_pcie_dw_msi_of_match,
> +	.probe				= dw_pcie_msi_probe,
> +	.remove				= dw_pcie_msi_remove,
> +};
> +builtin_platform_driver(pci_dw_msi_driver);
> 
