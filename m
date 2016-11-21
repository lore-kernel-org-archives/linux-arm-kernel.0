From: yt.shen@mediatek.com (YT Shen)
Date: Mon, 21 Nov 2016 22:28:48 +0800
Subject: [PATCH v9 02/10] drm/mediatek: add *driver_data for different
 hardware settings
In-Reply-To: <CAGS+omAa_SLg8WKfXXvZ-UT6-Mdep28FQVJuuwfskNqP2x50eg@mail.gmail.com>
References: <1478865346-19043-1-git-send-email-yt.shen@mediatek.com>
 <1478865346-19043-3-git-send-email-yt.shen@mediatek.com>
 <CAGS+omAa_SLg8WKfXXvZ-UT6-Mdep28FQVJuuwfskNqP2x50eg@mail.gmail.com>
Message-ID: <1479738528.15207.51.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, 2016-11-18 at 12:56 +0800, Daniel Kurtz wrote:
> Hi YT,
> 
> I don't see a reason to handle device_data in such a generic way at
> the generic mtk_ddp_comp layer.
> The device data is very component specific, so just define different
> structs for different comp types, ie:
> 
> struct mtk_disp_ovl_driver_data {
>     unsigned int reg_ovl_addr;
>     unsigned int fmt_rgb565;
>     unsigned int fmt_rgb888;
> };
> 
> struct mtk_disp_rdma_driver_data {
>     unsigned int fifo_pseudo_size;
> };
> 
> struct mtk_disp_color_driver_data {
>     unsigned int color_offset;
> };
> 
> Then add typed pointers to the local structs that use them, for example:
> 
> struct mtk_disp_ovl {
>         struct mtk_ddp_comp             ddp_comp;
>         struct drm_crtc                 *crtc;
>         const struct mtk_disp_ovl_driver_data *data;
> };
> 
> And fetch the device specific driver data directly in .probe, as you
> are already doing:
> 
> static int mtk_disp_ovl_probe(struct platform_device *pdev) {
>   ...
>   priv->data = of_device_get_match_data(dev);
>   ...
> }
These suggestions make code more readable.  We will change ovl and rdma
part, and keep mtk_disp_color_driver_data in its original place.
Because ovl and rdma have its files, other modules share
mtk_drm_ddp_comp.c.

> 
> More comments in-line...
> 
> On Fri, Nov 11, 2016 at 7:55 PM, YT Shen <yt.shen@mediatek.com> wrote:
> > There are some hardware settings changed, between MT8173 & MT2701:
> > DISP_OVL address offset changed, color format definition changed.
> > DISP_RDMA fifo size changed.
> > DISP_COLOR offset changed.
> > MIPI_TX pll setting changed.
> > And add prefix for mtk_ddp_main & mtk_ddp_ext & mutex_mod.
> 
> Nit: I think it would make sense to combine this patch with
> drm/mediatek: rename macros, add chip prefix
Will do.

> 
> >
> > Signed-off-by: YT Shen <yt.shen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 27 ++++++++++++++++-----------
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 11 +++++++++--
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 11 +++++++----
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 27 +++++++++++++++++++++------
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 13 +++++++++++++
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 25 ++++++++++++++++++-------
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |  8 ++++++++
> >  drivers/gpu/drm/mediatek/mtk_mipi_tx.c      | 24 +++++++++++++++++++++++-
> >  8 files changed, 115 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > index 019b7ca..1139834 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > @@ -35,13 +35,10 @@
> >  #define DISP_REG_OVL_PITCH(n)                  (0x0044 + 0x20 * (n))
> >  #define DISP_REG_OVL_RDMA_CTRL(n)              (0x00c0 + 0x20 * (n))
> >  #define DISP_REG_OVL_RDMA_GMC(n)               (0x00c8 + 0x20 * (n))
> > -#define DISP_REG_OVL_ADDR(n)                   (0x0f40 + 0x20 * (n))
> 
> Also, I would still use the "#define macros", for example
> "DISP_REG_OVL_ADDR offsets, and use the named constant in the
> driver_data:
> 
> #define DISP_REG_OVL_ADDR_MT8173  0x0f40
> 
> (and in a later patch:
> #define DISP_REG_OVL_ADDR_MT2701  0x0040
> )
> 
> Also, I would still use the macro rather than open coding the "0x20 *
> (n)", and just pass 'ovl' to the overlay macros that depend on
> hardware type.
> Something like the following:
> 
> #define DISP_REG_OVL_ADDR(ovl, n)  ((ovl)->data->ovl_addr + 0x20 * (n))
Will use the "#define macros" here.

> 
> >
> >  #define        OVL_RDMA_MEM_GMC        0x40402020
> >
> >  #define OVL_CON_BYTE_SWAP      BIT(24)
> > -#define OVL_CON_CLRFMT_RGB565  (0 << 12)
> > -#define OVL_CON_CLRFMT_RGB888  (1 << 12)
> 
> This seems like a really random and unnecessary hardware change.
> Why chip designers, why!!?!?
There are many reasons for software bugs.  Unnecessary hardware change
should be one of them...

> 
> For this one, it seems the polarity is either one way or the other, so
> we can just use a bool to distinguish:
> 
>   bool fmt_rgb565_is_0;
> 
> > +static const struct mtk_ddp_comp_driver_data mt8173_ovl_driver_data = {
> > +       .ovl = { DISP_REG_OVL_ADDR_MT8173, .fmt_rgb565_is_0 = true }
> > +};
> 
> For use at runtime, the defines could become:
> 
> #define OVL_CON_CLRFMT_RGB565(ovl)  ((ovl)->data->fmt_rgb565_is_0 ? 0
> : OVL_CON_CLRFMT_RGB888)
> #define OVL_CON_CLRFMT_RGB888(ovl)  ((ovl)->data->fmt_rgb565_is_0 ?
> OVL_CON_CLRFMT_RGB888 : 0)
OK, will do.

> 
> >  #define OVL_CON_CLRFMT_RGBA8888        (2 << 12)
> >  #define OVL_CON_CLRFMT_ARGB8888        (3 << 12)
> >  #define        OVL_CON_AEN             BIT(8)
> > @@ -137,18 +134,18 @@ static void mtk_ovl_layer_off(struct mtk_ddp_comp *comp, unsigned int idx)
> >         writel(0x0, comp->regs + DISP_REG_OVL_RDMA_CTRL(idx));
> >  }
> >
> > -static unsigned int ovl_fmt_convert(unsigned int fmt)
> > +static unsigned int ovl_fmt_convert(struct mtk_ddp_comp *comp, unsigned int fmt)
> >  {
> >         switch (fmt) {
> >         default:
> >         case DRM_FORMAT_RGB565:
> > -               return OVL_CON_CLRFMT_RGB565;
> > +               return comp->data->ovl.fmt_rgb565;
> 
> It will be nice to define a helper function for converting from the
> generic 'mtk_ddp_comp' to the specific 'mtk_disp_ovl':
> 
> static inline struct mtk_disp_ovl *comp_to_ovl(struct mtk_ddp_comp *comp) {
>   return container_of(comp, struct mtk_disp_ovl, ddp_comp);
> }
> 
> Then these could become:
>    return OVL_CON_CLRFMT_RGB565(comp_to_ovl(comp));
> 
> Or maybe cleaner, do the conversion once at the top of the function:
>     struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
> 
> And then just:
>    return OVL_CON_CLRFMT_RGB565(ovl);
> 
> 
Will use a helper function for the converting.

> >         case DRM_FORMAT_BGR565:
> > -               return OVL_CON_CLRFMT_RGB565 | OVL_CON_BYTE_SWAP;
> > +               return comp->data->ovl.fmt_rgb565 | OVL_CON_BYTE_SWAP;
> >         case DRM_FORMAT_RGB888:
> > -               return OVL_CON_CLRFMT_RGB888;
> > +               return comp->data->ovl.fmt_rgb888;
> >         case DRM_FORMAT_BGR888:
> > -               return OVL_CON_CLRFMT_RGB888 | OVL_CON_BYTE_SWAP;
> > +               return comp->data->ovl.fmt_rgb888 | OVL_CON_BYTE_SWAP;
> >         case DRM_FORMAT_RGBX8888:
> >         case DRM_FORMAT_RGBA8888:
> >                 return OVL_CON_CLRFMT_ARGB8888;
> 
> [snip]
> 
> 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> > index 1c366f8..935a8ef 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/phy/phy.h>
> >
> > @@ -87,6 +88,9 @@
> >
> >  #define MIPITX_DSI_PLL_CON2    0x58
> >
> > +#define MIPITX_DSI_PLL_TOP     0x64
> > +#define RG_DSI_MPPLL_PRESERVE          (0xff << 8)
> > +
> >  #define MIPITX_DSI_PLL_PWR     0x68
> >  #define RG_DSI_MPPLL_SDM_PWR_ON                BIT(0)
> >  #define RG_DSI_MPPLL_SDM_ISO_EN                BIT(1)
> > @@ -123,10 +127,15 @@
> >  #define SW_LNT2_HSTX_PRE_OE            BIT(24)
> >  #define SW_LNT2_HSTX_OE                        BIT(25)
> >
> > +struct mtk_mipitx_data {
> > +       const u32 data;
> 
> Use a better name, like "mppll_preserve".
OK.

Regards,
yt.shen

> 
> Ok, that's it for now.
> Actually, the patch set in general looks pretty good.
> 
> -Dan
