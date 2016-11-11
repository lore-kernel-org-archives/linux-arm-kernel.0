From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 11 Nov 2016 15:45:28 -0600
Subject: [PATCH -next] PCI: rockchip: Add missing of_node_put() in
 rockchip_pcie_init_irq_domain()
In-Reply-To: <1476716242-31684-1-git-send-email-weiyj.lk@gmail.com>
References: <1476716242-31684-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20161111214528.GL9868@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 02:57:22PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> This node pointer is returned by of_get_next_child() with refcount
> incremented in this function. of_node_put() on it before exitting
> this function on error.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied with Shawn's ack to pci/host-rockchip for v4.10, thanks!

> ---
>  drivers/pci/host/pcie-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index e0b22da..ab88859 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -949,6 +949,7 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
>  						    &intx_domain_ops, rockchip);
>  	if (!rockchip->irq_domain) {
>  		dev_err(dev, "failed to get a INTx IRQ domain\n");
> +		of_node_put(intc);
>  		return -EINVAL;
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
