From: daniel@fooishbar.org (Daniel Stone)
Date: Wed, 2 Dec 2015 17:21:44 +0000
Subject: [PATCH v3 2/4] drm: Add support for ARM's HDLCD controller.
In-Reply-To: <1449058982-18595-3-git-send-email-Liviu.Dudau@arm.com>
References: <1449058982-18595-1-git-send-email-Liviu.Dudau@arm.com>
 <1449058982-18595-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <CAPj87rNFFGeL8z9GBXxyVri1RyhVpMGS0yz7opgCYamHYV1Yow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On 2 December 2015 at 12:23, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> +       if (irq_status & HDLCD_INTERRUPT_VSYNC) {
> +               unsigned long flags;
> +
> +               drm_handle_vblank(drm, 0);
> +
> +               spin_lock_irqsave(&drm->event_lock, flags);
> +               if (hdlcd->event) {
> +                       drm_send_vblank_event(drm, hdlcd->event->pipe, hdlcd->event);
> +                       drm_crtc_vblank_put(&hdlcd->crtc);
> +                       hdlcd->event = NULL;
> +               }
> +               spin_unlock_irqrestore(&drm->event_lock, flags);
> +       }

As with VC4 and Rockchip, you're missing a ->preclose handler in your
drm_drv, to make sure that you don't try to send events to a dead
client (which causes an OOPS):
https://git.collabora.com/cgit/user/daniels/linux.git/commit/?h=wip/4.4.x/rockchip-drm-fixes&id=d14f21bcd7
(and its parent)

Also, is there anything preventing clients from submitting multiple
pageflips before the event is sent? I couldn't see anything from a
quick look, so you could have the situation of:
  - client submits pageflip, event 1 stored to hdlcd->event
  - client submits pageflip, event 2 stored to hdlcd->event
  - vblank arrives, event 2 is sent
  - event 1 has disappeared and been leaked

Cheers,
Daniel
