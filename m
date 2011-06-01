From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 01 Jun 2011 13:12:24 +0530
Subject: [PATCH 1/3] dmaengine: add new dma API for max_segment_number
In-Reply-To: <1306391493-29425-1-git-send-email-shawn.guo@linaro.org>
References: <1306391493-29425-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1306914144.10976.4.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-26 at 14:31 +0800, Shawn Guo wrote:
> Like dma_set(get)_max_seg_size for max_segment_size, the patch adds
> max_segment_number into device_dma_parameters and creates the
> corresponding dmaengine API dma_set(get)_max_seg_number for it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  include/linux/device.h      |    1 +
>  include/linux/dma-mapping.h |   15 +++++++++++++++
>  2 files changed, 16 insertions(+), 0 deletions(-)
Can you explain me why this change is required, the patch description
isn't helping for this.

If you satisfy me with above then I am okay with it, but I need ACK from
Dan before applying...

~Vinod

> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index c66111a..44cb2528 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -487,6 +487,7 @@ struct device_dma_parameters {
>  	 * sg limitations.
>  	 */
>  	unsigned int max_segment_size;
> +	unsigned int max_segment_number;
>  	unsigned long segment_boundary_mask;
>  };
>  
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index ba8319a..fd314f4 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -131,6 +131,21 @@ static inline unsigned int dma_set_max_seg_size(struct device *dev,
>  		return -EIO;
>  }
>  
> +static inline unsigned int dma_get_max_seg_number(struct device *dev)
> +{
> +	return dev->dma_parms ? dev->dma_parms->max_segment_number : 1;
> +}
> +
> +static inline unsigned int dma_set_max_seg_number(struct device *dev,
> +						  unsigned int number)
> +{
> +	if (dev->dma_parms) {
> +		dev->dma_parms->max_segment_number = number;
> +		return 0;
> +	} else
> +		return -EIO;
> +}
> +
>  static inline unsigned long dma_get_seg_boundary(struct device *dev)
>  {
>  	return dev->dma_parms ?
