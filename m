From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 26 Jul 2013 12:54:45 +0200
Subject: [PATCH] pinctrl: sunxi: Fix gpio_set behaviour
In-Reply-To: <1374748876-23461-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1374748876-23461-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130726125445.612b2acf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

On Thu, 25 Jul 2013 12:41:16 +0200, Maxime Ripard wrote:
> The current gpio_set function is ignoring the previous value set in the
> GPIO value register, which leads in erasing the values already set for
> the other GPIOs in the same bank when setting the value of a given GPIO.
> 
> Add the usual read/mask/write pattern to fix this brown paper bag bug.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/pinctrl/pinctrl-sunxi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
> index fc058b6..4f8bb18 100644
> --- a/drivers/pinctrl/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/pinctrl-sunxi.c
> @@ -464,8 +464,14 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
>  	struct sunxi_pinctrl *pctl = dev_get_drvdata(chip->dev);
>  	u32 reg = sunxi_data_reg(offset);
>  	u8 index = sunxi_data_offset(offset);
> +	u32 regval = readl(pctl->membase + reg);
>  
> -	writel((value & DATA_PINS_MASK) << index, pctl->membase + reg);
> +	if (value)
> +		regval |= BIT(index);
> +	else
> +		regval &= ~(BIT(index));
> +
> +	writel(regval, pctl->membase + reg);

Hum, what about locking?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
