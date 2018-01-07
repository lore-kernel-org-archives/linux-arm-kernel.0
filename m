From: stefan@agner.ch (Stefan Agner)
Date: Sun, 07 Jan 2018 11:48:13 +0100
Subject: soc: imx: gpcv2: removing and probing fails
Message-ID: <3f836677c6e98aaf01bc1ac8c3410083@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

I noticed that the driver fails when removing and probing again. As far
as I can see due to duplicate add of the platform devices.

As far as I can tell the driver should register the remove callback and
do a platform_device_unregister on the newly created platform devices.
However, as far as I can tell we don't hold on to a reference to them...
I guess we could keep references in imx_gpcv2_probe, but maybe there is
an easier way?

This can be reproduced by using:
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y

The full stack trace:

[    0.673113] ------------[ cut here ]------------
[    0.676786] WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x64/0x74
[    0.686186] sysfs: cannot create duplicate filename
'/devices/platform/soc/30000000.aips-bus/303a0000.gpc/imx7-pgc-domain.1'
[    0.698594] Modules linked in:
[    0.700783] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.15.0-rc3-00027-g3b196a7dd3bd-dirty #220
[    0.711659] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    0.716746] [<8010f55c>] (unwind_backtrace) from [<8010b8e4>]
(show_stack+0x10/0x14)
[    0.726785] [<8010b8e4>] (show_stack) from [<80830124>]
(dump_stack+0x88/0x9c)
[    0.735813] [<80830124>] (dump_stack) from [<8011e58c>]
(__warn+0xdc/0xf4)
[    0.742232] [<8011e58c>] (__warn) from [<8011e5dc>]
(warn_slowpath_fmt+0x38/0x48)
[    0.752034] [<8011e5dc>] (warn_slowpath_fmt) from [<80276600>]
(sysfs_warn_dup+0x64/0x74)
[    0.762167] [<80276600>] (sysfs_warn_dup) from [<802766d8>]
(sysfs_create_dir_ns+0x84/0x90)
[    0.772513] [<802766d8>] (sysfs_create_dir_ns) from [<80834660>]
(kobject_add_internal+0xb4/0x30c)
[    0.783562] [<80834660>] (kobject_add_internal) from [<80834904>]
(kobject_add+0x4c/0x9c)
[    0.793846] [<80834904>] (kobject_add) from [<8050bdd0>]
(device_add+0xe0/0x594)
[    0.803418] [<8050bdd0>] (device_add) from [<80510178>]
(platform_device_add+0x110/0x224)
[    0.813805] [<80510178>] (platform_device_add) from [<8049bfa0>]
(imx_gpcv2_probe+0xdc/0x1f8)
[    0.824592] [<8049bfa0>] (imx_gpcv2_probe) from [<80510364>]
(platform_drv_probe+0x50/0xac)
[    0.835264] [<80510364>] (platform_drv_probe) from [<8050e9ac>]
(driver_probe_device+0x1b4/0x3c8)
[    0.846525] [<8050e9ac>] (driver_probe_device) from [<8050ec64>]
(__driver_attach+0xa4/0xa8)
[    0.857356] [<8050ec64>] (__driver_attach) from [<8050cd88>]
(bus_for_each_dev+0x4c/0x9c)
[    0.867935] [<8050cd88>] (bus_for_each_dev) from [<8050df40>]
(bus_add_driver+0x188/0x20c)
[    0.878650] [<8050df40>] (bus_add_driver) from [<8050f554>]
(driver_register+0x78/0xf4)
[    0.889101] [<8050f554>] (driver_register) from [<80101a5c>]
(do_one_initcall+0x44/0x168)
[    0.899733] [<80101a5c>] (do_one_initcall) from [<80c00db8>]
(kernel_init_freeable+0x14c/0x1d8)
[    0.910899] [<80c00db8>] (kernel_init_freeable) from [<80842638>]
(kernel_init+0x8/0x10c)
[    0.921529] [<80842638>] (kernel_init) from [<80107988>]
(ret_from_fork+0x14/0x2c)
[    0.931569] ---[ end trace 27014f64d1c1710e ]---
[    0.935967] ------------[ cut here ]------------
[    0.940537] WARNING: CPU: 0 PID: 1 at lib/kobject.c:240
kobject_add_internal+0x278/0x30c
[    0.951181] kobject_add_internal failed for imx7-pgc-domain.1 with
-EEXIST, don't try to register things with the same name in the same
directory.
[    0.966666] Modules linked in:
[    0.969363] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       
4.15.0-rc3-00027-g3b196a7dd3bd-dirty #220
[    0.981886] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    0.987266] [<8010f55c>] (unwind_backtrace) from [<8010b8e4>]
(show_stack+0x10/0x14)
[    0.997423] [<8010b8e4>] (show_stack) from [<80830124>]
(dump_stack+0x88/0x9c)
[    1.006649] [<80830124>] (dump_stack) from [<8011e58c>]
(__warn+0xdc/0xf4)
[    1.013159] [<8011e58c>] (__warn) from [<8011e5dc>]
(warn_slowpath_fmt+0x38/0x48)
[    1.022994] [<8011e5dc>] (warn_slowpath_fmt) from [<80834824>]
(kobject_add_internal+0x278/0x30c)
[    1.033847] [<80834824>] (kobject_add_internal) from [<80834904>]
(kobject_add+0x4c/0x9c)
[    1.043990] [<80834904>] (kobject_add) from [<8050bdd0>]
(device_add+0xe0/0x594)
[    1.053333] [<8050bdd0>] (device_add) from [<80510178>]
(platform_device_add+0x110/0x224)
[    1.063508] [<80510178>] (platform_device_add) from [<8049bfa0>]
(imx_gpcv2_probe+0xdc/0x1f8)
[    1.074202] [<8049bfa0>] (imx_gpcv2_probe) from [<80510364>]
(platform_drv_probe+0x50/0xac)
[    1.084735] [<80510364>] (platform_drv_probe) from [<8050e9ac>]
(driver_probe_device+0x1b4/0x3c8)
[    1.095818] [<8050e9ac>] (driver_probe_device) from [<8050ec64>]
(__driver_attach+0xa4/0xa8)
[    1.106556] [<8050ec64>] (__driver_attach) from [<8050cd88>]
(bus_for_each_dev+0x4c/0x9c)
[    1.117104] [<8050cd88>] (bus_for_each_dev) from [<8050df40>]
(bus_add_driver+0x188/0x20c)
[    1.127752] [<8050df40>] (bus_add_driver) from [<8050f554>]
(driver_register+0x78/0xf4)
[    1.138150] [<8050f554>] (driver_register) from [<80101a5c>]
(do_one_initcall+0x44/0x168)
[    1.148780] [<80101a5c>] (do_one_initcall) from [<80c00db8>]
(kernel_init_freeable+0x14c/0x1d8)
[    1.159946] [<80c00db8>] (kernel_init_freeable) from [<80842638>]
(kernel_init+0x8/0x10c)
[    1.170577] [<80842638>] (kernel_init) from [<80107988>]
(ret_from_fork+0x14/0x2c)
[    1.180607] ---[ end trace 27014f64d1c1710f ]---
[    1.185014] ------------[ cut here ]------------
[    1.189571] Kernel BUG at 5168736d [verbose debug info unavailable]
[    1.195868] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    1.200985] Modules linked in:
[    1.203978] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       
4.15.0-rc3-00027-g3b196a7dd3bd-dirty #220
[    1.216449] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    1.221768] PC is at kfree+0xfc/0x140
[    1.225376] LR is at platform_device_release+0x10/0x34
[    1.230510] pc : [<801fd494>]    lr : [<8050ff50>]    psr: 40000013
[    1.236804] sp : ac079df0  ip : 00000000  fp : ffffffef
[    1.242008] r10: ac225400  r9 : ac225000  r8 : 80d23fa0
[    1.247201] r7 : af770d04  r6 : 00000000  r5 : ac225410  r4 :
ac225410
[    1.253741] r3 : af794494  r2 : af794480  r1 : a0000013  r0 :
80d241a0
[    1.260252] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment none
[    1.267425] Control: 10c5387d  Table: 8000406a  DAC: 00000051
[    1.273163] Process swapper/0 (pid: 1, stack limit = 0x7ec51c00)
[    1.279174] Stack: (0xac079df0 to 0xac07a000)
[    1.283497] 9de0:                                     ac225410
ac225418 ac225410 ac225410
[    1.293629] 9e00: ac225410 00000000 af770d04 8050ff50 ac225418
80509c4c ac225418 80d2a744
[    1.302856] 9e20: ac2a68c0 80834038 80aa8500 af770d04 af770de8
ac11fa10 80aa8500 8049c078
[    1.312114] 9e40: 00000000 00000000 ac32d180 00000001 80b40a88
ac11fa10 fffffffe 80d24010
[    1.321543] 9e60: fffffdfb 80d24010 80daef28 00000000 00000000
80510364 ac11fa10 00000000
[    1.331081] 9e80: 80daef24 00000000 80d24010 8050e9ac af770b0c
00000000 000000d7 ac11fa10
[    1.340735] 9ea0: 80d24010 ac11fa44 00000000 000000d7 80c5b83c
80c6c578 00000000 8050ec64
[    1.350475] 9ec0: 00000000 80d24010 8050ebc0 8050cd88 ac041758
ac114ab4 80d24010 ac2a3400
[    1.360365] 9ee0: 80d2ab20 8050df40 80afeb04 80c35e1c 80d24010
80d24010 00000000 80c35e4c
[    1.370388] 9f00: 80d58600 8050f554 ffffe000 00000000 80c35e4c
80101a5c 80b949dc 000000d7
[    1.380600] 9f20: 00000000 8013a238 00000000 80b1d70c 00000006
00000006 80aada0c 00000000
[    1.390896] 9f40: 80ab6b90 80aada80 affffc8a affffc92 00000000
00000007 80d58600 80c5b830
[    1.401286] 9f60: 00000007 80d58600 80c5b834 80d58600 000000d7
80c00db8 00000006 00000006
[    1.411792] 9f80: 00000000 80c005b0 00000000 80842630 00000000
00000000 00000000 00000000
[    1.422343] 9fa0: 00000000 80842638 00000000 80107988 00000000
00000000 00000000 00000000
[    1.432895] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    1.443458] 9fe0: 00000000 00000000 00000000 00000000 00000013
00000000 bf73ffff 4c5eafe0
[    1.454043] [<801fd494>] (kfree) from [<8050ff50>]
(platform_device_release+0x10/0x34)
[    1.464336] [<8050ff50>] (platform_device_release) from [<80509c4c>]
(device_release+0x2c/0x90)
[    1.475435] [<80509c4c>] (device_release) from [<80834038>]
(kobject_put+0x94/0xe4)
[    1.485474] [<80834038>] (kobject_put) from [<8049c078>]
(imx_gpcv2_probe+0x1b4/0x1f8)
[    1.495784] [<8049c078>] (imx_gpcv2_probe) from [<80510364>]
(platform_drv_probe+0x50/0xac)
[    1.506544] [<80510364>] (platform_drv_probe) from [<8050e9ac>]
(driver_probe_device+0x1b4/0x3c8)
[    1.517844] [<8050e9ac>] (driver_probe_device) from [<8050ec64>]
(__driver_attach+0xa4/0xa8)
[    1.528708] [<8050ec64>] (__driver_attach) from [<8050cd88>]
(bus_for_each_dev+0x4c/0x9c)
[    1.539313] [<8050cd88>] (bus_for_each_dev) from [<8050df40>]
(bus_add_driver+0x188/0x20c)
[    1.550011] [<8050df40>] (bus_add_driver) from [<8050f554>]
(driver_register+0x78/0xf4)
[    1.560449] [<8050f554>] (driver_register) from [<80101a5c>]
(do_one_initcall+0x44/0x168)
[    1.571073] [<80101a5c>] (do_one_initcall) from [<80c00db8>]
(kernel_init_freeable+0x14c/0x1d8)
[    1.582239] [<80c00db8>] (kernel_init_freeable) from [<80842638>]
(kernel_init+0x8/0x10c)
[    1.592874] [<80842638>] (kernel_init) from [<80107988>]
(ret_from_fork+0x14/0x2c)
[    1.602885] Code: 1a000003 e5923014 e3130001 1a000000 (e7f001f2)
[    1.608796] ---[ end trace 27014f64d1c17110 ]---
[    1.613635] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    1.613635]
[    1.627569] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b
[    1.627569]

--
Stefan
