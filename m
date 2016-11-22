From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 22 Nov 2016 08:02:47 +0100
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20161121145528.GI1041@n2100.armlinux.org.uk>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20161121110604.GC1005@e106497-lin.cambridge.arm.com>
 <20161121112030.GC1041@n2100.armlinux.org.uk>
 <20161121113212.GF1005@e106497-lin.cambridge.arm.com>
 <20161121122556.GE1041@n2100.armlinux.org.uk>
 <20161121125653.GJ1005@e106497-lin.cambridge.arm.com>
 <20161121132419.GF1041@n2100.armlinux.org.uk>
 <20161121143053.GH1041@n2100.armlinux.org.uk>
 <20161121145528.GI1041@n2100.armlinux.org.uk>
Message-ID: <20161122070247.bbnmpaj5d6yzw3g5@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 02:55:28PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 21, 2016 at 02:30:53PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 21, 2016 at 01:24:19PM +0000, Russell King - ARM Linux wrote:
> > > On Mon, Nov 21, 2016 at 12:56:53PM +0000, Liviu Dudau wrote:
> > > > That is mostly due to the check in hdlcd_crtc_disable() which I should
> > > > remove, I've added it because I was getting a ->disable() hook call
> > > > before any ->enable() was called at startup time. I need to revisit
> > > > this as I remember Daniel was commenting that this was not needed.
> > > 
> > > Removing that test results in:
> > > 
> > > [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0] flip_done timed out
> > > 
> > > and the kernel hanging, seemingly in an IRQs-off region.
> > 
> > Annoyingly, enabling DRM debug prevents the kernel hanging...
> 
> I've been trying to trace through what's happening with this flip_done
> stuff, but I'm finding it _extremely_ difficult to follow the atomic
> code.
> 
> (Sorry, I'm going to go over my usual 72 column limit for this due to
> the damn long DRM function names.)
> 
> I can see that drm_atomic_helper_commit() calls drm_atomic_helper_setup_commit()
> which sets up commit->flip_done for each CRTC, and sets up an event for
> each.
> 
> drm_atomic_helper_commit() continues on to eventually call drm_atomic_helper_swap_state()
> which then swaps the state for the CRTCs, but then ends up dropping
> the event reference:
> 
> 	state->crtcs[i].commit->event = NULL;
> 
> What I can't see is why this isn't a leaked pointer - I don't see
> anything inbetween taking charge of that structure.  The _commit_
> hasn't been swapped from what I can see, it's just state->crtcs[i].state
> that have been swapped.

The event is also stored in crtc_state->event, which after swap_states
land in drm_crtc->state->event, which is the place drivers are supposed to
pick it up from for delivery.

> So I can't see who's responsible for generating this event, or how the
> backend DRM drivers get to know about this event, and that they should
> complete the flip.
> 
> What I also don't get is why DRM is wanting to wait for a flip event
> when we're disabling the CRTC.  None of this makes sense to me, like
> much of the atomic modeset code...

The DRM event has two uses:
- high-precision timestamp for when the new frame starts displaying.
- confirmation that the old buffers are no longer being used by the hw.
  This is used on Android's drm_hwcomposer in the new hwc2 mode.

Note that the crtc_state->event has 3 uses in total, all hidden behind the
abstraction:
- flip_done, for the atomic helpers
- drm event, for current userspace (also needed to emulate legacy flips)
- and out-fences, needed by android.

The trouble with ->event delivery was that many drivers didn't bother to
implement this at all, since driver submitters never even tested
pageflippping. And for those maintainers that did test pageflipping, they
only ever tested the legacy page_flip paths, which e.g. doesn't ever ask
for an event when disabling the CRTC (since you can't do that). But atomic
allows all this, and review wasn't enough to fight the influx of bad
drivers. Hence I opted to make the nonblocking support in the atomic
helpers enforce this part of the abi contract, even for blocking modesets.
If you're stuck on a flip_done, then your driver doesn't send out events
when disabling the CRTC.

All the waits have a 10s timeout, and none of them are in atomic contexts,
so no idea why this takes down your box. I suspect it's something
unrelated.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
