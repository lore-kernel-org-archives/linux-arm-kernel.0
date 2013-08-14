From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Aug 2013 17:23:18 +0100
Subject: [v3 1/2] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <1376497189-21298-1-git-send-email-zonque@gmail.com>
References: <1376497189-21298-1-git-send-email-zonque@gmail.com>
Message-ID: <20130814162318.GX23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 06:19:48PM +0200, Daniel Mack wrote:
> +static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan)
> +{
> +	struct mmp_pdma_desc_sw *sw;
> +	u32 curr, done = 0;
> +
> +	if (chan->dir == DMA_DEV_TO_MEM)
> +		curr = readl(chan->phy->base + DTADR(chan->phy->idx));
> +	else
> +		curr = readl(chan->phy->base + DSADR(chan->phy->idx));
> +
> +	list_for_each_entry(sw, &chan->chain_running, node) {
> +		u32 start;
> +		u32 len = sw->desc.dcmd & DCMD_LENGTH;
> +
> +		if (chan->dir == DMA_DEV_TO_MEM)
> +			start = sw->desc.dtadr;
> +		else
> +			start = sw->desc.dsadr;
> +
> +		if (curr >= start && curr <= (start + len)) {
> +			done += curr - start;
> +			break;
> +		}
> +
> +		done += len;
> +	}
> +
> +	return chan->total_len - done;

Yep, that should be sufficient.  Thanks for fixing that.
