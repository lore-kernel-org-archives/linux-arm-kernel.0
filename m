From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 15 Jul 2013 10:27:16 +0200
Subject: [PATCH 2/3] serial: mxs: enable the DMA only when the rts/cts is
 enabled
In-Reply-To: <1373857736-30108-2-git-send-email-b32955@freescale.com>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com>
 <1373857736-30108-2-git-send-email-b32955@freescale.com>
Message-ID: <20130715082716.GM12139@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 11:08:55AM +0800, Huang Shijie wrote:
> The originall DMA support works only when the rts/cts is enabled.
s/originall/original/. I'd drop "the" and capitalize RTS/CTS.

> But after several patchs, the DMA support has lost this limit.
s/patchs/patches/, s/the //.

do you want to say that the driver fails to only enable DMA when RTS/CTS
are available; or that today the driver can handle DMA just fine even
without RTS/CTS? I interpret your commit log as the latter, your patch
implements the former however.

> This patch adds an optional property for the uart DT node
> which indicates the uart has rts and cts.
which indicates that the UART has RTS and CTS lines.

> This patch also adds the check for rts/cts before we enable the DMA
> for the uart.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  .../bindings/tty/serial/fsl-mxs-auart.txt          |    3 +++
>  drivers/tty/serial/mxs-auart.c                     |    5 ++++-
>  2 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
> index 2c00ec6..ef82002 100644
> --- a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
> @@ -10,6 +10,9 @@ Required properties:
>    Refer to dma.txt and fsl-mxs-dma.txt for details.
>  - dma-names: "rx" for RX channel, "tx" for TX channel.
>  
> +Optional properties:
> +- fsl,uart-has-rtscts : Indicate the uart has rts and cts
> +
>  Example:
>  auart0: serial at 8006a000 {
>  	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 465ef0b..27532fd 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -134,6 +134,7 @@ enum mxs_auart_type {
>  struct mxs_auart_port {
>  	struct uart_port port;
>  
> +#define MXS_AUART_RTSCTS	1
>  #define MXS_AUART_DMA_ENABLED	0x2
>  #define MXS_AUART_DMA_TX_SYNC	2  /* bit 2 */
>  #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
> @@ -639,7 +640,7 @@ static void mxs_auart_settermios(struct uart_port *u,
>  		 * we can only implement the DMA support for auart
>  		 * in mx28.
>  		 */
> -		if (is_imx28_auart(s)) {
> +		if (is_imx28_auart(s) && (s->flags & MXS_AUART_RTSCTS)) {
>  			if (!mxs_auart_dma_init(s))
>  				/* enable DMA tranfer */
>  				ctrl2 |= AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE
> @@ -1001,6 +1002,8 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
>  	}
>  	s->port.line = ret;
>  
> +	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
> +		s->flags |= MXS_AUART_RTSCTS;
>  	return 0;
>  }
>  
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
