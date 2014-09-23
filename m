From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 23 Sep 2014 16:53:06 -0600
Subject: [PATCH] PCI: designware: Fix configuration base address
In-Reply-To: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <20140923225306.GF27117@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Mohit, Jingoo]

On Tue, Sep 23, 2014 at 10:28:56PM +0800, Minghuan Lian wrote:
> The code has calculated cfg0_base and cfg1_base when parsing 'reg'
> or 'ranges' property of PCI DTS node. so remove duplicate calculation.
> And when using 'reg', resource cfg is not used, the removed code
> will get incorrect configuration base.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
>  drivers/pci/host/pcie-designware.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index c28ca05..0f3cb2a 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -515,7 +515,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  	pp->mem_base = pp->mem.start;
>  
>  	if (!pp->va_cfg0_base) {
> -		pp->cfg0_base = pp->cfg.start;
>  		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
>  						pp->cfg0_size);
>  		if (!pp->va_cfg0_base) {
> @@ -525,7 +524,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  	}
>  
>  	if (!pp->va_cfg1_base) {
> -		pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
>  		pp->va_cfg1_base = devm_ioremap(pp->dev, pp->cfg1_base,
>  						pp->cfg1_size);
>  		if (!pp->va_cfg1_base) {
> -- 
> 1.9.1
> 
