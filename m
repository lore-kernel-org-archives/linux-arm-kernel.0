From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2016 14:55:28 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20161121143053.GH1041@n2100.armlinux.org.uk>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20161121110604.GC1005@e106497-lin.cambridge.arm.com>
 <20161121112030.GC1041@n2100.armlinux.org.uk>
 <20161121113212.GF1005@e106497-lin.cambridge.arm.com>
 <20161121122556.GE1041@n2100.armlinux.org.uk>
 <20161121125653.GJ1005@e106497-lin.cambridge.arm.com>
 <20161121132419.GF1041@n2100.armlinux.org.uk>
 <20161121143053.GH1041@n2100.armlinux.org.uk>
Message-ID: <20161121145528.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 02:30:53PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 21, 2016 at 01:24:19PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 21, 2016 at 12:56:53PM +0000, Liviu Dudau wrote:
> > > That is mostly due to the check in hdlcd_crtc_disable() which I should
> > > remove, I've added it because I was getting a ->disable() hook call
> > > before any ->enable() was called at startup time. I need to revisit
> > > this as I remember Daniel was commenting that this was not needed.
> > 
> > Removing that test results in:
> > 
> > [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0] flip_done timed out
> > 
> > and the kernel hanging, seemingly in an IRQs-off region.
> 
> Annoyingly, enabling DRM debug prevents the kernel hanging...

I've been trying to trace through what's happening with this flip_done
stuff, but I'm finding it _extremely_ difficult to follow the atomic
code.

(Sorry, I'm going to go over my usual 72 column limit for this due to
the damn long DRM function names.)

I can see that drm_atomic_helper_commit() calls drm_atomic_helper_setup_commit()
which sets up commit->flip_done for each CRTC, and sets up an event for
each.

drm_atomic_helper_commit() continues on to eventually call drm_atomic_helper_swap_state()
which then swaps the state for the CRTCs, but then ends up dropping
the event reference:

	state->crtcs[i].commit->event = NULL;

What I can't see is why this isn't a leaked pointer - I don't see
anything inbetween taking charge of that structure.  The _commit_
hasn't been swapped from what I can see, it's just state->crtcs[i].state
that have been swapped.

So I can't see who's responsible for generating this event, or how the
backend DRM drivers get to know about this event, and that they should
complete the flip.

What I also don't get is why DRM is wanting to wait for a flip event
when we're disabling the CRTC.  None of this makes sense to me, like
much of the atomic modeset code...

(I'm probably never going to convert Armada DRM to atomic modeset, I
just don't seem to be capable of understanding atomic modeset.  Maybe
I'm too old?)

[drm:drm_ioctl] pid=2178, dev=0xe200, auth=1, DRM_IOCTL_MODE_RMFB
[drm:drm_mode_object_unreference] OBJ ID: 38 (4)
[drm:drm_atomic_state_init] Allocated atomic state ffffffc974c7c300
[drm:drm_mode_object_reference] OBJ ID: 43 (1)
[drm:drm_atomic_get_crtc_state] Added [CRTC:24:crtc-0] ffffffc975e59400 state to ffffffc974c7c300
[drm:drm_mode_object_reference] OBJ ID: 38 (3)
[drm:drm_atomic_get_plane_state] Added [PLANE:23:plane-0] ffffffc974c7c100 state to ffffffc974c7c300
[drm:drm_mode_object_unreference] OBJ ID: 43 (2)
[drm:drm_atomic_set_mode_for_crtc] Set [NOMODE] for CRTC state ffffffc975e59400
[drm:drm_atomic_set_crtc_for_plane] Link plane state ffffffc974c7c100 to [NOCRTC]
[drm:drm_mode_object_unreference] OBJ ID: 38 (4)
[drm:drm_atomic_set_fb_for_plane] Set [NOFB] for plane state ffffffc974c7c100
[drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:24:crtc-0] to ffffffc974c7c300
[drm:drm_mode_object_reference] OBJ ID: 26 (4)
[drm:drm_mode_object_reference] OBJ ID: 26 (5)
[drm:drm_atomic_get_connector_state] Added [CONNECTOR:26] ffffffc974c7c000 state to ffffffc974c7c300
[drm:drm_mode_object_unreference] OBJ ID: 26 (6)
[drm:drm_atomic_set_crtc_for_connector] Link connector state ffffffc974c7c000 to [NOCRTC]
[drm:drm_atomic_check_only] checking ffffffc974c7c300
[drm:drm_atomic_helper_check_modeset] [CRTC:24:crtc-0] mode changed
[drm:drm_atomic_helper_check_modeset] [CRTC:24:crtc-0] enable changed
[drm:drm_atomic_helper_check_modeset] Updating routing for [CONNECTOR:26:HDMI-A-1]
[drm:drm_atomic_helper_check_modeset] Disabling [CONNECTOR:26:HDMI-A-1]
[drm:drm_atomic_helper_check_modeset] [CRTC:24:crtc-0] active changed
[drm:drm_atomic_helper_check_modeset] [CRTC:24:crtc-0] needs all connectors, enable: n, active: n
[drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:24:crtc-0] to ffffffc974c7c300
[drm:drm_atomic_commit] commiting ffffffc974c7c300
[drm:drm_atomic_helper_commit_modeset_disables] disabling [ENCODER:25:TMDS-25]
[drm:drm_atomic_helper_commit_modeset_disables] disabling [CRTC:24:crtc-0]
hdlcd_crtc_disable: active 0
[drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0] flip_done timed out
[drm:drm_atomic_state_default_clear] Clearing atomic state ffffffc974c7c300
[drm:drm_mode_object_unreference] OBJ ID: 26 (5)
[drm:drm_mode_object_unreference] OBJ ID: 26 (4)
[drm:drm_mode_object_unreference] OBJ ID: 43 (1)
[drm:drm_mode_object_unreference] OBJ ID: 38 (3)
[drm:drm_atomic_state_free] Freeing atomic state ffffffc974c7c300
[drm:drm_mode_object_unreference] OBJ ID: 38 (2)
[drm:drm_mode_object_unreference] OBJ ID: 38 (1)


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
