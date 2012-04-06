From: cjb@laptop.org (Chris Ball)
Date: Fri, 06 Apr 2012 00:04:22 -0400
Subject: [PATCH v7 09/11] ARM: pxa: change gpio to platform device
In-Reply-To: <1320806851-13928-10-git-send-email-haojian.zhuang@marvell.com>
 (Haojian Zhuang's message of "Wed, 9 Nov 2011 10:47:29 +0800")
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
 <1320806851-13928-10-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <87pqbl5wvt.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Tue, Nov 08 2011, Haojian Zhuang wrote:
> Remove most gpio macros and change gpio driver to platform driver.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Please could you help me understand how this patch (which was merged
in 3.2) relates to mach-mmp's use of gpio-pxa?  The patch changes
pxa_gpio_probe() to check for gpio0/gpio1/gpio_mux in platform data:

[..]
> +static int __devinit pxa_gpio_probe(struct platform_device *pdev)
>  {
>  	struct pxa_gpio_chip *c;
> +	struct resource *res;
>  	int gpio, irq;
> +	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
>  
>  	pxa_last_gpio = pxa_gpio_nums();
>  	if (!pxa_last_gpio)
> -		return;
> +		return -EINVAL;
> +
> +	irq0 = platform_get_irq_byname(pdev, "gpio0");
> +	irq1 = platform_get_irq_byname(pdev, "gpio1");
> +	irq_mux = platform_get_irq_byname(pdev, "gpio_mux");
> +	if ((irq0 > 0 && irq1 <= 0) || (irq0 <= 0 && irq1 > 0)
> +		|| (irq_mux <= 0))
> +		return -EINVAL;

But the patch only adds these resources to arch/arm/mach-pxa/devices.c:

[..]
> diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
> index 2e04254..5bc1312 100644
> --- a/arch/arm/mach-pxa/devices.c
> +++ b/arch/arm/mach-pxa/devices.c
> @@ -1051,6 +1051,36 @@ struct platform_device pxa3xx_device_ssp4 = {
>  };
>  #endif /* CONFIG_PXA3xx || CONFIG_PXA95x */
>  
> +struct resource pxa_resource_gpio[] = {
> +	{
> +		.start	= 0x40e00000,
> +		.end	= 0x40e0ffff,
> +		.flags	= IORESOURCE_MEM,
> +	}, {
> +		.start	= IRQ_GPIO0,
> +		.end	= IRQ_GPIO0,
> +		.name	= "gpio0",
> +		.flags	= IORESOURCE_IRQ,
> +	}, {
> +		.start	= IRQ_GPIO1,
> +		.end	= IRQ_GPIO1,
> +		.name	= "gpio1",
> +		.flags	= IORESOURCE_IRQ,
> +	}, {
> +		.start	= IRQ_GPIO_2_x,
> +		.end	= IRQ_GPIO_2_x,
> +		.name	= "gpio_mux",
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device pxa_device_gpio = {
> +	.name		= "pxa-gpio",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
> +	.resource	= pxa_resource_gpio,
> +};

and not anywhere under arch/arm/mach-mmp, which means that when we look
for these names on a mach-mmp device (in my case, OLPC XO-1.75/MMP2),
we hit the "return -EINVAL" above due to the missing platform resources.
Using gpio-pxa on mach-mmp devices worked fine on kernels before 3.2.

How is this supposed to work for mach-mmp boards?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
