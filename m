From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 14 Feb 2013 19:55:42 +0530
Subject: [PATCH] DMA: PL330: allow submitting 2 requests at a time
In-Reply-To: <1360752194-6506-1-git-send-email-jaswinder.singh@linaro.org>
References: <1360752194-6506-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <20130214142542.GE29960@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 04:13:14PM +0530, Jassi Brar wrote:
> Fix the logic to allow mc programming of second transfer after first
> has been done, by removing immediate return upon success and iterating
> until we detect QFull or DMAC dying.
This is a fix, should be sent to stable too?

--
~Vinod
> 
> Reported-by: Alvaro Moran <dirac3000@gmail.com>
> Tested-by: Alvaro Moran <dirac3000@gmail.com>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/dma/pl330.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 80680ee..c1a867e 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2282,13 +2282,12 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
>  
>  		/* If already submitted */
>  		if (desc->status == BUSY)
> -			break;
> +			continue;
>  
>  		ret = pl330_submit_req(pch->pl330_chid,
>  						&desc->req);
>  		if (!ret) {
>  			desc->status = BUSY;
> -			break;
>  		} else if (ret == -EAGAIN) {
>  			/* QFull or DMAC Dying */
>  			break;
> -- 
> 1.7.10.4
> 
