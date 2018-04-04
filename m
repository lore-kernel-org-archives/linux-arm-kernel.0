From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Apr 2018 12:46:18 +0300
Subject: [PATCH v4 1/5] drm/blend: Add a generic alpha property
In-Reply-To: <e0c1e8af3c8e9a8283d78d4cdeb2fe92147c5945.camel@bootlin.com>
References: <cover.b32b447321f6e04da30ed8099fbef2f00fc27fbc.1520974361.git-series.maxime.ripard@bootlin.com>
 <87vadd5mgf.fsf@anholt.net>
 <e0c1e8af3c8e9a8283d78d4cdeb2fe92147c5945.camel@bootlin.com>
Message-ID: <3959984.rxpnX4L0qy@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Wednesday, 4 April 2018 12:15:04 EEST Paul Kocialkowski wrote:
> On Fri, 2018-03-30 at 13:37 -0700, Eric Anholt wrote:
> > Maxime Ripard <maxime.ripard@bootlin.com> writes:
> >> Some drivers duplicate the logic to create a property to store a
> >> per-plane alpha.
> >> 
> >> This is especially useful if we ever want to support extra protocols
> >> for Wayland like:
> >> https://lists.freedesktop.org/archives/wayland-devel/2017-August/034
> >> 741.html
> >> 
> >> Let's create a helper in order to move that to the core.
> >> diff --git a/drivers/gpu/drm/drm_blend.c
> >> b/drivers/gpu/drm/drm_blend.c
> >> index 5a81e1b4c076..05eda2d57c77 100644
> >> --- a/drivers/gpu/drm/drm_blend.c
> >> +++ b/drivers/gpu/drm/drm_blend.c
> >> @@ -88,6 +88,12 @@
> >>   * On top of this basic transformation additional properties can be
> >> exposed by
> >>   * the driver:
> >>   *
> >> + * alpha:
> >> + * 	Alpha is setup with drm_plane_create_alpha_property().
> >> It controls the
> > 
> > s/setup/set up/
> > 
> >> + * 	plane-wide opacity, from transparent (0) to opaque
> >> (0xffff). It can be
> >> + * 	combined with pixel alpha.
> >> + * 	The alpha value is represented as premultiplied alpha.
> > 
> > I don't think this premultiplied comment makes any sense.  What are
> > you saying it's premultiplied with?  Maybe you mean that the output
> > pixels will have both their color and alpha channels multiplied by
> > this alpha? I'd just drop it.
> 
> I disagree here: since there are multiple ways to blend the pixel alpha
> value and the plane-wide alpha value, I think it's important to clearly
> specify which blending equation DRM expects here. Otherwise, the plane-
> wide alpha value just doesn't have a specified meaning and driver
> implementations can't figure whether the hardware uses the same equation
> or not and whether adaptation to this coefficient is needed.
> 
> The equations for premultiplied alpha blending are at:
> https://en.wikipedia.org/wiki/Alpha_compositing#Alpha_blending
> 
> What do you think?

I think it's important to be clear in the documentation, but I also don't 
think "premultiplied alpha" makes sense in this context. It's not the alpha 
value that is premultiplied, it is the RGB data. As correctly explained in the 
link you have provided, to compute the output RGB values the src and dst RGB 
values have to be multiplied by the src and dst alpha respectively. To 
simplify the hardware computation, RGB values can be premultiplied in a the 
framebuffer. This is useful when you deal with textures that have an alpha 
component (you can premultiply them offline first) or with multi-pass alpha 
blending where you can skip the division by outA in the intermediate steps. 
However, for plane global alpha, I fail to see a use case that would feed the 
device with a XRGB framebuffer premultiplied with a fixed global alpha value.

To summarize this, I'm fine specifying how alpha premultiplication is handled 
in relationship with the generic alpha property, but I think Maxime's patch 
was wrong, and the RGB values should not be premultiplied.

> > Reviewed-by: Eric Anholt <eric@anholt.net>
> > 
> > We should probably do this property for vc4 at some point, too.

-- 
Regards,

Laurent Pinchart
