From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 17 Aug 2010 14:51:30 +0900
Subject: [PATCH 3/5] ARM: S5PC110: gpio_to_irq support on external
	interrupt
In-Reply-To: <20100805072544.GA22271@july>
References: <20100805072544.GA22271@july>
Message-ID: <AANLkTimL2And_8-vBvQUSJerYUhKFyH3ycr761Q3UQEx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think it's also bug fix since current external IRQ can't support
'gpio_to_irq' feature.
I hope it's included at this rc window.

On Thu, Aug 5, 2010 at 4:25 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> Using group field, it can calculate the related irq number easily.
> Also if don't support gpio_to_irq, it can't use the gpio functionaliy fully.
> e.g., can't use the gpio-keys and so on
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> ?arch/arm/mach-s5pv210/gpiolib.c | ? 12 ++++++++++++
> ?1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
> index f6a32c4..bd24c81 100644
> --- a/arch/arm/mach-s5pv210/gpiolib.c
> +++ b/arch/arm/mach-s5pv210/gpiolib.c
> @@ -246,6 +246,15 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
> ? ? ? ?},
> ?};
>
> +static int s5pv210_extint_to_irq(struct gpio_chip *gpio, unsigned int offset)
> +{
> + ? ? ? struct s3c_gpio_chip *chip = to_s3c_gpio(gpio);
> + ? ? ? int irq;
> +
> + ? ? ? irq = (chip->group * 8) + offset;
> + ? ? ? return IRQ_EINT(irq);
> +}
> +
> ?static __init int s5pv210_gpiolib_init(void)
> ?{
> ? ? ? ?struct s3c_gpio_chip *chip = s5pv210_gpio_4bit;
> @@ -257,6 +266,9 @@ static __init int s5pv210_gpiolib_init(void)
> ? ? ? ? ? ? ? ? ? ? ? ?chip->config = &gpio_cfg;
> ? ? ? ? ? ? ? ?if (chip->config == &gpio_cfg_extint) {
> ? ? ? ? ? ? ? ? ? ? ? ?chip->base = S5PV210_BANK_BASE(extint) + EXTINT_OFFSET;
> + ? ? ? ? ? ? ? ? ? ? ? /* Assign the external GPIO interrupt group number */
> + ? ? ? ? ? ? ? ? ? ? ? chip->group = extint;
> + ? ? ? ? ? ? ? ? ? ? ? chip->chip.to_irq = s5pv210_extint_to_irq;
> ? ? ? ? ? ? ? ? ? ? ? ?extint++;
> ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?if (chip->base == NULL)
> --
> 1.5.3.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
