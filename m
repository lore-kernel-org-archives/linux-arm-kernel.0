From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 15 Dec 2010 10:09:16 +0800
Subject: [PATCH 16/16] ARM: w90x900: Switch over to gpiolib ->to_irq() and
	__gpio_to_irq().
In-Reply-To: <20101215020403.GI15575@mail.wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
	<20101215020403.GI15575@mail.wantstofly.org>
Message-ID: <AANLkTikS4VBWmFhQxkp9vYi4DnJc5cuzS1bHaL6WPrw2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/15 Lennert Buytenhek <buytenh@wantstofly.org>:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---
> ?arch/arm/mach-w90x900/gpio.c ? ? ? ? ? ? ?| ? ?6 ++++++
> ?arch/arm/mach-w90x900/include/mach/gpio.h | ? ?6 +-----
> ?2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-w90x900/gpio.c b/arch/arm/mach-w90x900/gpio.c
> index ba05aec..dbf1825 100644
> --- a/arch/arm/mach-w90x900/gpio.c
> +++ b/arch/arm/mach-w90x900/gpio.c
> @@ -40,6 +40,7 @@
> ? ? ? ? ? ? ? ? ? ? ? ?.direction_output = nuc900_dir_output, ? ? ? ? ?\
> ? ? ? ? ? ? ? ? ? ? ? ?.get ? ? ? ? ? ? ?= nuc900_gpio_get, ? ? ? ? ? ?\
> ? ? ? ? ? ? ? ? ? ? ? ?.set ? ? ? ? ? ? ?= nuc900_gpio_set, ? ? ? ? ? ?\
> + ? ? ? ? ? ? ? ? ? ? ? .to_irq ? ? ? ? ? = nuc900_gpio_to_irq, ? ? ? ? \
> ? ? ? ? ? ? ? ? ? ? ? ?.base ? ? ? ? ? ? = base_gpio, ? ? ? ? ? ? ? ? ?\
> ? ? ? ? ? ? ? ? ? ? ? ?.ngpio ? ? ? ? ? ?= nr_gpio, ? ? ? ? ? ? ? ? ? ?\
> ? ? ? ? ? ? ? ?} ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> @@ -130,6 +131,11 @@ static int nuc900_dir_output(struct gpio_chip *chip, unsigned offset, int val)
> ? ? ? ?return 0;
> ?}
>
> +static int nuc900_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> + ? ? ? return chip->base + offset;
> +}
> +
> ?static struct nuc900_gpio_chip nuc900_gpio[] = {
> ? ? ? ?NUC900_GPIO_CHIP("GROUPC", 0, 16),
> ? ? ? ?NUC900_GPIO_CHIP("GROUPD", 16, 10),
> diff --git a/arch/arm/mach-w90x900/include/mach/gpio.h b/arch/arm/mach-w90x900/include/mach/gpio.h
> index 034da3e..f9b9a37 100644
> --- a/arch/arm/mach-w90x900/include/mach/gpio.h
> +++ b/arch/arm/mach-w90x900/include/mach/gpio.h
> @@ -20,11 +20,7 @@
> ?#define gpio_get_value __gpio_get_value
> ?#define gpio_set_value __gpio_set_value
> ?#define gpio_cansleep ?__gpio_cansleep
> -
> -static inline int gpio_to_irq(unsigned gpio)
> -{
> - ? ? ? return gpio;
> -}
> +#define gpio_to_irq ? ?__gpio_to_irq
>
> ?static inline int irq_to_gpio(unsigned irq)
> ?{

Acked-by : Wan zongshun <mcuos.com@gmail.com>
> --
> 1.7.1
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
