From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 21 Oct 2015 16:34:16 -0500
Subject: [PATCH v4 6/6] PCI: layerscape: add ls_pcie_msi_host_init
In-Reply-To: <1444979960-24100-6-git-send-email-Minghuan.Lian@freescale.com>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
 <1444979960-24100-6-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <20151021213416.GJ1583@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Minghuan,

On Fri, Oct 16, 2015 at 03:19:20PM +0800, Minghuan Lian wrote:
> Layerscape PCIe has its own MSI implementation. The patch registers
> ls_pcie_msi_host_init() to avoid using Designware's MSI.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> Change log
> v4: split from [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and LS2080a
> 
>  drivers/pci/host/pci-layerscape.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index c53692a..8fac6c8 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -150,14 +150,31 @@ static void ls_pcie_host_init(struct pcie_port *pp)
>  	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
>  }
>  
> +static int ls_pcie_msi_host_init(struct pcie_port *pp,
> +				 struct msi_controller *chip)
> +{
> +	struct device_node *msi_node;
> +	struct device_node *np = pp->dev->of_node;
> +
> +	msi_node = of_parse_phandle(np, "msi-parent", 0);
> +	if (!msi_node) {
> +		dev_err(pp->dev, "failed to find msi-parent\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;

I don't see how this can be right.  I think it's OK if you want to enforce
the presence of "msi-parent", but the other implementations of
.msi_host_init (ks_dw_pcie_msi_host_init() and the default implementation
in dw_pcie_host_init()) both set pp->irq_domain and call
irq_create_mapping().

You don't do either of those, so I don't see how MSIs can work, because I
assume the generic DesignWare code will depend on pp->irq_domain.  If
you're planning to add more Layerscape-specific MSI support later, I think
you should wait and include this patch with that work.

> +}
> +
>  static struct pcie_host_ops ls1021_pcie_host_ops = {
>  	.link_up = ls1021_pcie_link_up,
>  	.host_init = ls1021_pcie_host_init,
> +	.msi_host_init = ls_pcie_msi_host_init,
>  };
>  
>  static struct pcie_host_ops ls_pcie_host_ops = {
>  	.link_up = ls_pcie_link_up,
>  	.host_init = ls_pcie_host_init,
> +	.msi_host_init = ls_pcie_msi_host_init,
>  };
>  
>  static struct ls_pcie_drvdata ls1021_drvdata = {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
