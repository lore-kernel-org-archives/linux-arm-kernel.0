From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 28 Jul 2016 12:29:48 -0400
Subject: [PATCH -next] PCI: keystone: Fix error return code in
 ks_add_pcie_port()
In-Reply-To: <1469722578-14863-1-git-send-email-weiyj.lk@gmail.com>
References: <1469722578-14863-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <579A32FC.4070907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2016 12:16 PM, Wei Yongjun wrote:
> Fix to return a negative error code from the request IRQ error
> handling case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/pci/host/pci-keystone.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 8ba2883..82b461b 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -334,8 +334,9 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
>  	if (ks_pcie->error_irq <= 0)
>  		dev_info(&pdev->dev, "no error IRQ defined\n");
>  	else {
> -		if (request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
> -				IRQF_SHARED, "pcie-error-irq", ks_pcie) < 0) {
> +		ret = request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
> +				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
> +		if (ret < 0) {
>  			dev_err(&pdev->dev, "failed to request error IRQ %d\n",
>  				ks_pcie->error_irq);
>  			return ret;
> 
Thanks

Acked-By: Murali Karicheri <m-karicheri2@ti.com>

-- 
Murali Karicheri
Linux Kernel, Keystone
