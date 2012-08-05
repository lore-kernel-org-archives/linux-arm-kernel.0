From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 05 Aug 2012 11:31:40 +0300
Subject: [PATCH 1/2] GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and
 pxa_irq_to_chip()
In-Reply-To: <1343230539-7196-1-git-send-email-zonque@gmail.com>
References: <1343230539-7196-1-git-send-email-zonque@gmail.com>
Message-ID: <501E2F6C.4050507@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 07/25/12 18:35, Daniel Mack wrote:
> Simplify the code in gpio-pxa.c and make them based on irq_base.
> When not probed from devicetree, initialize irq_base from
> PXA_GPIO_TO_IRQ() or MMP_GPIO_TO_IRQ(), respectively, so the non-DT case
> still works.
> 
> Only tested on PXA3xx.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/gpio/gpio-pxa.c |   70 +++++++++++------------------------------------
>  1 file changed, 16 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
> index 58a6a63..6d0cb9d 100644
> --- a/drivers/gpio/gpio-pxa.c
> +++ b/drivers/gpio/gpio-pxa.c

[...]

> @@ -564,10 +516,20 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
>  	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
>  
>  	ret = pxa_gpio_probe_dt(pdev);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		pxa_last_gpio = pxa_gpio_nums();
> -	else
> +#ifdef CONFIG_ARCH_PXA
> +		if (gpio_is_pxa_type(gpio_type))
> +			irq_base = PXA_GPIO_TO_IRQ(0);
> +#endif
> +#ifdef CONFIG_ARCH_MMP
> +		if (gpio_is_mmp_type(gpio_type))
> +			irq_base = MMP_GPIO_TO_IRQ(0);
> +#endif

The ifdes above do not look essential.
Can't we drop them and just have else if ... else if?

> +	} else {
>  		use_of = 1;
> +	}
> +
>  	if (!pxa_last_gpio)
>  		return -EINVAL;
>  

-- 
Regards,
Igor.
