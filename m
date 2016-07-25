From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 25 Jul 2016 12:42:27 -0500
Subject: [PATCH] PCI: xilinx: Modify error handling
In-Reply-To: <20160629151820.GA14282@amitoj-Inspiron-3542>
References: <20160629151820.GA14282@amitoj-Inspiron-3542>
Message-ID: <20160725174227.GE12484@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 08:48:20PM +0530, Amitoj Kaur Chawla wrote:
> Failure of of_get_next_child returns NULL, not an ERR_PTR. Use
> appropriate error code -ENODEV to be returned on failure instead.
> 
> The Coccinelle semantic patch used to find this issue is as follows:
> @@
> expression E,E1;
> @@
> 
> if (
> *   E == NULL
>    ) { <+... when != E = E1
>         PTR_ERR(E)
>        ...+> }
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
>  drivers/pci/host/pcie-xilinx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 65f0fe0..d76ea8d 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -550,7 +550,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  	pcie_intc_node = of_get_next_child(node, NULL);
>  	if (!pcie_intc_node) {
>  		dev_err(dev, "No PCIe Intc node found\n");
> -		return PTR_ERR(pcie_intc_node);
> +		return -ENODEV;

This fix is included in the patch posted by Christophe JAILLET
<christophe.jaillet@wanadoo.fr>, along with two other similar fixes.
I applied Christophe's patch to pci/host-xilinx for v4.8.

>  	}
>  
>  	port->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
