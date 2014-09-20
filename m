From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 20 Sep 2014 15:39:58 +0200
Subject: [PATCH] tty/serial: samsung: Add earlycon support
In-Reply-To: <1410867163-27962-1-git-send-email-alim.akhtar@samsung.com>
References: <1410867163-27962-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <541D83AE.1050006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alim,

Please see my comments inline.

On 16.09.2014 13:32, Alim Akhtar wrote:
> Add earlycon support for the samsung serial port. This allows enabling
> the samsung serial port for console when early_params are parse and processed.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  Documentation/kernel-parameters.txt |    6 ++++++
>  drivers/tty/serial/Kconfig          |    1 +
>  drivers/tty/serial/samsung.c        |   17 +++++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 5ae8608..e01c0e5 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -936,6 +936,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			must already be setup and configured. Options are not
>  			yet supported.
>  
> +		samsung,<addr>
> +			Start an early, polled-mode console on a samsung serial
> +			port at the specified address. The samsung serial port
> +			must already be setup and configured. Options are not
> +			yet supported.
> +

Couldn't you simply parse this from DT? I believe there is already code
parsing stdout property in chosen node for earlycon purposes present in
the kernel.

Anyway, we already had a patch for this in our internal tree, but it
wasn't submitted because there was no support for early ioremap on ARM
at that time. I haven't been following it since then (and I'm no longer
at Samsung; Marek might be able to take this topic), is it already
available?

>  		smh	Use ARM semihosting calls for early console.
>  
>  	earlyprintk=	[X86,SH,BLACKFIN,ARM,M68k]
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 249e340..9d42ac8 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -257,6 +257,7 @@ config SERIAL_SAMSUNG_CONSOLE
>  	bool "Support for console on Samsung SoC serial port"
>  	depends on SERIAL_SAMSUNG=y
>  	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
>  	help
>  	  Allow selection of the S3C24XX on-board serial ports for use as
>  	  an virtual console.
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index c78f43a..f32e9c8 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -917,6 +917,7 @@ s3c24xx_serial_verify_port(struct uart_port *port, struct serial_struct *ser)
>  #ifdef CONFIG_SERIAL_SAMSUNG_CONSOLE
>  
>  static struct console s3c24xx_serial_console;
> +static void s3c24xx_serial_console_putchar(struct uart_port *port, int ch);
>  
>  static int __init s3c24xx_serial_console_init(void)
>  {
> @@ -926,6 +927,22 @@ static int __init s3c24xx_serial_console_init(void)
>  console_initcall(s3c24xx_serial_console_init);
>  
>  #define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
> +static void samsung_early_write(struct console *con, const char *s, unsigned n)
> +{
> +	struct earlycon_device *dev = con->data;
> +
> +	uart_console_write(&dev->port, s, n, s3c24xx_serial_console_putchar);

Hmm, I'm not sure how this is supposed to work before the driver is
fully initialized.

s3c24xx_serial_console_putchar() will call
s3c24xx_serial_console_txrdy(), which in turn requires the port argument
to be a pointer to the member of a s3c24xx_uart_port struct, with filled
info pointer, which I believe is ready only after s3c24xx_serial_probe().

Has this patch been tested with earlycon enabled and it was indeed
verified that earlycon is actually used?

Best regards,
Tomasz
