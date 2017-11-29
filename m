From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Wed, 29 Nov 2017 22:59:49 +0100
Subject: [linux-sunxi] [PATCH 11/17] drm/sun4i: Wire in DE2 scaler support
In-Reply-To: <CAGRGNgX_ZP9bpVuHzgmkyj18TKAMUpNgudiEzFRkJV-Z4MN4fQ@mail.gmail.com>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-12-jernej.skrabec@siol.net>
 <CAGRGNgX_ZP9bpVuHzgmkyj18TKAMUpNgudiEzFRkJV-Z4MN4fQ@mail.gmail.com>
Message-ID: <4143236.xN3VOcVO54@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julian,

Dne sreda, 29. november 2017 ob 22:48:34 CET je Julian Calaby napisal(a):
> Hi Jernej,
> 
> On Tue, Nov 28, 2017 at 7:57 AM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > Calculate scaling parameters and call appropriate scaler set up
> > function.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_layer.c |  12 +++-
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 115
> >  +++++++++++++++++++++++++----------- drivers/gpu/drm/sun4i/sun8i_mixer.h
> >  |   4 --
> >  3 files changed, 90 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.c
> > b/drivers/gpu/drm/sun4i/sun8i_layer.c index e1b6ad82145e..6860271e5415
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_layer.c
> > @@ -41,9 +44,14 @@ static int sun8i_mixer_layer_atomic_check(struct
> > drm_plane *plane,> 
> >         clip.x2 = crtc_state->adjusted_mode.hdisplay;
> >         clip.y2 = crtc_state->adjusted_mode.vdisplay;
> > 
> > +       scaler_supported = !!(layer->mixer->cfg->scaler_mask &
> > BIT(layer->id)); +
> > +       min_scale = scaler_supported ? 1 : DRM_PLANE_HELPER_NO_SCALING;
> > +       max_scale = scaler_supported ? (1UL << 20) - 1 :
> > +                                      DRM_PLANE_HELPER_NO_SCALING;
> > +
> 
> Disclaimer: I hate ternaries, but this looks like it'd be better
> written as an if statement. I.e.
> 
> min_scale = DRM_PLANE_HELPER_NO_SCALING;
> max_scale = DRM_PLANE_HELPER_NO_SCALING;
> 
> if (layer->mixer->cfg->scaler_mask & BIT(layer->id)) {
>     min_scale = 1;
>     max_scale = (1UL << 20) - 1;
> }
> 
> However the compiler will probably sort it all out anyway, so it
> probably doesn't matter that much, except for style.

That indeed looks much better. I will use it in next version.

Thanks,
Jernej

> 
> Thanks,
> 
> --
> Julian Calaby
> 
> Email: julian.calaby at gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/
