From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 30 Nov 2016 14:42:39 +0800
Subject: [PATCH v10 02/13] drm/mediatek: add *driver_data for different
 hardware settings
In-Reply-To: <1480070076-6196-3-git-send-email-yt.shen@mediatek.com>
References: <1480070076-6196-1-git-send-email-yt.shen@mediatek.com>
 <1480070076-6196-3-git-send-email-yt.shen@mediatek.com>
Message-ID: <CAGS+omDmMq7AEnyDzo4Oih_f+g4DE1Jz6xiV=+_3JGtSAfd+-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi YT,


On Fri, Nov 25, 2016 at 6:34 PM, YT Shen <yt.shen@mediatek.com> wrote:
>
> There are some hardware settings changed, between MT8173 & MT2701:
> DISP_OVL address offset changed, color format definition changed.
> DISP_RDMA fifo size changed.
> DISP_COLOR offset changed.
> MIPI_TX pll setting changed.
> And add prefix for mtk_ddp_main & mtk_ddp_ext & mutex_mod.

Sorry, I have not had time to thoroughly review the new patch set, but
one quick comment:

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 22a33ee..cfaa760 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -78,6 +78,10 @@ struct mtk_ddp_comp_funcs {
>                           struct drm_crtc_state *state);
>  };
>
> +struct mtk_ddp_comp_driver_data {
> +       unsigned int color_offset;
> +};
> +
>  struct mtk_ddp_comp {
>         struct clk *clk;
>         void __iomem *regs;
> @@ -85,6 +89,7 @@ struct mtk_ddp_comp {
>         struct device *larb_dev;
>         enum mtk_ddp_comp_id id;
>         const struct mtk_ddp_comp_funcs *funcs;
> +       const struct mtk_ddp_comp_driver_data *data;

I want to avoid adding this generic pointer here to all mtk_ddp_comp,
since this is only used by the color component.
Instead, define color specific types:

struct mtk_disp_color_data {
       unsigned int offset;
};

struct mtk_disp_color {
       struct mtk_ddp_comp             ddp_comp;
       const struct mtk_disp_color_data *data;
};

Then, add another comp_type check and fetch the dev data in
mtk_drm_probe()  or maybe mtk_ddp_comp_init().

-Dan
