From: daniel@fooishbar.org (Daniel Stone)
Date: Thu, 3 Dec 2015 14:20:26 +0000
Subject: [PATCH v3 2/4] drm: Add support for ARM's HDLCD controller.
In-Reply-To: <20151203100021.GD972@e106497-lin.cambridge.arm.com>
References: <1449058982-18595-1-git-send-email-Liviu.Dudau@arm.com>
 <1449058982-18595-3-git-send-email-Liviu.Dudau@arm.com>
 <CAPj87rNFFGeL8z9GBXxyVri1RyhVpMGS0yz7opgCYamHYV1Yow@mail.gmail.com>
 <20151203100021.GD972@e106497-lin.cambridge.arm.com>
Message-ID: <CAPj87rOyBciAtBH_MiKA1bcqbpmk8gOscOMcLcgcbcag7k1W9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On 3 December 2015 at 10:00, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Wed, Dec 02, 2015 at 05:21:44PM +0000, Daniel Stone wrote:
>> On 2 December 2015 at 12:23, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>> > +       if (irq_status & HDLCD_INTERRUPT_VSYNC) {
>> > +               unsigned long flags;
>> > +
>> > +               drm_handle_vblank(drm, 0);
>> > +
>> > +               spin_lock_irqsave(&drm->event_lock, flags);
>> > +               if (hdlcd->event) {
>> > +                       drm_send_vblank_event(drm, hdlcd->event->pipe, hdlcd->event);
>> > +                       drm_crtc_vblank_put(&hdlcd->crtc);
>> > +                       hdlcd->event = NULL;
>> > +               }
>> > +               spin_unlock_irqrestore(&drm->event_lock, flags);
>> > +       }
>>
>> As with VC4 and Rockchip, you're missing a ->preclose handler in your
>> drm_drv, to make sure that you don't try to send events to a dead
>> client (which causes an OOPS):
>> https://git.collabora.com/cgit/user/daniels/linux.git/commit/?h=wip/4.4.x/rockchip-drm-fixes&id=d14f21bcd7
>> (and its parent)
>
> Thanks for reviewing this!
>
> I do acknowledge your concerns and you might correct my understanding on
> how atomic DRM works, but I believe in this case we should be safe. The
> event stored in hdlcd->event is taken out of the crtc->state->event during
> the crtc->atomic_begin() callback. If the client is dead the callback should
> not be called, so that's how we avoid the OOPS.

Right, it's taken out of the CRTC state and put into the overall HDLCD
structure. So the OOPS happens when:
  - client submits state with event requested, async flag set
  - atomic_begin moves crtc->state->event into hdlcd->event
  - control returns to client, who exits immediately
  - vblank happens
  - hdlcd->event->base.file_priv now points to a dead client
  - OOPS

>> Also, is there anything preventing clients from submitting multiple
>> pageflips before the event is sent? I couldn't see anything from a
>> quick look, so you could have the situation of:
>>   - client submits pageflip, event 1 stored to hdlcd->event
>>   - client submits pageflip, event 2 stored to hdlcd->event
>>   - vblank arrives, event 2 is sent
>>   - event 1 has disappeared and been leaked
>
> As for multiple events being submitted before vsync interrupt happening: given
> that the event is plucked out of the crtc->state, is that possible? And if so,
> is there a case where having the later event overwrite the earlier one a desired
> outcome?

Having events being overwritten is extremely undesirable; it could
cause a client to stall in the right scenarios (e.g. requests
submitted separately for different planes). It would be far better to
turn hdlcd->event into a list of events which are sent per-vblank,
probably just by retaining a list of pending states to apply; this
also makes it easier to handle async commits in the future (which
Weston in particular relies on).

Cheers,
Daniel
