From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 19 Nov 2014 10:16:47 +0100
Subject: [PATCH] i2c: at91: introduce probe deferring
In-Reply-To: <1415972879-26509-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415972879-26509-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20141119091647.GB1439@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 02:47:59PM +0100, Ludovic Desroches wrote:
> Return probe defer if requesting a dma channel without a dma controller probed.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/i2c/busses/i2c-at91.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 77fb647..df3f4c4 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -679,14 +679,21 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	dma->chan_tx = dma_request_slave_channel_compat(mask, filter, pdata,
> -							dev->dev, "tx");
> -	if (!dma->chan_tx) {
> +	dma->chan_tx = dma_request_slave_channel_reason(dev->dev, "tx");

Will it cause regressions if you drop the compat-version of requesting
a channel?

> +	if (IS_ERR(dma->chan_tx)) {
> +		ret = PTR_ERR(dma->chan_tx);
> +		if (ret == -EPROBE_DEFER) {
> +			dev_warn(dev->dev, "no DMA channel available at the moment\n");

I'd say drop this warning. The core usually prints when deferred probing
takes place.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141119/068461e4/attachment.sig>
