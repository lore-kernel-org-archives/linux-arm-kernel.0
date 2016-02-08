From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 8 Feb 2016 11:45:44 -0500
Subject: [PATCH 2/2] serial: 8250: fix building Ingenic with SERIAL_8250=m
In-Reply-To: <1454935947-2743255-2-git-send-email-arnd@arndb.de>
References: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
 <1454935947-2743255-2-git-send-email-arnd@arndb.de>
Message-ID: <20160208164543.GY23093@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[[PATCH 2/2] serial: 8250: fix building Ingenic with SERIAL_8250=m] On 08/02/2016 (Mon 13:51) Arnd Bergmann wrote:

> The Ingenic 8250 driver has a 'bool' Kconfig symbol, but that
> breaks when SERIAL_8250 is a loadable module:
> 
> drivers/tty/built-in.o: In function `ingenic_uart_probe':
> 8250_ingenic.c:(.text+0x1c1a0): undefined reference to `serial8250_register_8250_port'
> 
> This changes the symbol to a 'tristate', plus a dependency on

Note that Greg just queued a patch yesterday (but sent in 2015) that
removed what was the dead modular code.

It could also depend on SERIAL_8250=y to resolve the build issue you
found, if nobody cares about having modular SOC console UART drivers.

Either way, I don't have issue with it being tristate vs bool, but if
you do go with tristate, then my patch will have to be dropped/reverted.

Paul.
--

> SERIAL_8250, which makes it work again. Unlike the other
> soc-specific backends, this one has no dependency on an
> architecture or a platform. I'm adding a dependency on
> MIPS || COMPILE_TEST as well here, to avoid showing the driver
> on architectures that are not interested in it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 6ae0fae4f796..13c63b14179f 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -384,8 +384,8 @@ config SERIAL_8250_UNIPHIER
>  	  serial ports, say Y to this option. If unsure, say N.
>  
>  config SERIAL_8250_INGENIC
> -	bool "Support for Ingenic SoC serial ports"
> -	depends on OF_FLATTREE
> +	tristate "Support for Ingenic SoC serial ports"
> +	depends on SERIAL_8250 && OF_FLATTREE && (MIPS || COMPILE_TEST)
>  	select LIBFDT
>  	help
>  	  If you have a system using an Ingenic SoC and wish to make use of
> -- 
> 2.7.0
> 
