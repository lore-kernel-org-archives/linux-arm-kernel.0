From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 11 Mar 2016 13:02:18 +0530
Subject: [PATCH 5/5] dmaengine: sun6i: Add cyclic capability
In-Reply-To: <350ad364b3e46f53159ff71aa611c432b4c588e0.1457606136.git.moinejf@free.fr>
References: <cover.1457606136.git.moinejf@free.fr>
 <350ad364b3e46f53159ff71aa611c432b4c588e0.1457606136.git.moinejf@free.fr>
Message-ID: <20160311073218.GT11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 11:21:34AM +0100, Jean-Francois Moine wrote:

> +
> +	if (vchan->cyclic && vchan->phy && vchan->phy->desc)
> +		return NULL;

why check for vchan->cyclic? you are setting that at the end!

> @@ -792,6 +903,11 @@ static void sun6i_dma_issue_pending(struct dma_chan *chan)
>  	spin_lock_irqsave(&vchan->vc.lock, flags);
>  
>  	if (vchan_issue_pending(&vchan->vc)) {
> +		if (vchan->phy && vchan->cyclic) {
> +			sun6i_dma_start_desc(vchan);
> +			goto out;
> +		}

Why should this be cyclic specfic, Channel start should be same for all
channels?

> +static int sun6i_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
> +
> +	vchan->cyclic = false;

why do you need to set this here?

-- 
~Vinod
