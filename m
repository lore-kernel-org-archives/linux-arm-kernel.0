From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 24 Feb 2016 10:06:37 -0800
Subject: [PATCH 17/50] pinctrl: spmi-gpio: Use devm_pinctrl_register()
 for pinctrl registration
In-Reply-To: <1456319775-3216-18-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-18-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160224180637.GK21240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 24 Feb 05:15 PST 2016, Laxman Dewangan wrote:

> Use devm_pinctrl_register() for pin control registration and clean
> the error path.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Jonas Gorski <jogo@openwrt.org>
> ---

Reviewed-by Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index 4e12ded..330e822 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -764,14 +764,14 @@ static int pmic_gpio_probe(struct platform_device *pdev)
>  	state->chip.of_gpio_n_cells = 2;
>  	state->chip.can_sleep = false;
>  
> -	state->ctrl = pinctrl_register(pctrldesc, dev, state);
> +	state->ctrl = devm_pinctrl_register(dev, pctrldesc, state);
>  	if (IS_ERR(state->ctrl))
>  		return PTR_ERR(state->ctrl);
>  
>  	ret = gpiochip_add_data(&state->chip, state);
>  	if (ret) {
>  		dev_err(state->dev, "can't add gpio chip\n");
> -		goto err_chip;
> +		return ret;
>  	}
>  
>  	ret = gpiochip_add_pin_range(&state->chip, dev_name(dev), 0, 0, npins);
> @@ -784,8 +784,6 @@ static int pmic_gpio_probe(struct platform_device *pdev)
>  
>  err_range:
>  	gpiochip_remove(&state->chip);
> -err_chip:
> -	pinctrl_unregister(state->ctrl);
>  	return ret;
>  }
>  
> @@ -794,7 +792,6 @@ static int pmic_gpio_remove(struct platform_device *pdev)
>  	struct pmic_gpio_state *state = platform_get_drvdata(pdev);
>  
>  	gpiochip_remove(&state->chip);
> -	pinctrl_unregister(state->ctrl);
>  	return 0;
>  }
>  
> -- 
> 2.1.4
> 
