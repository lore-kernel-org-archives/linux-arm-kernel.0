From: vinod.koul@intel.com (Koul, Vinod)
Date: Fri, 29 Jul 2011 17:46:39 +0530
Subject: [PATCH 09/18] dmaengine/amba-pl08x: Schedule tasklet in case
	of error interrupt
In-Reply-To: <9c81beb9cd84f84b58abbd24ebfae85dfe8d8ee1.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<9c81beb9cd84f84b58abbd24ebfae85dfe8d8ee1.1311936524.git.viresh.kumar@st.com>
Message-ID: <1311941799.1536.532.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
> Currently, if error interrupt occurs, nothing is done in interrupt handler (just
> clearing the interrupts). We must somehow indicate this to the user that DMA is
> over, due to ERR interrupt or TC interrupt.
> 
> So, this patch just schedules existing tasklet, with a print showing error
> interrupt has occured on which channels.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/amba-pl08x.c |   43 ++++++++++++++++++-------------------------
>  1 files changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index c4ce1a2..b9137bc 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -1630,40 +1630,33 @@ static void pl08x_tasklet(unsigned long data)
>  static irqreturn_t pl08x_irq(int irq, void *dev)
>  {
>  	struct pl08x_driver_data *pl08x = dev;
> -	u32 mask = 0;
> -	u32 val;
> -	int i;
> -
> -	val = readl(pl08x->base + PL080_ERR_STATUS);
> -	if (val) {
> -		/* An error interrupt (on one or more channels) */
> -		dev_err(&pl08x->adev->dev,
> -			"%s error interrupt, register value 0x%08x\n",
> -				__func__, val);
> -		/*
> -		 * Simply clear ALL PL08X error interrupts,
> -		 * regardless of channel and cause
> -		 * FIXME: should be 0x00000003 on PL081 really.
> -		 */
> -		writel(0x000000FF, pl08x->base + PL080_ERR_CLEAR);
> +	u32 err, tc, i;
> +
> +	/* check & clear - ERR & TC interrupts */
> +	err = readl(pl08x->base + PL080_ERR_STATUS);
> +	if (err) {
> +		dev_err(&pl08x->adev->dev, "%s error interrupt, register value"
> +				"0x%08x\n", __func__, err);
again this looks convoluted, and the stuff is quotes can be in single
line :)
> +		writel(err, pl08x->base + PL080_ERR_CLEAR);
>  	}
> -	val = readl(pl08x->base + PL080_INT_STATUS);
> -	for (i = 0; i < pl08x->vd->channels; i++) {
> -		if ((1 << i) & val) {
> +	tc = readl(pl08x->base + PL080_INT_STATUS);
> +	if (tc)
> +		writel(tc, pl08x->base + PL080_TC_CLEAR);
> +
> +	if (!err && !tc)
> +		return IRQ_NONE;
> +
> +	for (i = 0; i < pl08x->vd->channels; i++)
> +		if (((1 << i) & err) || ((1 << i) & tc)) {
>  			/* Locate physical channel */
>  			struct pl08x_phy_chan *phychan = &pl08x->phy_chans[i];
>  			struct pl08x_dma_chan *plchan = phychan->serving;
>  
>  			/* Schedule tasklet on this channel */
>  			tasklet_schedule(&plchan->tasklet);
but in tasklet you will call the client callback, so how does the client
know if this was success or error? Did I miss anything?
> -
> -			mask |= (1 << i);
>  		}
> -	}
> -	/* Clear only the terminal interrupts on channels we processed */
> -	writel(mask, pl08x->base + PL080_TC_CLEAR);
>  
> -	return mask ? IRQ_HANDLED : IRQ_NONE;
> +	return IRQ_HANDLED;
>  }
>  
>  static void pl08x_dma_slave_init(struct pl08x_dma_chan *chan)


-- 
~Vinod
