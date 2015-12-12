From: linux.amoon@gmail.com (Anand Moon)
Date: Sat, 12 Dec 2015 10:02:14 +0530
Subject: Odroid U3 mutex deadlock.
Message-ID: <CANAwSgSE4UE5jn4Rp0LfVhDcSP=ynDsbCaUSHmM31_MF849bSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

I am just observing this deadlock om my Odroid U3.
------------------------------------------------------------------------------------------------------------------

[    2.937531] =============================================
[    2.938733] [ INFO: possible recursive locking detected ]
[    2.944117] 4.4.0-rc4-xu3s #32 Not tainted
[    2.948195] ---------------------------------------------
[    2.953577] swapper/0/1 is trying to acquire lock:
[    2.958351]  (&genpd->lock){+.+...}, at: [<c0361550>]
__genpd_poweron+0x64/0x108
[    2.965727]
[    2.965727] but task is already holding lock:
[    2.971543]  (&genpd->lock){+.+...}, at: [<c0361af8>]
genpd_dev_pm_attach+0x168/0x1b8
[    2.979355]
[    2.979355] other info that might help us debug this:
[    2.985865]  Possible unsafe locking scenario:
[    2.985865]
[    2.991768]        CPU0
[    2.994198]        ----
[    2.996628]   lock(&genpd->lock);
[    2.999926]   lock(&genpd->lock);
[    3.003225]
[    3.003225]  *** DEADLOCK ***
[    3.003225]
[    3.009128]  May be due to missing lock nesting notation
[    3.009128]
[    3.015900] 3 locks held by swapper/0/1:
[    3.019804]  #0:  (&dev->mutex){......}, at: [<c0350910>]
__driver_attach+0x48/0x98
[    3.027442]  #1:  (&dev->mutex){......}, at: [<c0350920>]
__driver_attach+0x58/0x98
[    3.035081]  #2:  (&genpd->lock){+.+...}, at: [<c0361af8>]
genpd_dev_pm_attach+0x168/0x1b8
[    3.043326]
[    3.043326] stack backtrace:
[    3.047671] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0-rc4-xu3s #32
[    3.054351] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    3.060444] [<c0016c98>] (unwind_backtrace) from [<c00139c4>]
(show_stack+0x10/0x14)
[    3.068163] [<c00139c4>] (show_stack) from [<c0270df0>]
(dump_stack+0x84/0xc4)
[    3.075367] [<c0270df0>] (dump_stack) from [<c00780b8>]
(__lock_acquire+0x1f88/0x215c)
[    3.083262] [<c00780b8>] (__lock_acquire) from [<c007886c>]
(lock_acquire+0xa4/0xd0)
[    3.090990] [<c007886c>] (lock_acquire) from [<c0641f2c>]
(mutex_lock_nested+0x70/0x4d4)
[    3.099061] [<c0641f2c>] (mutex_lock_nested) from [<c0361550>]
(__genpd_poweron+0x64/0x108)
[    3.107393] [<c0361550>] (__genpd_poweron) from [<c0361b00>]
(genpd_dev_pm_attach+0x170/0x1b8)
[    3.115986] [<c0361b00>] (genpd_dev_pm_attach) from [<c03520a8>]
(platform_drv_probe+0x2c/0xac)
[    3.124667] [<c03520a8>] (platform_drv_probe) from [<c03507d4>]
(driver_probe_device+0x208/0x2fc)
[    3.133519] [<c03507d4>] (driver_probe_device) from [<c035095c>]
(__driver_attach+0x94/0x98)
[    3.141939] [<c035095c>] (__driver_attach) from [<c034ec14>]
(bus_for_each_dev+0x68/0x9c)
[    3.150097] [<c034ec14>] (bus_for_each_dev) from [<c034fec8>]
(bus_add_driver+0x1a0/0x218)
[    3.158344] [<c034fec8>] (bus_add_driver) from [<c035115c>]
(driver_register+0x78/0xf8)
[    3.166330] [<c035115c>] (driver_register) from [<c0338488>]
(exynos_drm_register_drivers+0x28/0x74)
[    3.175441] [<c0338488>] (exynos_drm_register_drivers) from
[<c0338594>] (exynos_drm_init+0x6c/0xc4)
[    3.184556] [<c0338594>] (exynos_drm_init) from [<c00097f4>]
(do_one_initcall+0x90/0x1dc)
[    3.192718] [<c00097f4>] (do_one_initcall) from [<c0895e08>]
(kernel_init_freeable+0x158/0x1f8)
[    3.201396] [<c0895e08>] (kernel_init_freeable) from [<c063ecac>]
(kernel_init+0x8/0xe8)
[    3.209469] [<c063ecac>] (kernel_init) from [<c000f7d0>]
(ret_from_fork+0x14/0x24)
[    3.217932] exynos-hdmi 12d00000.hdmi: GPIO lookup for consumer hpd
[    3.223293] exynos-hdmi 12d00000.hdmi: using device tree for GPIO lookup
[    3.229980] of_get_named_gpiod_flags: can't parse 'hpd-gpios'
property of node '/hdmi at 12D00000[0]'
[    3.238945] of_get_named_gpiod_flags: parsed 'hpd-gpio' property of
node '/hdmi at 12D00000[0]' - status (0)
[    3.253430] exynos-drm exynos-drm: bound 12c10000.mixer (ops
mixer_component_ops)
[    3.256216] exynos-drm exynos-drm: bound 12d00000.hdmi (ops
hdmi_component_ops)
[    3.263245] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.269812] [drm] No driver support for vblank timestamp query.
[    3.323251] exynos-drm exynos-drm: fb0:  frame buffer device
[    3.341464] [drm] Initialized exynos 1.0.0 20110530 on minor 0

-----------------------------------------------------------------------------------------------------------------------
-Anand Moon
