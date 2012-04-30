From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 30 Apr 2012 08:05:54 +0200
Subject: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
In-Reply-To: <1335738969-27445-2-git-send-email-marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <1335738969-27445-2-git-send-email-marex@denx.de>
Message-ID: <20120430060554.GB7926@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 12:36:09AM +0200, Marek Vasut wrote:
> This patch implements DMA support into mxs-i2c. DMA transfers are now enabled by
> default, though it is possible for example for debugging purposes, to disable
> them via i2c->dma_mode.
> 
> Cc: Linux I2C <linux-i2c@vger.kernel.org>
> Cc: Detlev Zundel <dzu@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>

Looks promising, will give it a shot this week! Thanks.
Very quick review.

> ---
>  arch/arm/mach-mxs/devices/platform-mxs-i2c.c    |    5 +
>  arch/arm/mach-mxs/include/mach/devices-common.h |    1 +
>  drivers/i2c/busses/i2c-mxs.c                    |  261 +++++++++++++++++++++--
>  3 files changed, 245 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
> index 79222ec..a94f308 100644
> --- a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
> +++ b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
> @@ -14,6 +14,7 @@
>  	{								\
>  		.id = _id,						\
>  		.iobase = soc ## _I2C ## _id ## _BASE_ADDR,		\
> +		.dma	= soc ## _DMA_I2C ## _id,			\
>  		.errirq = soc ## _INT_I2C ## _id ## _ERROR,		\
>  		.dmairq = soc ## _INT_I2C ## _id ## _DMA,		\
>  	}
> @@ -37,6 +38,10 @@ struct platform_device *__init mxs_add_mxs_i2c(
>  			.end = data->iobase + SZ_8K - 1,
>  			.flags = IORESOURCE_MEM,
>  		}, {
> +			.start	= data->dma,
> +			.end	= data->dma,
> +			.flags	= IORESOURCE_DMA,
> +		}, {
>  			.start = data->errirq,
>  			.end = data->errirq,
>  			.flags = IORESOURCE_IRQ,
> diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
> index f2e3839..791d99c 100644
> --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> @@ -80,6 +80,7 @@ mxs_add_gpmi_nand(const struct gpmi_nand_platform_data *pdata,
>  struct mxs_mxs_i2c_data {
>  	int id;
>  	resource_size_t iobase;
> +	resource_size_t dma;
>  	resource_size_t errirq;
>  	resource_size_t dmairq;
>  };

You need to either split this and send via alkml or I need an ACK from
Shawn if it shall go in via I2C. You don't have Shawn on CC, please use
scripts/get_maintainer.pl on your patchesr; you have been missing
people/lists at least for the third time now.

>  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
>  {
> -	u32 data;
> +	u32 data = 0;

Unrelated, useless change.

>  	int i;
> +
> +	/*
> +	 * The MXS I2C DMA mode is prefered and enabled by default.
> +	 * The PIO mode is still supported, but should be used only
> +	 * for debuging purposes etc.
> +	 */

For exactness, should be "PIOQUEUE" instead of PIO. There is a PIO mode,
but we don't use it.

> +	i2c->dma_mode = 1;

Have you measured the overhead of DMA? I'd still think that 

	if (MX23 || msg->len > 24)
		do_dma
	else
		do_pioqueue

might be worth considered.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120430/58e70bbb/attachment.sig>
