From: eric@anholt.net (Eric Anholt)
Date: Wed, 04 Apr 2018 09:03:36 -0700
Subject: [PATCH v4 1/5] drm/blend: Add a generic alpha property
In-Reply-To: <e0c1e8af3c8e9a8283d78d4cdeb2fe92147c5945.camel@bootlin.com>
References: <cover.b32b447321f6e04da30ed8099fbef2f00fc27fbc.1520974361.git-series.maxime.ripard@bootlin.com>
 <402e596049beb3429faf5981682d902c70325274.1520974361.git-series.maxime.ripard@bootlin.com>
 <87vadd5mgf.fsf@anholt.net>
 <e0c1e8af3c8e9a8283d78d4cdeb2fe92147c5945.camel@bootlin.com>
Message-ID: <87a7ujc61z.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> [ Unknown signature status ]
> Hi,
>
> On Fri, 2018-03-30 at 13:37 -0700, Eric Anholt wrote:
>> Maxime Ripard <maxime.ripard@bootlin.com> writes:
>> 
>> > Some drivers duplicate the logic to create a property to store a
>> > per-plane
>> > alpha.
>> > 
>> > This is especially useful if we ever want to support extra protocols
>> > for
>> > Wayland like:
>> > https://lists.freedesktop.org/archives/wayland-devel/2017-August/034
>> > 741.html
>> > 
>> > Let's create a helper in order to move that to the core.
>> > diff --git a/drivers/gpu/drm/drm_blend.c
>> > b/drivers/gpu/drm/drm_blend.c
>> > index 5a81e1b4c076..05eda2d57c77 100644
>> > --- a/drivers/gpu/drm/drm_blend.c
>> > +++ b/drivers/gpu/drm/drm_blend.c
>> > @@ -88,6 +88,12 @@
>> >   * On top of this basic transformation additional properties can be
>> > exposed by
>> >   * the driver:
>> >   *
>> > + * alpha:
>> > + * 	Alpha is setup with drm_plane_create_alpha_property().
>> > It controls the
>> 
>> s/setup/set up/
>> 
>> > + * 	plane-wide opacity, from transparent (0) to opaque
>> > (0xffff). It can be
>> > + * 	combined with pixel alpha.
>> > + * 	The alpha value is represented as premultiplied alpha.
>> 
>> I don't think this premultiplied comment makes any sense.  What are
>> you saying it's premultiplied with?  Maybe you mean that the output
>> pixels will have both their color and alpha channels multiplied by
>> this alpha?
>> I'd just drop it.
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

"Premultiplied alpha" only has a meaning for an RGBA value, where RGB
have been already multiplied by their own A.  In this case, you're
saying that an alpha-only value is "premultiplied", but with what?  What
would an alternative to it being "premultiplied" do instead?  That's
what I'm confused about.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/506231ea/attachment.sig>
