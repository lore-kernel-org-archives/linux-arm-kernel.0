From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 24 Jan 2017 10:54:04 +0800
Subject: [PATCH v2] drm/mediatek: Support UYVY and YUYV format for overlay
In-Reply-To: <1485221752.9687.2.camel@mtksdaap41>
References: <1483079183-38637-1-git-send-email-bibby.hsieh@mediatek.com>
 <CAGS+omDHrYnUeRybHt+FtmjLS8d6jO-3==DYYCzbuhFZJME_Gg@mail.gmail.com>
 <1485221752.9687.2.camel@mtksdaap41>
Message-ID: <CAGS+omAqvoA1jjVpZi6v7r1X6eMgo5Jiaz0CHM9sur1M+M63HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 9:35 AM, Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:
>
> Hi, Daniel,
>
> Thanks for your comment.
>
> On Tue, 2017-01-03 at 14:27 +0800, Daniel Kurtz wrote:
> > On Fri, Dec 30, 2016 at 2:26 PM, Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:
> > >
> > > MT8173 overlay can support UYVY and YUYV format,
> > > we add the format in DRM driver.
> > >
> > > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > > Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c  | 21 +++++++++++++++++++++
> > >  drivers/gpu/drm/mediatek/mtk_drm_plane.c |  2 ++
> > >  2 files changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > > index c703102..de05845 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > > @@ -40,10 +40,13 @@
> > >  #define        OVL_RDMA_MEM_GMC        0x40402020
> > >
> > >  #define OVL_CON_BYTE_SWAP      BIT(24)
> > > +#define OVL_CON_MTX_YUV_TO_RGB (6 << 16)
> > >  #define OVL_CON_CLRFMT_RGB565  (0 << 12)
> > >  #define OVL_CON_CLRFMT_RGB888  (1 << 12)
> > >  #define OVL_CON_CLRFMT_RGBA8888        (2 << 12)
> > >  #define OVL_CON_CLRFMT_ARGB8888        (3 << 12)
> > > +#define OVL_CON_CLRFMT_UYVY    (4 << 12)
> > > +#define OVL_CON_CLRFMT_YUYV    (5 << 12)
> >
> > Why not just add " | OVL_CON_MTX_YUV_TO_RGB" here in the definition of
> > these two constants, instead of adding a helper function?
> >
> > >  #define        OVL_CON_AEN             BIT(8)
> > >  #define        OVL_CON_ALPHA           0xff
> > >
> > > @@ -162,6 +165,21 @@ static unsigned int ovl_fmt_convert(unsigned int fmt)
> > >         case DRM_FORMAT_XBGR8888:
> > >         case DRM_FORMAT_ABGR8888:
> > >                 return OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP;
> > > +       case DRM_FORMAT_UYVY:
> > > +               return OVL_CON_CLRFMT_UYVY;
> > > +       case DRM_FORMAT_YUYV:
> > > +               return OVL_CON_CLRFMT_YUYV;
> > > +       }
> > > +}
> How about adding " | OVL_CON_MTX_YUV_TO_RGB" after here in "return
> OVL_CON_CLRFMT_UYVY" and "return OVL_CON_CLRFMT_YUYV" ??

Sounds good to me.

> > > +
> > > +static bool ovl_yuv_space(unsigned int fmt)
> > > +{
> > > +       switch (fmt) {
> > > +       case DRM_FORMAT_UYVY:
> > > +       case DRM_FORMAT_YUYV:
> > > +               return true;
> > > +       default:
> > > +               return false;
> > >         }
> > >  }
> > >
> > > @@ -183,6 +201,9 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
> > >         if (idx != 0)
> > >                 con |= OVL_CON_AEN | OVL_CON_ALPHA;
> > >
> > > +       if (ovl_yuv_space(fmt))
> > > +               con |= OVL_CON_MTX_YUV_TO_RGB;
> > > +
> > >         writel_relaxed(con, comp->regs + DISP_REG_OVL_CON(idx));
> > >         writel_relaxed(pitch, comp->regs + DISP_REG_OVL_PITCH(idx));
> > >         writel_relaxed(src_size, comp->regs + DISP_REG_OVL_SRC_SIZE(idx));
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > > index c461a23..8c02d1d 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > > @@ -28,6 +28,8 @@
> > >         DRM_FORMAT_XRGB8888,
> > >         DRM_FORMAT_ARGB8888,
> > >         DRM_FORMAT_RGB565,
> > > +       DRM_FORMAT_UYVY,
> > > +       DRM_FORMAT_YUYV,
> > >  };
> > >
> > >  static void mtk_plane_reset(struct drm_plane *plane)
> > > --
> > > 1.9.1
> > >
>
> --
> Bibby
>
