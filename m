From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Sat, 27 Sep 2014 04:38:09 +0530
Subject: [PATCH v2 1/2] serial: samsung: Add support for early console
In-Reply-To: <1411638892-13702-2-git-send-email-m.szyprowski@samsung.com>
References: <1411638892-13702-1-git-send-email-m.szyprowski@samsung.com>
 <1411638892-13702-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAGOxZ52jYGxoKzx9ckwrsNMvRLRXz8qBV9QYezZ-RykEfyLc4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Thu, Sep 25, 2014 at 3:24 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> From: Tomasz Figa <t.figa@samsung.com>
>
> This patch adds support for early console initialized from device tree
> and kernel command line to all variants of Samsung serial driver.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> [added support for command line based initialization, fixed comment]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  Documentation/kernel-parameters.txt |  10 ++++
>  drivers/tty/serial/Kconfig          |   1 +
>  drivers/tty/serial/samsung.c        | 103 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 10d51c2f10d7..12e73c5fc90b 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -938,6 +938,16 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>
>                 smh     Use ARM semihosting calls for early console.
>
> +               s3c2410,<addr>[,options]
> +               s3c2412,<addr>[,options]
> +               s3c2440,<addr>[,options]
> +               s3c6400,<addr>[,options]
> +               s5pv210,<addr>[,options]
> +               exynos4210,<addr>[,options]
Which options are supported? If nothing is supported, probably you can
just remove _options_ fields above.
> +                       Use early console provided by serial driver available
> +                       on Samsung SoCs, requires selecting proper type and
> +                       a correct base address of the selected UART port.
> +
>         earlyprintk=    [X86,SH,BLACKFIN,ARM,M68k]
>                         earlyprintk=vga
>                         earlyprintk=efi
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 26cec64dadd7..e87a2dfd9080 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -222,6 +222,7 @@ config SERIAL_SAMSUNG
>         tristate "Samsung SoC serial support"
>         depends on PLAT_SAMSUNG
>         select SERIAL_CORE
> +       select SERIAL_EARLYCON
>         help
>           Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
>           providing /dev/ttySAC0, 1 and 2 (note, some machines may not
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index c78f43a481ce..8ad453a5d845 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1856,6 +1856,109 @@ static struct platform_driver samsung_serial_driver = {
>
>  module_platform_driver(samsung_serial_driver);
>
> +/*
> + * Early console.
> + */
> +
> +struct samsung_early_console_data {
> +       u32 txfull_mask;
> +};
> +
> +static void samsung_early_busyuart(struct uart_port *port)
> +{
> +       while (!(readl(port->membase + S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXFE))
> +               ;
> +}
> +
> +static void samsung_early_busyuart_fifo(struct uart_port *port)
> +{
> +       struct samsung_early_console_data *data = port->private_data;
> +
> +       while (readl(port->membase + S3C2410_UFSTAT) & data->txfull_mask)
> +               ;
> +}
> +
> +static void samsung_early_putc(struct uart_port *port, int c)
> +{
> +       if (readl(port->membase + S3C2410_UFCON) & S3C2410_UFCON_FIFOMODE)
> +               samsung_early_busyuart_fifo(port);
> +       else
> +               samsung_early_busyuart(port);
> +
> +       writeb(c, port->membase + S3C2410_UTXH);
> +}
> +
> +static void samsung_early_write(struct console *con, const char *s, unsigned n)
> +{
> +       struct earlycon_device *dev = con->data;
> +
> +       uart_console_write(&dev->port, s, n, samsung_early_putc);
> +}
> +
> +static int __init samsung_early_console_setup(struct earlycon_device *device,
> +                                             const char *opt)
> +{
> +       if (!device->port.membase)
> +               return -ENODEV;
> +
> +       device->con->write = samsung_early_write;
> +       return 0;
> +}
> +
> +/* S3C2410 */
> +static struct samsung_early_console_data s3c2410_early_console_data = {
> +       .txfull_mask = S3C2410_UFSTAT_TXFULL,
> +};
> +
> +static int __init s3c2410_early_console_setup(struct earlycon_device *device,
> +                                             const char *opt)
> +{
> +       device->port.private_data = &s3c2410_early_console_data;
> +       return samsung_early_console_setup(device, opt);
> +}
> +OF_EARLYCON_DECLARE(s3c2410, "samsung,s3c2410-uart",
> +                       s3c2410_early_console_setup);
> +EARLYCON_DECLARE(s3c2410, s3c2410_early_console_setup);
> +
> +/* S3C2412, S3C2440, S3C64xx */
> +static struct samsung_early_console_data s3c2440_early_console_data = {
> +       .txfull_mask = S3C2440_UFSTAT_TXFULL,
> +};
> +
> +static int __init s3c2440_early_console_setup(struct earlycon_device *device,
> +                                             const char *opt)
> +{
> +       device->port.private_data = &s3c2440_early_console_data;
> +       return samsung_early_console_setup(device, opt);
> +}
> +OF_EARLYCON_DECLARE(s3c2412, "samsung,s3c2412-uart",
> +                       s3c2440_early_console_setup);
> +OF_EARLYCON_DECLARE(s3c2440, "samsung,s3c2440-uart",
> +                       s3c2440_early_console_setup);
> +OF_EARLYCON_DECLARE(s3c6400, "samsung,s3c6400-uart",
> +                       s3c2440_early_console_setup);
> +EARLYCON_DECLARE(s3c2412, s3c2440_early_console_setup);
> +EARLYCON_DECLARE(s3c2440, s3c2440_early_console_setup);
> +EARLYCON_DECLARE(s3c6400, s3c2440_early_console_setup);
> +
> +/* S5PV210, EXYNOS */
> +static struct samsung_early_console_data s5pv210_early_console_data = {
> +       .txfull_mask = S5PV210_UFSTAT_TXFULL,
> +};
> +
> +static int __init s5pv210_early_console_setup(struct earlycon_device *device,
> +                                             const char *opt)
> +{
> +       device->port.private_data = &s5pv210_early_console_data;
> +       return samsung_early_console_setup(device, opt);
> +}
> +OF_EARLYCON_DECLARE(s5pv210, "samsung,s5pv210-uart",
> +                       s5pv210_early_console_setup);
> +OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
> +                       s5pv210_early_console_setup);
> +EARLYCON_DECLARE(s5pv210, s5pv210_early_console_setup);
> +EARLYCON_DECLARE(exynos4210, s5pv210_early_console_setup);
> +
>  MODULE_ALIAS("platform:samsung-uart");
>  MODULE_DESCRIPTION("Samsung SoC Serial port driver");
>  MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
> --
> 1.9.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
