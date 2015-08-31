From: sonnyrao@chromium.org (Sonny Rao)
Date: Mon, 31 Aug 2015 15:22:59 -0700
Subject: [PATCH v2 1/5] DMA: pl330: support burst mode for dev-to-mem and
 mem-to-dev transmit
In-Reply-To: <1440722268-31637-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440722176-31588-1-git-send-email-shawn.lin@rock-chips.com>
 <1440722268-31637-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <CAPz6YkWOV0fZGF=Ac6WuZV-rAO8gpS8zuuSSpPPHd_-eeJxQ_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 5:37 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> From: Boojin Kim <boojin.kim@samsung.com>
>
> This patch adds to support burst mode for dev-to-mem and
> mem-to-dev transmit.
>
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> cc: Heiko Stuebner <heiko@sntech.de>
> cc: Doug Anderson <dianders@chromium.org>
> cc: Olof Johansson <olof@lixom.net>
>
> ---
>
> Changes in v2:
> - amend the author
> - amend Olof's mail address
>
> Changes in v1:
> - rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
>   by Krzysztof.
> - add From original author.
> - remove Sunny's tag
>
>  drivers/dma/pl330.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index ecab4ea0..0d544d2 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -1141,10 +1141,13 @@ static inline int _ldst_devtomem(unsigned dry_run, u8 buf[],
>                 const struct _xfer_spec *pxs, int cyc)
>  {
>         int off = 0;
> +       enum pl330_cond cond;
> +
> +       cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
>
>         while (cyc--) {
> -               off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
> -               off += _emit_LDP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
> +               off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
> +               off += _emit_LDP(dry_run, &buf[off], cond, pxs->desc->peri);
>                 off += _emit_ST(dry_run, &buf[off], ALWAYS);
>                 off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
>         }
> @@ -1156,11 +1159,14 @@ static inline int _ldst_memtodev(unsigned dry_run, u8 buf[],
>                 const struct _xfer_spec *pxs, int cyc)
>  {
>         int off = 0;
> +       enum pl330_cond cond;
> +
> +       cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
>
>         while (cyc--) {
> -               off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
> +               off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
>                 off += _emit_LD(dry_run, &buf[off], ALWAYS);
> -               off += _emit_STP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
> +               off += _emit_STP(dry_run, &buf[off], cond, pxs->desc->peri);
>                 off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
>         }
>
> @@ -2557,7 +2563,7 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
>
>                 desc->rqtype = direction;
>                 desc->rqcfg.brst_size = pch->burst_sz;
> -               desc->rqcfg.brst_len = 1;
> +               desc->rqcfg.brst_len = pch->burst_len;
>                 desc->bytes_requested = period_len;
>                 fill_px(&desc->px, dst, src, period_len);
>
> @@ -2702,7 +2708,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>                 }
>
>                 desc->rqcfg.brst_size = pch->burst_sz;
> -               desc->rqcfg.brst_len = 1;
> +               desc->rqcfg.brst_len = pch->burst_len;
>                 desc->rqtype = direction;
>                 desc->bytes_requested = sg_dma_len(sg);
>         }
> --
> 2.3.7

Reviewed-by: Sonny Rao <sonnyrao@chromium.org>

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
