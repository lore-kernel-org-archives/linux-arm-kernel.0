From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 11 Nov 2016 15:50:37 -0600
Subject: [PATCH -next] PCI: xilinx: Add missing of_node_put() in
 xilinx_pcie_init_irq_domain()
In-Reply-To: <1476716344-1050-1-git-send-email-weiyj.lk@gmail.com>
References: <1476716344-1050-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20161111215037.GM9868@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 02:59:04PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> This node pointer is returned by of_get_next_child() with refcount
> incremented in this function. of_node_put() on it before exitting
> this function on error.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied to pci/host-xilinx for v4.10, thanks!

See below for another possible issue.

> ---
>  drivers/pci/host/pcie-xilinx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index c8616fa..7100ee5 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -529,6 +529,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  						 port);
>  	if (!port->leg_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		of_node_put(pcie_intc_node);
>  		return -ENODEV;
>  	}
>  
> @@ -540,6 +541,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  							 &xilinx_pcie_msi_chip);
>  		if (!port->msi_domain) {
>  			dev_err(dev, "Failed to get a MSI IRQ domain\n");
> +			of_node_put(pcie_intc_node);

We also leak port->leg_domain here, don't we?

>  			return -ENODEV;
>  		}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
