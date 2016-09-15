From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Sep 2016 16:24:31 +0100
Subject: [RFC PATCH v2 11/11] irqchip: mbigen: promote mbigen init
In-Reply-To: <1473862879-7769-12-git-send-email-guohanjun@huawei.com>
References: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
 <1473862879-7769-12-git-send-email-guohanjun@huawei.com>
Message-ID: <57DABD2F.1030606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/16 15:21, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> mbigen is an irqchip and it needs to be probed before
> devices, same logic is used for SMMU and etc., let's
> use arch_initcall instead of platform init for mbigen.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ma Jun <majun258@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/irqchip/irq-mbigen.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index ca6add1..3a33de6 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -374,7 +374,11 @@ static struct platform_driver mbigen_platform_driver = {
>  	.probe			= mbigen_device_probe,
>  };
>  
> -module_platform_driver(mbigen_platform_driver);
> +static __init int mbigen_init(void)
> +{
> +	return platform_driver_register(&mbigen_platform_driver);
> +}
> +arch_initcall(mbigen_init);
>  
>  MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
>  MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
> 

I've already NACKed such a patch in the past, and I will carry on
NACKing it until all the other avenues (like properly tracking device
dependencies) have been explored and have been proven not to be fit for
purpose.

Rafael had proposed something around this subject last year, and I've
been repeatedly advising you to work with him and others to make it
happen. You can choose to ignore this advise, but that doesn't make this
patch an acceptable approach.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
