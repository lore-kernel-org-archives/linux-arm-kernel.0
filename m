From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 18 Jul 2017 15:47:29 +0300
Subject: [PATCH 1/4] drm/atomic: implement drm_atomic_helper_commit_tail
 for runtime_pm users
In-Reply-To: <20170718120839.k7zsey67qgrtnfwe@phenom.ffwll.local>
References: <cover.75b0c7f741ed33015a7ad44941bed1f6152a48a9.1499956639.git-series.maxime.ripard@free-electrons.com>
 <10955632.YI7NJnTkKU@avalon>
 <20170718120839.k7zsey67qgrtnfwe@phenom.ffwll.local>
Message-ID: <2697690.BvagR2OUgd@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tuesday 18 Jul 2017 14:08:39 Daniel Vetter wrote:
> On Tue, Jul 18, 2017 at 01:14:12PM +0300, Laurent Pinchart wrote:
> > On Tuesday 18 Jul 2017 09:05:22 Maxime Ripard wrote:
> >> On Fri, Jul 14, 2017 at 02:43:12AM +0300, Laurent Pinchart wrote:
> >>> On Thursday 13 Jul 2017 16:41:13 Maxime Ripard wrote:
> >>>> The current drm_atomic_helper_commit_tail helper works only if the
> >>>> CRTC is accessible, and documents an alternative implementation that
> >>>> is supposed to be used if that happens.
> >>>> 
> >>>> That implementation is then duplicated by some drivers. Instead of
> >>>> documenting it, let's implement an helper that all the relevant users
> >>>> can use directly.
> >>>> 
> >>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>>> ---
> >>>> 
> >>>>  drivers/gpu/drm/drm_atomic_helper.c        | 47 +++++++++++++--------
> >>>>  drivers/gpu/drm/exynos/exynos_drm_fb.c     | 27 +-------------
> >>>>  drivers/gpu/drm/rcar-du/rcar_du_kms.c      | 18 +---------
> >>> 
> >>> I've submitted "[PATCH] drm: rcar-du: Setup planes before enabling
> >>> CRTC to avoid flicker" that changes the rcar-du implementation to the
> >>> standard disable/update planes/enable order, so I'd appreciate if you
> >>> could drop the rcar-du part of this patch to avoid conflicts.
> >> 
> >> I will.
> >> 
> >>> This being said, the reason why I switched back from the "runtime PM"
> >>> to the "standard" order is probably of interest to you. Quoting the
> >>> commit message,
> >>> 
> >>>> Commit 52055bafa1ff ("drm: rcar-du: Move plane commit code from CRTC
> >>>> start to CRTC resume") changed the order of the plane commit and CRTC
> >>>> enable operations to accommodate the runtime PM requirements.
> >>>> However, this introduced corruption in the first displayed frame, as
> >>>> the CRTC is now enabled without any plane configured. On Gen2
> >>>> hardware the first frame will be black and likely unnoticed, but on
> >>>> Gen3 hardware we end up starting the display before the VSP
> >>>> compositor, which is more noticeable.
> >>>> 
> >>>> To fix this, revert the order of the commit operations back, and
> >>>> handle runtime PM requirements in the CRTC .atomic_begin() and
> >>>> .atomic_enable() helper operation handlers.
> >>> 
> >>> I believe that the "runtime PM" order is problematic in most drivers.
> >>> The problem usually goes unnoticed as most monitors will not even
> >>> display the first frame, and I assume many devices will just output it
> >>> black, but it's an issue nonetheless.
> >>> 
> >>> Note that my driver hasn't lost the "runtime PM" requirements, so I
> >>> had to support them with the "standard" order. The best way I've found
> >>> was to runtime resume in the one of .atomic_begin() and .enable() that
> >>> is run first. Not very neat, as similar code would be needed in most
> >>> drivers. I wonder whether it wouldn't be useful to add resume/suspend
> >>> helper callbacks for the CRTC.
> >> 
> >> I'm not sure it would apply. Our driver doesn't use runtime_pm at all,
> >> but in order for the commits to happen, we need to have the CRTC
> >> active, but it will remain powered up the whole time. I'm not sure if
> >> we'll ever see such a frame.
> >> 
> >> But since this seems to be a pretty generic, maybe we should address
> >> it in the helper itself?
> > 
> > I think that would make sense.
> > 
> > There are a few options that result in too many combinations for separate
> > commit tail helpers to be provided in my opinion:
> > 
> > - disable/enable/planes vs. disable/planes/enable
> > - DRM_PLANE_COMMIT_ACTIVE_ONLY vs. all CRTCs
> > - drm_atomic_helper_wait_for_vblanks vs
> > drm_atomic_helper_wait_for_flip_done
> > 
> > Maybe we could add a few CRTC commit helper flags along the line of
> > DRM_PLANE_COMMIT_ACTIVE_ONLY, add a field to the drm_crtc structure to
> > store them, and have drm_atomic_helper_commit_tail() use those flags to
> > control the sequence of operations.
> 
> Why not write your own? Yes it's a bit of copypaste, but imo that's really
> not horrible.

I don't find it horrible either, it's not too much code. The question was more 
about which version(s) to consider standard enough to provide a core helper 
for.

What bothers me a bit more with the copy&paste implementations isn't so much 
the commit tail handling itself, but the consequences it has on the rest of 
the driver. Drivers pick the order they want based on their requirements, and 
that order then leads to different race conditions between the drivers. We 
don't document the potential issues there, so new drivers (and for that 
matter, possibly existing ones) will likely have bugs if the author is not 
aware of the subtle issues related to the particular operation order they 
happen to use.

> I'm already not happy with the flags for commit_planes because the docs for
> them are not great and it's hard to know when to use them and when not to.
> 
> ->commit_tail was specifically done to allow drivers to overwrite the hw
> commit stage without having to reinvent all the other commit tracking. I
> expect most non-simple drivers to have their own commit_tail function.

Maybe that should be all of them instead of most of them ?

-- 
Regards,

Laurent Pinchart
