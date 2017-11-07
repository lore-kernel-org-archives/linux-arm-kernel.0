From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Nov 2017 10:50:36 +0100
Subject: [PATCH v3 1/1] tty: serial: imx: remove imx_disable_rx_int
In-Reply-To: <20171106194610.9983-1-troy.kisky@boundarydevices.com>
References: <20171106194610.9983-1-troy.kisky@boundarydevices.com>
Message-ID: <20171107095036.kbqur6v6ywt6d5bu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 06, 2017 at 12:46:10PM -0700, Troy Kisky wrote:
> Since imx_disable_rx_int is only called by imx_startup,
> let's integrate it into that function.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
> v2: new patch
> v3: rebased on tty-next
> ---
>  drivers/tty/serial/imx.c | 36 +++++++++---------------------------
>  1 file changed, 9 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 1b04ef5925ef..9923b57fa60d 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -712,25 +712,6 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static void imx_disable_rx_int(struct imx_port *sport)
> -{
> -	unsigned long temp;
> -
> -	/* disable the receiver ready and aging timer interrupts */
> -	temp = readl(sport->port.membase + UCR1);
> -	temp &= ~(UCR1_RRDYEN);
> -	writel(temp, sport->port.membase + UCR1);
> -
> -	temp = readl(sport->port.membase + UCR2);
> -	temp &= ~(UCR2_ATEN);

ATEN is never set in the driver, right? That's the only one I had to
check with the imx driver open in my editor, so maybe point out that one
in the commit log?

Other than that you change looks fine.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
