From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 13 Jun 2011 09:04:16 -0600
Subject: [PATCH] gpio/74x164: fix clash with gpiolib namespace
In-Reply-To: <1307954835-20812-1-git-send-email-linus.walleij@stericsson.com>
References: <1307954835-20812-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110613150416.GC18161@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 10:47:15AM +0200, Linus Walleij wrote:
> The 74x164 GPIO driver has a static inline helper called
> gpio_to_chip which clashes with the gpiolib namespace if we
> try to expose the function with the same name from gpiolib,
> and it's still confusing even if we don't do that. So rename
> it to gpio_to_74x164_chip().
> 
> Reported-by: H Hartley Sweeten <hartleys@visionengravers.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

Merged, thanks.

g.

> ---
>  drivers/gpio/gpio-74x164.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
> index 7fb60b6..ff525c0 100644
> --- a/drivers/gpio/gpio-74x164.c
> +++ b/drivers/gpio/gpio-74x164.c
> @@ -23,7 +23,7 @@ struct gen_74x164_chip {
>  	u8			port_config;
>  };
>  
> -static struct gen_74x164_chip *gpio_to_chip(struct gpio_chip *gc)
> +static struct gen_74x164_chip *gpio_to_74x164_chip(struct gpio_chip *gc)
>  {
>  	return container_of(gc, struct gen_74x164_chip, gpio_chip);
>  }
> @@ -36,7 +36,7 @@ static int __gen_74x164_write_config(struct gen_74x164_chip *chip)
>  
>  static int gen_74x164_get_value(struct gpio_chip *gc, unsigned offset)
>  {
> -	struct gen_74x164_chip *chip = gpio_to_chip(gc);
> +	struct gen_74x164_chip *chip = gpio_to_74x164_chip(gc);
>  	int ret;
>  
>  	mutex_lock(&chip->lock);
> @@ -49,7 +49,7 @@ static int gen_74x164_get_value(struct gpio_chip *gc, unsigned offset)
>  static void gen_74x164_set_value(struct gpio_chip *gc,
>  		unsigned offset, int val)
>  {
> -	struct gen_74x164_chip *chip = gpio_to_chip(gc);
> +	struct gen_74x164_chip *chip = gpio_to_74x164_chip(gc);
>  
>  	mutex_lock(&chip->lock);
>  	if (val)
> -- 
> 1.7.3.2
> 
