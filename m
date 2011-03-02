From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 02 Mar 2011 23:43:53 +0530
Subject: [PATCH 4/8 resend] dw_dmac: calling dwc_scan_descriptors from
	dwc_tx_status() after taking lock
In-Reply-To: <725d9e629bce9f79d87bdab4596a5088b70ea416.1298889267.git.viresh.kumar@st.com>
References: <cover.1298889267.git.viresh.kumar@st.com>
	<725d9e629bce9f79d87bdab4596a5088b70ea416.1298889267.git.viresh.kumar@st.com>
Message-ID: <1299089633.6974.93.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-28 at 16:11 +0530, Viresh Kumar wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/dw_dmac.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
> index 3bf4772..5cc5abf 100644
> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c
> @@ -830,7 +830,9 @@ dwc_tx_status(struct dma_chan *chan,
>  
>  	ret = dma_async_is_complete(cookie, last_complete, last_used);
>  	if (ret != DMA_SUCCESS) {
> +		spin_lock_bh(&dwc->lock);
>  		dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
> +		spin_unlock_bh(&dwc->lock);
>  
>  		last_complete = dwc->completed;
>  		last_used = chan->cookie;

Please always add a short description in the patch, helps in long run

Shouldnt you be doing this for dwc_handle_error() as well? I see thats
called without taking the lock....

-- 
~Vinod
