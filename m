From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 18 Dec 2014 09:48:31 +0100
Subject: [PATCH 1/2] tty: serial: 8250_mtk: Add earlycon
In-Reply-To: <1418891601-53769-2-git-send-email-eddie.huang@mediatek.com>
References: <1418891601-53769-1-git-send-email-eddie.huang@mediatek.com>
 <1418891601-53769-2-git-send-email-eddie.huang@mediatek.com>
Message-ID: <CABuKBe+dki5ab8PexMhq36AJFCBk_dBifV86F8FKsF_es1cmJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-12-18 9:33 GMT+01:00 Eddie Huang <eddie.huang@mediatek.com>:
> Mediatek UART has highspeed register, but 8250_early.c doesn't
> support this, so add earlycon in 8250_mtk.c
>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index de7aae5..65dd569 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -23,6 +23,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/serial_8250.h>
>  #include <linux/serial_reg.h>
> +#include <linux/console.h>
>
>  #include "8250.h"
>
> @@ -289,6 +290,38 @@ static struct platform_driver mtk8250_platform_driver = {
>  };
>  module_platform_driver(mtk8250_platform_driver);
>
> +#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
> +
> +static void __init mtk8250_serial_putc(struct uart_port *port, int c)
> +{
> +       while ((readl(port->membase + (UART_LSR << 2)) & BOTH_EMPTY) !=
> +               BOTH_EMPTY)
> +               ;

Please delete newline before the semicolon.

> +       writel(c, port->membase + (UART_TX << 2));
> +}
> +
> +static void __init early_mtk8250_write(struct console *console,
> +                                       const char *s, unsigned int count)
> +{
> +       struct earlycon_device *dev = console->data;
> +
> +       uart_console_write(&dev->port, s, count, mtk8250_serial_putc);
> +}
> +
> +static int __init early_mtk8250_setup(struct earlycon_device *device,
> +                                       const char *options)
> +{
> +       if (!device->port.membase)
> +               return -ENODEV;
> +
> +       device->con->write = early_mtk8250_write;
> +
> +       return 0;
> +}
> +
> +EARLYCON_DECLARE(mtk8250, early_mtk8250_setup);
> +OF_EARLYCON_DECLARE(mtk8250, "mediatek,mt6577-uart", early_mtk8250_setup);
> +
>  MODULE_AUTHOR("Matthias Brugger");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Mediatek 8250 serial port driver");
> --
> 1.8.1.1.dirty
>



-- 
motzblog.wordpress.com
