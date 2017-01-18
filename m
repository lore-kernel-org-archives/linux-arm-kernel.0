From: randy.li@rock-chips.com (Randy Li)
Date: Wed, 18 Jan 2017 17:58:37 +0800
Subject: drm: rockchip: CONFIG_DRM_FBDEV_EMULATION will crash the HDMI
 down sometimes
In-Reply-To: <587DD4E3.5070202@rock-chips.com>
References: <edb88801-6ea1-3909-2e4e-ba78df6d3c7c@rock-chips.com>
 <587DD4E3.5070202@rock-chips.com>
Message-ID: <d3c6d319-6641-e17d-397c-63058f38aea6@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/17/2017 04:25 PM, Mark yao wrote:
>
> static void vop_plane_atomic_update(struct drm_plane *plane,
>         struct drm_plane_state *old_state)
> {
>     if (WARN_ON(!vop->is_enabled))
>         return;
>
> The issues seems vop is not enable. but commit planes is using
> DRM_PLANE_COMMIT_ACTIVE_ONLY...
>
> Hi Randy
>
> Can you add some print for this bug:
>     1, I think vop_crtc_enable function should be call before
> vop_plane_atomic_update, you can add some print to verified it.
Not hint
>     2, also add a trace on vop_crtc_disable.
Not hint
>     3, print the status of  crtc->state->active and
> plane_crtc_active(plane->state) when bug happen.
hint

[   11.481977] vop active 1, state 1

The full log is attached here
[   10.887294] rockchip-drm display-subsystem: bound ff940000.vop (ops 
vop_component_ops [rockchipdrm])
[  OK  ] Started Initialize hardware monitoring sensors.
[   10.898567] rockchip-drm display-subsystem: bound ff930000.vop (ops 
vop_component_ops [rockchipdrm])
[   10.912280] dwhdmi-rockchip ff980000.hdmi: Detected HDMI controller 
0x20:0xa:0xa0:0xc1
[   10.921423] rockchip-drm display-subsystem: bound ff980000.hdmi (ops 
dw_hdmi_rockchip_ops [dw_hdmi_rockchip])
[   10.931413] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.938090] [drm] No driver support for vblank timestamp query.
[   11.002102] rockchip-drm display-subsystem: fb0:  frame buffer device
[   11.031833] [drm] Initialized rockchip 1.0.0 20140818 for 
display-subsystem on minor 0
[  OK  ] Started Login Service.
[  OK  ] Created slice system-systemd\x2dbacklight.slice.
          Starting Load/Save Screen Backlight...htness of 
backlight:backlight...

[   11.128697] rk_iommu ff940300.iommu: FORCE_RESET command timed out
[   11.134928] rockchip-vop ff940000.vop: failed to attach dma mapping, -110
[   11.141805] rockchip-vop ff940000.vop: [drm:vop_crtc_enable] *ERROR* 
Failed to enable vop (-110)
[  OK  ] Started Load/Save Screen Backlight Brightness of 
backlight:backlight.
[   11.181850] ------------[ cut here ]------------
[   11.186568] WARNING: CPU: 3 PID: 167 at 
/home/ayaka/workspace/rk3288/kernel/linux-kernel/drivers/gpu/drm/rockchip/rockchip_drm$
vop.c:731 vop_plane_atomic_update+0x94/0x17a8 [rockchipdrm]
[   11.203254] Modules linked in: rockchip_vop_reg dw_hdmi_rockchip 
dw_hdmi rockchipdrm drm_kms_helper mali_kbase cfbfillrect sys$
opyarea rk_crypto gpio_ir_recv cfbimgblt panel_simple sysfillrect 
rc_core sysimgblt nvmem_rockchip_efuse fb_sys_fops cfbcopyarea $
rm des_generic dwc2 pwm_rockchip phy_rockchip_usb udc_core fb pwm_bl 
backlight
[   11.233011] CPU: 3 PID: 167 Comm: kworker/3:2 Not tainted 
4.10.0-rc3-next-20170111+ #149
[   11.241105] Hardware name: Rockchip (Device Tree)
[   11.245898] Workqueue: events output_poll_execute [drm_kms_helper]
[   11.252129] [<c0112b98>] (unwind_backtrace) from [<c010dab8>] 
(show_stack+0x20/0x24)
[   11.259896] [<c010dab8>] (show_stack) from [<c044973c>] 
(dump_stack+0x8c/0xa0)
[   11.267137] [<c044973c>] (dump_stack) from [<c0125f88>] 
(__warn+0xf8/0x110)
[   11.274119] [<c0125f88>] (__warn) from [<c01260b8>] 
(warn_slowpath_null+0x30/0x38)
[   11.281724] [<c01260b8>] (warn_slowpath_null) from [<bf57330c>] 
(vop_plane_atomic_update+0x94/0x17a8 [rockchipdrm])
[   11.292283] [<bf57330c>] (vop_plane_atomic_update [rockchipdrm]) from 
[<bf494590>] (drm_atomic_helper_commit_planes+0xd4/0x2b8
[drm_kms_helper])
[   11.305337] [<bf494590>] (drm_atomic_helper_commit_planes 
[drm_kms_helper]) from [<bf56fa88>] (rockchip_atomic_commit_tail+0x44
/0x68 [rockchipdrm])
[   11.318643] [<bf56fa88>] (rockchip_atomic_commit_tail [rockchipdrm]) 
from [<bf498714>] (commit_tail+0x50/0xb8 [drm_kms_helper])
[   11.330262] [<bf498714>] (commit_tail [drm_kms_helper]) from 
[<bf498870>] (drm_atomic_helper_commit+0xd4/0x13c [drm_kms_helper]
)
[   11.342071] [<bf498870>] (drm_atomic_helper_commit [drm_kms_helper]) 
from [<bf10b18c>] (drm_atomic_commit+0x5c/0x68 [drm])
[   11.353363] [<bf10b18c>] (drm_atomic_commit [drm]) from [<bf49c0f8>] 
(restore_fbdev_mode+0x160/0x300 [drm_kms_helper])
[   11.364207] [<bf49c0f8>] (restore_fbdev_mode [drm_kms_helper]) from 
[<bf49d71c>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x4
0/0x84 [drm_kms_helper])
[   11.377916] [<bf49d71c>] (drm_fb_helper_restore_fbdev_mode_unlocked 
[drm_kms_helper]) from [<bf49d7a0>] (drm_fb_helper_set_par+
0x40/0x70 [drm_kms_helper])
[   11.391942] [<bf49d7a0>] (drm_fb_helper_set_par [drm_kms_helper]) 
from [<bf49d6d4>] (drm_fb_helper_hotplug_event+0xb4/0xbc [drm
_kms_helper])
[   11.404652] [<bf49d6d4>] (drm_fb_helper_hotplug_event 
[drm_kms_helper]) from [<bf56fad0>] (rockchip_drm_output_poll_changed+0x2
4/0x28 [rockchipdrm])
[   11.418047] [<bf56fad0>] (rockchip_drm_output_poll_changed 
[rockchipdrm]) from [<bf48db64>] (drm_kms_helper_hotplug_event+0x34$
0x38 [drm_kms_helper])
[   11.431573] [<bf48db64>] (drm_kms_helper_hotplug_event 
[drm_kms_helper]) from [<bf48dc7c>] (output_poll_execute+0xbc/0x1f4 [dr$
_kms_helper])
[   11.444286] [<bf48dc7c>] (output_poll_execute [drm_kms_helper]) from 
[<c0142364>] (process_one_work+0x1b0/0x4c0)
[   11.454476] [<c0142364>] (process_one_work) from [<c014328c>] 
(worker_thread+0x60/0x548)
[   11.462581] [<c014328c>] (worker_thread) from [<c0148ec0>] 
(kthread+0x128/0x158)
[   11.469994] [<c0148ec0>] (kthread) from [<c0108e90>] 
(ret_from_fork+0x14/0x24)
[   11.477309] ---[ end trace 92447684af807ac2 ]---

[   11.481977] vop active 1, state 1

[   11.481985] ------------[ cut here ]------------
[   11.482021] WARNING: CPU: 3 PID: 167 at 
/home/ayaka/workspace/rk3288/kernel/linux-kernel/drivers/gpu/drm/rockchip/rockchip_drm_
vop.c:1023 vop_crtc_atomic_flush+0x27c/0x2b8 [rockchipdrm]
[   11.482030] Modules linked in: rockchip_vop_reg dw_hdmi_rockchip 
dw_hdmi rockchipdrm drm_kms_helper mali_kbase cfbfillrect sysc
opyarea rk_crypto gpio_ir_recv cfbimgblt panel_simple sysfillrect 
rc_core sysimgblt nvmem_rockchip_efuse fb_sys_fops cfbcopyarea d
rm des_generic dwc2 pwm_rockchip phy_rockchip_usb udc_core fb pwm_bl 
backlight
[   11.482119] CPU: 3 PID: 167 Comm: kworker/3:2 Tainted: G        W 
   4.10.0-rc3-next-20170111+ #149
[   11.482122] Hardware name: Rockchip (Device Tree)
[   11.482200] Workqueue: events output_poll_execute [drm_kms_helper]
[   11.482227] [<c0112b98>] (unwind_backtrace) from [<c010dab8>] 
(show_stack+0x20/0x24)
[   11.482242] [<c010dab8>] (show_stack) from [<c044973c>] 
(dump_stack+0x8c/0xa0)
[   11.482259] [<c044973c>] (dump_stack) from [<c0125f88>] 
(__warn+0xf8/0x110)
[   11.482275] [<c0125f88>] (__warn) from [<c01260b8>] 
(warn_slowpath_null+0x30/0x38)
[   11.482308] [<c01260b8>] (warn_slowpath_null) from [<bf5713e0>] 
(vop_crtc_atomic_flush+0x27c/0x2b8 [rockchipdrm])
[   11.482416] [<bf5713e0>] (vop_crtc_atomic_flush [rockchipdrm]) from 
[<bf49468c>] (drm_atomic_helper_commit_planes+0x1d0/0x2b8 [
drm_kms_helper])
[   11.482522] [<bf49468c>] (drm_atomic_helper_commit_planes 
[drm_kms_helper]) from [<bf56fa88>] (rockchip_atomic_commit_tail+0x44
/0x68 [rockchipdrm])
[   11.482623] [<bf56fa88>] (rockchip_atomic_commit_tail [rockchipdrm]) 
from [<bf498714>] (commit_tail+0x50/0xb8 [drm_kms_helper])
[   11.482779] [<bf498714>] (commit_tail [drm_kms_helper]) from 
[<bf498870>] (drm_atomic_helper_commit+0xd4/0x13c [drm_kms_helper]
)
[   11.483024] [<bf498870>] (drm_atomic_helper_commit [drm_kms_helper]) 
from [<bf10b18c>] (drm_atomic_commit+0x5c/0x68 [drm])
[   11.483270] [<bf10b18c>] (drm_atomic_commit [drm]) from [<bf49c0f8>] 
(restore_fbdev_mode+0x160/0x300 [drm_kms_helper])
[   11.483422] [<bf49c0f8>] (restore_fbdev_mode [drm_kms_helper]) from 
[<bf49d71c>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x4
0/0x84 [drm_kms_helper])
[   11.483569] [<bf49d71c>] (drm_fb_helper_restore_fbdev_mode_unlocked 
[drm_kms_helper]) from [<bf49d7a0>] (drm_fb_helper_set_par+
0x40/0x70 [drm_kms_helper])
[   11.483715] [<bf49d7a0>] (drm_fb_helper_set_par [drm_kms_helper]) 
from [<bf49d6d4>] (drm_fb_helper_hotplug_event+0xb4/0xbc [drm
_kms_helper])
[   11.483821] [<bf49d6d4>] (drm_fb_helper_hotplug_event 
[drm_kms_helper]) from [<bf56fad0>] (rockchip_drm_output_poll_changed+0x2
4/0x28 [rockchipdrm])


>
> Thanks.
> On 2017?01?17? 15:58, Randy Li wrote:
>> Hello:
>>   I want to enable the video output at RK3288 Firefly board, but I
>> found if I enable CONFIG_DRM_FBDEV_EMULATION, the HDMI would crash
>> down sometimes but sometimes it works. After disable that opinion, I
>> never meet a problem. I have not verified it with eDP as I meet a big
>> problem in there.
>>[..]
>> [   34.464856] ---[ end trace 95ed2c3f167607d5 ]---
>
>

-- 
Randy Li
