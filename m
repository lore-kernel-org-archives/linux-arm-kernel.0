From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 15 Jan 2014 14:41:01 +0530
Subject: [PATCH] ARM: S3C[24|64]xx: move includes back under <mach/> scope
In-Reply-To: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
References: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAHbNUh29qGSt-isqOAdVVO3x0w2mDTVnKeH+Sc_rkfkOiXc_mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 January 2014 19:23, Linus Walleij <linus.walleij@linaro.org> wrote:
> When refactoring and breaking out the includes for the
> machine-specific GPIO configuration, two files were created
> in <linux/platform_data/gpio-samsung-s3c[24|64]xx.h>, but as
> that namespace shall be used for defining data exchanged
> between machines and drivers, using it for these broad macros
> and config settings is wrong.
>
> Move the headers back into the machine-local
> <mach/gpio-samsung.h> file and think about the next step.
>

<snip>

> diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
> index c4efa1c2a5d1..a9f7a37c4173 100644
> --- a/arch/arm/plat-samsung/pm-gpio.c
> +++ b/arch/arm/plat-samsung/pm-gpio.c
> @@ -19,12 +19,7 @@
>  #include <linux/io.h>
>  #include <linux/gpio.h>
>
> -#ifdef CONFIG_ARCH_S3C24XX
> -#include <linux/platform_data/gpio-samsung-s3c24xx.h>
> -#endif
> -#ifdef CONFIG_ARCH_S3C64XX
> -#include <linux/platform_data/gpio-samsung-s3c64xx.h>
> -#endif
> +#include <mach/gpio-samsung.h>

This inclusion should be protected by a check for CONFIG_ARCH_S3C24XX
|| CONFIG_ARCH_S3C64XX. Currently generating build errors for
s5p64x0_defconfig, s5pc100_defconfig and s5pv210_defconfig on
next-20140115.

-- 
Tushar Behera
