From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Nov 2014 18:53:29 +0100
Subject: [PATCH 06/17] gpio: mvebu: add suspend/resume support
In-Reply-To: <1414151970-6626-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5457C119.90809@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/10/2014 13:59, Thomas Petazzoni wrote:
> This commit adds the implementation of ->suspend() and ->resume()
> platform_driver hooks in order to save and restore the state of the
> GPIO configuration. In order to achieve that, additional fields are
> added to the mvebu_gpio_chip structure.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-gpio at vger.kernel.org
> ---
>  drivers/gpio/gpio-mvebu.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 418e386..dd5545c 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -83,6 +83,14 @@ struct mvebu_gpio_chip {
>  	int		   irqbase;
>  	struct irq_domain *domain;
>  	int                soc_variant;
> +
> +	/* Used to preserve GPIO registers accross suspend/resume */
                                           across

> +	u32                out_reg;
> +	u32                io_conf_reg;
> +	u32                blink_en_reg;
> +	u32                in_pol_reg;
> +	u32                edge_mask_regs[4];
> +	u32                level_mask_regs[4];
>  };
>  
>  /*
> @@ -554,6 +562,93 @@ static const struct of_device_id mvebu_gpio_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mvebu_gpio_of_match);
>  
> +static int mvebu_gpio_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct mvebu_gpio_chip *mvchip = platform_get_drvdata(pdev);
> +	int i;
> +
> +	mvchip->out_reg = readl(mvebu_gpioreg_out(mvchip));
> +	mvchip->io_conf_reg = readl(mvebu_gpioreg_io_conf(mvchip));
> +	mvchip->blink_en_reg = readl(mvebu_gpioreg_blink(mvchip));
> +	mvchip->in_pol_reg = readl(mvebu_gpioreg_in_pol(mvchip));
> +
> +	switch (mvchip->soc_variant) {
> +	case MVEBU_GPIO_SOC_VARIANT_ORION:
> +		mvchip->edge_mask_regs[0] =
> +			readl(mvchip->membase + GPIO_EDGE_MASK_OFF);
> +		mvchip->level_mask_regs[0] =
> +			readl(mvchip->membase + GPIO_LEVEL_MASK_OFF);
> +		break;
> +	case MVEBU_GPIO_SOC_VARIANT_MV78200:
> +		for (i = 0; i < 2; i++) {
> +			mvchip->edge_mask_regs[i] =
> +				readl(mvchip->membase +
> +				      GPIO_EDGE_MASK_MV78200_OFF(i));
> +			mvchip->level_mask_regs[i] =
> +				readl(mvchip->membase +
> +				      GPIO_LEVEL_MASK_MV78200_OFF(i));
> +		}
> +		break;

I don't know if the suspend is supported on this platform but as we were
on the road to remove this platform I don't know it it worth testing it unless
some interested users show up.

I didn't tested it on a mv782xx platform but the patch looks correct:

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
