From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 27 Aug 2015 10:57:12 +0200
Subject: [PATCH 1/5] DMA: pl330: support burst mode for dev-to-mem and
 mem-to-dev transmit
In-Reply-To: <1440665313-31603-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440665280-31557-1-git-send-email-shawn.lin@rock-chips.com>
 <1440665313-31603-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <7170592.bdD8VT9GQ2@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,


you're loosing the original author. Your can override the patch-author (away 
from the mail sender) via a "From:" line at the top of the commit message, 
like:

------
From: Boojin Kim <boojin.kim@samsung.com>

This patch adds to support burst mode for dev-to-mem and
mem-to-dev transmit.
...
------


> This patch adds to support burst mode for dev-to-mem and
> mem-to-dev transmit.
> 
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> cc: Heiko Stuebner <heiko@sntech.de>
> cc: Doug Anderson <dianders@chromium.org>
> cc: Olof Johansson <olofj@google.com>
> Reviewed-and-tested-by: Sonny Rao <sonnyrao@chromium.org>
> 
> ---
> 
>  drivers/dma/pl330.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index ecab4ea0..0d544d2 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -1141,10 +1141,13 @@ static inline int _ldst_devtomem(unsigned dry_run,
> u8 buf[], const struct _xfer_spec *pxs, int cyc)
>  {
>  	int off = 0;
> +	enum pl330_cond cond;
> +
> +	cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
> 
>  	while (cyc--) {
> -		off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
> -		off += _emit_LDP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
> +		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
> +		off += _emit_LDP(dry_run, &buf[off], cond, pxs->desc->peri);
>  		off += _emit_ST(dry_run, &buf[off], ALWAYS);
>  		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
>  	}
> @@ -1156,11 +1159,14 @@ static inline int _ldst_memtodev(unsigned dry_run,
> u8 buf[], const struct _xfer_spec *pxs, int cyc)
>  {
>  	int off = 0;
> +	enum pl330_cond cond;
> +
> +	cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
> 
>  	while (cyc--) {
> -		off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
> +		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
>  		off += _emit_LD(dry_run, &buf[off], ALWAYS);
> -		off += _emit_STP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
> +		off += _emit_STP(dry_run, &buf[off], cond, pxs->desc->peri);
>  		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
>  	}
> 
> @@ -2557,7 +2563,7 @@ static struct dma_async_tx_descriptor
> *pl330_prep_dma_cyclic(
> 
>  		desc->rqtype = direction;
>  		desc->rqcfg.brst_size = pch->burst_sz;
> -		desc->rqcfg.brst_len = 1;
> +		desc->rqcfg.brst_len = pch->burst_len;
>  		desc->bytes_requested = period_len;
>  		fill_px(&desc->px, dst, src, period_len);
> 
> @@ -2702,7 +2708,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct
> scatterlist *sgl, }
> 
>  		desc->rqcfg.brst_size = pch->burst_sz;
> -		desc->rqcfg.brst_len = 1;
> +		desc->rqcfg.brst_len = pch->burst_len;
>  		desc->rqtype = direction;
>  		desc->bytes_requested = sg_dma_len(sg);
>  	}
