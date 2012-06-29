From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 29 Jun 2012 17:19:01 +0800
Subject: [PATCH 2/2] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <1340958243-2332-2-git-send-email-marex@denx.de>
References: <1340958243-2332-1-git-send-email-marex@denx.de>
 <1340958243-2332-2-git-send-email-marex@denx.de>
Message-ID: <20120629091900.GJ5844@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 04:24:03PM +0800, Marek Vasut wrote:
> This patch implements DMA support into mxs-i2c. DMA transfers are now enabled
> via DT. The DMA operation is enabled by default.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Detlev Zundel <dzu@denx.de>
> CC: Dong Aisheng <b29396@freescale.com>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> Cc: linux-i2c at vger.kernel.org
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    4 +
>  arch/arm/boot/dts/imx28.dtsi                      |    2 +
>  drivers/i2c/busses/i2c-mxs.c                      |  267 +++++++++++++++++++--
>  3 files changed, 251 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> index d2bf750..9497ee0 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> @@ -5,6 +5,10 @@ Required properties:
>  - reg: Should contain registers location and length
>  - interrupts: Should contain ERROR and DMA interrupts
>  - clock-frequency: desired I2C bus clock frequency in Hz.
> +- fsl,i2c-dma-channel: APBX DMA channel for the I2C
Shoundn't this be optional?

> +	/*
> +	 * The last descriptor must have this callback,
> +	 * to finish the DMA transaction.
> +	 */
> +	desc->callback = mxs_i2c_dma_irq_callback;
> +	desc->callback_param = i2c;
> +
> +	/* Start the transfer. */
> +	dmaengine_submit(desc);
> +	dma_async_issue_pending(i2c->dmach);
> +	return 0;
> +
> +/* Read failpath. */
> +read_init_dma_fail:
> +	dma_unmap_sg(i2c->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
> +select_init_dma_fail:
> +	dma_unmap_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
> +select_init_pio_fail:
> +	return 1;
look strange why return 1;
> +
> +
One more unnecessary line?

> +/* Write failpath. */
> +write_init_dma_fail:
> +	dma_unmap_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
> +write_init_pio_fail:
> +	return 1;
> +}
> +
..
> @@ -291,6 +459,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
>  
>  timeout:
>  	dev_dbg(i2c->dev, "Timeout!\n");
> +	mxs_i2c_dma_finish(i2c);
Shared with pio?

>  	mxs_i2c_reset(i2c);
>  	return -ETIMEDOUT;
>  }

Regards
Dong Aisheng
