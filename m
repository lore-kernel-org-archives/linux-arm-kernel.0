From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 24 Apr 2014 17:24:31 -0600
Subject: [PATCH 3/3] pci: add DT based ARM Versatile PCI host driver
In-Reply-To: <1395960398-4238-4-git-send-email-robherring2@gmail.com>
References: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
 <1395960398-4238-4-git-send-email-robherring2@gmail.com>
Message-ID: <20140424232431.GO29593@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 05:46:38PM -0500, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This converts the Versatile PCI host code to a platform driver using
> of_create_pci_host_bridge for parsing DT and setup.
> 
> I think more of this setup could be done by the core code. There are
> accesses to the host's config space (accesses using local_pci_cfg_base)
> which seem like they could be done by the core code or using standard
> config space accessors. The problem is bridge->bus->self is needed, but
> it does not get setup. I'm not exactly sure how that should work.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ...

> +static int versatile_pci_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int ret, i, mem = 1, myslot = -1;
> +	unsigned int lastbus;
> +	u32 val;
> +	struct pci_host_bridge *bridge;
> +	void __iomem *local_pci_cfg_base;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +	versatile_pci_base = devm_ioremap_resource(&pdev->dev, res);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res)
> +		return -ENODEV;
> +	versatile_cfg_base[0] = devm_ioremap_resource(&pdev->dev, res);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	if (!res)
> +		return -ENODEV;
> +	versatile_cfg_base[1] = devm_ioremap_resource(&pdev->dev, res);
> +
> +	bridge = of_create_pci_host_bridge(&pdev->dev, &pci_versatile_ops, &sys);

Are we still relying on the PCI core to default to a bus number range of
00-ff?  Can we not do that?

Bjorn
