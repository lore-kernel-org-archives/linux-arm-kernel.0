From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Dec 2015 13:03:53 +0100
Subject: [PATCH v3 0/8] drm/rockchip: covert to support atomic API
In-Reply-To: <56728F3F.6060309@rock-chips.com>
References: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
 <4029109.1DucZWNrFm@diego> <56728F3F.6060309@rock-chips.com>
Message-ID: <1817698.JgNG3flpWP@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am Donnerstag, 17. Dezember 2015, 18:32:31 schrieb Mark yao:
> On 2015?12?17? 18:00, Heiko St?bner wrote:
> > Am Donnerstag, 17. Dezember 2015, 11:01:07 schrieb Mark Yao:
> >> The series of patches coverting drm rockchip to atomic API, do some
> >> cleanup and some fixes on atomic side.

[...]

> > Plugging in HDMI after boot:
> > 
> > [   20.559534] ------------[ cut here ]------------
> > [   20.564412] WARNING: CPU: 3 PID: 74 at
> > drivers/gpu/drm/drm_atomic_helper.c:682
> > drm_atomic_helper_update_legacy_modeset_state+0x6c/0x200() [   20.576991]
> > Modules linked in:
> > [   20.580175] CPU: 3 PID: 74 Comm: irq/51-ff980000 Not tainted 4.4.0-rc5+
> > #2787 [   20.587502] Hardware name: Rockchip (Device Tree)
> > [   20.592347] [<c0019914>] (unwind_backtrace) from [<c0014bcc>]
> > (show_stack+0x20/0x24) [   20.600319] [<c0014bcc>] (show_stack) from
> > [<c02c4344>] (dump_stack+0x84/0xb8) [   20.607776] [<c02c4344>]
> > (dump_stack) from [<c0029a20>] (warn_slowpath_common+0x98/0xc4) [  
> > 20.616087] [<c0029a20>] (warn_slowpath_common) from [<c0029b08>]
> > (warn_slowpath_null+0x2c/0x34) [   20.625106] [<c0029b08>]
> > (warn_slowpath_null) from [<c0361144>]
> > (drm_atomic_helper_update_legacy_modeset_state+0x6c/0x200) [   20.636382]
> > [<c0361144>] (drm_atomic_helper_update_legacy_modeset_state) from
> > [<c0361684>] (drm_atomic_helper_commit_modeset_disables+0x1e4/0x35c) [  
> > 20.649732] [<c0361684>] (drm_atomic_helper_commit_modeset_disables) from
> > [<c038782c>] (rockchip_atomic_commit_complete+0x34/0x108) [   20.661789]
> > [<c038782c>] (rockchip_atomic_commit_complete) from [<c0387984>]
> > (rockchip_drm_atomic_commit+0x84/0xa0) [   20.672442] [<c0387984>]
> > (rockchip_drm_atomic_commit) from [<c0384c58>]
> > (drm_atomic_commit+0x60/0x70) [   20.681711] [<c0384c58>]
> > (drm_atomic_commit) from [<c0363ab0>] (restore_fbdev_mode+0x128/0x258) [ 
> >  20.690418] [<c0363ab0>] (restore_fbdev_mode) from [<c0365208>]
> > (drm_fb_helper_restore_fbdev_mode_unlocked+0x3c/0x80) [   20.701033]
> > [<c0365208>] (drm_fb_helper_restore_fbdev_mode_unlocked) from
> > [<c036529c>] (drm_fb_helper_set_par+0x50/0x60) [   20.711907]
> > [<c036529c>] (drm_fb_helper_set_par) from [<c03651b4>]
> > (drm_fb_helper_hotplug_event+0xc8/0xe0) [   20.721569] [<c03651b4>]
> > (drm_fb_helper_hotplug_event) from [<c0387bd0>]
> > (rockchip_drm_output_poll_changed+0x24/0x28) [   20.732185] [<c0387bd0>]
> > (rockchip_drm_output_poll_changed) from [<c035aaf8>]
> > (drm_kms_helper_hotplug_event+0x34/0x38) [   20.742891] [<c035aaf8>]
> > (drm_kms_helper_hotplug_event) from [<c035b434>]
> > (drm_helper_hpd_irq_event+0x120/0x150) [   20.753078] [<c035b434>]
> > (drm_helper_hpd_irq_event) from [<c038dd1c>] (dw_hdmi_irq+0x14c/0x18c) [ 
> >  20.761772] [<c038dd1c>] (dw_hdmi_irq) from [<c008d030>]
> > (irq_thread_fn+0x2c/0x44) [   20.769350] [<c008d030>] (irq_thread_fn)
> > from [<c008d33c>] (irq_thread+0x118/0x21c) [   20.777019] [<c008d33c>]
> > (irq_thread) from [<c004bbb8>] (kthread+0xf4/0x10c) [   20.784083]
> > [<c004bbb8>] (kthread) from [<c0010010>] (ret_from_fork+0x14/0x24) [  
> > 20.791300] ---[ end trace 3deaa51d288067a0 ]---
> 
> Hi Heiko
>      This issue can be explained from following thread:
>         https://lkml.org/lkml/2015/11/16/498
> 
>      You can fix it by following changes:
> 
> @@ -1667,8 +1667,6 @@ static int dw_hdmi_register(struct drm_device
> *drm, struct dw_hdmi *hdmi)
>                                     &dw_hdmi_connector_funcs,
>                                     DRM_MODE_CONNECTOR_HDMIA);
> 
>      -       hdmi->connector.encoder = encoder;

yep that fixes the warning. From the thread you mention, it looks like that 
assignment should also be removed in the non-atomic case (i.MX)?

Or if it is really necessary there could also wrap it in a conditional to only 
be set for the non-atomic case.


Heiko
