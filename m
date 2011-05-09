From: vinod.koul@intel.com (Koul, Vinod)
Date: Mon, 09 May 2011 10:32:51 +0530
Subject: [PATCH V4 1/5] dmaengine/dw_dmac: don't call callback routine
	in case dmaengine_terminate_all() is called
In-Reply-To: <8d1b15be425a70cdbd30725b88bd303cc74e706d.1304596524.git.viresh.kumar@st.com>
References: <cover.1304596524.git.viresh.kumar@st.com>
	<8d1b15be425a70cdbd30725b88bd303cc74e706d.1304596524.git.viresh.kumar@st.com>
Message-ID: <1304917371.32447.10.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-05 at 17:30 +0530, Viresh Kumar wrote:
> If dmaengine_terminate_all() is called for dma channel, then it doesn't make
> much sense to call registered callback routine. While in case of success or
> failure it must be called.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/dw_dmac.c |   31 ++++++++++++++++---------------
>  1 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
> index 1bd4803..d28cd84 100644
> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c
> @@ -195,18 +195,21 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
>  /*----------------------------------------------------------------------*/
>  

> -	/*
> -	 * The API requires that no submissions are done from a
> -	 * callback, so we don't need to drop the lock here
> -	 */
> -	if (callback)
> -		callback(param);
> +	if (callback_required) {
> +		if (callback)
> +			callback(param);
> +	}
How about changing this to:
	if (callback_required && callback)
		callback(param)
This will make it look cleaner ...


-- 
~Vinod
