From: vkoul@kernel.org (Vinod)
Date: Fri, 29 Jun 2018 16:33:46 +0530
Subject: [PATCH v5 1/7] tty: serial: imx: correct dma cookie status
In-Reply-To: <20180626192252.6qdpwzpbpn6s5sd3@pengutronix.de>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
 <1529427424-12321-2-git-send-email-yibin.gong@nxp.com>
 <20180626192252.6qdpwzpbpn6s5sd3@pengutronix.de>
Message-ID: <20180629110346.GD22377@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26-06-18, 21:22, Uwe Kleine-K?nig wrote:
> On Wed, Jun 20, 2018 at 12:56:58AM +0800, Robin Gong wrote:
> > Correct to check the right rx dma cookie status in spit of it
> > works because only one cookie is running in the current sdma.
> > But it will not once sdma driver support multi cookies
> > running based on virt-dma.
> > 
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Looks wrong (because of tx_status vs rx_cookie), but is right
> nevertheless I think:

hehe, tx refers to transfer status for rx (receive) cookie and not
transmit .. yeah notations can be better!

> 
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Thanks
> Uwe
> 
> > ---
> >  drivers/tty/serial/imx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 4e85357..2879407 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1051,7 +1051,7 @@ static void imx_uart_dma_rx_callback(void *data)
> >  	unsigned int r_bytes;
> >  	unsigned int bd_size;
> >  
> > -	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
> > +	status = dmaengine_tx_status(chan, sport->rx_cookie, &state);
> >  
> >  	if (status == DMA_ERROR) {
> >  		imx_uart_clear_rx_errors(sport);
> > -- 
> > 2.7.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

-- 
~Vinod
