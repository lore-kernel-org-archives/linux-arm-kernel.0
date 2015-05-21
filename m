From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 21 May 2015 19:00:02 +0200
Subject: [PATCH soc] ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
In-Reply-To: <1432161344-1930-1-git-send-email-stefan@agner.ch>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
Message-ID: <CAGhQ9VxkGh_V0ctb1U7Y5UZ36qa-7ZPPW2xsg07m4SHhXmXeJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 21 May 2015 at 00:35, Stefan Agner <stefan@agner.ch> wrote:
> Use the new config symbol ARM_SINGLE_ARMV7M which groups config
> symbols used by modern ARMv7-M platforms. This allows supporting
> multiple ARMv7-M platforms in one kernel image. However, a common
> kernel image requires the combined platforms to share the same
> main memory layout to be bootable.
>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

You should have your sign-off on the top and not Uwe's ack.

> ---
> Since this is essentially only a shift of config symbols, it
> should not change runtime behavior, at least when selecting
> only one platform.
>
> Uwe, this is essentially the same I had in my patchset, just
> converting the other platforms too. I was bold and added your
> Ack anyway...
>
> Joachim, Maxime, I test compiled with your defconfigs, compiled
> fine on my machine.
>
>  arch/arm/Kconfig       | 86 ++++++++++++++++++--------------------------------
>  arch/arm/Kconfig.debug |  5 ++-
>  2 files changed, 32 insertions(+), 59 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 75920ed..9b777e3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -334,6 +334,7 @@ config ARM_SINGLE_ARMV7M
>         depends on !MMU
>         select ARCH_WANT_OPTIONAL_GPIOLIB
>         select ARM_NVIC
> +       select AUTO_ZRELADDR
>         select CLKSRC_OF
>         select COMMON_CLK
>         select CPU_V7M
> @@ -411,24 +412,6 @@ config ARCH_EBSA110
>           Ethernet interface, two PCMCIA sockets, two serial ports and a
>           parallel port.
[...]
> -config ARCH_LPC18XX
> -       bool "NXP LPC18xx/LPC43xx"
> -       depends on !MMU
> -       select ARCH_HAS_RESET_CONTROLLER
> -       select ARCH_REQUIRE_GPIOLIB
> -       select ARM_AMBA
> -       select ARM_NVIC
> -       select AUTO_ZRELADDR
> -       select CLKSRC_LPC32XX
> -       select COMMON_CLK
> -       select CPU_V7M
> -       select GENERIC_CLOCKEVENTS
> -       select NO_IOPORT_MAP
> -       select PINCTRL
> -       select SPARSE_IRQ
> -       select USE_OF
> -       help
> -         Support for NXP's LPC18xx Cortex-M3 and LPC43xx Cortex-M4
> -         high performance microcontrollers.
> -
[...]
> +config ARCH_LPC18XX
> +       bool "NXP LPC18xx/LPC43xx"
> +       depends on ARM_SINGLE_ARMV7M
> +       select ARCH_HAS_RESET_CONTROLLER
> +       select ARM_AMBA
> +       select CLKSRC_LPC32XX
> +       select PINCTRL
> +       help
> +         Support for NXP's LPC18xx Cortex-M3 and LPC43xx Cortex-M4
> +         high performance microcontrollers.

The LPC18xx parts look good and it still builds and boots on my devkit so;

Acked-by: Joachim Eastwood <manabian@gmail.com>

regards,
Joachim Eastwood
