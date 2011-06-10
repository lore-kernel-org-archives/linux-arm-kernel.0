From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 10 Jun 2011 10:57:33 -0500
Subject: [PATCH 1/2] gpio: expose gpio_to_chip()
In-Reply-To: <1307695752-28051-1-git-send-email-linus.walleij@stericsson.com>
References: <1307695752-28051-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3820B879F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 10, 2011 1:49 AM, Linus Walleij wrote:
>
> This makes the gpio_to_chip() function available to drivers. The
> usecase is when you want to add a few chip-specific operations
> apart from the ones exposed in struct gpio_chip.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpiolib.c     |    2 +-
>  include/asm-generic/gpio.h |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index a971e3d..dc315e9 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -114,7 +114,7 @@ static int gpio_ensure_requested(struct gpio_desc *desc, unsigned offset)
>  }
> 
>  /* caller holds gpio_lock *OR* gpio is marked as requested */
> -static inline struct gpio_chip *gpio_to_chip(unsigned gpio)
> +struct gpio_chip *gpio_to_chip(unsigned gpio)
>  {
>  	return gpio_desc[gpio].chip;
>  }
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index fcdcb5d..dd8c815 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -132,6 +132,7 @@ struct gpio_chip {
>  #endif
>  };
> 
> +extern struct gpio_chip *gpio_to_chip(unsigned gpio);
>  extern const char *gpiochip_is_requested(struct gpio_chip *chip,
> 			unsigned offset);
>  extern int __must_check gpiochip_reserve(int start, int ngpio);

Linus,

You'll need to fix a couple drivers for this to work.  The symbol gpio_to_chip
is a static symbol in a couple places other than gpiolib.c.


arch/arm/plat-pxa/gpio.c:static inline struct pxa_gpio_chip *gpio_to_chip(unsigned gpio)
drivers/gpio/gpio-74x164.c:static struct gen_74x164_chip *gpio_to_chip(struct gpio_chip *gc)

Regards,
Hartley
