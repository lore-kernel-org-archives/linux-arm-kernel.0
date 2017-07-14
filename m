From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 14 Jul 2017 07:37:54 +0200
Subject: [PATCH 1/4] drm/atomic: implement drm_atomic_helper_commit_tail
 for runtime_pm users
In-Reply-To: <1823154.LT2zYSFJ4j@avalon>
References: <cover.75b0c7f741ed33015a7ad44941bed1f6152a48a9.1499956639.git-series.maxime.ripard@free-electrons.com>
 <aeeb8f778dae8f170294b6da92819973b742feb2.1499956639.git-series.maxime.ripard@free-electrons.com>
 <1823154.LT2zYSFJ4j@avalon>
Message-ID: <CAKMK7uE4j3Dy4qOd+WbTxg1BrYfPXGZVsxMWgPSx_1a1OhKu7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 1:43 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> Commit 52055bafa1ff ("drm: rcar-du: Move plane commit code from CRTC
>> start to CRTC resume") changed the order of the plane commit and CRTC
>> enable operations to accommodate the runtime PM requirements. However,
>> this introduced corruption in the first displayed frame, as the CRTC is
>> now enabled without any plane configured. On Gen2 hardware the first
>> frame will be black and likely unnoticed, but on Gen3 hardware we end up
>> starting the display before the VSP compositor, which is more
>> noticeable.
>>
>> To fix this, revert the order of the commit operations back, and handle
>> runtime PM requirements in the CRTC .atomic_begin() and .atomic_enable()
>> helper operation handlers.
>
> I believe that the "runtime PM" order is problematic in most drivers. The
> problem usually goes unnoticed as most monitors will not even display the
> first frame, and I assume many devices will just output it black, but it's an
> issue nonetheless.
>
> Note that my driver hasn't lost the "runtime PM" requirements, so I had to
> support them with the "standard" order. The best way I've found was to runtime
> resume in the one of .atomic_begin() and .enable() that is run first. Not very
> neat, as similar code would be needed in most drivers. I wonder whether it
> wouldn't be useful to add resume/suspend helper callbacks for the CRTC.

I discussed this with Laurent and explained that "first black frame"
is exactly what i915 does. I'd say given special customer requests we
don't yet have to bother with this in general ...

Wrt adding more hooks for rpm: I honestly don't like that, because
then someone else wants to add a hook for clocks, or for the sideband
and then we have a horror show of hooks where every driver uses just a
very small subset. The point of atomic helpers is to make them
modular, if one part doesn't fit, just redo in your driver. Goal
should be that shared parts are good for about 90% of
drivers/use-cases (maybe even less, there's sooooo many special
cases).

tldr; I still think the _runtime_pm variant is the recommended way to do this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
