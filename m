From: wangx@marvell.com (Xiang Wang)
Date: Fri, 16 Aug 2013 15:57:53 +0800
Subject: [v3 1/2] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <1376497189-21298-1-git-send-email-zonque@gmail.com>
References: <1376497189-21298-1-git-send-email-zonque@gmail.com>
Message-ID: <520DDB81.20607@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2013 12:19 AM, Daniel Mack wrote:
> In order to report the channel's residue, we have to memorize the first
> dma buffer position when the channel is configured.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>   drivers/dma/mmp_pdma.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 43 insertions(+), 2 deletions(-)
>

> +static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan)
> +{
> +	struct mmp_pdma_desc_sw *sw;
> +	u32 curr, done = 0;
> +
> +	if (chan->dir == DMA_DEV_TO_MEM)
> +		curr = readl(chan->phy->base + DTADR(chan->phy->idx));
One concern for this patch:
If we call dmaengine_tx_status() after dma_do_tasklet at mmp_pdma.c, 
chan->phy will most likely to be NULL.
dma_do_tasklet() -> start_pending_queue() -> mmp_pdma_free_phy()

For why do we call dmaengine_tx_status() after a DMA interrupt:
briefly, if we use DMA to handle device trailing bytes, it'll report a 
DMA interrupt. We need to get to know how many bytes have been received 
in the IRQ handler.
We've discussed about this in the link below:
http://thread.gmane.org/gmane.linux.kernel/1500713

-- 
Regards,
Xiang
