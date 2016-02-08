From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 8 Feb 2016 11:55:35 -0500
Subject: [PATCH 1/2] serial: 8250: fix building mediatek with SERIAL_8250=m
In-Reply-To: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
References: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
Message-ID: <20160208165535.GZ23093@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[[PATCH 1/2] serial: 8250: fix building mediatek with SERIAL_8250=m] On 08/02/2016 (Mon 13:51) Arnd Bergmann wrote:

> The Mediatek 8250 driver has a 'bool' Kconfig symbol, but that
> breaks when SERIAL_8250 is a loadable module:
> 
> drivers/tty/built-in.o: In function `mtk8250_set_termios':
> 8250_ingenic.c:(.text+0x1bee8): undefined reference to `serial8250_do_set_termios'
> 8250_ingenic.c:(.text+0x1bf10): undefined reference to `uart_get_baud_rate'
> 8250_ingenic.c:(.text+0x1c09c): undefined reference to `uart_get_divisor'
> drivers/tty/built-in.o: In function `mtk8250_do_pm':
> 8250_ingenic.c:(.text+0x1c0d0): undefined reference to `serial8250_do_pm'
> drivers/tty/built-in.o: In function `mtk8250_probe':
> 8250_ingenic.c:(.text+0x1c2e4): undefined reference to `serial8250_register_8250_port'
> serial/8250/8250_mtk.c:287:242: error: data definition has no type or storage class [-Werror]
> serial/8250/8250_mtk.c:287:122: error: 'mtk8250_platform_driver_init' defined but not used [-Werror=unused-function]

Probably should drop the ingenic lines above ; assuming they are make -j N
related and that mtk doesn't depend on or build ingenic.

> 
> This changes the symbol to a 'tristate', so the dependency on
> SERIAL_8250 also works when that is set to 'm'.
> To actually build the driver, we also need to include <linux/module.h>.
> 
> Note that the driver uses builtin_platform_driver() and implements
> no .remove() callback, so unloading the module is not possible.

But this is due to d72d391c126e0ffd3047c06c4bef4d795853d5d5.  So again,
I'm not sure what this achives vs. just making it depend on having
SERIAL_8250=y as a trivial fix for the one build issue.

If you really see a use case for tristate, then the above should be
reverted before adding your conversion to tristate I think.

Paul.
--

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 1 +
>  drivers/tty/serial/8250/Kconfig    | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 9038843cadc7..7e9242a5ddfe 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -19,6 +19,7 @@
>  #include <linux/init.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/serial_8250.h>
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 67ad6b0d595b..6ae0fae4f796 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -370,7 +370,7 @@ config SERIAL_8250_LPC18XX
>  	  serial port, say Y to this option. If unsure, say Y.
>  
>  config SERIAL_8250_MT6577
> -	bool "Mediatek serial port support"
> +	tristate "Mediatek serial port support"
>  	depends on SERIAL_8250 && ARCH_MEDIATEK
>  	help
>  	  If you have a Mediatek based board and want to use the
> -- 
> 2.7.0
> 
