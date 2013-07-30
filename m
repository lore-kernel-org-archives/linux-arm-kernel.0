From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 30 Jul 2013 10:48:37 +0530
Subject: [PATCH 3/9] ARM: edma: Add function to manually trigger an EDMA
 channel
In-Reply-To: <1375104595-16018-4-git-send-email-joelf@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
 <1375104595-16018-4-git-send-email-joelf@ti.com>
Message-ID: <51F74CAD.3040604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 July 2013 06:59 PM, Joel Fernandes wrote:
> Manual trigger for events missed as a result of splitting a
> scatter gather list and DMA'ing it in batches. Add a helper
> function to trigger a channel incase any such events are missed.
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  arch/arm/common/edma.c             |   21 +++++++++++++++++++++
>  include/linux/platform_data/edma.h |    2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 3567ba1..10995b2 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -1236,6 +1236,27 @@ void edma_resume(unsigned channel)
>  }
>  EXPORT_SYMBOL(edma_resume);
>  
> +int edma_manual_trigger(unsigned channel)

edma_trigger_channel() maybe? Brings consistency with
edma_alloc_channel() edma_free_channel() etc.

> +{
> +	unsigned ctlr;
> +	int j;
> +	unsigned int mask;
> +
> +	ctlr = EDMA_CTLR(channel);
> +	channel = EDMA_CHAN_SLOT(channel);
> +	mask = BIT(channel & 0x1f);
> +
> +	j = channel >> 5;
> +
> +	/* EDMA channels without event association */

May be actually check for no-event association before you trigger in
software? You can do that by looking at unused channel list, no?

> +	edma_shadow0_write_array(ctlr, SH_ESR, j, mask);

edma_shadow0_write_array(ctlr, SH_ESR, channel >> 5, mask) is no less
readable, but I leave it to you.

Thanks,
Sekhar
