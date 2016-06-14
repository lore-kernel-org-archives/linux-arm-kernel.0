From: eric@anholt.net (Eric Anholt)
Date: Mon, 13 Jun 2016 22:06:49 -0700
Subject: [PATCH 2/2] dmaengine: bcm2835: Avoid splitting periods into very
 small chunks
In-Reply-To: <1465472504-10191-3-git-send-email-hias@horus.com>
References: <1465472504-10191-1-git-send-email-hias@horus.com>
 <1465472504-10191-3-git-send-email-hias@horus.com>
Message-ID: <8760tcwe8m.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matthias Reichl <hias@horus.com> writes:

> The current cyclic DMA period splitting implementation can generate
> very small chunks at the end of each period. For example a 65536 byte
> period will be split into a 65532 byte chunk and a 4 byte chunk on
> the "lite" DMA channels.
>
> This increases pressure on the RAM controller as the DMA controller
> needs to fetch two control blocks from RAM in quick succession and
> could potentially cause latency issues if the RAM is tied up by other
> devices.
>
> We can easily avoid these situations by distributing the remaining
> length evenly between the last-but-one and the last chunk, making
> sure that split chunks will be at least half the maximum length the
> DMA controller can handle.
>
> This patch checks if the last chunk would be less than half of
> the maximum DMA length and if yes distributes the max len+4...max_len*1.5
> bytes evenly between the last 2 chunks. This results in chunk sizes
> between max_len/2 and max_len*0.75 bytes.
>
> Signed-off-by: Matthias Reichl <hias@horus.com>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> Tested-by: Clive Messer <clive.messer@digitaldreamtime.co.uk>
> ---
>  drivers/dma/bcm2835-dma.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 344bcf92..36b998d 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -252,6 +252,20 @@ static void bcm2835_dma_create_cb_set_length(
>  
>  	/* have we filled in period_length yet? */
>  	if (*total_len + control_block->length < period_len) {
> +		/*
> +		 * If the next control block is the last in the period
> +		 * and it's length would be less than half of max_len
> +		 * change it so that both control blocks are (almost)
> +		 * equally long. This avoids generating very short
> +		 * control blocks (worst case would be 4 bytes) which
> +		 * might be problematic. We also have to make sure the
> +		 * new length is a multiple of 4 bytes.
> +		 */
> +		if (*total_len + control_block->length + max_len / 2 >
> +		    period_len) {
> +			control_block->length =
> +				DIV_ROUND_UP(period_len - *total_len, 8) * 4;
> +		}
>  		/* update number of bytes in this period so far */
>  		*total_len += control_block->length;
>  		return;

It seems to me like this would all be a lot simpler if we always split
the last 2 control blocks evenly (other than 4-byte rounding):

u32 period_remaining = period_len - *total_len;

/* Early exit if we aren't finishing this period */
if (period_remaining >= max_len) {
	/*
	 * Split the length between the last 2 CBs, to help hide the
	 * latency of fetching the CBs.
	 */
	if (period_remaining < max_len * 2) {
		control_block->length =
                	DIV_ROUND_UP(period_remaining, 8) * 4;
        }
	/* update number of bytes in this period so far */
	*total_len += control_block->length;
}

I'm about to go semi-AFK for a couple weeks.  If there's a good reason
to only do this when the last block is very short, I'm fine with:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/51301430/attachment.sig>
