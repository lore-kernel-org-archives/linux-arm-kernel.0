From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 13 Oct 2014 17:41:24 +0800
Subject: [PATCHv2] serial: of-serial: fix up PM ops on no_console_suspend
 and port type
In-Reply-To: <1413185820-5920-1-git-send-email-jingchang.lu@freescale.com>
References: <1413185820-5920-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <543B9E44.109@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/13/2014 03:37 PM, Jingchang Lu wrote:
> This patch fixes commit 2dea53bf57783f243c892e99c10c6921e956aa7e,
> "serial: of-serial: add PM suspend/resume support", which disables
> the uart clock on suspend, but also causes a hardware hang on register
> access if no_console_suspend command line option is used.
>
> Also, not every of_serial device is an 8250 port, so the serial8250
> suspend/resume functions should only be applied to a real 8250 port.
>
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
> changes in v2:
>   add switch selection on uart type.

After apply this, it can't build for me. I still need to apply the fix 
like something below.

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index e535f9c1563d..14c1ff4e7816 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -9,6 +9,7 @@
   *  2 of the License, or (at your option) any later version.
   *
   */
+#include <linux/console.h>
  #include <linux/module.h>
  #include <linux/slab.h>
  #include <linux/delay.h>
@@ -248,13 +249,13 @@ static int of_serial_suspend(struct device *dev)
  #ifdef CONFIG_SERIAL_8250
         case PORT_8250 ... PORT_MAX_8250:
         {
-               struct uart_8250_port port8250;
+               struct uart_8250_port *port8250;
                 port8250 = serial8250_get_port(info->line);

                 serial8250_suspend_port(info->line);
                 if (info->clk &&
-                   (!uart_console(port8250) ||
-                    (uart_console(port8250) && console_suspend_enabled)))
+                   (!uart_console(&port8250->port) ||
+                    (uart_console(&port8250->port) && 
console_suspend_enabled)))
                         clk_disable_unprepare(info->clk);
                 break;
         }
@@ -274,12 +275,12 @@ static int of_serial_resume(struct device *dev)
  #ifdef CONFIG_SERIAL_8250
         case PORT_8250 ... PORT_MAX_8250:
         {
-               struct uart_8250_port port8250;
+               struct uart_8250_port *port8250;
                 port8250 = serial8250_get_port(info->line);

                 if (info->clk &&
-                   (!uart_console(port8250) ||
-                    (uart_console(port8250) && console_suspend_enabled)))
+                   (!uart_console(&port8250->port) ||
+                    (uart_console(&port8250->port) && 
console_suspend_enabled)))
                         clk_prepare_enable(info->clk);

                 serial8250_resume_port(info->line);

-Joseph

>
>   drivers/tty/serial/of_serial.c | 42 ++++++++++++++++++++++++++++++++++++------
>   1 file changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index 8bc2563..b525383 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -245,9 +245,24 @@ static int of_serial_suspend(struct device *dev)
>   {
>   	struct of_serial_info *info = dev_get_drvdata(dev);
>
> -	serial8250_suspend_port(info->line);
> -	if (info->clk)
> -		clk_disable_unprepare(info->clk);
> +	switch(info->type) {
> +#ifdef CONFIG_SERIAL_8250
> +	case PORT_8250 ... PORT_MAX_8250:
> +	{
> +		struct uart_8250_port port8250;
> +		port8250 = serial8250_get_port(info->line);
> +
> +		serial8250_suspend_port(info->line);
> +		if (info->clk &&
> +		    (!uart_console(port8250) ||
> +		     (uart_console(port8250) && console_suspend_enabled)))
> +			clk_disable_unprepare(info->clk);
> +		break;
> +	}
> +#endif
> +	default:
> +		break;
> +	}
>
>   	return 0;
>   }
> @@ -256,10 +271,25 @@ static int of_serial_resume(struct device *dev)
>   {
>   	struct of_serial_info *info = dev_get_drvdata(dev);
>
> -	if (info->clk)
> -		clk_prepare_enable(info->clk);
> +	switch(info->type) {
> +#ifdef CONFIG_SERIAL_8250
> +	case PORT_8250 ... PORT_MAX_8250:
> +	{
> +		struct uart_8250_port port8250;
> +		port8250 = serial8250_get_port(info->line);
> +
> +		if (info->clk &&
> +		    (!uart_console(port8250) ||
> +		     (uart_console(port8250) && console_suspend_enabled)))
> +			clk_prepare_enable(info->clk);
>
> -	serial8250_resume_port(info->line);
> +		serial8250_resume_port(info->line);
> +		break;
> +	}
> +#endif
> +	default:
> +		break;
> +	}
>
>   	return 0;
>   }
>
