From: joe@perches.com (Joe Perches)
Date: Sun, 08 Apr 2012 14:40:46 -0700
Subject: [PATCH] dma: pl330: fix a couple of compilation warnings
In-Reply-To: <1333919920-25481-1-git-send-email-olof@lixom.net>
References: <1333919920-25481-1-git-send-email-olof@lixom.net>
Message-ID: <1333921246.2508.8.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-04-08 at 14:18 -0700, Olof Johansson wrote:
> Move a couple of tests and do a minor refactor to avoid:
[]
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
[]
> @@ -2926,8 +2928,9 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>  	INIT_LIST_HEAD(&pd->channels);
>  
>  	/* Initialize channel parameters */
> -	num_chan = max(pdat ? pdat->nr_valid_peri : (u8)pi->pcfg.num_peri,
> -			(u8)pi->pcfg.num_chan);
> +	num_chan = max_t(int, pdat ? pdat->nr_valid_peri :
> +				     pi->pcfg.num_peri,
> +			      pi->pcfg.num_chan);
>  	pdmac->peripherals = kzalloc(num_chan * sizeof(*pch), GFP_KERNEL);

Few trivial things:

There's no error checking for a malloc failure
This should probably be kcalloc
The alignment here is not nice

Maybe:

	num_chan = max_t(size_t, pdat ? pdat->nr_valid_peri : pi->pcfg.num_peri,
			 pi->pcfg.num_chan);
	pdmac->peripherals = kcalloc(num_chan, sizeof(*pch), GFP_KERNEL);
	if (!pdmac->peripherals)
		goto some_err;
