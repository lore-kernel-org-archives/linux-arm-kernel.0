From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Aug 2016 13:17:57 +0100
Subject: [PATCH 3/3] PCI: Xilinx NWL PCIe: Fix Error for multi function
 device for legacy interrupts.
In-Reply-To: <1472553558-27215-3-git-send-email-bharatku@xilinx.com>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
 <1472553558-27215-3-git-send-email-bharatku@xilinx.com>
Message-ID: <57C57975.7040306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bharat,

On 30/08/16 11:39, Bharat Kumar Gogada wrote:
> PCIe legacy interrupts start at 1, not at 0.
> When testing with multi function device "error: hwirq 0x4 is too large for
> dummy" error comes.
> So adding one addtional interrupt when creating irq domain.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> ---
>  drivers/pci/host/pcie-xilinx-nwl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index d8d43e6..9f04411 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -561,7 +561,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
>  	}
>  
>  	pcie->legacy_irq_domain = irq_domain_add_linear(legacy_intc_node,
> -							INTX_NUM,
> +							INTX_NUM + 1,
>  							&legacy_domain_ops,
>  							pcie);

This feels like the wrong thing to do. You have INTX_NUM irqs, so the
domain allocation should reflect this. On the other hand, the way the
driver currently deals with mappings is quite broken (consistently
adding 1 to the HW interrupt).

How about something like this instead?

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 0b597d9..72b159f 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -314,8 +314,7 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
 	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
 				MSGF_LEG_SR_MASKALL) != 0) {
 		for_each_set_bit(bit, &status, INTX_NUM) {
-			virq = irq_find_mapping(pcie->legacy_irq_domain,
-						bit + 1);
+			virq = irq_find_mapping(pcie->legacy_irq_domain, bit);
 			if (virq)
 				generic_handle_irq(virq);
 		}
@@ -483,7 +482,7 @@ static void nwl_pcie_free_irq_domain(struct nwl_pcie *pcie)
 	u32 irq;
 
 	for (i = 0; i < INTX_NUM; i++) {
-		irq = irq_find_mapping(pcie->legacy_irq_domain, i + 1);
+		irq = irq_find_mapping(pcie->legacy_irq_domain, i);
 		if (irq > 0)
 			irq_dispose_mapping(irq);
 	}

I may have missed a few things, but you'll get the idea.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
