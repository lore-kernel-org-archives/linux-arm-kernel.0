From: horms@verge.net.au (Simon Horman)
Date: Thu, 2 Feb 2017 10:25:41 +0100
Subject: [PATCH 1 4/4] PCI: rcar: Use of_device_get_match_data() to
 simplify probe
In-Reply-To: <20170131202020.27605.39560.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170131202020.27605.39560.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170202092541.GM21831@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 02:20:20PM -0600, Bjorn Helgaas wrote:
> This is a DT-only driver, so the only way to call rcar_pcie_probe() is to
> match an entry in rcar_pcie_of_match[], so of_id cannot be NULL.
> 
> Furthermore, of_id->data can only be NULL if an rcar_pcie_of_match[] entry
> has a NULL .data member.  That's a driver defect, and we don't want to
> return -EINVAL, which is easy to ignore.  We'd rather take the NULL pointer
> dereference so we notice the problem and fix it.
> 
> Use of_device_get_match_data() to retrieve the hw_init_fn pointer.  No
> functional change intended.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pci/host/pcie-rcar.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index aca85be101f8..b3b6d5273347 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1125,7 +1125,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct rcar_pcie *pcie;
>  	unsigned int data;
> -	const struct of_device_id *of_id;
>  	int err;
>  	int (*hw_init_fn)(struct rcar_pcie *);
>  
> @@ -1149,11 +1148,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	of_id = of_match_device(rcar_pcie_of_match, dev);
> -	if (!of_id || !of_id->data)
> -		return -EINVAL;
> -	hw_init_fn = of_id->data;
> -
>  	pm_runtime_enable(dev);
>  	err = pm_runtime_get_sync(dev);
>  	if (err < 0) {
> @@ -1162,6 +1156,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Failure to get a link might just be that no cards are inserted */
> +	hw_init_fn = of_device_get_match_data(dev);
>  	err = hw_init_fn(pcie);
>  	if (err) {
>  		dev_info(dev, "PCIe link down\n");
> 
