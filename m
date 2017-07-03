From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 3 Jul 2017 09:01:20 +0200
Subject: [PATCH 5/7] serial: imx: umap sg buffers when DMA channel is
 released
In-Reply-To: <20170630120446.13994-6-romain.perier@collabora.com>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-6-romain.perier@collabora.com>
Message-ID: <20170703070120.j6fg2vfiikug4jmd@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

$Subject ~= s/umap/unmap/

On Fri, Jun 30, 2017 at 02:04:44PM +0200, Romain Perier wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> This commits unmaps sg buffers when the DMA channel is released
> 
> Signed-off-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  drivers/tty/serial/imx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index e8cf7cf..58d6b1c 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1215,6 +1215,12 @@ static void imx_stop_tx_dma(struct imx_port *sport)
>  	temp = readl(sport->port.membase + UCR1);
>  	temp &= ~UCR1_TDMAEN;
>  	writel(temp, sport->port.membase + UCR1);
> +
> +	if (sport->dma_is_txing) {
> +		dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
> +		sport->dma_tx_nents, DMA_TO_DEVICE);
> +		sport->dma_is_txing = 0;

You don't motivate setting dma_is_txing to zero in the commit log. 

Does this mean the driver leaks memory in the current state?

> +	}
>  }
>  
>  static void imx_stop_rx_dma(struct imx_port *sport)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
