From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Nov 2013 20:06:31 +0100
Subject: [PATCH v7] gpio: Add MOXA ART GPIO driver
In-Reply-To: <1385723494-8033-1-git-send-email-jonas.jensen@gmail.com>
References: <1385651945-22355-1-git-send-email-jonas.jensen@gmail.com>
 <1385723494-8033-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201311292006.31661.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 November 2013, Jonas Jensen wrote:
> Add GPIO driver for MOXA ART SoCs.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

One more comment, no need to resend for another review if this is the only
thing you want to change:

> +struct moxart_gpio_chip {
> +	struct gpio_chip gpio;
> +	void __iomem *moxart_gpio_base;
> +};

If you rename 'moxart_gpio_base' to 'base'

> +static int moxart_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct moxart_gpio_chip *gc = to_moxart_gpio(chip);
> +	u32 ret = readl(gc->moxart_gpio_base + GPIO_PIN_DIRECTION);
> +
> +	if (ret & BIT(offset))
> +		return !!(readl(gc->moxart_gpio_base + GPIO_DATA_OUT) &
> +			  BIT(offset));
> +	else
> +		return !!(readl(gc->moxart_gpio_base + GPIO_DATA_IN) &
> +			  BIT(offset));
> +}

These will fit in one line with no loss of readability.

	Arnd
