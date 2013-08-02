From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 02 Aug 2013 13:59:59 -0600
Subject: [PATCH] DMA: add help function to check whether dma controller
 registered
In-Reply-To: <1375423458-6868-1-git-send-email-rizhao@nvidia.com>
References: <1375423458-6868-1-git-send-email-rizhao@nvidia.com>
Message-ID: <51FC0FBF.9010107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2013 12:04 AM, Richard Zhao wrote:
> DMA client device driver usually needs to know at probe time whether
> dma controller has been registered to deffer probe. So add a help
> function of_dma_check_controller.
> 
> DMA request channel functions can also used to check it, but they
> are usually called at open() time.

> diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
> index e1c4d3b..b6828c1 100644

> +int of_dma_check_controller(struct device *dev, const char *name)


> +	for (i = 0; i < count; i++) {
> +		if (of_dma_match_channel(np, name, i, &dma_spec))
> +			continue;
> +
> +		mutex_lock(&of_dma_lock);
> +		ofdma = of_dma_find_controller(&dma_spec);
> +		mutex_unlock(&of_dma_lock);
> +		of_node_put(dma_spec.np);

Do we need to add the following here:

if (ofdma)
	break

To ensure that as soon as a successful match is found, the loop exits?
Otherwise, if there are multiple providers for that name, and the first
N are registered but the last isn't, this function will still return
failure.

> +	if (ofdma)
> +		return 0;
> +	else
> +		return -ENODEV;

That probably should be -EPROBE_DEFER?

Although, what about differentiating between "entry not found by
of_dma_match_channel" and "controller not yet probed"?
