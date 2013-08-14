From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Aug 2013 13:46:43 +0100
Subject: [v2 rebased 1/2] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <1376483121-11306-1-git-send-email-zonque@gmail.com>
References: <1376483121-11306-1-git-send-email-zonque@gmail.com>
Message-ID: <20130814124643.GP23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 02:25:20PM +0200, Daniel Mack wrote:
> In order to report the channel's residue, we have to memorize the first
> dma buffer position when the channel is configured.

This is actually broken, and I'm surprised that Vinod even suggested it.

Think about what happens with a scatter-gather list where the addresses
of each element really are scattered in memory.  Let's say that the
N'th element is at a lower address than the first element, and we're on
that N'th element.  What happens when curr is less than chan->start_addr
here:

> +static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan)
> +{
> +	u32 curr, done;
> +
> +	if (chan->dir == DMA_DEV_TO_MEM)
> +		curr = readl(chan->phy->base + DTADR(chan->phy->idx));
> +	else
> +		curr = readl(chan->phy->base + DSADR(chan->phy->idx));
> +
> +	done = curr - chan->start_addr;
> +
> +	return chan->total_len - done;
> +}
