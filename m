From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 26 Jan 2016 14:50:05 -0600
Subject: [PATCH v9 5/6] PCI: generic: Make pci-host-generic driver numa
 aware
In-Reply-To: <1453134965-6125-6-git-send-email-gkulkarni@caviumnetworks.com>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1453134965-6125-6-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <20160126205005.GD17600@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 10:06:04PM +0530, Ganapatrao Kulkarni wrote:
> update numa_node of device associated with pci bus.
> moved down devm_kzalloc to allocate from node memory.
> 
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> ---
>  drivers/pci/host/pci-host-generic.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 5434c90..0e1ce06 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -215,11 +215,9 @@ static int gen_pci_probe(struct platform_device *pdev)
>  	const struct of_device_id *of_id;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> -	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	struct gen_pci *pci;
>  	struct pci_bus *bus, *child;
>  
> -	if (!pci)
> -		return -ENOMEM;
>  
>  	type = of_get_property(np, "device_type", NULL);
>  	if (!type || strcmp(type, "pci")) {
> @@ -230,6 +228,11 @@ static int gen_pci_probe(struct platform_device *pdev)
>  	of_pci_check_probe_only();
>  
>  	of_id = of_match_node(gen_pci_of_match, np);
> +	set_dev_node(dev, of_node_to_nid(np));

I like the idea of this patch, but why do we need to call
set_dev_node() here in driver code?  Shouldn't that be done by the
OF/platform device infrastructure so that all drivers for platform devices
get this benefit?

> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
>  	pci->cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
>  	pci->host.dev.parent = dev;
>  	INIT_LIST_HEAD(&pci->host.windows);
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
