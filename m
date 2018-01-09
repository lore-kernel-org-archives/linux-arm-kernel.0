From: stefan@agner.ch (Stefan Agner)
Date: Tue, 09 Jan 2018 20:26:54 +0100
Subject: soc: imx: gpcv2: removing and probing fails
In-Reply-To: <1515509738.12538.35.camel@pengutronix.de>
References: <3f836677c6e98aaf01bc1ac8c3410083@agner.ch>
 <1515507886.12538.33.camel@pengutronix.de>
 <d71311e13720724b3b3bccd06fe9309b@agner.ch>
 <1515509738.12538.35.camel@pengutronix.de>
Message-ID: <03d47d57168d5f7c23f97f266a218632@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-09 15:55, Lucas Stach wrote:
> Am Dienstag, den 09.01.2018, 15:44 +0100 schrieb Stefan Agner:
>> On 2018-01-09 15:24, Lucas Stach wrote:
>> > Am Sonntag, den 07.01.2018, 11:48 +0100 schrieb Stefan Agner:
>> > > Hi Andrew,
>> > >
>> > > I noticed that the driver fails when removing and probing again.
>> > > As far
>> > > as I can see due to duplicate add of the platform devices.
>> > >
>> > > As far as I can tell the driver should register the remove
>> > > callback and
>> > > do a platform_device_unregister on the newly created platform
>> > > devices.
>> > > However, as far as I can tell we don't hold on to a reference to
>> > > them...
>> > > I guess we could keep references in imx_gpcv2_probe, but maybe
>> > > there is
>> > > an easier way?
>> >
>> > The GPC v1 driver adds the necessary device dependency between the
>> > power domain devices and the GPC parent device. See the
>> > device_link_add() in imx_pgc_power_domain_probe().
>>
>> Note that despite device_link_add, GPC v1 seems to cause issue with
>> CONFIG_DEBUG_TEST_DRIVER_REMOVE=y:
>> https://marc.info/?l=linux-arm-kernel&m=151544599904423&w=4
>>
>> (sorry, I made it confusing, by adding a stack trace when using GPC
>> v1
>> in the gpcv2 thread...)
> 
> IMHO this is an issue with the?CONFIG_DEBUG_TEST_DRIVER_REMOVE option,
> as it just blindly calls the remove callback instead of doing a proper
> __device_release_driver(). All the regular driver/device unbind paths
> will properly unbind the consumer devices before removing the driver.
> 

There still seem to be an isse (gpc v1). I even removed PD consumers in
the device tree....

root at colibri-imx6:~# echo 20dc000.gpc >
/sys/bus/platform/drivers/imx-gpc/unbind
[   18.821940] imx-pgc-pd imx-pgc-power-domain.0: Dropping the link to
20dc000.gpc
[   18.833249] imx-pgc-pd imx-pgc-power-domain.1: Dropping the link to
20dc000.gpc
root at colibri-imx6:~# echo 20dc000.gpc >
/sys/bus/platform/drivers/imx-gpc/bind
[   23.031945] ------------[ cut here ]------------
[   23.036600] WARNING: CPU: 0 PID: 432 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x64/0x74
[   23.044251] sysfs: cannot create duplicate filename
'/devices/soc0/soc/2000000.aips-bus/20dc000.gpc/imx-pgc-power-domain.0'
[   23.055434] Modules linked in:
[   23.058505] CPU: 0 PID: 432 Comm: sh Not tainted
4.15.0-rc3-00061-g38f99f72e8f3-dirty #247
[   23.066778] Hardware name: Freescale i.MX6 Quad/DualLite (Device
Tree)
[   23.073332] [<8010f61c>] (unwind_backtrace) from [<8010b984>]
(show_stack+0x10/0x14)
[   23.081094] [<8010b984>] (show_stack) from [<80831f84>]
(dump_stack+0x88/0x9c)
[   23.088336] [<80831f84>] (dump_stack) from [<8011e7ac>]
(__warn+0xdc/0xf4)
[   23.095226] [<8011e7ac>] (__warn) from [<8011e7fc>]
(warn_slowpath_fmt+0x38/0x48)
[   23.102726] [<8011e7fc>] (warn_slowpath_fmt) from [<802768b0>]
(sysfs_warn_dup+0x64/0x74)
[   23.110923] [<802768b0>] (sysfs_warn_dup) from [<80276988>]
(sysfs_create_dir_ns+0x84/0x90)
[   23.119291] [<80276988>] (sysfs_create_dir_ns) from [<808364c0>]
(kobject_add_internal+0xb4/0x30c)
[   23.128264] [<808364c0>] (kobject_add_internal) from [<80836764>]
(kobject_add+0x4c/0x9c)
[   23.136469] [<80836764>] (kobject_add) from [<8050c030>]
(device_add+0xe0/0x594)
[   23.143892] [<8050c030>] (device_add) from [<8051033c>]
(platform_device_add+0x110/0x224)
[   23.152096] [<8051033c>] (platform_device_add) from [<8049bb94>]
(imx_gpc_probe+0x184/0x380)
[   23.160556] [<8049bb94>] (imx_gpc_probe) from [<80510528>]
(platform_drv_probe+0x50/0xac)
[   23.168758] [<80510528>] (platform_drv_probe) from [<8050ecac>]
(driver_probe_device+0x254/0x32c)
[   23.177652] [<8050ecac>] (driver_probe_device) from [<8050d3f4>]
(bind_store+0xac/0x140)
[   23.185765] [<8050d3f4>] (bind_store) from [<802757a4>]
(kernfs_fop_write+0xec/0x1f0)
[   23.193623] [<802757a4>] (kernfs_fop_write) from [<80206064>]
(__vfs_write+0x1c/0x120)
[   23.201562] [<80206064>] (__vfs_write) from [<80206310>]
(vfs_write+0xa4/0x1b4)
[   23.208890] [<80206310>] (vfs_write) from [<80206520>]
(SyS_write+0x3c/0x90)
[   23.215963] [<80206520>] (SyS_write) from [<80107940>]
(ret_fast_syscall+0x0/0x54)
[   23.223619] ---[ end trace a5f9524661a4dba7 ]---
[   23.228254] ------------[ cut here ]------------
[   23.232920] WARNING: CPU: 0 PID: 432 at lib/kobject.c:240
kobject_add_internal+0x278/0x30c
[   23.241205] kobject_add_internal failed for imx-pgc-power-domain.0
with -EEXIST, don't try to register things with the same name in the
same directory.
[   23.254808] Modules linked in:
[   23.257880] CPU: 0 PID: 432 Comm: sh Tainted: G        W       
4.15.0-rc3-00061-g38f99f72e8f3-dirty #247
[   23.267459] Hardware name: Freescale i.MX6 Quad/DualLite (Device
Tree)
[   23.274009] [<8010f61c>] (unwind_backtrace) from [<8010b984>]
(show_stack+0x10/0x14)
[   23.281776] [<8010b984>] (show_stack) from [<80831f84>]
(dump_stack+0x88/0x9c)
[   23.289022] [<80831f84>] (dump_stack) from [<8011e7ac>]
(__warn+0xdc/0xf4)
[   23.295914] [<8011e7ac>] (__warn) from [<8011e7fc>]
(warn_slowpath_fmt+0x38/0x48)
[   23.303417] [<8011e7fc>] (warn_slowpath_fmt) from [<80836684>]
(kobject_add_internal+0x278/0x30c)
[   23.312308] [<80836684>] (kobject_add_internal) from [<80836764>]
(kobject_add+0x4c/0x9c)
[   23.320506] [<80836764>] (kobject_add) from [<8050c030>]
(device_add+0xe0/0x594)
[   23.327922] [<8050c030>] (device_add) from [<8051033c>]
(platform_device_add+0x110/0x224)
[   23.336125] [<8051033c>] (platform_device_add) from [<8049bb94>]
(imx_gpc_probe+0x184/0x380)
[   23.344586] [<8049bb94>] (imx_gpc_probe) from [<80510528>]
(platform_drv_probe+0x50/0xac)
[   23.352783] [<80510528>] (platform_drv_probe) from [<8050ecac>]
(driver_probe_device+0x254/0x32c)
[   23.361677] [<8050ecac>] (driver_probe_device) from [<8050d3f4>]
(bind_store+0xac/0x140)
[   23.369788] [<8050d3f4>] (bind_store) from [<802757a4>]
(kernfs_fop_write+0xec/0x1f0)
[   23.377644] [<802757a4>] (kernfs_fop_write) from [<80206064>]
(__vfs_write+0x1c/0x120)
[   23.385583] [<80206064>] (__vfs_write) from [<80206310>]
(vfs_write+0xa4/0x1b4)
[   23.392910] [<80206310>] (vfs_write) from [<80206520>]
(SyS_write+0x3c/0x90)
[   23.399979] [<80206520>] (SyS_write) from [<80107940>]
(ret_fast_syscall+0x0/0x54)
[   23.407603] ---[ end trace a5f9524661a4dba8 ]---
[   23.412263] ------------[ cut here ]------------
[   23.416893] Kernel BUG at 9e1dfcde [verbose debug info unavailable]
[   23.423173] Internal error: Oops - BUG: 0 [#1] SMP ARM
[   23.428322] Modules linked in:
[   23.431391] CPU: 0 PID: 432 Comm: sh Tainted: G        W       
4.15.0-rc3-00061-g38f99f72e8f3-dirty #247
[   23.440972] Hardware name: Freescale i.MX6 Quad/DualLite (Device
Tree)
[   23.447514] PC is at kfree+0xfc/0x140
[   23.451189] LR is at platform_device_release+0x10/0x34
[   23.456339] pc : [<801fd744>]    lr : [<80510114>]    psr: 40010013
[   23.462615] sp : 84cfdde8  ip : 00000000  fp : 84b34e00
[   23.467849] r10: 84b35a00  r9 : 80d23968  r8 : 80aa8a40
[   23.473084] r7 : 80952bac  r6 : 00000000  r5 : 84b35a10  r4 :
84b35a10
[   23.479622] r3 : 87dd2474  r2 : 87dd2460  r1 : a0010013  r0 :
80d23a20
[   23.486162] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment none
[   23.493308] Control: 10c5387d  Table: 14bd0059  DAC: 00000051
[   23.499065] Process sh (pid: 432, stack limit = 0xd85916d3)
[   23.504647] Stack: (0x84cfdde8 to 0x84cfe000)
[   23.509017] dde0:                   84b35a10 84b35a18 84b35a10
84b35a10 84b35a10 00000000
[   23.517212] de00: 80952bac 80510114 84b35a18 80509eac 84b35a18
80d2a784 84355780 80835e98
[   23.525408] de20: 87da9920 80952bac 87da983c ffffffef 87da9920
8049bd2c 00000000 00000000
[   23.533602] de40: 84151a10 00000042 84c28840 00000000 80b410d8
84151a10 fffffffe 80d239d8
[   23.541797] de60: fffffdfb 80d239d8 00000000 00000003 84c2b610
80510528 84151a10 80daefe4
[   23.549991] de80: 80daefe8 00000000 80d239d8 8050ecac 84151a10
80d2ab60 80d239d8 84151a44
[   23.558185] dea0: 0000000c 84cfdf80 00000000 8050d3f4 0000000c
84c2b600 00000000 00000000
[   23.566379] dec0: 84355a40 802757a4 00000000 00000000 84563910
802756b8 84efbcc0 01a661a8
[   23.574574] dee0: 84cfdf80 00000000 0000000c 00000000 000a5608
80206064 0000000a 00000100
[   23.582767] df00: 84dfd100 84e797c0 0000000a 8022401c 84cfb600
ffffe000 0000000a 00000001
[   23.590961] df20: 84cfb600 84cfc000 0000000a 80224800 00000000
80845644 00000000 8457bd80
[   23.599157] df40: 0000000c 84efbcc0 01a661a8 84cfdf80 00000000
80206310 84cfb600 00000002
[   23.607352] df60: 0000000a 84efbcc0 84efbcc0 00000000 00000000
01a661a8 0000000c 80206520
[   23.615548] df80: 00000000 00000000 00000000 0000000c 01a661a8
76f6ed60 00000004 80107b24
[   23.623743] dfa0: 84cfc000 80107940 0000000c 01a661a8 00000001
01a661a8 0000000c 00000000
[   23.631938] dfc0: 0000000c 01a661a8 76f6ed60 00000004 0000000c
0000000c 00086920 000a5608
[   23.640133] dfe0: 00000000 7ed2395c 76e9cffc 76ef57e0 60010010
00000001 00000000 00000000
[   23.648334] [<801fd744>] (kfree) from [<80510114>]
(platform_device_release+0x10/0x34)
[   23.656276] [<80510114>] (platform_device_release) from [<80509eac>]
(device_release+0x2c/0x90)
[   23.664999] [<80509eac>] (device_release) from [<80835e98>]
(kobject_put+0x94/0xe4)
[   23.672679] [<80835e98>] (kobject_put) from [<8049bd2c>]
(imx_gpc_probe+0x31c/0x380)
[   23.680443] [<8049bd2c>] (imx_gpc_probe) from [<80510528>]
(platform_drv_probe+0x50/0xac)
[   23.688640] [<80510528>] (platform_drv_probe) from [<8050ecac>]
(driver_probe_device+0x254/0x32c)
[   23.697531] [<8050ecac>] (driver_probe_device) from [<8050d3f4>]
(bind_store+0xac/0x140)
[   23.705644] [<8050d3f4>] (bind_store) from [<802757a4>]
(kernfs_fop_write+0xec/0x1f0)
[   23.713499] [<802757a4>] (kernfs_fop_write) from [<80206064>]
(__vfs_write+0x1c/0x120)
[   23.721436] [<80206064>] (__vfs_write) from [<80206310>]
(vfs_write+0xa4/0x1b4)
[   23.728764] [<80206310>] (vfs_write) from [<80206520>]
(SyS_write+0x3c/0x90)
[   23.735832] [<80206520>] (SyS_write) from [<80107940>]
(ret_fast_syscall+0x0/0x54)
[   23.743420] Code: 1a000003 e5923014 e3130001 1a000000 (e7f001f2)
[   23.749526] ---[ end trace a5f9524661a4dba9 ]---

--
Stefan
