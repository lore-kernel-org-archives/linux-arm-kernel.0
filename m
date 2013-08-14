From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Aug 2013 13:45:20 +0530
Subject: [PATCH v2 09/11] dma: mmp_pdma: implement DMA_PAUSE and DMA_RESUME
In-Reply-To: <1376153545-14361-10-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
 <1376153545-14361-10-git-send-email-zonque@gmail.com>
Message-ID: <20130814081520.GJ32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 06:52:23PM +0200, Daniel Mack wrote:
> This is needed at least for audio operation.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/dma/mmp_pdma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index 579f79a..7a0956b 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -659,6 +659,12 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
>  		if (cfg->slave_id)
>  			chan->drcmr = cfg->slave_id;
>  		break;
> +	case DMA_PAUSE:
> +		disable_chan(chan->phy);
> +		break;
> +	case DMA_RESUME:
> +		start_pending_queue(chan);
This is your usual start_pending ops. The meaning of pause and resume is NOT to
drop current descriptor and start from next one. You need to start from where
you had left off.

The way I see in this driver you are going to pick next descriptor and since
usage is audio, imply loss of audio in puase-resume case.

You need to resume here, not start next one

~Vinod
