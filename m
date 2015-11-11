From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Nov 2015 09:12:15 +0100
Subject: [PATCH v3 2/7] spi: imx: replace fixed timeout with calculated one
In-Reply-To: <56425176.9060805@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1446388901-6073-3-git-send-email-anton.bondarenko.sama@gmail.com>
 <20151105084723.GI8526@pengutronix.de> <56425176.9060805@gmail.com>
Message-ID: <20151111081215.GQ8526@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 09:20:06PM +0100, Anton Bondarenko wrote:
> 
> 
> On 05.11.2015 09:47, Sascha Hauer wrote:
> >>@@ -890,12 +891,40 @@ static void spi_imx_dma_tx_callback(void *cookie)
> >>  	complete(&spi_imx->dma_tx_completion);
> >>  }
> >>
> >>+static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
> >>+{
> >>+	unsigned long coef1 = 1;
> >>+	unsigned long coef2 = MSEC_PER_SEC;
> >>+	unsigned long timeout = 0;
> >>+
> >>+	/* Swap coeficients to avoid div by 0 */
> >>+	if (spi_imx->spi_bus_clk < MSEC_PER_SEC) {
> >>+		coef1 = MSEC_PER_SEC;
> >>+		coef2 = 1;
> >>+	}
> >>+
> >>+	/* Time with actual data transfer */
> >>+	timeout += DIV_ROUND_UP(8 * size * coef1,
> >>+				spi_imx->spi_bus_clk / coef2);
> >>+
> >>+	/* Take CS change delay related to HW */
> >>+	timeout += DIV_ROUND_UP((size - 1) * 4 * coef1,
> >>+				spi_imx->spi_bus_clk / coef2);
> >>+
> >>+	/* Add extra second for scheduler related activities */
> >>+	timeout += MSEC_PER_SEC;
> >>+
> >>+	/* Double calculated timeout */
> >>+	return msecs_to_jiffies(2 * timeout);
> >>+}
> >
> >I think you can simplify this function to:
> >
> >	timeout = size * 8 / spi_imx->spi_bus_clk;
> >	timeout += 2;
> >
> >	return msecs_to_jiffies(timeout * MSEC_PER_SEC);
> >
> >The rationale is that when size * 8 / spi_imx->spi_bus_clk is 0 then we
> >can add another second and be fine. No need to calculate this more
> >accurate, in the end it's important to catch the timeout. If we do this
> >one or two seconds too late doesn't matter.
> >
> >Sascha
> >
> 
> Sascha,
> 
> What about something like this:
> 	timeout = size * (8 + 4) / spi_imx->spi_bus_clk;
> 	timeout += 2;
> 
> 	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);
> 
> I think we still need to take into account 4 CLKs between each burst.

Fine with me.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
