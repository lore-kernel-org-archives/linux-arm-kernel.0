From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 3 Dec 2015 10:00:21 +0000
Subject: [PATCH v3 2/4] drm: Add support for ARM's HDLCD controller.
In-Reply-To: <CAPj87rNFFGeL8z9GBXxyVri1RyhVpMGS0yz7opgCYamHYV1Yow@mail.gmail.com>
References: <1449058982-18595-1-git-send-email-Liviu.Dudau@arm.com>
 <1449058982-18595-3-git-send-email-Liviu.Dudau@arm.com>
 <CAPj87rNFFGeL8z9GBXxyVri1RyhVpMGS0yz7opgCYamHYV1Yow@mail.gmail.com>
Message-ID: <20151203100021.GD972@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 05:21:44PM +0000, Daniel Stone wrote:
> Hi Liviu,

Hi Daniel,

> 
> On 2 December 2015 at 12:23, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > +       if (irq_status & HDLCD_INTERRUPT_VSYNC) {
> > +               unsigned long flags;
> > +
> > +               drm_handle_vblank(drm, 0);
> > +
> > +               spin_lock_irqsave(&drm->event_lock, flags);
> > +               if (hdlcd->event) {
> > +                       drm_send_vblank_event(drm, hdlcd->event->pipe, hdlcd->event);
> > +                       drm_crtc_vblank_put(&hdlcd->crtc);
> > +                       hdlcd->event = NULL;
> > +               }
> > +               spin_unlock_irqrestore(&drm->event_lock, flags);
> > +       }
> 
> As with VC4 and Rockchip, you're missing a ->preclose handler in your
> drm_drv, to make sure that you don't try to send events to a dead
> client (which causes an OOPS):
> https://git.collabora.com/cgit/user/daniels/linux.git/commit/?h=wip/4.4.x/rockchip-drm-fixes&id=d14f21bcd7
> (and its parent)
 
Thanks for reviewing this!

I do acknowledge your concerns and you might correct my understanding on
how atomic DRM works, but I believe in this case we should be safe. The
event stored in hdlcd->event is taken out of the crtc->state->event during
the crtc->atomic_begin() callback. If the client is dead the callback should
not be called, so that's how we avoid the OOPS.

> Also, is there anything preventing clients from submitting multiple
> pageflips before the event is sent? I couldn't see anything from a
> quick look, so you could have the situation of:
>   - client submits pageflip, event 1 stored to hdlcd->event
>   - client submits pageflip, event 2 stored to hdlcd->event
>   - vblank arrives, event 2 is sent
>   - event 1 has disappeared and been leaked

As for multiple events being submitted before vsync interrupt happening: given
that the event is plucked out of the crtc->state, is that possible? And if so,
is there a case where having the later event overwrite the earlier one a desired
outcome?

> 
> Cheers,
> Daniel
> 

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
