From: Hong-Xing.Zhu@freescale.com (Hong-Xing.Zhu at freescale.com)
Date: Wed, 26 Feb 2014 01:40:18 +0000
Subject: [PATCH 2/2] PCI: imx6: add support for MSI
In-Reply-To: <1393350444-29784-3-git-send-email-l.stach@pengutronix.de>
References: <1393350444-29784-1-git-send-email-l.stach@pengutronix.de>
 <1393350444-29784-3-git-send-email-l.stach@pengutronix.de>
Message-ID: <b906b998d45047d7826836ac4af25c6d@BLUPR03MB136.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas:

Thanks for your patch-set.
Only one minor comments, others are okay for me.

> -----Original Message-----
> From: linux-pci-owner at vger.kernel.org [mailto:linux-pci-owner at vger.kernel.org]
> On Behalf Of Lucas Stach
> Sent: Wednesday, February 26, 2014 1:47 AM
> To: Zhu Richard-R65037
> Cc: Shawn Guo; Bjorn Helgaas; linux-pci at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; kernel at pengutronix.de
> Subject: [PATCH 2/2] PCI: imx6: add support for MSI
> 
> From: Juergen Beisert <jbe@pengutronix.de>
> 
> This patch adds support for Message Signaled Interrupt in the imx6q-pcie
> driver. It is done in a similar way as for the Exynos PCIe driver (commit
> f342d940ee0e3a2b5197fd4fbade1cb6bbc960b7),
> which is also using the Synopsys designware PCIe IP core.
> 
> Signed-off-by: Harro Haan <hrhaan@gmail.com>
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pci-imx6.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c index
> ee082509b0ba..8076a79d975f 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -25,6 +25,7 @@
>  #include <linux/resource.h>
>  #include <linux/signal.h>
>  #include <linux/types.h>
> +#include <linux/interrupt.h>
> 
>  #include "pcie-designware.h"
> 
> @@ -329,6 +330,17 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
>  	return 0;
>  }
> 
> +/* legacy IRQD/MSI interrupt */
> +static irqreturn_t imx6_pcie_irqd_msi_handler(int irq, void *arg) {
> +	struct pcie_port *pp = arg;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_handle_msi_irq(pp);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int imx6_pcie_start_link(struct pcie_port *pp)  {
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp); @@ -403,6 +415,9 @@
> static void imx6_pcie_host_init(struct pcie_port *pp)
>  	dw_pcie_setup_rc(pp);
> 
>  	imx6_pcie_start_link(pp);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
>  }
> 
>  static void imx6_pcie_reset_phy(struct pcie_port *pp) @@ -498,6 +513,20 @@
> static int imx6_add_pcie_port(struct pcie_port *pp,
>  		return -ENODEV;
>  	}
> 
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq(pdev, 3);
> +		if (!pp->msi_irq) {
> +			dev_err(&pdev->dev, "failed to get INTD/MSI\n");
> +			return -ENODEV;
> +		}
> +
> +		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
> +					imx6_pcie_irqd_msi_handler,
> +					IRQF_SHARED, "mx6-pcie-msi", pp);
> +		if (ret)
> +			dev_err(&pdev->dev, "failed to request INTD/MCI irq\n");

[Richard] Is this INTD/MSI?

> +	}
> +
>  	pp->root_bus_nr = -1;
>  	pp->ops = &imx6_pcie_host_ops;
> 
> --
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 


Best Regards
Richard Zhu
