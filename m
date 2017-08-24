From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 24 Aug 2017 11:42:11 -0500
Subject: [PATCH 2/3] pci: designware: add separate driver for the MSI
 part of the RC
In-Reply-To: <20170821192907.8695-3-ard.biesheuvel@linaro.org>
References: <20170821192907.8695-1-ard.biesheuvel@linaro.org>
 <20170821192907.8695-3-ard.biesheuvel@linaro.org>
Message-ID: <20170824164211.GH31858@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 08:29:06PM +0100, Ard Biesheuvel wrote:
> Most drivers that currently exist for the Synopsys Designware PCIe
> controller in RC mode hardcode the relation with the embedded MSI
> controller. This makes it more difficult than necessary to use a
> generic driver to drive the RC, which is especially unfortunate
> in cases where the firmware already configures the RC to the extent
> that it can be driven by the generic ECAM driver. It also makes it
> impossible to use an existing driver but use another IP block for
> MSI support, i.e., a GICv2m or GICv3-ITS.
> 
> So add a separate driver for the MSI part, which can be referenced
> from the DT node describing the RC via its msi-parent property.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> +static int dw_pcie_msi_probe(struct platform_device *pdev)
> +{
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(pdev->dev.of_node);
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

dev_err()

I'm not sure "failed to *map* IRQ" is the most informative text.
Other callers often use some variant of "failed to get IRQ" or "no IRQ
resource found".

> +		return -ENXIO;
> +	}
> +
> +	dw_msi->irqd = irq_domain_create_linear(fwnode, MAX_MSI_IRQS,
> +						&irq_dom_ops, dw_msi);
> +	if (!dw_msi->irqd) {
> +		dev_err(dev, "Failed to create IRQ domain\n");
> +		return -ENOMEM;
