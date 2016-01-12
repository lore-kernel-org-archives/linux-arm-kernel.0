From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 11 Jan 2016 17:24:46 -0800
Subject: [PATCH -next] arm: Select GPIO_GENERIC_PLATFORM for CRAGG_6410
In-Reply-To: <56944E49.3040707@samsung.com>
References: <1452531649-14940-1-git-send-email-linux@roeck-us.net>
 <56944E49.3040707@samsung.com>
Message-ID: <569455DE.1010905@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2016 04:52 PM, Krzysztof Kozlowski wrote:
> On 12.01.2016 02:00, Guenter Roeck wrote:
>> Since commit 0f4630f3720e ("gpio: generic: factor into gpio_chip struct"),
>> all users of struct bgpio_pdata depend on GPIO_GENERIC.
>>
>> This results in the following build error.
>>
>> arch/arm/mach-s3c64xx/mach-crag6410.c:270:3: warning:
>> 	excess elements in struct initializer
>> arch/arm/mach-s3c64xx/mach-crag6410.c:270:3: warning:
>> 	(near initialization for '(anonymous)')
>> arch/arm/mach-s3c64xx/mach-crag6410.c:271:2: error:
>> 	invalid use of undefined type 'struct bgpio_pdata'
>>
>> Fixes: 0f4630f3720e ("gpio: generic: factor into gpio_chip struct")
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> I don't know if this is the correct way to fix this problem.
>> If not, please consider this to be a bug report.
>>
>>   arch/arm/mach-s3c64xx/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>
> Thanks for the report! I think that:
>
> 1. Other boards using the bgpio_pdata might be also affected:
> mach-clps711x/board-autcpu12.c
> mach-clps711x/board-p720t.c
> mach-imx/mach-mx21ads.c
>
> 2. The boards does not directly depend on the GPIO_GENERIC.
> If GPIO_GENERIC is not selected then it still might create
> a basic-mmio-gpio device. The device of course won't be in
> such case supported by any driver.
>
>
> Instead to solve the error the structure should be
> always visible so:
>
>
> -- >8 --
> From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Date: Tue, 12 Jan 2016 09:46:06 +0900
> Subject: [PATCH] gpio: generic: Fix build error of missing bgpio_pdata
>   declaration
>
> Commit 0f4630f3720e ("gpio: generic: factor into gpio_chip struct")
> introduced struct bgpio_pdata along with users but made the declaration
> hidden by CONFIG_GPIO_GENERIC.
>
> This results in the following build error:
>
> arch/arm/mach-s3c64xx/mach-crag6410.c:270:3: warning: 	excess elements in struct initializer
> arch/arm/mach-s3c64xx/mach-crag6410.c:270:3: warning:	(near initialization for '(anonymous)')
> arch/arm/mach-s3c64xx/mach-crag6410.c:271:2: error:	invalid use of undefined type 'struct bgpio_pdata'
>
> Fixes: 0f4630f3720e ("gpio: generic: factor into gpio_chip struct")
> Reported-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>   include/linux/gpio/driver.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index e2d05fd0e6e3..7b9054366e7a 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -220,14 +220,13 @@ static inline void *gpiochip_get_data(struct gpio_chip *chip)
>
>   struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc);
>
> -#if IS_ENABLED(CONFIG_GPIO_GENERIC)
> -
>   struct bgpio_pdata {
>   	const char *label;
>   	int base;
>   	int ngpio;
>   };
>
> +#if IS_ENABLED(CONFIG_GPIO_GENERIC)
>   int bgpio_init(struct gpio_chip *gc, struct device *dev,
>   	       unsigned long sz, void __iomem *dat, void __iomem *set,
>   	       void __iomem *clr, void __iomem *dirout, void __iomem *dirin,
>
