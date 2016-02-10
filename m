From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 10 Feb 2016 19:06:27 +0100
Subject: [PATCH 1/2] serial: 8250: fix building mediatek with SERIAL_8250=m
In-Reply-To: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
References: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
Message-ID: <56BB7C23.5070600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/02/16 13:51, Arnd Bergmann wrote:
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
>
> This changes the symbol to a 'tristate', so the dependency on
> SERIAL_8250 also works when that is set to 'm'.
> To actually build the driver, we also need to include <linux/module.h>.
>
> Note that the driver uses builtin_platform_driver() and implements
> no .remove() callback, so unloading the module is not possible.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I tried this with:
commit 2178cbc68f3602dc0b5949b9be2c8383ad3d93ef

$ grep 8250 .config
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_MT6577=y
# CONFIG_SERIAL_8250_INGENIC is not set
# CONFIG_SERIAL_8250_MID is not set

$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- drivers/tty/

compiles just fine.

Do I missing something?

Regards,
Matthias
