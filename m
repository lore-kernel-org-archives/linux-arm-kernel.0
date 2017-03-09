From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Mar 2017 11:54:50 +0100
Subject: [PATCH 12/15] drm/sun4i: tcon: multiply the vtotal when not in
 interlace
In-Reply-To: <CAGb2v67t7O4AuSXUupB3EU7OZdxgQbeyB6qL_g3x_BXOFLg9Bg@mail.gmail.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <0b3b516527c42e745ed8a35736948a383411bd50.1488876832.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67t7O4AuSXUupB3EU7OZdxgQbeyB6qL_g3x_BXOFLg9Bg@mail.gmail.com>
Message-ID: <20170309105450.44l26dbry56an65d@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07, 2017 at 06:05:17PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Tue, Mar 7, 2017 at 4:56 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > It appears that the total vertical resolution needs to be doubled when
> > we're not in interlaced. Make sure that is the case.
> 
> This is true for both channels, though we handle them differently.
> 
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > index e44217fb4f6f..515fa56c1e6a 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -248,10 +248,13 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
> >                      SUN4I_TCON1_BASIC3_H_BACKPORCH(bp));
> >
> >         bp = mode->crtc_vtotal - mode->crtc_vsync_start;
> > +       val = mode->crtc_vtotal;
> > +       if (!(mode->flags & DRM_MODE_FLAG_INTERLACE))
> > +               val = val * 2;
> >         DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
> >                          mode->vtotal, bp);
> >         regmap_write(tcon->regs, SUN4I_TCON1_BASIC4_REG,
> > -                    SUN4I_TCON1_BASIC4_V_TOTAL(mode->vtotal) |
> > +                    SUN4I_TCON1_BASIC4_V_TOTAL(val) |
> 
> For channel 0, the SUN4I_TCON0_BASIC2_V_TOTAL macro multiplies the passed in
> value by 2. I think we should do the same for channel 1, and instead halve the
> value passed in if we are outputting interlaced data. I think this makes more
> sense because:
> 
> 1) The register description for both channels are the same. Handling them
>    consistently will result in less confusion, such as this one.
> 
> 2) The definition of interlaced modes is a frame is separated into odd and
>    even fields, with each field contains half the number of lines of the
>    full frame. One field is displayed during each VSYNC cycle. The TCON does
>    not know whether it's interlaced video or not. It only knows the display
>    timings. In this case, the number of horizontal lines per cycle is key.

Hmm, yes, you're right. I'll fix it in the next release.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170309/2e149937/attachment.sig>
