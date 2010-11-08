From: awg@embtoolkit.org (Abdoulaye Walsimou GAYE)
Date: Mon, 08 Nov 2010 22:41:11 +0100
Subject: [PATCH v3] ARM: s3c2442: Setup gpio {set,get}_pull callbacks
In-Reply-To: <1289247983-20747-1-git-send-email-anarsoul@gmail.com>
References: <1289030074-5233-1-git-send-email-anarsoul@gmail.com>
	<1289247983-20747-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4CD86E77.9000906@embtoolkit.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2010 09:26 PM, Vasily Khoruzhick wrote:
> Currently the {set,get}_pull callbacks of the s3c24xx_gpiocfg_default structure
> are initalized via s3c_gpio_{get,set}pull_1up. This results in a linker
> error when compiling kernel for s3c2442:
>
> arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f4): undefined reference to
> `s3c_gpio_getpull_1up'
> arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f8): undefined reference to
> `s3c_gpio_setpull_1up'
>
> The s3c2442 has pulldowns instead of pullups compared to the s3c2440.
> The method of controlling them is the same though.
> So this patch modifies the existing s3c_gpio_{get,set}pull_1up helper functions
> to take an additional parameter deciding whether the pin has a pullup or pulldown.
> The s3c_gpio_{get,set}pull_1{down,up} functions then wrap that functions passing
> either S3C_GPIO_PULL_UP or S3C_GPIO_PULL_DOWN.
>
> Furthermore this patch sets up the s3c24xx_gpiocfg_default.{get,set}_pull fields
> in the s3c2442 cpu init function to the new pulldown helper functions.
>
> Based on patch from "Lars-Peter Clausen"<lars@metafoo.de>
>
> Signed-off-by: Vasily Khoruzhick<anarsoul@gmail.com>
> ---
> v2: adapt patch for 2.6.37-rc1
> v3: restore default pull callbacks, add default pull callbacks for s3c2442
>   arch/arm/mach-s3c2440/Kconfig                      |    1 +
>   arch/arm/mach-s3c2440/s3c2442.c                    |    7 +++
>   arch/arm/plat-s3c24xx/gpiolib.c                    |    9 +++-
>   arch/arm/plat-samsung/gpio-config.c                |   44 ++++++++++++++++---
>   .../plat-samsung/include/plat/gpio-cfg-helpers.h   |   11 +++++
>   5 files changed, 63 insertions(+), 9 deletions(-)
>
>    

Ackey-by: Abdoulaye Walsimou GAYE <awg@embtoolkit.org>

Thanks
