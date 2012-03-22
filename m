From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 22 Mar 2012 12:49:48 +0100
Subject: [PATCH v4 2/2] DMAEngine: Add DMAEngine driver based on old MSM
 ADM DMA APIs
In-Reply-To: <1332413882-8456-1-git-send-email-kumarrav@codeaurora.org>
References: <1332413882-8456-1-git-send-email-kumarrav@codeaurora.org>
Message-ID: <4F6B11DC.9090401@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2012 11:58 AM, Ravi Kumar V wrote:
> [...]
> +static struct dma_async_tx_descriptor *msm_dma_prep_sg(
> +		struct dma_chan *dchan,
> +		struct scatterlist *dst_sg, unsigned int dst_nents,
> +		struct scatterlist *src_sg, unsigned int src_nents,
> +		unsigned long flags, void *context)
> +{
> [...]
> +
> +	if (!dchan)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (dst_nents == 0 || src_nents == 0)
> +		return ERR_PTR(-EINVAL);
> +	if (!dst_sg || !src_sg)
> +		return ERR_PTR(-EINVAL);
> +
> +	if ((dst_nents != src_nents) || (cmd_config->num_cmd != src_nents))
> +		return ERR_PTR(-EINVAL);
> +
> + [...]
> +
> +	if (!new) {
> +		dev_err(chan->dev,
> +			"No free memory for link descriptor\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> [...]
> +	return &new->async_tx;
> +}

Same comment as before. This is supposed to return either a valid descriptor
or NULL, but not an ERR_PTR.
