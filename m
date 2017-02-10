From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Feb 2017 15:25:17 -0800
Subject: [PATCH] pinctrl: qcom: add get_direction function
In-Reply-To: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
References: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
Message-ID: <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2017 03:21 PM, Timur Tabi wrote:
> The get_direction callback function allows gpiolib to know the current
> direction (input vs output) for a given GPIO.
>
> This is particularly useful on ACPI systems, where the GPIOs are
> configured only by firmware (typically UEFI), so the only way to
> know the initial values to query the hardware directly.  Without
> this function, gpiolib thinks that all GPIOs are configured for
> input.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index f8e9e1c..c978be5 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -422,6 +422,20 @@ static int msm_gpio_direction_output(struct gpio_chip *chip, unsigned offset, in
>  	return 0;
>  }
>  
> +static int msm_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct msm_pinctrl *pctrl = gpiochip_get_data(chip);
> +	const struct msm_pingroup *g;
> +	u32 val;
> +
> +	g = &pctrl->soc->groups[offset];
> +
> +	val = readl(pctrl->regs + g->ctl_reg);
> +
> +	/* 0 = output, 1 = input */
> +	return val & BIT(g->oe_bit) ? 0 : 1;

Maybe we can use the macros GPIOF_DIR_IN and GPIOF_DIR_OUT here instead?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
