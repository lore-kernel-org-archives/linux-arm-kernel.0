From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 11 Mar 2016 12:17:15 +0530
Subject: [PATCH 4/5] dmaengine: sun6i: Set default values to burst and
 bus width
In-Reply-To: <7f5fc4733c8145fe146bd2a7e0d8febfddf2fe6b.1457606136.git.moinejf@free.fr>
References: <cover.1457606136.git.moinejf@free.fr>
 <7f5fc4733c8145fe146bd2a7e0d8febfddf2fe6b.1457606136.git.moinejf@free.fr>
Message-ID: <20160311064715.GS11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 11:07:53AM +0100, Jean-Francois Moine wrote:
> When defining the DMA transfer, the sound PCM DMA engine sets only
> the burst and bus width values on the DMA side.
> This was making the audio transfers to be rejected because of invalid
> values on the memory side.

I think there is a misunderstanding of the API. The slave configuration set
thru dma_slave_config is only intended for peripheral and not for memory.

In memory case you need to assume values based on system. DMA to memory is
usually done for max throughput and these parameters do not make sense
there.


> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/dma/sun6i-dma.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 7c98c0d..c27d572 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -288,19 +288,31 @@ static inline int sun6i_dma_cfg_lli(struct sun6i_dma_lli *lli,
>  	if (!config)
>  		return -EINVAL;
>  
> -	src_burst = convert_burst(config->src_maxburst);
> +	if (config->src_maxburst == 0)
> +		src_burst = convert_burst(config->dst_maxburst);
> +	else
> +		src_burst = convert_burst(config->src_maxburst);

No 0 is error for the transfer direction and don't assume default for
peripheral, that is just wrong

-- 
~Vinod
