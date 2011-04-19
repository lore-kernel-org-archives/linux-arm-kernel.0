From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 19 Apr 2011 09:55:15 +0100
Subject: [PATCH V2 7/7] dmaengine/dw_dmac: implement pause and resume in
	dwc_control
In-Reply-To: <a1168e413888e35badd9fab6b1626fcfe355dc9b.1303194836.git.viresh.kumar@st.com>
References: <cover.1303194835.git.viresh.kumar@st.com>
	<a1168e413888e35badd9fab6b1626fcfe355dc9b.1303194836.git.viresh.kumar@st.com>
Message-ID: <20110419085514.GG2820@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 02:02:12PM +0530, Viresh Kumar wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Some peripherals like amba-pl011 needs pause to be implemented in DMA controller
> drivers. This also returns correct status from dwc_tx_status() in case chan is
> paused.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/dw_dmac.c      |   25 +++++++++++++++++++++++--
>  drivers/dma/dw_dmac_regs.h |    1 +
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
> index c30f0ba..48d2d7e 100644
> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c
> @@ -832,8 +832,7 @@ static int dwc_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>  	struct dw_desc		*desc, *_desc;
>  	LIST_HEAD(list);
>  
> -	/* Only supports DMA_TERMINATE_ALL */
> -	if (cmd != DMA_TERMINATE_ALL)
> +	if (cmd != DMA_TERMINATE_ALL && cmd != DMA_PAUSE && cmd != DMA_RESUME)
>  		return -ENXIO;
>  
>  	/*
> @@ -844,11 +843,30 @@ static int dwc_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>  	 */
>  	spin_lock_irqsave(&dwc->lock, dwc->lflags);
>  
> +	if (cmd == DMA_RESUME) {
> +		if (dwc->paused) {
> +			channel_set_bit(dw, CH_EN, dwc->mask);
> +			while (!(dma_readl(dw, CH_EN) & dwc->mask))
> +				cpu_relax();
> +		}
> +		spin_unlock_irqrestore(&dwc->lock, dwc->lflags);
> +		return 0;
> +	}
> +
>  	channel_clear_bit(dw, CH_EN, dwc->mask);
>  
>  	while (dma_readl(dw, CH_EN) & dwc->mask)
>  		cpu_relax();
>  
> +	if (cmd == DMA_PAUSE) {
> +		dwc->paused = true;
> +		spin_unlock_irqrestore(&dwc->lock, dwc->lflags);
> +		return 0;
> +	}
