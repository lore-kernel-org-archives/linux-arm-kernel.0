From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 9 Jan 2017 11:27:44 -0500
Subject: [PATCH v4 3/3] drm: zte: add overlay plane support
In-Reply-To: <1483972544-12731-4-git-send-email-shawnguo@kernel.org>
References: <1483972544-12731-1-git-send-email-shawnguo@kernel.org>
 <1483972544-12731-4-git-send-email-shawnguo@kernel.org>
Message-ID: <CAOw6vbLrHuEa_L9uW6X-_ZMkfXyGjaFACFoedVYN1epeMW+9=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 9, 2017 at 9:35 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
>
> It enables VOU VL (Video Layer) to support overlay plane with scaling
> function.  VL0 has some quirks on scaling support.  We choose to skip it
> and only adds VL1 and VL2 into DRM core for now.
>
> Function zx_plane_atomic_disable() gets moved around with no changes to
> save a forward declaration.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/gpu/drm/zte/zx_plane.c      | 301 +++++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/zte/zx_plane.h      |   1 +
>  drivers/gpu/drm/zte/zx_plane_regs.h |  51 ++++++
>  drivers/gpu/drm/zte/zx_vou.c        |  84 +++++++++-
>  drivers/gpu/drm/zte/zx_vou_regs.h   |  18 +++
>  5 files changed, 426 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/zte/zx_plane.c b/drivers/gpu/drm/zte/zx_plane.c
> index 5445eebf830f..24426c2b4b8f 100644

<snip>

> diff --git a/drivers/gpu/drm/zte/zx_vou.c b/drivers/gpu/drm/zte/zx_vou.c
> index 3fb4fc04e693..8e7edda184d0 100644
> --- a/drivers/gpu/drm/zte/zx_vou.c
> +++ b/drivers/gpu/drm/zte/zx_vou.c
> @@ -112,6 +112,22 @@ struct vou_layer_bits {
>         },
>  };
>
> +static const struct vou_layer_bits zx_vl_bits[VL_NUM] = {
> +       {
> +               .enable = OSD_CTRL0_VL0_EN,
> +               .chnsel = OSD_CTRL0_VL0_SEL,
> +               .clksel = VOU_CLK_VL0_SEL,
> +       }, {
> +               .enable = OSD_CTRL0_VL1_EN,
> +               .chnsel = OSD_CTRL0_VL1_SEL,
> +               .clksel = VOU_CLK_VL1_SEL,
> +       }, {
> +               .enable = OSD_CTRL0_VL2_EN,
> +               .chnsel = OSD_CTRL0_VL2_SEL,
> +               .clksel = VOU_CLK_VL2_SEL,
> +       },
> +};
> +
>  struct zx_vou_hw {
>         struct device *dev;
>         void __iomem *osd;
> @@ -125,6 +141,7 @@ struct zx_vou_hw {
>         struct clk *aux_clk;
>         struct zx_crtc *main_crtc;
>         struct zx_crtc *aux_crtc;
> +       struct drm_plane *overlays[VL_NUM];
>  };
>
>  static inline struct zx_vou_hw *crtc_to_vou(struct drm_crtc *crtc)
> @@ -439,6 +456,8 @@ void zx_vou_layer_enable(struct drm_plane *plane)
>         }
>
>         zx_writel_mask(vou->osd + OSD_CTRL0, bits->enable, bits->enable);
> +
> +       zplane->enabled = true;
>  }
>
>  void zx_vou_layer_disable(struct drm_plane *plane)
> @@ -449,6 +468,57 @@ void zx_vou_layer_disable(struct drm_plane *plane)
>         const struct vou_layer_bits *bits = zplane->bits;
>
>         zx_writel_mask(vou->osd + OSD_CTRL0, bits->enable, 0);
> +
> +       zplane->enabled = false;
> +}
> +
> +static void zx_overlay_init(struct drm_device *drm, struct zx_vou_hw *vou)
> +{
> +       struct device *dev = vou->dev;
> +       struct zx_plane *zplane;
> +       int i;
> +       int ret;
> +
> +       /*
> +        * VL0 has some quirks on scaling support which need special handling.
> +        * Let's leave it out for now.
> +        */
> +       for (i = 1; i < VL_NUM; i++) {
> +               zplane = devm_kzalloc(dev, sizeof(*zplane), GFP_KERNEL);
> +               if (!zplane) {
> +                       DRM_DEV_ERROR(dev, "failed to allocate zplane %d\n", i);
> +                       return;
> +               }
> +
> +               zplane->layer = vou->osd + OSD_VL_OFFSET(i);
> +               zplane->hbsc = vou->osd + HBSC_VL_OFFSET(i);
> +               zplane->rsz = vou->otfppu + RSZ_VL_OFFSET(i);
> +               zplane->bits = &zx_vl_bits[i];
> +
> +               ret = zx_plane_init(drm, zplane, DRM_PLANE_TYPE_OVERLAY);
> +               if (ret) {
> +                       DRM_DEV_ERROR(dev, "failed to init overlay %d\n", i);
> +                       continue;
> +               }
> +
> +               vou->overlays[i] = &zplane->plane;
> +       }
> +}
> +
> +static inline void zx_osd_int_update(struct zx_crtc *zcrtc)
> +{
> +       struct zx_vou_hw *vou = zcrtc->vou;
> +       int i;
> +
> +       vou_chn_set_update(zcrtc);
> +       zx_plane_set_update(zcrtc->primary);
> +
> +       for (i = 0; i < VL_NUM; i++) {
> +               struct drm_plane *overlay = vou->overlays[i];
> +
> +               if (overlay)
> +                       zx_plane_set_update(overlay);
> +       }

Hi Shawn,
Thanks so much for revving this patch, it's looking really good. I
just have one (1.5, really) suggestion.

I don't think we need to keep vou->overlays around. You should be able
to loop through all the planes registered with drm core and use
crtc->state->plane_mask to determine which are active for a given crtc
(this would also encapsulate the zcrtc->primary update above).

I think you can also use if (plane->state->crtc) as your
enable/disable check in zx_plane_set_update() and eliminate the new
enabled flag. I fully realize this was my suggestion, and I apologize
for the churn. I'll try not to do reviews past midnight again :-)

Sean

>  }
>
>  static irqreturn_t vou_irq_handler(int irq, void *dev_id)
> @@ -470,15 +540,11 @@ static irqreturn_t vou_irq_handler(int irq, void *dev_id)
>         state = zx_readl(vou->osd + OSD_INT_STA);
>         zx_writel(vou->osd + OSD_INT_CLRSTA, state);
>
> -       if (state & OSD_INT_MAIN_UPT) {
> -               vou_chn_set_update(vou->main_crtc);
> -               zx_plane_set_update(vou->main_crtc->primary);
> -       }
> +       if (state & OSD_INT_MAIN_UPT)
> +               zx_osd_int_update(vou->main_crtc);
>
> -       if (state & OSD_INT_AUX_UPT) {
> -               vou_chn_set_update(vou->aux_crtc);
> -               zx_plane_set_update(vou->aux_crtc->primary);
> -       }
> +       if (state & OSD_INT_AUX_UPT)
> +               zx_osd_int_update(vou->aux_crtc);
>
>         if (state & OSD_INT_ERROR)
>                 DRM_DEV_ERROR(vou->dev, "OSD ERROR: 0x%08x!\n", state);
> @@ -648,6 +714,8 @@ static int zx_crtc_bind(struct device *dev, struct device *master, void *data)
>                 goto disable_ppu_clk;
>         }
>
> +       zx_overlay_init(drm, vou);
> +
>         return 0;
>
>  disable_ppu_clk:
> diff --git a/drivers/gpu/drm/zte/zx_vou_regs.h b/drivers/gpu/drm/zte/zx_vou_regs.h
> index f44e7a4ae441..193c1ce01fe7 100644
> --- a/drivers/gpu/drm/zte/zx_vou_regs.h
> +++ b/drivers/gpu/drm/zte/zx_vou_regs.h
> @@ -22,6 +22,15 @@
>  #define AUX_HBSC_OFFSET                        0x860
>  #define AUX_RSZ_OFFSET                 0x800
>
> +#define OSD_VL0_OFFSET                 0x040
> +#define OSD_VL_OFFSET(i)               (OSD_VL0_OFFSET + 0x050 * (i))
> +
> +#define HBSC_VL0_OFFSET                        0x760
> +#define HBSC_VL_OFFSET(i)              (HBSC_VL0_OFFSET + 0x040 * (i))
> +
> +#define RSZ_VL1_U0                     0xa00
> +#define RSZ_VL_OFFSET(i)               (RSZ_VL1_U0 + 0x200 * (i))
> +
>  /* OSD (GPC_GLOBAL) registers */
>  #define OSD_INT_STA                    0x04
>  #define OSD_INT_CLRSTA                 0x08
> @@ -42,6 +51,12 @@
>  )
>  #define OSD_INT_ENABLE (OSD_INT_ERROR | OSD_INT_AUX_UPT | OSD_INT_MAIN_UPT)
>  #define OSD_CTRL0                      0x10
> +#define OSD_CTRL0_VL0_EN               BIT(13)
> +#define OSD_CTRL0_VL0_SEL              BIT(12)
> +#define OSD_CTRL0_VL1_EN               BIT(11)
> +#define OSD_CTRL0_VL1_SEL              BIT(10)
> +#define OSD_CTRL0_VL2_EN               BIT(9)
> +#define OSD_CTRL0_VL2_SEL              BIT(8)
>  #define OSD_CTRL0_GL0_EN               BIT(7)
>  #define OSD_CTRL0_GL0_SEL              BIT(6)
>  #define OSD_CTRL0_GL1_EN               BIT(5)
> @@ -146,6 +161,9 @@
>  #define VOU_INF_DATA_SEL               0x08
>  #define VOU_SOFT_RST                   0x14
>  #define VOU_CLK_SEL                    0x18
> +#define VOU_CLK_VL2_SEL                        BIT(8)
> +#define VOU_CLK_VL1_SEL                        BIT(7)
> +#define VOU_CLK_VL0_SEL                        BIT(6)
>  #define VOU_CLK_GL1_SEL                        BIT(5)
>  #define VOU_CLK_GL0_SEL                        BIT(4)
>  #define VOU_CLK_REQEN                  0x20
> --
> 1.9.1
>



-- 
Sean Paul, Software Engineer, Google / Chromium OS
