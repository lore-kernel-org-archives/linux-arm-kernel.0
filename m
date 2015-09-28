From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 28 Sep 2015 10:00:08 +0300
Subject: [PATCH 1/1] dmaengine: dw: fix nollp issue
In-Reply-To: <032901d0f999$363fae80$a2bf0b80$@tangramtek.com>
References: <032901d0f999$363fae80$a2bf0b80$@tangramtek.com>
Message-ID: <CAHp75Vd-AUrNdT6_yxwHbx49JHTVO+-ZkQTJ5xijebW1gFdp0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 5:55 AM, yitian <yitian.bu@tangramtek.com> wrote:
> when channel number is less than maximum number, the register
> address of all channels is wrong, which causes the "nollp" flag
> is set for all channels even if HW supports llp.
>

Thanks for the fix, though proper one is already under review here:
http://www.spinics.net/lists/dmaengine/msg06143.html

You might break a channel prioritization.

> Signed-off-by: Yitian Bu <yitian.bu@tangramtek.com>
> ---
>  drivers/dma/dw/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index cf1c87f..c2e9ac8 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -1591,7 +1591,7 @@ int dw_dma_probe(struct dw_dma_chip *chip, struct
> dw_dma_platform_data *pdata)
>         INIT_LIST_HEAD(&dw->dma.channels);
>         for (i = 0; i < nr_channels; i++) {
>                 struct dw_dma_chan      *dwc = &dw->chan[i];
> -               int                     r = nr_channels - i - 1;
> +               int                     r = DW_DMA_MAX_NR_CHANNELS - i - 1;
>
>                 dwc->chan.device = &dw->dma;
>                 dma_cookie_init(&dwc->chan);
> --
> 1.7.12.4
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
