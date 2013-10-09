From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Oct 2013 22:35:01 +0100
Subject: [BUG] imx-drm: lockdep circular locking dependency
Message-ID: <20131009213501.GM25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A suggestion to IMX developers: please run your test kernels with
PROVE_LOCKING enabled (and preferably other debugging options too.)
Thanks.

======================================================
[ INFO: possible circular locking dependency detected ]
3.12.0-rc3+ #43 Not tainted
-------------------------------------------------------
swapper/0/1 is trying to acquire lock:
 (&imx_drm_device->mutex){+.+.+.}, at: [<c046eaa8>] imx_drm_encoder_get_mux_id+0x28/0x98

but task is already holding lock:
 (&crtc->mutex){+.+...}, at: [<c03094b0>] drm_modeset_lock_all+0x44/0x58

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&crtc->mutex){+.+...}:
       [<c0076660>] __lock_acquire+0x15a8/0x1e1c
       [<c0077420>] lock_acquire+0x68/0x7c
       [<c05fe4c4>] _mutex_lock_nest_lock+0x58/0x388
       [<c030960c>] drm_crtc_init+0x48/0xb0
       [<c046f1a0>] imx_drm_add_crtc+0xe4/0x148
       [<c0475f20>] ipu_drm_probe+0x138/0x20c
       [<c031cd6c>] platform_drv_probe+0x20/0x24
       [<c031b9d4>] driver_probe_device+0x9c/0x234
       [<c031bc08>] __driver_attach+0x9c/0xa0
       [<c0319fbc>] bus_for_each_dev+0x70/0x94
       [<c031b620>] driver_attach+0x24/0x28
       [<c031b134>] bus_add_driver+0x1d8/0x26c
       [<c031c2a4>] driver_register+0x80/0xfc
       [<c031d07c>] __platform_driver_register+0x50/0x64
       [<c081d8e8>] ipu_drm_driver_init+0x18/0x20
       [<c000879c>] do_one_initcall+0x38/0x168
       [<c07fac34>] kernel_init_freeable+0x104/0x1cc
       [<c05fa7fc>] kernel_init+0x10/0xec
       [<c000ea08>] ret_from_fork+0x14/0x2c

-> #1 (&dev->mode_config.mutex){+.+.+.}:
       [<c0076660>] __lock_acquire+0x15a8/0x1e1c
       [<c0077420>] lock_acquire+0x68/0x7c
       [<c05fe850>] mutex_lock_nested+0x5c/0x38c
       [<c030948c>] drm_modeset_lock_all+0x20/0x58
       [<c03094e4>] drm_encoder_init+0x20/0x84
       [<c046effc>] imx_drm_add_encoder+0x8c/0xe0
       [<c0470f24>] imx_ldb_probe+0x2bc/0x50c
       [<c031cd6c>] platform_drv_probe+0x20/0x24
       [<c031b9d4>] driver_probe_device+0x9c/0x234
       [<c031bc08>] __driver_attach+0x9c/0xa0
       [<c0319fbc>] bus_for_each_dev+0x70/0x94
       [<c031b620>] driver_attach+0x24/0x28
       [<c031b134>] bus_add_driver+0x1d8/0x26c
       [<c031c2a4>] driver_register+0x80/0xfc
       [<c031d07c>] __platform_driver_register+0x50/0x64
       [<c081d818>] imx_ldb_driver_init+0x18/0x20
       [<c000879c>] do_one_initcall+0x38/0x168
       [<c07fac34>] kernel_init_freeable+0x104/0x1cc
       [<c05fa7fc>] kernel_init+0x10/0xec
       [<c000ea08>] ret_from_fork+0x14/0x2c

-> #0 (&imx_drm_device->mutex){+.+.+.}:
       [<c0073604>] print_circular_bug+0x74/0x2fc
       [<c0076828>] __lock_acquire+0x1770/0x1e1c
       [<c0077420>] lock_acquire+0x68/0x7c
       [<c05fe850>] mutex_lock_nested+0x5c/0x38c
       [<c046eaa8>] imx_drm_encoder_get_mux_id+0x28/0x98
       [<c0470b0c>] imx_ldb_encoder_prepare+0x3c/0x12c
       [<c02fa040>] drm_crtc_helper_set_mode+0x1f8/0x4b0
       [<c02fac3c>] drm_crtc_helper_set_config+0x7b4/0x9dc
       [<c0308828>] drm_mode_set_config_internal+0x68/0xf0
       [<c02f8c7c>] drm_fb_helper_set_par+0x54/0xb0
       [<c02ba12c>] fbcon_init+0x4c8/0x520
       [<c02e7e94>] visual_init+0xac/0xf8
       [<c02e9a1c>] do_bind_con_driver+0x16c/0x388
       [<c02e9cdc>] do_take_over_console+0xa4/0x1b4
       [<c02b7140>] do_fbcon_takeover+0x70/0xd4
       [<c02bc264>] fbcon_event_notify+0x7e0/0x830
       [<c0046c48>] notifier_call_chain+0x4c/0x8c
       [<c0047164>] __blocking_notifier_call_chain+0x50/0x68
       [<c004719c>] blocking_notifier_call_chain+0x20/0x28
       [<c02b0008>] fb_notifier_call_chain+0x20/0x24
       [<c02b12dc>] register_framebuffer+0x1ac/0x268
       [<c02f90e0>] drm_fb_helper_initial_config+0x408/0x574
       [<c02fb8d8>] drm_fbdev_cma_init+0x7c/0xe8
       [<c081d878>] imx_fb_helper_init+0x58/0x90
       [<c000879c>] do_one_initcall+0x38/0x168
       [<c07fac34>] kernel_init_freeable+0x104/0x1cc
       [<c05fa7fc>] kernel_init+0x10/0xec
       [<c000ea08>] ret_from_fork+0x14/0x2c

other info that might help us debug this:

Chain exists of:
  &imx_drm_device->mutex --> &dev->mode_config.mutex --> &crtc->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&crtc->mutex);
                               lock(&dev->mode_config.mutex);
                               lock(&crtc->mutex);
  lock(&imx_drm_device->mutex);

 *** DEADLOCK ***


6 locks held by swapper/0/1:
 #0:  (registration_lock){+.+.+.}, at: [<c02b1150>] register_framebuffer+0x20/0x268
 #1:  (&fb_info->lock){+.+.+.}, at: [<c02b05d8>] lock_fb_info+0x20/0x44
 #2:  (console_lock){+.+.+.}, at: [<c02b12cc>] register_framebuffer+0x19c/0x268
 #3:  ((fb_notifier_list).rwsem){.+.+.+}, at: [<c0047148>] __blocking_notifier_call_chain+0x34/0x68
 #4:  (&dev->mode_config.mutex){+.+.+.}, at: [<c030948c>] drm_modeset_lock_all+0x20/0x58
 #5:  (&crtc->mutex){+.+...}, at: [<c03094b0>] drm_modeset_lock_all+0x44/0x58

stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12.0-rc3+ #43
Backtrace: 
[<c001214c>] (dump_backtrace+0x0/0x10c) from [<c00122e8>] (show_stack+0x18/0x1c)
 r6:c097dba8 r5:c097e318 r4:00000000 r3:00000000
[<c00122d0>] (show_stack+0x0/0x1c) from [<c05fc748>] (dump_stack+0x70/0x90)
[<c05fc6d8>] (dump_stack+0x0/0x90) from [<c0073760>] (print_circular_bug+0x1d0/0x2fc)
 r4:c097ddc8 r3:df870000
[<c0073590>] (print_circular_bug+0x0/0x2fc) from [<c0076828>] (__lock_acquire+0x1770/0x1e1c)
[<c00750b8>] (__lock_acquire+0x0/0x1e1c) from [<c0077420>] (lock_acquire+0x68/0x7c)
[<c00773b8>] (lock_acquire+0x0/0x7c) from [<c05fe850>] (mutex_lock_nested+0x5c/0x38c)
 r7:df86c000 r6:c088904c r5:c046eaa8 r4:dfb6c4a0
[<c05fe7f4>] (mutex_lock_nested+0x0/0x38c) from [<c046eaa8>] (imx_drm_encoder_get_mux_id+0x28/0x98)
[<c046ea80>] (imx_drm_encoder_get_mux_id+0x0/0x98) from [<c0470b0c>] (imx_ldb_encoder_prepare+0x3c/0x12c)
 r7:df83f5d8 r6:dfb8b418 r5:df83f010 r4:df83fa8c
[<c0470ad0>] (imx_ldb_encoder_prepare+0x0/0x12c) from [<c02fa040>] (drm_crtc_helper_set_mode+0x1f8/0x4b0)
[<c02f9e48>] (drm_crtc_helper_set_mode+0x0/0x4b0) from [<c02fac3c>] (drm_crtc_helper_set_config+0x7b4/0x9dc)
[<c02fa488>] (drm_crtc_helper_set_config+0x0/0x9dc) from [<c0308828>] (drm_mode_set_config_internal+0x68/0xf0)
[<c03087c0>] (drm_mode_set_config_internal+0x0/0xf0) from [<c02f8c7c>] (drm_fb_helper_set_par+0x54/0xb0)
 r6:df009000 r5:00000001 r4:df80c800 r3:00000002
[<c02f8c28>] (drm_fb_helper_set_par+0x0/0xb0) from [<c02ba12c>] (fbcon_init+0x4c8/0x520)
 r7:c0dc3f28 r6:00000000 r5:dfbffc00 r4:df80c800
[<c02b9c64>] (fbcon_init+0x0/0x520) from [<c02e7e94>] (visual_init+0xac/0xf8)
[<c02e7de8>] (visual_init+0x0/0xf8) from [<c02e9a1c>] (do_bind_con_driver+0x16c/0x388)
 r7:00000001 r6:df80c800 r5:00000000 r4:c0658a10
[<c02e98b0>] (do_bind_con_driver+0x0/0x388) from [<c02e9cdc>] (do_take_over_console+0xa4/0x1b4)
[<c02e9c38>] (do_take_over_console+0x0/0x1b4) from [<c02b7140>] (do_fbcon_takeover+0x70/0xd4)
[<c02b70d0>] (do_fbcon_takeover+0x0/0xd4) from [<c02bc264>] (fbcon_event_notify+0x7e0/0x830)
 r5:c0dc5f20 r4:c0856554
[<c02bba84>] (fbcon_event_notify+0x0/0x830) from [<c0046c48>] (notifier_call_chain+0x4c/0x8c)
[<c0046bfc>] (notifier_call_chain+0x0/0x8c) from [<c0047164>] (__blocking_notifier_call_chain+0x50/0x68)
 r8:dfbffe9c r7:00000005 r6:df86ddb8 r5:ffffffff r4:c085637c
r3:ffffffff
[<c0047114>] (__blocking_notifier_call_chain+0x0/0x68) from [<c004719c>] (blocking_notifier_call_chain+0x20/0x28)
 r7:dfbffc0c r6:00000000 r5:c0840f58 r4:00000000
[<c004717c>] (blocking_notifier_call_chain+0x0/0x28) from [<c02b0008>] (fb_notifier_call_chain+0x20/0x24)
[<c02affe8>] (fb_notifier_call_chain+0x0/0x24) from [<c02b12dc>] (register_framebuffer+0x1ac/0x268)
[<c02b1130>] (register_framebuffer+0x0/0x268) from [<c02f90e0>] (drm_fb_helper_initial_config+0x408/0x574)
[<c02f8cd8>] (drm_fb_helper_initial_config+0x0/0x574) from [<c02fb8d8>] (drm_fbdev_cma_init+0x7c/0xe8)
[<c02fb85c>] (drm_fbdev_cma_init+0x0/0xe8) from [<c081d878>] (imx_fb_helper_init+0x58/0x90)
 r8:c07fa49c r7:00000000 r6:df86c000 r5:c0876ac8 r4:c0dcd850
r3:00000004
[<c081d820>] (imx_fb_helper_init+0x0/0x90) from [<c000879c>] (do_one_initcall+0x38/0x168)
 r5:00000007 r4:c0829720
[<c0008764>] (do_one_initcall+0x0/0x168) from [<c07fac34>] (kernel_init_freeable+0x104/0x1cc)
[<c07fab30>] (kernel_init_freeable+0x0/0x1cc) from [<c05fa7fc>] (kernel_init+0x10/0xec)
[<c05fa7ec>] (kernel_init+0x0/0xec) from [<c000ea08>] (ret_from_fork+0x14/0x2c)
 r4:00000000 r3:00000000
