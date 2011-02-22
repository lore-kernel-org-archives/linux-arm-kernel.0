From: konkers@android.com (Erik Gilling)
Date: Tue, 22 Feb 2011 11:18:08 -0800
Subject: [PATCH 1/6] ARM: tegra: add tegra_gpio_table and tegra_gpio_config
In-Reply-To: <1298354117-19097-2-git-send-email-olof@lixom.net>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-2-git-send-email-olof@lixom.net>
Message-ID: <AANLkTik9_t0mq07mysO2CcK4ppKAmuPAujownfeWEGL5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can you split the boardfile changes into their own patch?  Also see
the below whitespace only change.  Other than that, looks good.

On Mon, Feb 21, 2011 at 9:55 PM, Olof Johansson <olof@lixom.net> wrote:
snip
> diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
> index 132dcd6..ffc146d 100644
> --- a/arch/arm/mach-tegra/gpio.c
> +++ b/arch/arm/mach-tegra/gpio.c
> @@ -378,9 +378,22 @@ static int __init tegra_gpio_init(void)
>
> ? ? ? ?return 0;
> ?}
> -
> ?postcore_initcall(tegra_gpio_init);

whitespace only change

>
> +void __init tegra_gpio_config(struct tegra_gpio_table *table, int num)
> +{
> + ? ? ? int i;
> +
> + ? ? ? for (i = 0; i < num; i++) {
> + ? ? ? ? ? ? ? int gpio = table[i].gpio;
> +
> + ? ? ? ? ? ? ? if (table[i].enable)
> + ? ? ? ? ? ? ? ? ? ? ? tegra_gpio_enable(gpio);
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? tegra_gpio_disable(gpio);
> + ? ? ? }
> +}
> +
> ?#ifdef CONFIG_DEBUG_FS
>
> ?#include <linux/debugfs.h>
> diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
> index e31f486..2369fba 100644
> --- a/arch/arm/mach-tegra/include/mach/gpio.h
> +++ b/arch/arm/mach-tegra/include/mach/gpio.h
> @@ -20,6 +20,7 @@
> ?#ifndef __MACH_TEGRA_GPIO_H
> ?#define __MACH_TEGRA_GPIO_H
>
> +#include <linux/init.h>
> ?#include <mach/irqs.h>
>
> ?#define TEGRA_NR_GPIOS ? ? ? ? INT_GPIO_NR
> @@ -47,6 +48,12 @@ static inline int irq_to_gpio(unsigned int irq)
> ? ? ? ?return -EINVAL;
> ?}
>
> +struct tegra_gpio_table {
> + ? ? ? int ? ? gpio; ? /* GPIO number */
> + ? ? ? bool ? ?enable; /* Enable for GPIO at init? */
> +};
> +
> +void __init tegra_gpio_config(struct tegra_gpio_table *table, int num);
> ?void tegra_gpio_enable(int gpio);
> ?void tegra_gpio_disable(int gpio);
>
> --
> 1.7.0.4
>
>
