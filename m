From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 18 Apr 2013 17:14:37 +0200
Subject: [PATCH RESEND v5 1/2] dma: imx-dma: Add oftree support
In-Reply-To: <1366291298-30004-2-git-send-email-mpa@pengutronix.de>
References: <1366291298-30004-1-git-send-email-mpa@pengutronix.de>
 <1366291298-30004-2-git-send-email-mpa@pengutronix.de>
Message-ID: <51700DDD.1060801@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/18/2013 03:21 PM, Markus Pargmann wrote:
[...]
> +static struct dma_chan *imxdma_xlate(struct of_phandle_args *dma_spec,
> +						struct of_dma *ofdma)
> +{
> +	int count = dma_spec->args_count;
> +	struct imxdma_engine *imxdma = ofdma->of_dma_data;
> +	struct imxdma_filter_data fdata = {
> +		.imxdma = imxdma,
> +		.request = *(unsigned *)&dma_spec->args[0],

This cast looks rather bogus and shouldn't be necessary.

> +	};
> +
> +	if (count != 1)
> +		return NULL;

I think you need to check count before you access dma_spec->args[0]

> +
> +	return dma_request_channel(imxdma->dma_device.cap_mask,
> +					imxdma_filter_fn, &fdata);
> +}
> +
[...]
