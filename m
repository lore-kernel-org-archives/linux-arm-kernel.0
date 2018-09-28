From: ryder.lee@mediatek.com (Ryder Lee)
Date: Fri, 28 Sep 2018 23:41:17 +0800
Subject: [PATCH v5 4/9] PCI: mediatek: Convert to use pci_host_probe()
In-Reply-To: <1538129080-8206-5-git-send-email-honghui.zhang@mediatek.com>
References: <1538129080-8206-1-git-send-email-honghui.zhang@mediatek.com>
 <1538129080-8206-5-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1538149277.23182.7.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-09-28 at 18:04 +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Part of mtk_pcie_register_host is an open-coded version of
> pci_host_probe(). So instead of duplicating this code, use
> pci_host_probe() directly and remove mtk_pcie_register_host.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 37 ++++++++--------------------------
>  1 file changed, 8 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index e2c4127..cbf4543 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1125,34 +1125,6 @@ static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
>  	return 0;
>  }
>  
> -static int mtk_pcie_register_host(struct pci_host_bridge *host)
> -{
> -	struct mtk_pcie *pcie = pci_host_bridge_priv(host);
> -	struct pci_bus *child;
> -	int err;

To make the patch simple, could we keep these host->*. and return
pci_host_probe() directly?

> -	host->busnr = pcie->busn.start;
> -	host->dev.parent = pcie->dev;
> -	host->ops = pcie->soc->ops;
> -	host->map_irq = of_irq_parse_and_map_pci;
> -	host->swizzle_irq = pci_common_swizzle;
> -	host->sysdata = pcie;
> -
> -	err = pci_scan_root_bus_bridge(host);
> -	if (err < 0)
> -		return err;
> -
> -	pci_bus_size_bridges(host->bus);
> -	pci_bus_assign_resources(host->bus);
> -
> -	list_for_each_entry(child, &host->bus->children, node)
> -		pcie_bus_configure_settings(child);
> -
> -	pci_bus_add_devices(host->bus);
> -
> -	return 0;
> -}
> -
>  static int mtk_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1179,7 +1151,14 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		goto put_resources;
>  
> -	err = mtk_pcie_register_host(host);
> +	host->busnr = pcie->busn.start;
> +	host->dev.parent = pcie->dev;
> +	host->ops = pcie->soc->ops;
> +	host->map_irq = of_irq_parse_and_map_pci;
> +	host->swizzle_irq = pci_common_swizzle;
> +	host->sysdata = pcie;
> +
> +	err = pci_host_probe(host);
>  	if (err)
>  		goto put_resources;
>  
