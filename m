From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Mon, 11 Nov 2013 10:25:32 +0100
Subject: imx-drm: possible circular locking dependency detected
Message-ID: <CAH9NwWdswcfwVOoCz3AmS8O7Adaun5tf3QJh5YE2iK96d3ajOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am not sure if this problem is known but here is dmesg output. If a
kernel config is needed I can
send it

[    1.954256] snvs_rtc 20cc034.snvs-rtc-lp: setting system clock to
2013-11-11 08:40:51 UTC (1384159251)
[    1.968781]
[    1.968785] ======================================================
[    1.968788] [ INFO: possible circular locking dependency detected ]
[    1.968793] 3.12.0 #1 Not tainted
[    1.968796] -------------------------------------------------------
[    1.968799] swapper/0/1 is trying to acquire lock:
[    1.968828]  (&imx_drm_device->mutex){+.+.+.}, at: [<c0376248>]
imx_drm_encoder_get_mux_id+0x24/0x78
[    1.968831]
[    1.968831] but task is already holding lock:
[    1.968853]  (&crtc->mutex){+.+.+.}, at: [<c02a2e24>]
drm_modeset_lock_all+0x38/0x50
[    1.968856]
[    1.968856] which lock already depends on the new lock.
[    1.968856]
[    1.968858]
[    1.968858] the existing dependency chain (in reverse order) is:
[    1.968868]
[    1.968868] -> #2 (&crtc->mutex){+.+.+.}:
[    1.968886]        [<c0076e18>] lock_acquire+0x128/0x14c
[    1.968900]        [<c04378c8>] _mutex_lock_nest_lock+0x4c/0x3d0
[    1.968911]        [<c02a3254>] drm_crtc_init+0x40/0x9c
[    1.968923]        [<c03767f0>] imx_drm_add_crtc+0xc8/0x118
[    1.968938]        [<c037c244>] ipu_drm_probe+0x138/0x1ec
[    1.968953]        [<c02b6eac>] platform_drv_probe+0x14/0x18
[    1.968963]        [<c02b604c>] driver_probe_device+0xb4/0x1cc
[    1.968972]        [<c02b61cc>] __driver_attach+0x68/0x8c
[    1.968982]        [<c02b4938>] bus_for_each_dev+0x50/0x84
[    1.968991]        [<c02b57ac>] bus_add_driver+0xac/0x248
[    1.969000]        [<c02b65d4>] driver_register+0x9c/0xe0
[    1.969010]        [<c0008764>] do_one_initcall+0x90/0x138
[    1.969025]        [<c0619c0c>] kernel_init_freeable+0x154/0x224
[    1.969040]        [<c04316d0>] kernel_init+0x8/0xe4
[    1.969053]        [<c000dac8>] ret_from_fork+0x14/0x2c
[    1.969064]
[    1.969064] -> #1 (&dev->mode_config.mutex){+.+.+.}:
[    1.969075]        [<c0076e18>] lock_acquire+0x128/0x14c
[    1.969086]        [<c0437c98>] mutex_lock_nested+0x4c/0x3d0
[    1.969096]        [<c02a2e00>] drm_modeset_lock_all+0x14/0x50
[    1.969105]        [<c02a3114>] drm_encoder_init+0x18/0x70
[    1.969116]        [<c03766a4>] imx_drm_add_encoder+0x88/0xbc
[    1.969127]        [<c03781bc>] imx_ldb_probe+0x368/0x450
[    1.969137]        [<c02b6eac>] platform_drv_probe+0x14/0x18
[    1.969146]        [<c02b604c>] driver_probe_device+0xb4/0x1cc
[    1.969155]        [<c02b61cc>] __driver_attach+0x68/0x8c
[    1.969164]        [<c02b4938>] bus_for_each_dev+0x50/0x84
[    1.969173]        [<c02b57ac>] bus_add_driver+0xac/0x248
[    1.969181]        [<c02b65d4>] driver_register+0x9c/0xe0
[    1.969190]        [<c0008764>] do_one_initcall+0x90/0x138
[    1.969199]        [<c0619c0c>] kernel_init_freeable+0x154/0x224
[    1.969210]        [<c04316d0>] kernel_init+0x8/0xe4
[    1.969219]        [<c000dac8>] ret_from_fork+0x14/0x2c
[    1.969229]
[    1.969229] -> #0 (&imx_drm_device->mutex){+.+.+.}:
[    1.969239]        [<c0076090>] __lock_acquire+0x1248/0x19b0
[    1.969248]        [<c0076e18>] lock_acquire+0x128/0x14c
[    1.969258]        [<c0437c98>] mutex_lock_nested+0x4c/0x3d0
[    1.969268]        [<c0376248>] imx_drm_encoder_get_mux_id+0x24/0x78
[    1.969277]        [<c0377d28>] imx_ldb_encoder_prepare+0x28/0xfc
[    1.969292]        [<c02952a4>] drm_crtc_helper_set_mode+0x1d0/0x458
[    1.969301]        [<c0295c8c>] drm_crtc_helper_set_config+0x660/0x8f8
[    1.969312]        [<c02a38b0>] drm_mode_set_config_internal+0x4c/0xc4
[    1.969322]        [<c029498c>] drm_fb_helper_set_par+0x44/0x9c
[    1.969333]        [<c025a1bc>] fbcon_init+0x2f4/0x40c
[    1.969343]        [<c027e968>] visual_init+0xa0/0xf4
[    1.969353]        [<c0280444>] do_bind_con_driver+0x1ec/0x304
[    1.969362]        [<c02806c0>] do_take_over_console+0x164/0x188
[    1.969369]        [<c025a334>] do_fbcon_takeover+0x60/0xc8
[    1.969380]        [<c043db40>] notifier_call_chain+0x5c/0x9c
[    1.969396]        [<c0045558>] __blocking_notifier_call_chain+0x44/0x58
[    1.969404]        [<c0045580>] blocking_notifier_call_chain+0x14/0x18
[    1.969419]        [<c0252d68>] register_framebuffer+0x1e0/0x224
[    1.969429]        [<c0294888>] drm_fb_helper_initial_config+0x338/0x3f8
[    1.969440]        [<c0296b04>] drm_fbdev_cma_init+0xb4/0xe0
[    1.969454]        [<c0647040>] imx_fb_helper_init+0x48/0x84
[    1.969463]        [<c0008764>] do_one_initcall+0x90/0x138
[    1.969473]        [<c0619c0c>] kernel_init_freeable+0x154/0x224
[    1.969483]        [<c04316d0>] kernel_init+0x8/0xe4
[    1.969493]        [<c000dac8>] ret_from_fork+0x14/0x2c
[    1.969496]
[    1.969496] other info that might help us debug this:
[    1.969496]
[    1.969509] Chain exists of:
[    1.969509]   &imx_drm_device->mutex --> &dev->mode_config.mutex
--> &crtc->mutex
[    1.969509]
[    1.969511]  Possible unsafe locking scenario:
[    1.969511]
[    1.969514]        CPU0                    CPU1
[    1.969516]        ----                    ----
[    1.969521]   lock(&crtc->mutex);
[    1.969528]                                lock(&dev->mode_config.mutex);
[    1.969534]                                lock(&crtc->mutex);
[    1.969540]   lock(&imx_drm_device->mutex);
[    1.969542]
[    1.969542]  *** DEADLOCK ***
[    1.969542]
[    1.969546] 6 locks held by swapper/0/1:
[    1.969563]  #0:  (registration_lock){+.+.+.}, at: [<c0252ba0>]
register_framebuffer+0x18/0x224
[    1.969580]  #1:  (&fb_info->lock){+.+.+.}, at: [<c0251930>]
lock_fb_info+0x18/0x3c
[    1.969595]  #2:  (console_lock){+.+.+.}, at: [<c0252d58>]
register_framebuffer+0x1d0/0x224
[    1.969612]  #3:  ((fb_notifier_list).rwsem){.+.+.+}, at:
[<c004553c>] __blocking_notifier_call_chain+0x28/0x58
[    1.969629]  #4:  (&dev->mode_config.mutex){+.+.+.}, at:
[<c02a2e00>] drm_modeset_lock_all+0x14/0x50
[    1.969645]  #5:  (&crtc->mutex){+.+.+.}, at: [<c02a2e24>]
drm_modeset_lock_all+0x38/0x50
[    1.969647]
[    1.969647] stack backtrace:
[    1.969655] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12.0 #1
[    1.969675] [<c001395c>] (unwind_backtrace+0x0/0xe0) from
[<c0010ff4>] (show_stack+0x10/0x14)
[    1.969689] [<c0010ff4>] (show_stack+0x10/0x14) from [<c0436004>]
(dump_stack+0x64/0xa4)
[    1.969702] [<c0436004>] (dump_stack+0x64/0xa4) from [<c04335ec>]
(print_circular_bug+0x278/0x2cc)
[    1.969716] [<c04335ec>] (print_circular_bug+0x278/0x2cc) from
[<c0076090>] (__lock_acquire+0x1248/0x19b0)
[    1.969728] [<c0076090>] (__lock_acquire+0x1248/0x19b0) from
[<c0076e18>] (lock_acquire+0x128/0x14c)
[    1.969741] [<c0076e18>] (lock_acquire+0x128/0x14c) from
[<c0437c98>] (mutex_lock_nested+0x4c/0x3d0)
[    1.969756] [<c0437c98>] (mutex_lock_nested+0x4c/0x3d0) from
[<c0376248>] (imx_drm_encoder_get_mux_id+0x24/0x78)
[    1.969769] [<c0376248>] (imx_drm_encoder_get_mux_id+0x24/0x78)
from [<c0377d28>] (imx_ldb_encoder_prepare+0x28/0xfc)
[    1.969784] [<c0377d28>] (imx_ldb_encoder_prepare+0x28/0xfc) from
[<c02952a4>] (drm_crtc_helper_set_mode+0x1d0/0x458)
[    1.969797] [<c02952a4>] (drm_crtc_helper_set_mode+0x1d0/0x458)
from [<c0295c8c>] (drm_crtc_helper_set_config+0x660/0x8f8)
[    1.969812] [<c0295c8c>] (drm_crtc_helper_set_config+0x660/0x8f8)
from [<c02a38b0>] (drm_mode_set_config_internal+0x4c/0xc4)
[    1.969825] [<c02a38b0>] (drm_mode_set_config_internal+0x4c/0xc4)
from [<c029498c>] (drm_fb_helper_set_par+0x44/0x9c)
[    1.969838] [<c029498c>] (drm_fb_helper_set_par+0x44/0x9c) from
[<c025a1bc>] (fbcon_init+0x2f4/0x40c)
[    1.969849] [<c025a1bc>] (fbcon_init+0x2f4/0x40c) from [<c027e968>]
(visual_init+0xa0/0xf4)
[    1.969860] [<c027e968>] (visual_init+0xa0/0xf4) from [<c0280444>]
(do_bind_con_driver+0x1ec/0x304)
[    1.969871] [<c0280444>] (do_bind_con_driver+0x1ec/0x304) from
[<c02806c0>] (do_take_over_console+0x164/0x188)
[    1.969882] [<c02806c0>] (do_take_over_console+0x164/0x188) from
[<c025a334>] (do_fbcon_takeover+0x60/0xc8)
[    1.969895] [<c025a334>] (do_fbcon_takeover+0x60/0xc8) from
[<c043db40>] (notifier_call_chain+0x5c/0x9c)
[    1.969908] [<c043db40>] (notifier_call_chain+0x5c/0x9c) from
[<c0045558>] (__blocking_notifier_call_chain+0x44/0x58)
[    1.969921] [<c0045558>] (__blocking_notifier_call_chain+0x44/0x58)
from [<c0045580>] (blocking_notifier_call_chain+0x14/0x18)
[    1.969936] [<c0045580>] (blocking_notifier_call_chain+0x14/0x18)
from [<c0252d68>] (register_framebuffer+0x1e0/0x224)
[    1.969949] [<c0252d68>] (register_framebuffer+0x1e0/0x224) from
[<c0294888>] (drm_fb_helper_initial_config+0x338/0x3f8)
[    1.969961] [<c0294888>] (drm_fb_helper_initial_config+0x338/0x3f8)
from [<c0296b04>] (drm_fbdev_cma_init+0xb4/0xe0)
[    1.969975] [<c0296b04>] (drm_fbdev_cma_init+0xb4/0xe0) from
[<c0647040>] (imx_fb_helper_init+0x48/0x84)
[    1.969987] [<c0647040>] (imx_fb_helper_init+0x48/0x84) from
[<c0008764>] (do_one_initcall+0x90/0x138)
[    1.970000] [<c0008764>] (do_one_initcall+0x90/0x138) from
[<c0619c0c>] (kernel_init_freeable+0x154/0x224)
[    1.970015] [<c0619c0c>] (kernel_init_freeable+0x154/0x224) from
[<c04316d0>] (kernel_init+0x8/0xe4)
[    1.970029] [<c04316d0>] (kernel_init+0x8/0xe4) from [<c000dac8>]
(ret_from_fork+0x14/0x2c)
[    1.972821] Console: switching to colour frame buffer device 80x30

greets
--
Christian Gmeiner, MSc
