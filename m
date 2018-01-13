From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat, 13 Jan 2018 11:05:23 +0100
Subject: bcm2835: device tree regression in 4.15.0-rc7
Message-ID: <6809C455-9989-409C-9AB8-DDA8FDD04EB3@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I have to report a regression in 4.15.0-rc7 when using a device tree compiled in 4.14.0.
(from the cm3 patch that I have posted earlier, which needed brushing up).

The system fails with the following:

Jan 13 09:18:18 raspcm3 kernel: [    1.515454] vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc4_hdmi_ops)
Jan 13 09:18:18 raspcm3 kernel: [    1.524755] vc4-drm soc:gpu: bound 3f806000.vec (ops vc4_vec_ops)
Jan 13 09:18:18 raspcm3 kernel: [    1.533707] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_hvs_ops)
Jan 13 09:18:18 raspcm3 kernel: [    1.542704] vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops vc4_crtc_ops)
Jan 13 09:18:18 raspcm3 kernel: [    1.552365] vc4-drm soc:gpu: bound 3f207000.pixelvalve (ops vc4_crtc_ops)
Jan 13 09:18:18 raspcm3 kernel: [    1.561928] vc4-drm soc:gpu: bound 3f807000.pixelvalve (ops vc4_crtc_ops)
Jan 13 09:18:18 raspcm3 kernel: [    1.590330] ------------[ cut here ]------------
Jan 13 09:18:18 raspcm3 kernel: [    1.597459] WARNING: CPU: 0 PID: 70 at kernel/irq/chip.c:244 __irq_startup+0x50/0xb4
Jan 13 09:18:18 raspcm3 kernel: [    1.610254] Modules linked in:
Jan 13 09:18:18 raspcm3 kernel: [    1.615823] CPU: 0 PID: 70 Comm: kworker/0:2 Not tainted 4.15.0-rc7msu7+ #175
Jan 13 09:18:18 raspcm3 kernel: [    1.625587] Hardware name: BCM2835
Jan 13 09:18:18 raspcm3 kernel: [    1.631622] Workqueue: events deferred_probe_work_func
Jan 13 09:18:18 raspcm3 kernel: [    1.639471] [<c0110a50>] (unwind_backtrace) from [<c010c750>] (show_stack+0x20/0x24)
Jan 13 09:18:18 raspcm3 kernel: [    1.652696] [<c010c750>] (show_stack) from [<c0796070>] (dump_stack+0x8c/0xb0)
Jan 13 09:18:18 raspcm3 kernel: [    1.662819] [<c0796070>] (dump_stack) from [<c0120ad4>] (__warn+0xf0/0x110)
Jan 13 09:18:18 raspcm3 kernel: [    1.672676] [<c0120ad4>] (__warn) from [<c0120be0>] (warn_slowpath_null+0x4c/0x58)
Jan 13 09:18:18 raspcm3 kernel: [    1.685978] [<c0120be0>] (warn_slowpath_null) from [<c0173a8c>] (__irq_startup+0x50/0xb4)
Jan 13 09:18:18 raspcm3 kernel: [    1.700005] [<c0173a8c>] (__irq_startup) from [<c0173bf0>] (irq_startup+0x100/0x120)
Jan 13 09:18:18 raspcm3 kernel: [    1.713701] [<c0173bf0>] (irq_startup) from [<c0171a9c>] (__enable_irq+0x70/0x80)
Jan 13 09:18:18 raspcm3 kernel: [    1.727338] [<c0171a9c>] (__enable_irq) from [<c0171b1c>] (enable_irq+0x70/0x80)
Jan 13 09:18:18 raspcm3 kernel: [    1.741030] [<c0171b1c>] (enable_irq) from [<c049ed48>] (vc4_irq_postinstall+0x20/0x44)
Jan 13 09:18:18 raspcm3 kernel: [    1.755750] [<c049ed48>] (vc4_irq_postinstall) from [<c047126c>] (drm_irq_install+0xdc/0x11c)
Jan 13 09:18:18 raspcm3 kernel: [    1.771499] [<c047126c>] (drm_irq_install) from [<c04a1b6c>] (vc4_v3d_bind+0x1c0/0x224)
Jan 13 09:18:18 raspcm3 kernel: [    1.786924] [<c04a1b6c>] (vc4_v3d_bind) from [<c04a4824>] (component_bind_all+0x110/0x224)
Jan 13 09:18:18 raspcm3 kernel: [    1.802730] [<c04a4824>] (component_bind_all) from [<c0495744>] (vc4_drm_bind+0x90/0x138)
Jan 13 09:18:18 raspcm3 kernel: [    1.818603] [<c0495744>] (vc4_drm_bind) from [<c04a41d4>] (try_to_bring_up_master+0x14c/0x254)
Jan 13 09:18:18 raspcm3 kernel: [    1.835083] [<c04a41d4>] (try_to_bring_up_master) from [<c04a4380>] (component_add+0xa4/0x11c)
Jan 13 09:18:18 raspcm3 kernel: [    1.851583] [<c04a4380>] (component_add) from [<c04a15a4>] (vc4_v3d_dev_probe+0x20/0x28)
Jan 13 09:18:18 raspcm3 kernel: [    1.867723] [<c04a15a4>] (vc4_v3d_dev_probe) from [<c04ac1ec>] (platform_drv_probe+0x60/0xac)
Jan 13 09:18:18 raspcm3 kernel: [    1.884344] [<c04ac1ec>] (platform_drv_probe) from [<c04aa608>] (driver_probe_device+0x254/0x46c)
Jan 13 09:18:18 raspcm3 kernel: [    1.901326] [<c04aa608>] (driver_probe_device) from [<c04aaa1c>] (__device_attach_driver+0xb0/0x104)
Jan 13 09:18:18 raspcm3 kernel: [    1.918572] [<c04aaa1c>] (__device_attach_driver) from [<c04a8890>] (bus_for_each_drv+0x98/0xa0)
Jan 13 09:18:18 raspcm3 kernel: [    1.935469] [<c04a8890>] (bus_for_each_drv) from [<c04aa2b4>] (__device_attach+0xac/0x134)
Jan 13 09:18:18 raspcm3 kernel: [    1.951857] [<c04aa2b4>] (__device_attach) from [<c04aaa8c>] (device_initial_probe+0x1c/0x20)
Jan 13 09:18:18 raspcm3 kernel: [    1.968516] [<c04aaa8c>] (device_initial_probe) from [<c04a9640>] (bus_probe_device+0x38/0x90)
Jan 13 09:18:18 raspcm3 kernel: [    1.985264] [<c04a9640>] (bus_probe_device) from [<c04a9c44>] (deferred_probe_work_func+0x10c/0x140)
Jan 13 09:18:18 raspcm3 kernel: [    2.002548] [<c04a9c44>] (deferred_probe_work_func) from [<c01385c0>] (process_one_work+0x1d0/0x42c)
Jan 13 09:18:18 raspcm3 kernel: [    2.036136] [<c013976c>] (worker_thread) from [<c013e404>] (kthread+0x14c/0x164)
Jan 13 09:18:18 raspcm3 kernel: [    2.051636] [<c013e404>] (kthread) from [<c0108068>] (ret_from_fork+0x14/0x2c)
Jan 13 09:18:18 raspcm3 kernel: [    2.062979] ---[ end trace 574020c6446fc7f4 ]---
Jan 13 09:18:18 raspcm3 kernel: [    2.071713] vc4-drm soc:gpu: bound 3fc00000.v3d (ops vc4_v3d_ops)
Jan 13 09:18:18 raspcm3 kernel: [    2.081863] checking generic (3db75000 85400) vs hw (0 ffffffff)
Jan 13 09:18:18 raspcm3 kernel: [    2.081869] fb: switching to vc4drmfb from simple
Jan 13 09:18:18 raspcm3 kernel: [    2.090677] Console: switching to colour dummy device 80x30
Jan 13 09:18:18 raspcm3 kernel: [    2.097454] [drm] Initialized vc4 0.0.0 20140616 for soc:gpu on minor 0
Jan 13 09:18:18 raspcm3 kernel: [    2.104083] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
Jan 13 09:18:18 raspcm3 kernel: [    2.110732] [drm] Driver supports precise vblank timestamp query.
Jan 13 09:18:18 raspcm3 kernel: [    2.159872] Console: switching to colour frame buffer device 90x30

And then later on systemd fails:
[  OK  ] Started Raise network interfaces.
[FAILED] Failed to start Login Service.
See 'systemctl status systemd-logind.service' for details. and network does not
come up so ssh access is not possible?
DHCP-Networking does not come up either!

After reapplying the patch for CM3-dt and rebuilding it boots fine.

As far as I understand older, formerly functional DTs should always continue to work.

Martin
