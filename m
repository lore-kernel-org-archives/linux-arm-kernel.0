From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 6 Mar 2014 20:44:40 +0530
Subject: [PATCH] dma: fsl-edma: fix static checker warning of NULL
 dereference
In-Reply-To: <1392965406-10112-1-git-send-email-b35083@freescale.com>
References: <1392965406-10112-1-git-send-email-b35083@freescale.com>
Message-ID: <20140306151440.GH1976@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 02:50:06PM +0800, Jingchang Lu wrote:
> The static checker reports following warning:
> 	drivers/dma/fsl-edma.c:732 fsl_edma_xlate()
> 	error: we previously assumed 'chan' could be null (see line 737)
> The changes of the loop cursor in the iteration may result in
> NULL dereference when dma_get_slave_channel failed but loop
> will continue. So use list_for_each_entry_safe() instead of
> list_for_each_entry() to against this.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>

Applied, thanks

-- 
~Vinod
> ---
>  drivers/dma/fsl-edma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
> index 9025300..381e793 100644
> --- a/drivers/dma/fsl-edma.c
> +++ b/drivers/dma/fsl-edma.c
> @@ -723,13 +723,13 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
>  		struct of_dma *ofdma)
>  {
>  	struct fsl_edma_engine *fsl_edma = ofdma->of_dma_data;
> -	struct dma_chan *chan;
> +	struct dma_chan *chan, *_chan;
>  
>  	if (dma_spec->args_count != 2)
>  		return NULL;
>  
>  	mutex_lock(&fsl_edma->fsl_edma_mutex);
> -	list_for_each_entry(chan, &fsl_edma->dma_dev.channels, device_node) {
> +	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels, device_node) {
>  		if (chan->client_count)
>  			continue;
>  		if ((chan->chan_id / DMAMUX_NR) == dma_spec->args[0]) {
> -- 
> 1.8.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
