From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 25 Jan 2016 21:02:14 +0200
Subject: [PATCH v2 13/26] drm/fb_cma_helper: Remove implicit call to
 disable_unused_functions
In-Reply-To: <20160125072938.GI11240@phenom.ffwll.local>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1484612.l42nGNbAu5@avalon> <20160125072938.GI11240@phenom.ffwll.local>
Message-ID: <4816141.nXxRuEqaX5@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Monday 25 January 2016 08:29:38 Daniel Vetter wrote:
> On Mon, Jan 25, 2016 at 12:19:27AM +0200, Laurent Pinchart wrote:
> > On Friday 15 January 2016 11:17:30 Daniel Vetter wrote:
> >> On Fri, Jan 15, 2016 at 01:13:05AM +0200, Laurent Pinchart wrote:
> >>> On Thursday 14 January 2016 16:24:56 Maxime Ripard wrote:
> >>>> The drm_fbdev_cma_init function always calls the
> >>>> drm_helper_disable_unused_functions. Since it's part of the usual
> >>>> probe process, all the drivers using that helper will end up having
> >>>> their encoder and CRTC disable functions called at probe if their
> >>>> device has not been reported as enabled.
> >>>> 
> >>>> This could be fixed by reading out from the registers the current
> >>>> state of the device if it is enabled, but even that will not handle
> >>>> the case where the device is actually disabled.
> >>>> 
> >>>> Moreover, the drivers using the atomic modesetting expect that their
> >>>> enable and disable callback to be called when the device is already
> >>>> enabled or disabled (respectively).
> >>>> 
> >>>> We can however fix this issue by moving the call to
> >>>> drm_helper_disable_unused_functions out of drm_fbdev_cma_init and
> >>>> make the drivers needing it (all the drivers calling
> >>>> drm_fbdev_cma_init and not using the atomic modesetting) explicitly
> >>>> call it.
> >>> 
> >>> I'd rather add it to all drivers that call drm_fbdev_cma_init(). All
> >>> the atomic ones must have special code to cope with it that could be
> >>> rendered useless by the removal of the
> >>> drm_helper_disable_unused_functions() call. That code should be
> >>> removed too, and it would be easier to check drivers one by one and
> >>> fixing them individually (outside of this patch series, unless you
> >>> insist ;-)) when removing the explicit
> >>> drm_helper_disable_unused_functions() call.
> >> 
> >> I had the same thought, but figured there's really no good reason ever
> >> to do this. I suspect most of that disable_unused_function stuff we have
> >> all over is supreme cargo-cult anyway ;-)
> > 
> > I'm not sure you got my point. Yes, the
> > drm_helper_disable_unused_functions() call should be removed from atomic
> > drivers, but that will leave support code added for the sole reason of
> > avoiding the crash in the drivers. That code will likely not be noticed
> > and will stay there rotting. If we added
> > drm_helper_disable_unused_functions() calls to all atomic drivers then
> > driver authors will hopefully check carefully if there's any support code
> > that can be removed when removing the function call. It would act as a
> > kind of FIXME reminder.
> 
> drm_helper_disable_unused_functions() already prefers the ->disable
> callbacks over dpms, like atomic helpers. I don't think there's any dead
> code due to this change. The problem was that driver/hw blew up since it
> was disabled when the hw was off already.

The rcar-du-drm driver keeps an internal CRTC enabled state for just this 
purpose. I expect other drivers to implement something similar that can be 
removed after dropping the drm_helper_disable_unused_functions() calls.

-- 
Regards,

Laurent Pinchart
