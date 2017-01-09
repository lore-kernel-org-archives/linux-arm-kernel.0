From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 9 Jan 2017 22:23:46 +0800
Subject: [PATCH v3 3/3] drm: zte: add overlay plane support
In-Reply-To: <CAOw6vbLz0ueNsXXPuDtrHkL_Mac5w_jjD9nVUzy+9zbaR-iBmg@mail.gmail.com>
References: <1482979048-32037-1-git-send-email-shawnguo@kernel.org>
 <1482979048-32037-4-git-send-email-shawnguo@kernel.org>
 <CAOw6vbLz0ueNsXXPuDtrHkL_Mac5w_jjD9nVUzy+9zbaR-iBmg@mail.gmail.com>
Message-ID: <20170109142345.GN20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 02:26:30AM -0500, Sean Paul wrote:
> > +static u32 zx_vl_get_fmt(uint32_t format)
> > +{
> > +       u32 val = 0;
> > +
> > +       switch (format) {
> > +       case DRM_FORMAT_NV12:
> > +               val = VL_FMT_YUV420;
> > +               break;
> > +       case DRM_FORMAT_YUV420:
> > +               val = VL_YUV420_PLANAR | VL_FMT_YUV420;
> > +               break;
> > +       case DRM_FORMAT_YUYV:
> > +               val = VL_YUV422_YUYV | VL_FMT_YUV422;
> > +               break;
> > +       case DRM_FORMAT_YVYU:
> > +               val = VL_YUV422_YVYU | VL_FMT_YUV422;
> > +               break;
> > +       case DRM_FORMAT_UYVY:
> > +               val = VL_YUV422_UYVY | VL_FMT_YUV422;
> > +               break;
> > +       case DRM_FORMAT_VYUY:
> > +               val = VL_YUV422_VYUY | VL_FMT_YUV422;
> > +               break;
> > +       case DRM_FORMAT_YUV444:
> > +               val = VL_FMT_YUV444_8BIT;
> 
> Minor nit: You could have eliminated val and just returned directly
> from all of the cases. Seems like there are a few other functions this
> is also true for.

Okay.  I will change zx_vl_get_fmt() and zx_vl_rsz_get_fmt()
accordingly.

> 
> > +               break;
> > +       default:
> > +               WARN_ONCE(1, "invalid pixel format %d\n", format);
> > +       }
> > +
> > +       return val;
> > +}

<snip>

> > +static void zx_vl_rsz_setup(struct zx_plane *zplane, uint32_t format,
> > +                           u32 src_w, u32 src_h, u32 dst_w, u32 dst_h)
> > +{
> > +       void __iomem *rsz = zplane->rsz;
> > +       u32 src_chroma_w = src_w;
> > +       u32 src_chroma_h = src_h;
> > +       u32 fmt;
> > +
> > +       /* Set up source and destination resolution */
> > +       zx_writel(rsz + RSZ_SRC_CFG, RSZ_VER(src_h - 1) | RSZ_HOR(src_w - 1));
> > +       zx_writel(rsz + RSZ_DEST_CFG, RSZ_VER(dst_h - 1) | RSZ_HOR(dst_w - 1));
> > +
> > +       /* Configure data format for VL RSZ */
> > +       fmt = zx_vl_rsz_get_fmt(format);
> > +       zx_writel_mask(rsz + RSZ_VL_CTRL_CFG, RSZ_VL_FMT_MASK, fmt);
> > +
> > +       /* Calculate Chroma heigth and width */
> 
> s/heigth/height/

Thanks for spotting it.

> 
> > +       if (fmt == RSZ_VL_FMT_YCBCR420) {
> > +               src_chroma_w = src_w >> 1;
> > +               src_chroma_h = src_h >> 1;
> > +       } else if (fmt == RSZ_VL_FMT_YCBCR422) {
> > +               src_chroma_w = src_w >> 1;
> > +       }
> > +
> > +       /* Set up Luma and Chroma step registers */
> > +       zx_writel(rsz + RSZ_VL_LUMA_HOR, rsz_step_value(src_w, dst_w));
> > +       zx_writel(rsz + RSZ_VL_LUMA_VER, rsz_step_value(src_h, dst_h));
> > +       zx_writel(rsz + RSZ_VL_CHROMA_HOR, rsz_step_value(src_chroma_w, dst_w));
> > +       zx_writel(rsz + RSZ_VL_CHROMA_VER, rsz_step_value(src_chroma_h, dst_h));
> > +
> > +       zx_vl_rsz_set_update(zplane);
> > +}

<snip>

> > diff --git a/drivers/gpu/drm/zte/zx_vou.c b/drivers/gpu/drm/zte/zx_vou.c
> > index 3fb4fc04e693..e832c2ec3156 100644
> > --- a/drivers/gpu/drm/zte/zx_vou.c
> > +++ b/drivers/gpu/drm/zte/zx_vou.c
> > @@ -84,6 +84,8 @@ struct zx_crtc_bits {
> >  struct zx_crtc {
> >         struct drm_crtc crtc;
> >         struct drm_plane *primary;
> > +       struct drm_plane *overlay_active[VL_NUM];
> > +       unsigned int overlay_active_num;
> 
> I don't think this belongs here. You can instead add an active (or
> enabled) bool to the zx_plane struct and keep track of it via
> atomic_plane_update/disable. This allows you to call
> zx_plane_set_update unconditionally in the vou irq handler and check
> active/enabled in zx_plane_set_update.

It's a truly great suggestion.  How did I not think of it :)  The v4 is
coming for that.

Thanks a lot for the review effort, Sean.

Shawn
