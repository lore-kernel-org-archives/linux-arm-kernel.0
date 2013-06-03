From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jun 2013 10:50:14 +0100
Subject: [PATCH] serial: imx: enable the clocks only when the uart is used
In-Reply-To: <1370245331-12501-1-git-send-email-b32955@freescale.com>
References: <1370245331-12501-1-git-send-email-b32955@freescale.com>
Message-ID: <20130603095014.GJ18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 03:42:11PM +0800, Huang Shijie wrote:
> Current code opens the clocks when the uart driver is probed.
> This will wastes some power if several uarts are enabled, but not really
> used.
> 
> So close these clocks for uart, and enable the clocks only when
> the uart is used.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/tty/serial/imx.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 72bc1db..5705fc8 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -699,6 +699,9 @@ static int imx_startup(struct uart_port *port)
>  	int retval;
>  	unsigned long flags, temp;
>  
> +	clk_prepare_enable(sport->clk_per);
> +	clk_prepare_enable(sport->clk_ipg);

You should check the return value.  I've a good mind to mark these
functions with __must_check...
