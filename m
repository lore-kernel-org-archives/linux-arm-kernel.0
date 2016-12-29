From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 29 Dec 2016 10:35:28 +0800
Subject: [PATCH v2] drm: zte: add overlay plane support
In-Reply-To: <CAOw6vb+u7yb05nyMjgyW2hdUVHTPOVF=dkxSkpTC1qGk1j6N6w@mail.gmail.com>
References: <1482235795-6223-1-git-send-email-shawnguo@kernel.org>
 <CAOw6vb+u7yb05nyMjgyW2hdUVHTPOVF=dkxSkpTC1qGk1j6N6w@mail.gmail.com>
Message-ID: <20161229023522.GB11972@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Thu, Dec 22, 2016 at 09:56:01AM -0500, Sean Paul wrote:
> On Tue, Dec 20, 2016 at 7:09 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > diff --git a/drivers/gpu/drm/zte/zx_vou.c b/drivers/gpu/drm/zte/zx_vou.c
> > index 73fe15c17c32..8ca9c4bdeeaf 100644
> > --- a/drivers/gpu/drm/zte/zx_vou.c
> > +++ b/drivers/gpu/drm/zte/zx_vou.c
> > @@ -93,10 +93,38 @@ struct zx_crtc {
> >         const struct zx_crtc_bits *bits;
> >         enum vou_chn_type chn_type;
> >         struct clk *pixclk;
> > +       u32 overlay_bitmap;
> >  };
> >
> >  #define to_zx_crtc(x) container_of(x, struct zx_crtc, crtc)
> >
> > +struct zx_vl_bits {
> > +       u32 enable;
> > +       u32 chnsel;
> > +       u32 clksel;
> > +};
> > +
> > +static const struct zx_vl_bits zx_vl_bits[VL_NUM] = {
> > +       {
> > +               .enable = OSD_CTRL0_VL0_EN,
> > +               .chnsel = OSD_CTRL0_VL0_SEL,
> > +               .clksel = VOU_CLK_VL0_SEL,
> > +       }, {
> > +               .enable = OSD_CTRL0_VL1_EN,
> > +               .chnsel = OSD_CTRL0_VL1_SEL,
> > +               .clksel = VOU_CLK_VL1_SEL,
> > +       }, {
> > +               .enable = OSD_CTRL0_VL2_EN,
> > +               .chnsel = OSD_CTRL0_VL2_SEL,
> > +               .clksel = VOU_CLK_VL2_SEL,
> > +       },
> > +};
> > +
> > +struct zx_overlay {
> > +       struct drm_plane *plane;
> 
> If you subclass plane instead of storing the pointer, you don't need
> to keep an array of overlays in vou_hw or the find_vl_idx function.

Thanks for the comment, which I found is quite useful.  It reminds me
something in the existing code which could be optimized.

We already have a subclass of drm_plane.  That's struct zx_plane in
zx_plane.c.  Initially, I thought it might be good to keep the structure
local in zx_plane driver.  It should make the most sense for the ideal
case, like all the data we have to encode in the structure will only be
accessed inside zx_plane driver.  Unfortunately, I found it's not quite
true.  There are a few layer specific hardware bits we need to configure
do not sit inside layer block itself, but in some VOU hardware glue
blocks like OSD_CTRL and VOU_CTRL.  These glue blocks are only available
in zx_vou driver.  If we can access struct zx_plane from zx_vou driver,
things will become much easier and functions like find_vl_idx can be
saved completely.

I have worked out v3 with your comment addressed.  There are a couple
of new patches added, which moves struct zx_plane from zx_plane.c to
zx_plane.h and adds support of disabling layer.  I will post it shortly.
Please take another look at your convenient time.  Thanks for your time.

Shawn
