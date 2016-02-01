From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 1 Feb 2016 11:57:18 +0000
Subject: [RFC PATCH] irq/mbigen:Fix the problem of IO remap for
 duplicated physical address in mbigen driver
In-Reply-To: <1454327094-7848-1-git-send-email-majun258@huawei.com>
References: <1454327094-7848-1-git-send-email-majun258@huawei.com>
Message-ID: <20160201115717.GD674@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 07:44:54PM +0800, MaJun wrote:
> From: Ma Jun <majun258@huawei.com>
> 
> For mbigen module, there is a special case that more than one mbigen 
> device nodes use the same reg definition in DTS when these devices
> exist in the same mbigen hardware module. 
> 
> mbigen_dev1:intc_dev1 {
> 	...
> 	reg = <0x0 0xc0080000 0x0 0x10000>;
> 	...
> };
> 
> mbigen_dev2:intc_dev2 {
> 	...
> 	reg = <0x0 0xc0080000 0x0 0x10000>;
> 	...
> };

This doesn't sound right. If they exist in the same place, and have the
same reg, they _are_ the same device.

You'll need to explain this better.

> On this case, devm_ioremap_resource() returns fail with info
> "can't request region for resource" because of memory region check.
> 
> Because we only need to program 1 into corresponding bit into status 
> register of mbigen to clear the interrupt status during runtime,
> I think we can replace devm_ioremap_resource() by devm_ioremap().
> 
> Signed-off-by: Ma Jun <majun258@huawei.com>
> ---
>  drivers/irqchip/irq-mbigen.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 4dd3eb8..b19e528 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -250,7 +250,7 @@ static int mbigen_device_probe(struct platform_device *pdev)
>  	mgn_chip->pdev = pdev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mgn_chip->base = devm_ioremap_resource(&pdev->dev, res);
> +	mgn_chip->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));

These two behaving differently doesn't seem correct either...

Mark.

>  	if (IS_ERR(mgn_chip->base))
>  		return PTR_ERR(mgn_chip->base);
>  
> -- 
> 1.7.1
> 
> 
