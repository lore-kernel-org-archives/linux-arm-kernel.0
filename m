From: greg@kroah.com (Greg KH)
Date: Wed, 31 Aug 2016 16:00:36 +0200
Subject: [PATCH] serial: imx: add rx and tx led trigger
In-Reply-To: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20160831140036.GC13298@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 05:34:12PM +0200, Uwe Kleine-K?nig wrote:
> Add support for two led triggers per UART instance that blink on
> transmission and reception of data respectively.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/imx.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 621e488cbb12..2b6ba3b8bdd5 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -39,6 +39,7 @@
>  #include <linux/of_device.h>
>  #include <linux/io.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/leds.h>
>  
>  #include <asm/irq.h>
>  #include <linux/platform_data/serial-imx.h>
> @@ -227,6 +228,8 @@ struct imx_port {
>  	wait_queue_head_t	dma_wait;
>  	unsigned int            saved_reg[10];
>  	bool			context_saved;
> +	struct led_trigger	led_trigger_rx;
> +	struct led_trigger	led_trigger_tx;
>  };
>  
>  struct imx_port_ucrs {
> @@ -293,6 +296,10 @@ static inline int is_imx6q_uart(struct imx_port *sport)
>  {
>  	return sport->devdata->devtype == IMX6Q_UART;
>  }
> +
> +static unsigned long led_delay = 50;
> +module_param(led_delay, ulong, 0644);

I hate module parameters, and so should you, this isn't the 1990's
anymore :(

And I'm with Arnd, let's make this work for all tty drivers that want to
use it please.

thanks,

greg k-h
