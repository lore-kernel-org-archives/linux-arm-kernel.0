From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Dec 2014 09:42:31 +0100
Subject: [PATCH v3 1/2] ARM: hip04: set ARCH_NR_GPIO to 128
In-Reply-To: <547D5FA7.3040307@gmail.com>
References: <1417156188-500-1-git-send-email-wangzhou.bry@gmail.com>
 <CACRpkdb1nZN-vOXLC-QFUAT9wDGM2Nm5YeH0qY_u2JV9toOaVg@mail.gmail.com>
 <547D5FA7.3040307@gmail.com>
Message-ID: <142367414.tx9doeBDv9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 December 2014 14:43:51 Zhou Wang wrote:
> 
> how about a patch like this, we read the base from the dts here.
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index e8e98ca..0c40f53 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -107,11 +107,16 @@ struct gpio_chip *gpiod_to_chip(const struct 
> gpio_desc *desc)
>   EXPORT_SYMBOL_GPL(gpiod_to_chip);
> 
>   /* dynamic allocation of GPIOs, e.g. on a hotplugged device */
> -static int gpiochip_find_base(int ngpio)
> +static int gpiochip_find_base(struct gpio_chip *gpio_chip)
>   {
>          struct gpio_chip *chip;
> +       int ngpio = gpio_chip->ngpio;
>          int base = ARCH_NR_GPIOS - ngpio;
> 
> +       /* just prototype */
> +       if (!of_property_read_u32(gpio_chip->dev->of_node, "base", &base))
> +               return base;
> +

I don't think that would be appropriate. The concept of a gpio number
base is implementation specific to current Linux versions and we want
to get rid of that in the future, so it should not be part of an
OS-independent spec.

	Arnd
