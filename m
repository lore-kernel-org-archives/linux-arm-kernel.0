From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 10 Oct 2014 07:39:21 -0400
Subject: [PATCH] serial: of-serial: fix up PM ops on no_console_suspend
In-Reply-To: <1412845852-26157-1-git-send-email-jingchang.lu@freescale.com>
References: <1412845852-26157-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <5437C569.3030404@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingchang,

On 10/09/2014 05:10 AM, Jingchang Lu wrote:
> Mandatorily disabling the uart clock will cause register access
> hung on "no_console_suspend". This patch add condition check on
> it and only disable the clock with console_suspend_enabled true.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  drivers/tty/serial/of_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index 8bc2563..a765399 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -246,7 +246,7 @@ static int of_serial_suspend(struct device *dev)
>  	struct of_serial_info *info = dev_get_drvdata(dev);
>  
>  	serial8250_suspend_port(info->line);
> -	if (info->clk)
> +	if (info->clk && console_suspend_enabled)
>  		clk_disable_unprepare(info->clk);

This needs to check that _this_ port is the console port, like:

	if (info->clk && uart_console(port) && and console_suspend_enabled)
		clk_disable_unprepare(info->clk);

which means you need something like:

	struct uart_8250_port *uart = serial8250_get_port(info->line);
	struct uart_port *port = &uart->port;

Also, there's another problem with your original patch:
not every of_serial device is an 8250, right?
serial8250_suspend_port() on a port that's not registered with 8250 core
is probably going to blow up.

Which means the body of of_platform_suspend() and of_platform_resume()
should probably look like

	switch (info->type) {
#ifdef CONFIG_SERIAL_8250
	case PORT_8250 ... PORT_MAX_8250:
	{
		/* current body of function */
	}
#endif
	default:
	}

Regards,
Peter Hurley


>  
>  	return 0;
> @@ -256,7 +256,7 @@ static int of_serial_resume(struct device *dev)
>  {
>  	struct of_serial_info *info = dev_get_drvdata(dev);
>  
> -	if (info->clk)
> +	if (info->clk && console_suspend_enabled)
>  		clk_prepare_enable(info->clk);
>  
>  	serial8250_resume_port(info->line);
> 
