From: stefan@agner.ch (Stefan Agner)
Date: Mon, 08 Jan 2018 22:12:23 +0100
Subject: soc: imx: gpcv2: removing and probing fails
In-Reply-To: <CAHQ1cqEutLV7wRWq3FdU1CyercLiiDgNL0trSuV5p-x7eGYFVg@mail.gmail.com>
References: <3f836677c6e98aaf01bc1ac8c3410083@agner.ch>
 <CAHQ1cqHvkk01NDTB14PpG4tgpsbPg=75K9wqHUCBjWkyNuFy=A@mail.gmail.com>
 <CAHQ1cqEutLV7wRWq3FdU1CyercLiiDgNL0trSuV5p-x7eGYFVg@mail.gmail.com>
Message-ID: <b9910714e7c2e8a273e1e2030e9e090b@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-08 07:24, Andrey Smirnov wrote:
> On Sun, Jan 7, 2018 at 4:22 PM, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> On Sun, Jan 7, 2018 at 2:48 AM, Stefan Agner <stefan@agner.ch> wrote:
>>> Hi Andrew,
>>>
>>> I noticed that the driver fails when removing and probing again. As far
>>> as I can see due to duplicate add of the platform devices.
>>>
>>> As far as I can tell the driver should register the remove callback and
>>> do a platform_device_unregister on the newly created platform devices.
>>> However, as far as I can tell we don't hold on to a reference to them...
>>> I guess we could keep references in imx_gpcv2_probe, but maybe there is
>>> an easier way?
>>
>> Stefan:
>>
>> Good catch and sorry for the inconvenience. I just spent a little bit
>> of time repro-ing this and it looks like there are two separate bugs,
>> actually. First one, as you correctly pointed out, is due to
>> re-registration of pm-domain platform drivers. That, however, should
>> only result in a WARNING and a failed driver probing, not in a killed
>> init due to BUG. So the second one, that BUG message in the stack
>> trace, is due to the fact that I incorrectly provide statically
>> allocated data via dev.platform_data and it ends up being kfree'd in
>> platform_device_release().
>>
>> IMHO, this driver isn't really meant to be removed, so the simplest
>> solution to the first problem would be to specify
>> "imx_gpc_driver.driver.suppress_bind_attrs = true" and remove any
>> option to remove the driver, but I don't know if that's acceptable or
>> not.
>>
>> Shawn, would the above be acceptable upstream?
>>
>> Solution for bug #2 is trivial and I'll send patches for both once we
>> agree how to fix #1.
>>
>> Thanks,
>> Andrey Smirnov
>>
>> P.S: Also, since I based my code on gpc.c, I suspect that driver will
>> have exactly the same problem (I'll do some experiments to confirm)
> 
> Done with experiments. Same problem happens with gpc.c as well.

Yeah gpc.c also has another problem:
https://patchwork.kernel.org/patch/10148315/

But, yeah, you are right, even with that patch applied and when using
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y it seems to show the problem as well.

I like the config symbol to test my own drivers, its just unfortunate
when mainline blows by default... But then, maybe it is the reason why
that config symbol got a UNSTABLE flag.

The full splash:
[    0.697548] ------------[ cut here ]------------
[    0.702212] WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x64/0x74
[    0.709695] sysfs: cannot create duplicate filename
'/devices/soc0/soc/2000000.aips-bus/20dc000.gpc/imx-pgc-power-domain.0'
[    0.720887] Modules linked in:
[    0.723965] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.15.0-rc3-00061-g38f99f72e8f3-dirty #246
[    0.732694] Hardware name: Freescale i.MX6 Quad/DualLite (Device
Tree)
[    0.739263] [<8010f61c>] (unwind_backtrace) from [<8010b984>]
(show_stack+0x10/0x14)
[    0.747045] [<8010b984>] (show_stack) from [<80832024>]
(dump_stack+0x88/0x9c)
[    0.754308] [<80832024>] (dump_stack) from [<8011e7ac>]
(__warn+0xdc/0xf4)
[    0.761214] [<8011e7ac>] (__warn) from [<8011e7fc>]
(warn_slowpath_fmt+0x38/0x48)
[    0.768732] [<8011e7fc>] (warn_slowpath_fmt) from [<802768b0>]
(sysfs_warn_dup+0x64/0x74)
[    0.776950] [<802768b0>] (sysfs_warn_dup) from [<80276988>]
(sysfs_create_dir_ns+0x84/0x90)
[    0.785339] [<80276988>] (sysfs_create_dir_ns) from [<80836560>]
(kobject_add_internal+0xb4/0x30c)
[    0.794337] [<80836560>] (kobject_add_internal) from [<80836804>]
(kobject_add+0x4c/0x9c)
[    0.802554] [<80836804>] (kobject_add) from [<8050c030>]
(device_add+0xe0/0x594)
[    0.809991] [<8050c030>] (device_add) from [<805103d8>]
(platform_device_add+0x110/0x224)
[    0.818208] [<805103d8>] (platform_device_add) from [<8049bb94>]
(imx_gpc_probe+0x184/0x380)
[    0.826685] [<8049bb94>] (imx_gpc_probe) from [<805105c4>]
(platform_drv_probe+0x50/0xac)
[    0.834901] [<805105c4>] (platform_drv_probe) from [<8050ec0c>]
(driver_probe_device+0x1b4/0x3c8)
[    0.843810] [<8050ec0c>] (driver_probe_device) from [<8050eec4>]
(__driver_attach+0xa4/0xa8)
[    0.852284] [<8050eec4>] (__driver_attach) from [<8050cfe8>]
(bus_for_each_dev+0x4c/0x9c)
[    0.860495] [<8050cfe8>] (bus_for_each_dev) from [<8050e1a0>]
(bus_add_driver+0x188/0x20c)
[    0.868795] [<8050e1a0>] (bus_add_driver) from [<8050f7b4>]
(driver_register+0x78/0xf4)
[    0.876835] [<8050f7b4>] (driver_register) from [<80101b00>]
(do_one_initcall+0x44/0x168)
[    0.885049] [<80101b00>] (do_one_initcall) from [<80c00db8>]
(kernel_init_freeable+0x14c/0x1d8)
[    0.893789] [<80c00db8>] (kernel_init_freeable) from [<80844538>]
(kernel_init+0x8/0x10c)
[    0.902006] [<80844538>] (kernel_init) from [<80107a28>]
(ret_from_fork+0x14/0x2c)
[    0.909639] ---[ end trace ade27083f156a989 ]---
[    0.914277] ------------[ cut here ]------------
[    0.918934] WARNING: CPU: 0 PID: 1 at lib/kobject.c:240
kobject_add_internal+0x278/0x30c
[    0.927073] kobject_add_internal failed for imx-pgc-power-domain.0
with -EEXIST, don't try to register things with the same name in the
same directory.
[    0.940690] Modules linked in:
[    0.943763] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       
4.15.0-rc3-00061-g38f99f72e8f3-dirty #246
[    0.953796] Hardware name: Freescale i.MX6 Quad/DualLite (Device
Tree)
[    0.960357] [<8010f61c>] (unwind_backtrace) from [<8010b984>]
(show_stack+0x10/0x14)
[    0.968136] [<8010b984>] (show_stack) from [<80832024>]
(dump_stack+0x88/0x9c)
[    0.975394] [<80832024>] (dump_stack) from [<8011e7ac>]
(__warn+0xdc/0xf4)
[    0.982298] [<8011e7ac>] (__warn) from [<8011e7fc>]
(warn_slowpath_fmt+0x38/0x48)
[    0.989815] [<8011e7fc>] (warn_slowpath_fmt) from [<80836724>]
(kobject_add_internal+0x278/0x30c)
[    0.998725] [<80836724>] (kobject_add_internal) from [<80836804>]
(kobject_add+0x4c/0x9c)
[    1.006938] [<80836804>] (kobject_add) from [<8050c030>]
(device_add+0xe0/0x594)
[    1.014370] [<8050c030>] (device_add) from [<805103d8>]
(platform_device_add+0x110/0x224)
[    1.022583] [<805103d8>] (platform_device_add) from [<8049bb94>]
(imx_gpc_probe+0x184/0x380)
[    1.031057] [<8049bb94>] (imx_gpc_probe) from [<805105c4>]
(platform_drv_probe+0x50/0xac)
[    1.039269] [<805105c4>] (platform_drv_probe) from [<8050ec0c>]
(driver_probe_device+0x1b4/0x3c8)
[    1.048176] [<8050ec0c>] (driver_probe_device) from [<8050eec4>]
(__driver_attach+0xa4/0xa8)
[    1.056647] [<8050eec4>] (__driver_attach) from [<8050cfe8>]
(bus_for_each_dev+0x4c/0x9c)
[    1.064857] [<8050cfe8>] (bus_for_each_dev) from [<8050e1a0>]
(bus_add_driver+0x188/0x20c)
[    1.073153] [<8050e1a0>] (bus_add_driver) from [<8050f7b4>]
(driver_register+0x78/0xf4)
[    1.081191] [<8050f7b4>] (driver_register) from [<80101b00>]
(do_one_initcall+0x44/0x168)
[    1.089404] [<80101b00>] (do_one_initcall) from [<80c00db8>]
(kernel_init_freeable+0x14c/0x1d8)
[    1.098141] [<80c00db8>] (kernel_init_freeable) from [<80844538>]
(kernel_init+0x8/0x10c)
[    1.106355] [<80844538>] (kernel_init) from [<80107a28>]
(ret_from_fork+0x14/0x2c)
[    1.113979] ---[ end trace ade27083f156a98a ]---
[    1.118637] ------------[ cut here ]------------
[    1.123275] Kernel BUG at c46b9f56 [verbose debug info unavailable]
[    1.129564] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    1.134719] Modules linked in:
[    1.137791] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       
4.15.0-rc3-00061-g38f99f72e8f3-dirty #246
[    1.147823] Hardware name: Freescale i.MX6 Quad/DualLite (Device
Tree)
[    1.154375] PC is at kfree+0xfc/0x140
[    1.158054] LR is at platform_device_release+0x10/0x34
[    1.163209] pc : [<801fd744>]    lr : [<805101b0>]    psr: 40000053
[    1.169495] sp : 84057de8  ip : 00000000  fp : 842e9e00
[    1.174736] r10: 842e9800  r9 : 80d23968  r8 : 80aa8a40
[    1.179980] r7 : 80952bac  r6 : 00000000  r5 : 842e9810  r4 :
842e9810
[    1.186529] r3 : 87dd2474  r2 : 87dd2460  r1 : a0000053  r0 :
80d23a20
[    1.193080] Flags: nZcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM 
Segment none
[    1.200328] Control: 10c5387d  Table: 10004059  DAC: 00000051
[    1.206093] Process swapper/0 (pid: 1, stack limit = 0x86b82e40)
[    1.212122] Stack: (0x84057de8 to 0x84058000)
[    1.216499] 7de0:                   842e9810 842e9818 842e9810
842e9810 842e9810 00000000
[    1.224710] 7e00: 80952bac 805101b0 842e9818 80509eac 842e9818
80d2a784 84251480 80835f38
[    1.232919] 7e20: 87da98f4 80952bac 87da9810 ffffffef 87da98f4
8049bd2c 00000000 00000000
[    1.241128] 7e40: 84155a10 00000042 842500c0 00000000 80b410d8
84155a10 fffffffe 80d239d8
[    1.249337] 7e60: fffffdfb 80d239d8 80daefe8 00000000 00000000
805105c4 84155a10 00000000
[    1.257548] 7e80: 80daefe4 00000000 80d239d8 8050ec0c 87da95f0
00000000 000000d7 84155a10
[    1.265756] 7ea0: 80d239d8 84155a44 00000000 000000d7 80c5b83c
80c6c57c 00000000 8050eec4
[    1.273965] 7ec0: 00000000 80d239d8 8050ee20 8050cfe8 84050358
8414f6b4 80d239d8 842b4f00
[    1.282174] 7ee0: 80d2ab60 8050e1a0 80afef10 80c35700 80d239d8
80d239d8 00000000 80c35ecc
[    1.290384] 7f00: 80d58680 8050f7b4 ffffe000 00000000 80c35ecc
80101b00 80b94c44 000000d7
[    1.298595] 7f20: 00000000 8013a458 00000000 80b1dd5c 00000006
00000006 80aadf4c 00000000
[    1.306803] 7f40: 80ab7130 80aadfc0 87fffaee 87fffaf4 00000000
00000007 80d58680 80c5b830
[    1.315012] 7f60: 00000007 80d58680 80c5b834 80d58680 000000d7
80c00db8 00000006 00000006
[    1.323221] 7f80: 00000000 80c005b0 00000000 80844530 00000000
00000000 00000000 00000000
[    1.331430] 7fa0: 00000000 80844538 00000000 80107a28 00000000
00000000 00000000 00000000
[    1.339639] 7fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    1.347848] 7fe0: 00000000 00000000 00000000 00000000 00000013
00000000 3fbfd7ff fed779df
[    1.356064] [<801fd744>] (kfree) from [<805101b0>]
(platform_device_release+0x10/0x34)
[    1.364019] [<805101b0>] (platform_device_release) from [<80509eac>]
(device_release+0x2c/0x90)
[    1.372759] [<80509eac>] (device_release) from [<80835f38>]
(kobject_put+0x94/0xe4)
[    1.380447] [<80835f38>] (kobject_put) from [<8049bd2c>]
(imx_gpc_probe+0x31c/0x380)
[    1.388224] [<8049bd2c>] (imx_gpc_probe) from [<805105c4>]
(platform_drv_probe+0x50/0xac)
[    1.396435] [<805105c4>] (platform_drv_probe) from [<8050ec0c>]
(driver_probe_device+0x1b4/0x3c8)
[    1.405345] [<8050ec0c>] (driver_probe_device) from [<8050eec4>]
(__driver_attach+0xa4/0xa8)
[    1.413815] [<8050eec4>] (__driver_attach) from [<8050cfe8>]
(bus_for_each_dev+0x4c/0x9c)
[    1.422024] [<8050cfe8>] (bus_for_each_dev) from [<8050e1a0>]
(bus_add_driver+0x188/0x20c)
[    1.430320] [<8050e1a0>] (bus_add_driver) from [<8050f7b4>]
(driver_register+0x78/0xf4)
[    1.438357] [<8050f7b4>] (driver_register) from [<80101b00>]
(do_one_initcall+0x44/0x168)
[    1.446568] [<80101b00>] (do_one_initcall) from [<80c00db8>]
(kernel_init_freeable+0x14c/0x1d8)
[    1.455305] [<80c00db8>] (kernel_init_freeable) from [<80844538>]
(kernel_init+0x8/0x10c)
[    1.463518] [<80844538>] (kernel_init) from [<80107a28>]
(ret_from_fork+0x14/0x2c)
[    1.471118] Code: 1a000003 e5923014 e3130001 1a000000 (e7f001f2)
[    1.477236] ---[ end trace ade27083f156a98b ]---
[    1.482097] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    1.482097]
[    1.491281] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b
[    1.491281]

--
Stefan
