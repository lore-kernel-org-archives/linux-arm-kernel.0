From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 1 Jun 2014 17:10:07 +0530
Subject: [PATCH] dma: imx: correct sdmac->status for cyclic dma tx
In-Reply-To: <1400116933-14063-1-git-send-email-jiada_wang@mentor.com>
References: <1400116933-14063-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <20140601114007.GQ21128@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 06:22:13PM -0700, jiada_wang at mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> In cyclic dma tx's handler sdma_handle_channel_loop(),
> SDMA channel statue is set to either DMA_ERROR or DMA_IN_PROGRESS
> based on each period's status. This has the following issues:
> 
> 1) If one period's status is BD_RROR, then channel status
>    will be set to DMA_ERROR, but it will be overwritten to DMA_IN_PROGRESS
>    if the following periods are OK.
> 2) DMA client may call sdma_control(DMA_TERMINATE_ALL) to stop the cyclic dma
>    operation, sdma channel status will be set to DMA_ERROR,
>    but if after this handler is called, then again the channel status will be overwritten
>    to DMA_IN_PROGRESS. Then the following dmaengine_prep_dma_cyclic() will always fail,
>    as channel status is DMA_IN_PROGRESS.
> 
> As in cyclic dma tx, channel status will be initially set to DMA_IN_PROGRESS,
> driver only needs to change it to DMA_ERROR, when something wrong happens
> (one period status is wrong, or stoped by client explicitly).

Applied, thanks

-- 
~Vinod
