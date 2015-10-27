From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 27 Oct 2015 09:38:12 -0500
Subject: [PATCH V4 7/8] PCI: OF: Move of_pci_dma_configure() to
 pci_dma_configure()
In-Reply-To: <1445442731-28819-8-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1445442731-28819-8-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <20151027143812.GB8660@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suravee,

On Wed, Oct 21, 2015 at 08:52:10AM -0700, Suravee Suthikulpanit wrote:
> This patch move of_pci_dma_configure() to a more generic
> pci_dma_configure(), which can be extended by non-OF code (e.g. ACPI).

> -void of_pci_dma_configure(struct pci_dev *pci_dev)
> -{
> -	struct device *dev = &pci_dev->dev;
> -	struct device *bridge = pci_get_host_bridge_device(pci_dev);
> -
> -	if (!bridge->parent)
> -		return;
> -
> -	of_dma_configure(dev, bridge->parent->of_node);
> -	pci_put_host_bridge_device(bridge);
> -}

> +static void pci_dma_configure(struct pci_dev *dev)
> +{
> +	struct device *bridge = pci_get_host_bridge_device(dev);
> +
> +	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
> +		if (!bridge->parent)
> +			return;

Don't we leak a bridge reference here?  This looks like it was a problem in
the original code, not something you added.  Ideally I guess I would add a
new patch that only fixes the leak in the original code, followed by this
patch that moves it from of_pci_dma_configure() to pci_dma_configure().

> +
> +		of_dma_configure(&dev->dev, bridge->parent->of_node);
> +	}
> +
> +	pci_put_host_bridge_device(bridge);
> +}
