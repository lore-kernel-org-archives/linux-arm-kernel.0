From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 21 Feb 2018 14:04:35 +0100
Subject: [PATCH v3 1/8] drm/blend: Add a generic alpha property
In-Reply-To: <CAOZHkRw=eNmkKwpFc=tRaO=TjpNPzcfncCCUneaDb0aBaaONQw@mail.gmail.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
 <9403570d73b6eb63ab87488d5e8eb767ba6f1ac7.1518802627.git-series.maxime.ripard@bootlin.com>
 <20180216182041.GU5453@intel.com>
 <CAOZHkRw=eNmkKwpFc=tRaO=TjpNPzcfncCCUneaDb0aBaaONQw@mail.gmail.com>
Message-ID: <20180221130435.yqkpjk4i6qeq3eud@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 20, 2018 at 04:10:28PM +0100, Stefan Schake wrote:
> On Fri, Feb 16, 2018 at 7:20 PM, Ville Syrj?l?
> <ville.syrjala@linux.intel.com> wrote:
> > On Fri, Feb 16, 2018 at 06:39:29PM +0100, Maxime Ripard wrote:
> >> Some drivers duplicate the logic to create a property to store a per-plane
> >> alpha.
> >>
> >> This is especially useful if we ever want to support extra protocols for
> >> Wayland like:
> >> https://lists.freedesktop.org/archives/wayland-devel/2017-August/034741.html
> >>
> >> Let's create a helper in order to move that to the core.
> >>
> >> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >> ---
> >>  Documentation/gpu/kms-properties.csv |  2 +-
> >>  drivers/gpu/drm/drm_atomic.c         |  4 ++++-
> >>  drivers/gpu/drm/drm_atomic_helper.c  |  4 ++++-
> >>  drivers/gpu/drm/drm_blend.c          | 32 +++++++++++++++++++++++++++++-
> >>  include/drm/drm_blend.h              |  1 +-
> >>  include/drm/drm_plane.h              |  6 +++++-
> >>  6 files changed, 48 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/gpu/kms-properties.csv b/Documentation/gpu/kms-properties.csv
> >> index 927b65e14219..25ad3503d663 100644
> >> --- a/Documentation/gpu/kms-properties.csv
> >> +++ b/Documentation/gpu/kms-properties.csv
> >> @@ -99,5 +99,5 @@ radeon,DVI-I,?coherent?,RANGE,"Min=0, Max=1",Connector,TBD
> >>  ,,"""underscan vborder""",RANGE,"Min=0, Max=128",Connector,TBD
> >>  ,Audio,?audio?,ENUM,"{ ""off"", ""on"", ""auto"" }",Connector,TBD
> >>  ,FMT Dithering,?dither?,ENUM,"{ ""off"", ""on"" }",Connector,TBD
> >> -rcar-du,Generic,"""alpha""",RANGE,"Min=0, Max=255",Plane,TBD
> >> +,,"""alpha""",RANGE,"Min=0, Max=Driver dependant",Plane,Opacity of the plane from transparent (0) to fully opaque (MAX). If this property is set to a value different than max, and that the pixel will define an alpha component, the property will have precendance and the pixel value will be ignored.
> >
> > Those semantics don't seem particularly good to me. I think we would want the
> > per-pixel alpha and global alpha both to be effecive at the same time. You can
> > always decide to ignore the per-pixel alpha by using a pixel format without
> > alpha.
> >
> > Also, where's the userspace that wants this feature?
> 
> drm_hwcomposer uses an 8-bit per-plane alpha property, and from what I
> can tell the semantics are that both pixel and plane alpha apply
> simultaneously if present.
> Here is what I think was the kernel-side for this:
> 
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/306122
> 
> I've added Sean Paul, he might be able to give a more definitive answer.

What is the behaviour of the tegra engine when it has both a
pixel-alpha and a plane-alpha?

Atmel at least will drop one (but I'm not sure which one anymore).

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180221/4e4354d6/attachment.sig>
