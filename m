From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 22 Jan 2010 12:58:53 +0100
Subject: [PATCH] serial imx.c: fix CTS trigger level lower to avoid
	lost chars
In-Reply-To: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <20100122115853.GF4782@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2010 at 10:26:03PM +0100, Valentin Longchamp wrote:
> The imx CTS trigger level is left at its reset value that is 32
> chars. Since the RX FIFO has 32 entries, when CTS is raised, the
> FIFO already is full. However, some serial port devices first empty
> their TX FIFO before stopping when CTS is raised, resulting in lost
> chars.
> 
> This patch sets the trigger level lower so that other chars arrive
> after CTS is raised, there is still room for 16 of them.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
> Tested-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>

If you fix the comment, feel free to add my:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>  drivers/serial/imx.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
> index 18130f1..f7d2da5 100644
> --- a/drivers/serial/imx.c
> +++ b/drivers/serial/imx.c
> @@ -119,7 +119,8 @@
>  #define  MX2_UCR3_RXDMUXSEL	 (1<<2)  /* RXD Muxed Input Select, on mx2/mx3 */
>  #define  UCR3_INVT  	 (1<<1)  /* Inverted Infrared transmission */
>  #define  UCR3_BPEN  	 (1<<0)  /* Preset registers enable */
> -#define  UCR4_CTSTL_32   (32<<10) /* CTS trigger level (32 chars) */
> +#define  UCR4_CTSTL_SHF  10      /* CTS trigger level shift */
> +#define  UCR4_CTSTL_MASK 0x3F    /* CTS trigger is 6 bits wide */
>  #define  UCR4_INVR  	 (1<<9)  /* Inverted infrared reception */
>  #define  UCR4_ENIRI 	 (1<<8)  /* Serial infrared interrupt enable */
>  #define  UCR4_WKEN  	 (1<<7)  /* Wake interrupt enable */
> @@ -590,6 +591,8 @@ static int imx_setup_ufcr(struct imx_port *sport, unsigned int mode)
>  	return 0;
>  }
>  
> +#define CTSTL 16
> +

Maybe a comment that it is set to half the buffer size? Dunno...

>  static int imx_startup(struct uart_port *port)
>  {
>  	struct imx_port *sport = (struct imx_port *)port;
> @@ -606,6 +609,11 @@ static int imx_startup(struct uart_port *port)
>  	if (USE_IRDA(sport))
>  		temp |= UCR4_IRSC;
>  
> +	/* set the trigger level for CTS to 16 by default
> +	 */

Make this comment a one-liner. Also remove the "to 16 by default" part as this
value is #defined and, who knows, it may change.

> +	temp &= ~(UCR4_CTSTL_MASK << UCR4_CTSTL_SHF);
> +	temp |= CTSTL << UCR4_CTSTL_SHF;
> +
>  	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
>  
>  	if (USE_IRDA(sport)) {

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100122/7de68086/attachment.sig>
