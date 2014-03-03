From: joe@perches.com (Joe Perches)
Date: Sun, 02 Mar 2014 22:49:12 -0800
Subject: [Patch v8 2/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <1393828245-18766-3-git-send-email-agross@codeaurora.org>
References: <1393828245-18766-1-git-send-email-agross@codeaurora.org>
 <1393828245-18766-3-git-send-email-agross@codeaurora.org>
Message-ID: <1393829352.13719.73.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-03 at 00:30 -0600, Andy Gross wrote:
> Add the DMA engine driver for the QCOM Bus Access Manager (BAM) DMA controller
> found in the MSM 8x74 platforms.
> 
> Each BAM DMA device is associated with a specific on-chip peripheral.  Each
> channel provides a uni-directional data transfer engine that is capable of
> transferring data between the peripheral and system memory (System mode), or
> between two peripherals (BAM2BAM).
[]

trivia:

> +static u32 process_channel_irqs(struct bam_device *bdev)
> +{
[]
> +	for (i = 0; i < bdev->num_channels; i++) {
> +		struct bam_chan *bchan = &bdev->channels[i];
> +		if (srcs & BIT(i)) {
> +			/* clear pipe irq */
> +			pipe_stts = readl_relaxed(bdev->regs +
> +				BAM_P_IRQ_STTS(i));
> +
> +			writel_relaxed(pipe_stts, bdev->regs +
> +					BAM_P_IRQ_CLR(i));
> +
> +			spin_lock_irqsave(&bchan->vc.lock, flags);
> +			async_desc = bchan->curr_txd;
> +
> +			if (async_desc) {
> +				async_desc->num_desc -= async_desc->xfer_len;
> +				async_desc->curr_desc += async_desc->xfer_len;
> +				bchan->curr_txd = NULL;
> +
> +				/* manage FIFO */
> +				bchan->head += async_desc->xfer_len;
> +				bchan->head %= MAX_DESCRIPTORS;
> +
> +				/*
> +				 * if complete, process cookie.  Otherwise
> +				 * push back to front of desc_issued so that
> +				 * it gets restarted by the tasklet
> +				 */
> +				if (!async_desc->num_desc)
> +					vchan_cookie_complete(&async_desc->vd);
> +				else
> +					list_add(&async_desc->vd.node,
> +						&bchan->vc.desc_issued);
> +			}
> +
> +			spin_unlock_irqrestore(&bchan->vc.lock, flags);
> +		}
> +	}

This could be written with fewer indents using continue
(and maybe faster using ffs too)

	for (i = 0; i < bdev->num_channels; i++) {
		struct bam_chan *bchan;

		if (!(srcs & BIT(i)))
			continue;

		bchan = &bdev->channels[i];

		/* clear pipe irq */
		pipe_stts = readl_relaxed(bdev->regs + BAM_P_IRQ_STTS(i));
		writel_relaxed(pipe_stts, bdev->regs + BAM_P_IRQ_CLR(i));

		etc...
