From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 18 Dec 2013 22:05:41 +0530
Subject: [PATCH] dma: mv_xor: fix kernel crash on probe error
In-Reply-To: <20131212235908.GZ4360@n2100.arm.linux.org.uk>
References: <1386882715-16433-1-git-send-email-aaro.koskinen@iki.fi>
 <20131212224249.GX4360@n2100.arm.linux.org.uk>
 <CAPcyv4hr2N0kiZabsJJjfmFqTRbT_ntjX4Rdg=THpYg=_2cELg@mail.gmail.com>
 <20131212234453.GB8754@blackmetal.musicnaut.iki.fi>
 <20131212235908.GZ4360@n2100.arm.linux.org.uk>
Message-ID: <20131218163541.GP16227@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 11:59:08PM +0000, Russell King - ARM Linux wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Subject: [PATCH] dmaengine: mv_xor: fix oops when channels fail to initialise
> 
> When a channel fails to initialise, we error out and clean up any
> previously unregistered channels by walking the entire xordev->channels
> array.  Unfortunately, there are paths which end up storing an error
> pointer in this array, which we then try and dereference in the cleanup
> code, which causes an oops.
> 
> Fix this by avoiding writing invalid pointers to this array in the first
> place.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
> ---
>  drivers/dma/mv_xor.c |   24 +++++++++++++-----------
>  1 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 7807f0ef4e20..a7e91090443e 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -1176,6 +1176,7 @@ static int mv_xor_probe(struct platform_device *pdev)
>  		int i = 0;
>  
>  		for_each_child_of_node(pdev->dev.of_node, np) {
> +			struct mv_xor_chan *chan;
>  			dma_cap_mask_t cap_mask;
>  			int irq;
>  
> @@ -1193,21 +1194,21 @@ static int mv_xor_probe(struct platform_device *pdev)
>  				goto err_channel_add;
>  			}
>  
> -			xordev->channels[i] =
> -				mv_xor_channel_add(xordev, pdev, i,
> -						   cap_mask, irq);
> -			if (IS_ERR(xordev->channels[i])) {
> -				ret = PTR_ERR(xordev->channels[i]);
> -				xordev->channels[i] = NULL;
> +			chan = mv_xor_channel_add(xordev, pdev, i,
> +						  cap_mask, irq);
> +			if (IS_ERR(chan)) {
> +				ret = PTR_ERR(chan);
>  				irq_dispose_mapping(irq);
>  				goto err_channel_add;
>  			}
>  
> +			xordev->channels[i] = chan;
>  			i++;
>  		}
>  	} else if (pdata && pdata->channels) {
>  		for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
>  			struct mv_xor_channel_data *cd;
> +			struct mv_xor_chan *chan;
>  			int irq;
>  
>  			cd = &pdata->channels[i];
> @@ -1222,13 +1223,14 @@ static int mv_xor_probe(struct platform_device *pdev)
>  				goto err_channel_add;
>  			}
>  
> -			xordev->channels[i] =
> -				mv_xor_channel_add(xordev, pdev, i,
> -						   cd->cap_mask, irq);
> -			if (IS_ERR(xordev->channels[i])) {
> -				ret = PTR_ERR(xordev->channels[i]);
> +			chan = mv_xor_channel_add(xordev, pdev, i,
> +						  cd->cap_mask, irq);
> +			if (IS_ERR(chan)) {
> +				ret = PTR_ERR(chan);
>  				goto err_channel_add;
>  			}
> +
> +			xordev->channels[i] = chan;
>  		}
>  	}
>  

-- 
