From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Dec 2015 11:00:16 +0100
Subject: [PATCH v3 0/8] drm/rockchip: covert to support atomic API
In-Reply-To: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
References: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <4029109.1DucZWNrFm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am Donnerstag, 17. Dezember 2015, 11:01:07 schrieb Mark Yao:
> The series of patches coverting drm rockchip to atomic API, do some
> cleanup and some fixes on atomic side.
> 
> TODO: fence is not support on current version.
> 
> Tested on rk3288 popmetal board.

In general this works nicely and hdmi is still working on my firefly, so

Tested-by: Heiko Stuebner <heiko@sntech.de>


I get one warning though, which seems to be related to fbcon grabbing
the framebuffer it seems.


HDMI plugged in on boot:

[    4.345329] ------------[ cut here ]------------
[    4.345360] WARNING: CPU: 1 PID: 66 at drivers/gpu/drm/drm_atomic_helper.c:682 drm_atomic_helper_update_legacy_modeset_state+0x6c/0x200()
[    4.345373] Modules linked in:
[    4.345386] CPU: 1 PID: 66 Comm: kworker/u8:1 Not tainted 4.4.0-rc5+ #2787
[    4.345392] Hardware name: Rockchip (Device Tree)
[    4.345411] Workqueue: deferwq deferred_probe_work_func
[    4.345438] [<c0019914>] (unwind_backtrace) from [<c0014bcc>] (show_stack+0x20/0x24)
[    4.345458] [<c0014bcc>] (show_stack) from [<c02c4344>] (dump_stack+0x84/0xb8)
[    4.345479] [<c02c4344>] (dump_stack) from [<c0029a20>] (warn_slowpath_common+0x98/0xc4)
[    4.345496] [<c0029a20>] (warn_slowpath_common) from [<c0029b08>] (warn_slowpath_null+0x2c/0x34)
[    4.345514] [<c0029b08>] (warn_slowpath_null) from [<c0361144>] (drm_atomic_helper_update_legacy_modeset_state+0x6c/0x200)
[    4.345534] [<c0361144>] (drm_atomic_helper_update_legacy_modeset_state) from [<c0361684>] (drm_atomic_helper_commit_modeset_disables+0x1e4/0x35c)
[    4.345557] [<c0361684>] (drm_atomic_helper_commit_modeset_disables) from [<c038782c>] (rockchip_atomic_commit_complete+0x34/0x108)
[    4.345576] [<c038782c>] (rockchip_atomic_commit_complete) from [<c0387984>] (rockchip_drm_atomic_commit+0x84/0xa0)
[    4.345594] [<c0387984>] (rockchip_drm_atomic_commit) from [<c0384c58>] (drm_atomic_commit+0x60/0x70)
[    4.345609] [<c0384c58>] (drm_atomic_commit) from [<c0363ab0>] (restore_fbdev_mode+0x128/0x258)
[    4.345625] [<c0363ab0>] (restore_fbdev_mode) from [<c0365208>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x3c/0x80)
[    4.345640] [<c0365208>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c036529c>] (drm_fb_helper_set_par+0x50/0x60)
[    4.345659] [<c036529c>] (drm_fb_helper_set_par) from [<c03052cc>] (fbcon_init+0x328/0x458)
[    4.345676] [<c03052cc>] (fbcon_init) from [<c033a66c>] (visual_init+0xc4/0x114)
[    4.345692] [<c033a66c>] (visual_init) from [<c033c098>] (do_bind_con_driver+0x1fc/0x330)
[    4.345707] [<c033c098>] (do_bind_con_driver) from [<c033c540>] (do_take_over_console+0x174/0x1b4)
[    4.345722] [<c033c540>] (do_take_over_console) from [<c0305464>] (do_fbcon_takeover+0x68/0xd0)
[    4.345738] [<c0305464>] (do_fbcon_takeover) from [<c0305c6c>] (fbcon_event_notify+0x3fc/0x7d8)
[    4.345756] [<c0305c6c>] (fbcon_event_notify) from [<c004d144>] (notifier_call_chain+0x58/0x80)
[    4.345771] [<c004d144>] (notifier_call_chain) from [<c004d4d4>] (__blocking_notifier_call_chain+0x54/0x6c)
[    4.345785] [<c004d4d4>] (__blocking_notifier_call_chain) from [<c004d514>] (blocking_notifier_call_chain+0x28/0x30)
[    4.345804] [<c004d514>] (blocking_notifier_call_chain) from [<c0308c68>] (fb_notifier_call_chain+0x24/0x2c)
[    4.345822] [<c0308c68>] (fb_notifier_call_chain) from [<c030aa7c>] (register_framebuffer+0x214/0x264)
[    4.345839] [<c030aa7c>] (register_framebuffer) from [<c0365a00>] (drm_fb_helper_initial_config+0x2dc/0x34c)
[    4.345856] [<c0365a00>] (drm_fb_helper_initial_config) from [<c038823c>] (rockchip_drm_fbdev_init+0x9c/0xe4)
[    4.345873] [<c038823c>] (rockchip_drm_fbdev_init) from [<c03876bc>] (rockchip_drm_load+0x25c/0x2b0)
[    4.345892] [<c03876bc>] (rockchip_drm_load) from [<c036eae4>] (drm_dev_register+0x80/0xc4)
[    4.345910] [<c036eae4>] (drm_dev_register) from [<c03873d4>] (rockchip_drm_bind+0x58/0x84)
[    4.345932] [<c03873d4>] (rockchip_drm_bind) from [<c03b4b54>] (try_to_bring_up_master.part.0+0xbc/0x114)
[    4.345950] [<c03b4b54>] (try_to_bring_up_master.part.0) from [<c03b4da0>] (component_add+0xb0/0x118)
[    4.345967] [<c03b4da0>] (component_add) from [<c038a2d8>] (vop_probe+0x40/0x4c)
[    4.345984] [<c038a2d8>] (vop_probe) from [<c03bc350>] (platform_drv_probe+0x60/0xb0)
[    4.345999] [<c03bc350>] (platform_drv_probe) from [<c03b9ffc>] (driver_probe_device+0x1a0/0x418)
[    4.346014] [<c03b9ffc>] (driver_probe_device) from [<c03ba3f8>] (__device_attach_driver+0x94/0xa0)
[    4.346028] [<c03ba3f8>] (__device_attach_driver) from [<c03b82a0>] (bus_for_each_drv+0x94/0xa4)
[    4.346042] [<c03b82a0>] (bus_for_each_drv) from [<c03b9d3c>] (__device_attach+0xa4/0x144)
[    4.346055] [<c03b9d3c>] (__device_attach) from [<c03ba564>] (device_initial_probe+0x1c/0x20)
[    4.346068] [<c03ba564>] (device_initial_probe) from [<c03b91d4>] (bus_probe_device+0x38/0x94)
[    4.346082] [<c03b91d4>] (bus_probe_device) from [<c03b9714>] (deferred_probe_work_func+0x8c/0xbc)
[    4.346098] [<c03b9714>] (deferred_probe_work_func) from [<c0045094>] (process_one_work+0x328/0x668)
[    4.346112] [<c0045094>] (process_one_work) from [<c0046304>] (worker_thread+0x2cc/0x41c)
[    4.346128] [<c0046304>] (worker_thread) from [<c004bbb8>] (kthread+0xf4/0x10c)
[    4.346146] [<c004bbb8>] (kthread) from [<c0010010>] (ret_from_fork+0x14/0x24)
[    4.346155] ---[ end trace 8cd78a9f6ee0a57e ]---


Plugging in HDMI after boot:

[   20.559534] ------------[ cut here ]------------
[   20.564412] WARNING: CPU: 3 PID: 74 at drivers/gpu/drm/drm_atomic_helper.c:682 drm_atomic_helper_update_legacy_modeset_state+0x6c/0x200()
[   20.576991] Modules linked in:
[   20.580175] CPU: 3 PID: 74 Comm: irq/51-ff980000 Not tainted 4.4.0-rc5+ #2787
[   20.587502] Hardware name: Rockchip (Device Tree)
[   20.592347] [<c0019914>] (unwind_backtrace) from [<c0014bcc>] (show_stack+0x20/0x24)
[   20.600319] [<c0014bcc>] (show_stack) from [<c02c4344>] (dump_stack+0x84/0xb8)
[   20.607776] [<c02c4344>] (dump_stack) from [<c0029a20>] (warn_slowpath_common+0x98/0xc4)
[   20.616087] [<c0029a20>] (warn_slowpath_common) from [<c0029b08>] (warn_slowpath_null+0x2c/0x34)
[   20.625106] [<c0029b08>] (warn_slowpath_null) from [<c0361144>] (drm_atomic_helper_update_legacy_modeset_state+0x6c/0x200)
[   20.636382] [<c0361144>] (drm_atomic_helper_update_legacy_modeset_state) from [<c0361684>] (drm_atomic_helper_commit_modeset_disables+0x1e4/0x35c)
[   20.649732] [<c0361684>] (drm_atomic_helper_commit_modeset_disables) from [<c038782c>] (rockchip_atomic_commit_complete+0x34/0x108)
[   20.661789] [<c038782c>] (rockchip_atomic_commit_complete) from [<c0387984>] (rockchip_drm_atomic_commit+0x84/0xa0)
[   20.672442] [<c0387984>] (rockchip_drm_atomic_commit) from [<c0384c58>] (drm_atomic_commit+0x60/0x70)
[   20.681711] [<c0384c58>] (drm_atomic_commit) from [<c0363ab0>] (restore_fbdev_mode+0x128/0x258)
[   20.690418] [<c0363ab0>] (restore_fbdev_mode) from [<c0365208>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x3c/0x80)
[   20.701033] [<c0365208>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c036529c>] (drm_fb_helper_set_par+0x50/0x60)
[   20.711907] [<c036529c>] (drm_fb_helper_set_par) from [<c03651b4>] (drm_fb_helper_hotplug_event+0xc8/0xe0)
[   20.721569] [<c03651b4>] (drm_fb_helper_hotplug_event) from [<c0387bd0>] (rockchip_drm_output_poll_changed+0x24/0x28)
[   20.732185] [<c0387bd0>] (rockchip_drm_output_poll_changed) from [<c035aaf8>] (drm_kms_helper_hotplug_event+0x34/0x38)
[   20.742891] [<c035aaf8>] (drm_kms_helper_hotplug_event) from [<c035b434>] (drm_helper_hpd_irq_event+0x120/0x150)
[   20.753078] [<c035b434>] (drm_helper_hpd_irq_event) from [<c038dd1c>] (dw_hdmi_irq+0x14c/0x18c)
[   20.761772] [<c038dd1c>] (dw_hdmi_irq) from [<c008d030>] (irq_thread_fn+0x2c/0x44)
[   20.769350] [<c008d030>] (irq_thread_fn) from [<c008d33c>] (irq_thread+0x118/0x21c)
[   20.777019] [<c008d33c>] (irq_thread) from [<c004bbb8>] (kthread+0xf4/0x10c)
[   20.784083] [<c004bbb8>] (kthread) from [<c0010010>] (ret_from_fork+0x14/0x24)
[   20.791300] ---[ end trace 3deaa51d288067a0 ]---
