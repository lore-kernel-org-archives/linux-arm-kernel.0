From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 22 Feb 2016 11:24:03 +0000
Subject: [PATCH] Irq/mbigen:Promote the mbigen driver register timing
In-Reply-To: <1456138810-24008-1-git-send-email-majun258@huawei.com>
References: <1456138810-24008-1-git-send-email-majun258@huawei.com>
Message-ID: <56CAEFD3.2060700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/02/16 11:00, MaJun wrote:
> From: Ma Jun <majun258@huawei.com>
> 
> Using module_platform_driver() to register mbigen driver is
> too late for some driver to apply irq, because the mbigen irq
> domain is not created yet. 
> 
> Signed-off-by: Ma Jun <majun258@huawei.com>
> ---
>  drivers/irqchip/irq-mbigen.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 4dd3eb8..4df359c 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -289,7 +289,14 @@ static struct platform_driver mbigen_platform_driver = {
>  	.probe			= mbigen_device_probe,
>  };
>  
> -module_platform_driver(mbigen_platform_driver);
> +static __init int mbigen_init(void)
> +
> +{
> +	return platform_driver_register(&mbigen_platform_driver);
> +
> +}
> +
> +arch_initcall(mbigen_init);
>  
>  MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
>  MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
> 

I don't believe this is a proper fix, and already said so when reviewing
this code:

http://www.spinics.net/lists/linux-pci/msg46534.html

Short of actually solving the dependencies, it is likely that you will
only move the problem somewhere else.

I suggest you engage will people that are working on a proper solution,
and/or fix the drivers to gracefully defer their probing if their IRQs
are not available.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
