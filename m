From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 10:18:24 +0200
Subject: [PATCH v2 07/10] dmaengine: sun6i: Retrieve channel count/max
 request from devicetree
In-Reply-To: <20170917031956.28010-8-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
 <20170917031956.28010-8-stefan.bruens@rwth-aachen.de>
Message-ID: <20170918081824.iiebcj63wvnean57@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Sep 17, 2017 at 05:19:53AM +0200, Stefan Br?ns wrote:
> +	ret = of_property_read_u32(np, "dma-channels", &sdc->num_pchans);
> +	if (ret && !sdc->num_pchans) {
> +		dev_err(&pdev->dev, "Can't get dma-channels.\n");
> +		return ret;
> +	}
> +
> +	if (sdc->num_pchans > DMA_MAX_CHANNELS) {
> +		dev_err(&pdev->dev, "Number of dma-channels out of range.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32(np, "dma-requests", &sdc->max_request);
> +	if (ret && !sdc->max_request) {
> +		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
> +			 DMA_CHAN_MAX_DRQ);
> +		sdc->max_request = DMA_CHAN_MAX_DRQ;
> +	}
> +
> +	if (sdc->max_request > DMA_CHAN_MAX_DRQ) {
> +		dev_err(&pdev->dev, "Value of dma-requests out of range.\n");
> +		return -EINVAL;
> +	}

I'm not really convinced about these two checks. They don't catch all
errors (the range between the actual number of channels / DRQ and the
maximum allowed per the registers), they might increase in the future
too, and if we want to make that check actually working, we would have
to duplicate the number of requests and channels into the driver.

Which is kind of the opposite of what we're trying to do here :)

Once removed,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime



-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/981ea7d7/attachment.sig>
