From: robherring2@gmail.com (Rob Herring)
Date: Wed, 16 Apr 2014 13:51:17 -0500
Subject: [PATCH] clocksource: efm32: let CLKSRC_EFM32 select CLKSRC_OF
In-Reply-To: <1397673612-24247-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <CAL_JsqKXYOdpCkixBLg8kAXwpkaLHhckJnTkzdNVeOQDYzxK3w@mail.gmail.com>
 <1397673612-24247-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAL_Jsq+Wm-jxeZoYXpC+W3Was5WTS2UqLJ__N5uPB43ZHUmrLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 1:40 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> The efm32 timer driver is only usable with CLKSRC_OF, so it makes sense
> to let its Kconfig symbol select it. For compile coverage testing it's not
> needed though, so only select it if ARCH_EFM32 is enabled.
>
> This allows to drop ARCH_EFM32 selecting CLKSRC_OF which is done here
> for simplicity, too.
>
> Reported-by: Rob Herring <robherring2@gmail.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/Kconfig            | 1 -
>  drivers/clocksource/Kconfig | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ab438cb5af55..e345419fb112 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -424,7 +424,6 @@ config ARCH_EFM32
>         select ARCH_REQUIRE_GPIOLIB
>         select AUTO_ZRELADDR
>         select ARM_NVIC
> -       select CLKSRC_OF
>         select COMMON_CLK
>         select CPU_V7M
>         select GENERIC_CLOCKEVENTS
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -80,6 +80,7 @@ config CLKSRC_EFM32
>         bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
>         depends on OF && ARM && (ARCH_EFM32 || COMPILE_TEST)
>         select CLKSRC_MMIO
> +       select CLKSRC_OF if ARCH_EFM32

You already depend on OF, so I believe you don't need the if here.

Rob
