From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 23 Oct 2018 11:33:10 +0200
Subject: [PATCH 1/4] drm/sun4i: tcon: Support an active-low DE signal
 with RGB interface
In-Reply-To: <20181010145736.l6zpohvvd4b5qngr@flea>
References: <20181010114134.8211-1-contact@paulk.fr>
 <20181010145736.l6zpohvvd4b5qngr@flea>
Message-ID: <224ec158bf627b4d2f577b1dadf10bd87891e2a7.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le mercredi 10 octobre 2018 ? 16:57 +0200, Maxime Ripard a ?crit :
> On Wed, Oct 10, 2018 at 01:41:31PM +0200, Paul Kocialkowski wrote:
> > Some panels need an active-low data enable (DE) signal for the RGB
> > interface. This requires flipping a bit in the TCON0 polarity register
> > when setting up the mode for the RGB interface.
> > 
> > Add a new helper function to match specific bus flags and use it to set
> > the polarity inversion bit for the DE signal when required.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++--
> >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
> >  2 files changed, 27 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > index 3fb084f802e2..d249a462ec09 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -78,6 +78,24 @@ static int sun4i_tcon_get_pixel_depth(const struct drm_encoder *encoder)
> >  	return -EINVAL;
> >  }
> >  
> > +static bool sun4i_tcon_match_bus_flags(const struct drm_encoder *encoder,
> > +				       u32 bus_flags)
> > +{
> > +	struct drm_connector *connector;
> > +	struct drm_display_info *info;
> > +
> > +	connector = sun4i_tcon_get_connector(encoder);
> > +	if (!connector)
> > +		return false;
> > +
> > +	info = &connector->display_info;
> > +
> > +	if ((info->bus_flags & bus_flags) == bus_flags)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
> >  					  bool enabled)
> >  {
> > @@ -415,6 +433,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
> >  }
> >  
> >  static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> > +				     const struct drm_encoder *encoder,
> >  				     const struct drm_display_mode *mode)
> >  {
> >  	unsigned int bp, hsync, vsync;
> > @@ -474,8 +493,13 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> >  	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> >  		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> >  
> > +	if (sun4i_tcon_match_bus_flags(encoder, DRM_BUS_FLAG_DE_LOW))
> > +		val |= SUN4I_TCON0_IO_POL_DE_NEGATIVE;
> > +
> 
> There's other flags in use in that function, you should also migrate
> them (ideally by splitting that new function into a separate patch).

Actually, these other flags are not DRM bus flags but DRM mode flags,
which can be accessed directly from the mode pointer passed as
argument. Thus, they don't require a helper.

If you'd like, I could still split this patch into one introducing the
helper and one using it for checking the DE_LOW flag.

What do you think?

Cheers,

Paul

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181023/3761bac8/attachment-0001.sig>
