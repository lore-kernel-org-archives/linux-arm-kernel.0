From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 3 Jul 2017 08:58:49 +0200
Subject: [PATCH 4/7] serial: imx: Simplify DMA disablement
In-Reply-To: <20170630120446.13994-5-romain.perier@collabora.com>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-5-romain.perier@collabora.com>
Message-ID: <20170703065849.u55umof2lkjmgohf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 02:04:43PM +0200, Romain Perier wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> This commits simplify the function imx_disable_dma() by moving
> the code for disabling RX and TX DMAs to dedicated functions.

I'd point out there that this prepares the next commit because in the
current state I'd prefer just improved comments.

> Also move away CTSC and CTS as this is not related to DMA.

Hmm, maybe this is related to the rs485 breakage we're seeing and
deserves a separate commit?

This also has the advantage that the refactoring change is semantically
a no-op.

> Signed-off-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  drivers/tty/serial/imx.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 81fb413..e8cf7cf 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1208,6 +1208,24 @@ static int imx_uart_dma_init(struct imx_port *sport)
>  	return ret;
>  }
>  
> +static void imx_stop_tx_dma(struct imx_port *sport)
> +{
> +	unsigned long temp;
> +
> +	temp = readl(sport->port.membase + UCR1);
> +	temp &= ~UCR1_TDMAEN;
> +	writel(temp, sport->port.membase + UCR1);
> +}
> +
> +static void imx_stop_rx_dma(struct imx_port *sport)
> +{
> +	unsigned long temp;
> +
> +	temp = readl(sport->port.membase + UCR1);
> +	temp &= ~(UCR1_RDMAEN | UCR1_ATDMAEN);
> +	writel(temp, sport->port.membase + UCR1);
> +}
> +
>  static void imx_enable_dma(struct imx_port *sport)
>  {
>  	unsigned long temp;
> @@ -1233,17 +1251,8 @@ static void imx_enable_dma(struct imx_port *sport)
>  
>  static void imx_disable_dma(struct imx_port *sport)
>  {
> -	unsigned long temp;
> -
> -	/* clear UCR1 */
> -	temp = readl(sport->port.membase + UCR1);
> -	temp &= ~(UCR1_RDMAEN | UCR1_TDMAEN | UCR1_ATDMAEN);
> -	writel(temp, sport->port.membase + UCR1);
> -
> -	/* clear UCR2 */
> -	temp = readl(sport->port.membase + UCR2);
> -	temp &= ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);

You also dropped clearing ATEN without mentioning that in the commit
log. Is this done on purpose?

> -	writel(temp, sport->port.membase + UCR2);
> +	imx_stop_rx_dma(sport);
> +	imx_stop_tx_dma(sport);
>  
>  	imx_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
