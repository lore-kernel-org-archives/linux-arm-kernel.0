From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 19 Sep 2011 10:36:50 +0200
Subject: [PATCH 2/3] at91/gpio: drop PIN_BASE
In-Reply-To: <1316285923-12461-2-git-send-email-plagnioj@jcrosoft.com>
References: <1316285923-12461-1-git-send-email-plagnioj@jcrosoft.com>
	<1316285923-12461-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4E76FF22.40001@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 17/09/2011 20:58, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/mach-at91/gpio.c              |   54 ++--
>  arch/arm/mach-at91/include/mach/gpio.h |  454 ++++++++++++++++----------------
>  2 files changed, 254 insertions(+), 254 deletions(-)
>  rewrite arch/arm/mach-at91/include/mach/gpio.h (78%)
> 
> diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
> index 04beff1..e709406 100644
> --- a/arch/arm/mach-at91/gpio.c
> +++ b/arch/arm/mach-at91/gpio.c
> @@ -60,18 +60,17 @@ static int at91_gpiolib_direction_input(struct gpio_chip *chip,
>  	}
>  
>  static struct at91_gpio_chip gpio_chip[] = {
> -	AT91_GPIO_CHIP("A", 0x00 + PIN_BASE, 32),
> -	AT91_GPIO_CHIP("B", 0x20 + PIN_BASE, 32),
> -	AT91_GPIO_CHIP("C", 0x40 + PIN_BASE, 32),
> -	AT91_GPIO_CHIP("D", 0x60 + PIN_BASE, 32),
> -	AT91_GPIO_CHIP("E", 0x80 + PIN_BASE, 32),
> +	AT91_GPIO_CHIP("A", 0x00, 32),
> +	AT91_GPIO_CHIP("B", 0x20, 32),
> +	AT91_GPIO_CHIP("C", 0x40, 32),
> +	AT91_GPIO_CHIP("D", 0x60, 32),
> +	AT91_GPIO_CHIP("E", 0x80, 32),
>  };
>  
>  static int gpio_banks;
>  
>  static inline void __iomem *pin_to_controller(unsigned pin)
>  {
> -	pin -= PIN_BASE;
>  	pin /= 32;
>  	if (likely(pin < gpio_banks))
>  		return gpio_chip[pin].regbase;
> @@ -81,7 +80,6 @@ static inline void __iomem *pin_to_controller(unsigned pin)
>  
>  static inline unsigned pin_to_mask(unsigned pin)
>  {
> -	pin -= PIN_BASE;
>  	return 1 << (pin % 32);
>  }
>  
> @@ -276,8 +274,9 @@ static u32 backups[MAX_GPIO_BANKS];
>  
>  static int gpio_irq_set_wake(struct irq_data *d, unsigned state)
>  {
> -	unsigned	mask = pin_to_mask(d->irq);
> -	unsigned	bank = (d->irq - PIN_BASE) / 32;
> +	unsigned	pin = irq_to_gpio(d->irq);

No, we try to remove the use of this irq_to_gpio() function. So we have
to avoid re-introducing it...

[..]

Best regards,
-- 
Nicolas Ferre
