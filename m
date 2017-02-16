From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Feb 2017 09:35:28 +0800
Subject: [PATCH v2 1/4] dt-bindings: add multidomain support to i.MX GPC
 DT binding
In-Reply-To: <1487150765.2304.65.camel@pengutronix.de>
References: <20170127183728.26701-1-l.stach@pengutronix.de>
 <1486741439.3879.7.camel@pengutronix.de>
 <20170215070830.GA8398@dragon>
 <1487150765.2304.65.camel@pengutronix.de>
Message-ID: <20170216013526.GB8398@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 10:26:05AM +0100, Lucas Stach wrote:
> Am Mittwoch, den 15.02.2017, 15:08 +0800 schrieb Shawn Guo:
> > On Fri, Feb 10, 2017 at 04:43:59PM +0100, Lucas Stach wrote:
> > > Hi Shawn,
> > > 
> > > are you willing to take this series through your tree or do you think we
> > > need to get this in via some other tree?
> > 
> > I'm willing to take it.  But I don't think it's been ready yet.  Since
> > you insist on keeping the .remove hook for both imx_gpc_driver and
> > imx_pgc_power_domain_driver, did you actually test it with manually
> > bind/unbind the drivers?  I tested it a bit and found it doesn't work
> > well for me.
> 
> It works as well as it could at this point. The driver unloads fine, but
> obviously anything that depends on it is broken at that point. Try
> unloading a regulator driver, it's the same experience.
> 
> This will get better once the functional dependency stuff is far enough
> to either block unloading of drivers providing resources to other
> devices, or unload the dependent drivers first.

I'm seeing two problems with my testing.  I need some help to understand
whether they are expected.

1. There is an error message with imx-pgc-power-domain.1 unbind.

root at arm:~# echo imx-pgc-power-domain.1 > /sys/bus/platform/drivers/imx-pgc-pd/unbind
[   31.934370] genpd_remove: unable to remove PU

2. Unbind 20dc000.gpc and bind again causes a fat kernel warning and
drops out console login.

root at arm:~# echo 20dc000.gpc > /sys/bus/platform/drivers/imx-gpc/unbind
root at arm:~# echo 20dc000.gpc > /sys/bus/platform/drivers/imx-gpc/bind
[   45.855469] ------------[ cut here ]------------
[   45.860282] WARNING: CPU: 3 PID: 1899 at ../fs/sysfs/dir.c:31 sysfs_warn_dup+0x5c/0x7c
[   45.868510] sysfs: cannot create duplicate filename '/devices/soc0/soc/2000000.aips-bus/20dc000.gpc/imx-pgc-power-domain.0'
[   45.879991] Modules linked in:
[   45.883228] CPU: 3 PID: 1899 Comm: bash Not tainted 4.10.0-rc2-00051-geada826574ce #757
[   45.891462] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   45.898175] Backtrace: 
[   45.900753] [<c010c390>] (dump_backtrace) from [<c010c638>] (show_stack+0x18/0x1c)
[   45.908548]  r7:00000000 r6:60000013 r5:00000000 r4:c0e27758
[   45.914391] [<c010c620>] (show_stack) from [<c03fa3b8>] (dump_stack+0xb4/0xe8)
[   45.921830] [<c03fa304>] (dump_stack) from [<c01258d8>] (__warn+0xd8/0x104)
[   45.929000]  r10:ee202400 r9:c0297be4 r8:0000001f r7:00000009 r6:c0c0e780 r5:00000000
[   45.937047]  r4:ed93dc78 r3:00000000
[   45.940749] [<c0125800>] (__warn) from [<c0125940>] (warn_slowpath_fmt+0x3c/0x44)
[   45.948464]  r9:c0e2cd48 r8:ef1b4c10 r7:ef1b4c18 r6:ef1a4c00 r5:ed5b43c0 r4:c0c0e74c
[   45.956435] [<c0125908>] (warn_slowpath_fmt) from [<c0297be4>] (sysfs_warn_dup+0x5c/0x7c)
[   45.964839]  r3:ee545000 r2:c0c0e74c
[   45.968528]  r4:ee545000
[   45.971163] [<c0297b88>] (sysfs_warn_dup) from [<c0297cdc>] (sysfs_create_dir_ns+0x88/0xa0)
[   45.979746]  r6:ef1a4c00 r5:ee202418 r4:ffffffef
[   45.984521] [<c0297c54>] (sysfs_create_dir_ns) from [<c03fd080>] (kobject_add_internal+0xa4/0x2dc)
[   45.993728]  r6:ef1b4c18 r5:00000000 r4:ee202418
[   45.998501] [<c03fcfdc>] (kobject_add_internal) from [<c03fd464>] (kobject_add+0x54/0x98)
[   46.006798]  r7:00000000 r6:ef1b4c18 r5:00000000 r4:ee202418
[   46.012549] [<c03fd414>] (kobject_add) from [<c051bd30>] (device_add+0xd8/0x5a8)
[   46.020046]  r3:00000000 r2:00000000
[   46.023679]  r6:ef1b4c10 r5:ee202410 r4:ee202418
[   46.028371] [<c051bc58>] (device_add) from [<c0520594>] (platform_device_add+0xa8/0x204)
[   46.036577]  r10:ee202400 r9:c0e2cd48 r8:ef1b4c10 r7:ef7e5404 r6:ee202410 r5:ee202400
[   46.044511]  r4:00000000
[   46.047098] [<c05204ec>] (platform_device_add) from [<c048c54c>] (imx_gpc_probe+0x198/0x308)
[   46.055651]  r7:ef7e5404 r6:00000000 r5:ef7e5548 r4:00000000
[   46.061396] [<c048c3b4>] (imx_gpc_probe) from [<c052088c>] (platform_drv_probe+0x54/0xb8)
[   46.069687]  r10:eda26ccc r9:00000000 r8:00000003 r7:fffffdfb r6:c0e2cdb8 r5:ef1b4c10
[   46.077621]  r4:ef1b4c10
[   46.080211] [<c0520838>] (platform_drv_probe) from [<c051ec64>] (driver_probe_device+0x20c/0x2e4)
[   46.089204]  r7:c0e2cdb8 r6:00000000 r5:c1661940 r4:ef1b4c10
[   46.094951] [<c051ea58>] (driver_probe_device) from [<c051d478>] (bind_store+0xb8/0x14c)
[   46.103154]  r9:00000000 r8:0000000c r7:ef1b4c44 r6:c0e2cdb8 r5:c0e39ec0 r4:ef1b4c10
[   46.111009] [<c051d3c0>] (bind_store) from [<c051cb34>] (drv_attr_store+0x28/0x34)
[   46.118686]  r9:00000000 r8:00000000 r7:ed5b4140 r6:ed5b4140 r5:c051cb0c r4:c051d3c0
[   46.126540] [<c051cb0c>] (drv_attr_store) from [<c0297434>] (sysfs_kf_write+0x54/0x58)
[   46.134564]  r5:c051cb0c r4:0000000c
[   46.138200] [<c02973e0>] (sysfs_kf_write) from [<c0296988>] (kernfs_fop_write+0xfc/0x208)
[   46.146490]  r7:ed5b4140 r6:ed93df80 r5:00000000 r4:eda26cc0
[   46.155538] [<c029688c>] (kernfs_fop_write) from [<c021ea88>] (__vfs_write+0x30/0x120)
[   46.166869]  r10:00000000 r9:ed93c000 r8:c0107f44 r7:ed93df80 r6:ed93df80 r5:c029688c
[   46.178177]  r4:ed609cc0
[   46.184137] [<c021ea58>] (__vfs_write) from [<c022030c>] (vfs_write+0xa8/0x16c)
[   46.194915]  r9:ed93c000 r8:c0107f44 r7:ed93df80 r6:01b9fc08 r5:ed609cc0 r4:0000000c
[   46.206109] [<c0220264>] (vfs_write) from [<c0221130>] (SyS_write+0x4c/0xa8)
[   46.216565]  r9:ed93c000 r8:c0107f44 r7:0000000c r6:01b9fc08 r5:ed609cc0 r4:ed609cc0
[   46.227728] [<c02210e4>] (SyS_write) from [<c0107da0>] (ret_fast_syscall+0x0/0x1c)
[   46.238718]  r7:00000004 r6:01b9fc08 r5:0000000c r4:b6ef55e0
[   46.247885] ---[ end trace 4e5758c98dab08c4 ]---
[   46.259297] ------------[ cut here ]------------
[   46.266636] WARNING: CPU: 3 PID: 1899 at ../lib/kobject.c:240 kobject_add_internal+0x260/0x2dc
[   46.278058] kobject_add_internal failed for imx-pgc-power-domain.0 with -EEXIST, don't try to register things with the same name in the same directory.
[   46.297292] Modules linked in:
[   46.303175] CPU: 3 PID: 1899 Comm: bash Tainted: G        W       4.10.0-rc2-00051-geada826574ce #757
[   46.315170] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   46.324446] Backtrace: 
[   46.329613] [<c010c390>] (dump_backtrace) from [<c010c638>] (show_stack+0x18/0x1c)
[   46.339939]  r7:00000000 r6:60000013 r5:00000000 r4:c0e27758
[   46.348367] [<c010c620>] (show_stack) from [<c03fa3b8>] (dump_stack+0xb4/0xe8)
[   46.358379] [<c03fa304>] (dump_stack) from [<c01258d8>] (__warn+0xd8/0x104)
[   46.368101]  r10:ee202400 r9:c03fd23c r8:000000f0 r7:00000009 r6:c0c25bc8 r5:00000000
[   46.378669]  r4:ed93dcc8 r3:00000000
[   46.384940] [<c0125800>] (__warn) from [<c0125940>] (warn_slowpath_fmt+0x3c/0x44)
[   46.395154]  r9:c0e2cd48 r8:ef1b4c10 r7:ef1b4c18 r6:ef1b4c18 r5:ffffffef r4:c0c25cb4
[   46.405637] [<c0125908>] (warn_slowpath_fmt) from [<c03fd23c>] (kobject_add_internal+0x260/0x2dc)
[   46.417256]  r3:c0a22098 r2:c0c25cb4
[   46.423537]  r4:ee202418
[   46.428780] [<c03fcfdc>] (kobject_add_internal) from [<c03fd464>] (kobject_add+0x54/0x98)
[   46.439716]  r7:00000000 r6:ef1b4c18 r5:00000000 r4:ee202418
[   46.448111] [<c03fd414>] (kobject_add) from [<c051bd30>] (device_add+0xd8/0x5a8)
[   46.458250]  r3:00000000 r2:00000000
[   46.464520]  r6:ef1b4c10 r5:ee202410 r4:ee202418
[   46.471821] [<c051bc58>] (device_add) from [<c0520594>] (platform_device_add+0xa8/0x204)
[   46.482618]  r10:ee202400 r9:c0e2cd48 r8:ef1b4c10 r7:ef7e5404 r6:ee202410 r5:ee202400
[   46.493151]  r4:00000000
[   46.498343] [<c05204ec>] (platform_device_add) from [<c048c54c>] (imx_gpc_probe+0x198/0x308)
[   46.509489]  r7:ef7e5404 r6:00000000 r5:ef7e5548 r4:00000000
[   46.517837] [<c048c3b4>] (imx_gpc_probe) from [<c052088c>] (platform_drv_probe+0x54/0xb8)
[   46.528727]  r10:eda26ccc r9:00000000 r8:00000003 r7:fffffdfb r6:c0e2cdb8 r5:ef1b4c10
[   46.539269]  r4:ef1b4c10
[   46.544458] [<c0520838>] (platform_drv_probe) from [<c051ec64>] (driver_probe_device+0x20c/0x2e4)
[   46.556060]  r7:c0e2cdb8 r6:00000000 r5:c1661940 r4:ef1b4c10
[   46.564432] [<c051ea58>] (driver_probe_device) from [<c051d478>] (bind_store+0xb8/0x14c)
[   46.575249]  r9:00000000 r8:0000000c r7:ef1b4c44 r6:c0e2cdb8 r5:c0e39ec0 r4:ef1b4c10
[   46.585715] [<c051d3c0>] (bind_store) from [<c051cb34>] (drv_attr_store+0x28/0x34)
[   46.595996]  r9:00000000 r8:00000000 r7:ed5b4140 r6:ed5b4140 r5:c051cb0c r4:c051d3c0
[   46.606454] [<c051cb0c>] (drv_attr_store) from [<c0297434>] (sysfs_kf_write+0x54/0x58)
[   46.617089]  r5:c051cb0c r4:0000000c
[   46.623349] [<c02973e0>] (sysfs_kf_write) from [<c0296988>] (kernfs_fop_write+0xfc/0x208)
[   46.634260]  r7:ed5b4140 r6:ed93df80 r5:00000000 r4:eda26cc0
[   46.642629] [<c029688c>] (kernfs_fop_write) from [<c021ea88>] (__vfs_write+0x30/0x120)
[   46.653271]  r10:00000000 r9:ed93c000 r8:c0107f44 r7:ed93df80 r6:ed93df80 r5:c029688c
[   46.663830]  r4:ed609cc0
[   46.669041] [<c021ea58>] (__vfs_write) from [<c022030c>] (vfs_write+0xa8/0x16c)
[   46.679084]  r9:ed93c000 r8:c0107f44 r7:ed93df80 r6:01b9fc08 r5:ed609cc0 r4:0000000c
[   46.689568] [<c0220264>] (vfs_write) from [<c0221130>] (SyS_write+0x4c/0xa8)
[   46.699379]  r9:ed93c000 r8:c0107f44 r7:0000000c r6:01b9fc08 r5:ed609cc0 r4:ed609cc0
[   46.709891] [<c02210e4>] (SyS_write) from [<c0107da0>] (ret_fast_syscall+0x0/0x1c)
[   46.720200]  r7:00000004 r6:01b9fc08 r5:0000000c r4:b6ef55e0
[   46.728617] ---[ end trace 4e5758c98dab08c5 ]---
[   46.736054] ------------[ cut here ]------------
[   46.743333] Kernel BUG at c02170f8 [verbose debug info unavailable]
[   46.752248] Internal error: Oops - BUG: 0 [#1] SMP ARM
[   46.760028] Modules linked in:
[   46.765684] CPU: 3 PID: 1899 Comm: bash Tainted: G        W       4.10.0-rc2-00051-geada826574ce #757
[   46.777574] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   46.786744] task: edb1c800 task.stack: ed93c000
[   46.793923] PC is at kfree+0x160/0x1ac
[   46.800284] LR is at platform_device_release+0x18/0x3c
[   46.808039] pc : [<c02170f8>]    lr : [<c0520394>]    psr: 40000013
[   46.808039] sp : ed93dce0  ip : ed93dd18  fp : ed93dd14
[   46.824688] r10: ee202400  r9 : c0e2cd48  r8 : ef1b4c10
[   46.832462] r7 : c0520394  r6 : c0e2ce00  r5 : ee202410  r4 : ef814580
[   46.841515] r3 : ef814594  r2 : c164e500  r1 : 00000110  r0 : c0e2ce00
[   46.850584] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   46.860261] Control: 10c5387d  Table: 3dbb004a  DAC: 00000051
[   46.868524] Process bash (pid: 1899, stack limit = 0xed93c210)
[   46.876856] Stack: (0xed93dce0 to 0xed93e000)
[   46.883697] dce0: ed93dce0 ed93dce0 00000001 ee202410 ee202410 00000000 ee202418 ef1b4c10
[   46.894424] dd00: c0e2cd48 ee202400 ed93dd2c ed93dd18 c0520394 c0216fa4 ee202418 ee202410
[   46.905142] dd20: ed93dd4c ed93dd30 c0519a30 c0520388 ee202434 c0e39884 ed5b43c0 ee202418
[   46.915845] dd40: ed93dd6c ed93dd50 c03fc838 c0519a08 ee202418 ef7e5548 00000000 ef7e5404
[   46.926532] dd60: ed93dd8c ed93dd70 c03fc8c4 c03fc7f4 ef7e5404 ef1b4c10 c0e2cd48 00000000
[   46.937199] dd80: ed93dd9c ed93dd90 c0519dc0 c03fc878 ed93ddac ed93dda0 c0520378 c0519db0
[   46.947851] dda0: ed93ddf4 ed93ddb0 c048c560 c0520368 00000000 c0c413ac 00000042 ffffffef
[   46.958491] ddc0: ef1b4c10 00000000 c0e2cdb8 ef1b4c10 ef1b4c10 c0e2cdb8 fffffdfb 00000003
[   46.969127] dde0: 00000000 eda26ccc ed93de14 ed93ddf8 c052088c c048c3c0 ef1b4c10 c1661940
[   46.979755] de00: 00000000 c0e2cdb8 ed93de3c ed93de18 c051ec64 c0520844 ef1b4c10 c0e39ec0
[   46.990362] de20: c0e2cdb8 ef1b4c44 0000000c 00000000 ed93de64 ed93de40 c051d478 c051ea64
[   47.000956] de40: c051d3c0 c051cb0c ed5b4140 ed5b4140 00000000 00000000 ed93de7c ed93de68
[   47.011547] de60: c051cb34 c051d3cc 0000000c c051cb0c ed93de9c ed93de80 c0297434 c051cb18
[   47.022127] de80: eda26cc0 00000000 ed93df80 ed5b4140 ed93dedc ed93dea0 c0296988 c02973ec
[   47.032698] dea0: 00000000 00000000 00000000 00000000 ee4861fc ed609cc0 c029688c ed93df80
[   47.043266] dec0: ed93df80 c0107f44 ed93c000 00000000 ed93df4c ed93dee0 c021ea88 c0296898
[   47.053817] dee0: c0187754 c016e4f0 c0e1c707 ee4861fc ed93df14 ed93df00 c0187ad8 c01876e0
[   47.064351] df00: 00000000 ee4862b0 ed93df4c ed93df18 c0222a30 c0187aa4 00000001 00000000
[   47.074888] df20: c02203b8 60000013 0000000c ed609cc0 01b9fc08 ed93df80 c0107f44 ed93c000
[   47.085421] df40: ed93df7c ed93df50 c022030c c021ea64 00000003 ed997040 ed609cc0 ed609cc0
[   47.095949] df60: 01b9fc08 0000000c c0107f44 ed93c000 ed93dfa4 ed93df80 c0221130 c0220270
[   47.106474] df80: 00000000 00000000 b6ef55e0 0000000c 01b9fc08 00000004 00000000 ed93dfa8
[   47.116994] dfa0: c0107da0 c02210f0 b6ef55e0 0000000c 00000001 01b9fc08 0000000c 00000000
[   47.127503] dfc0: b6ef55e0 0000000c 01b9fc08 00000004 be967a9c 000ad08c 00000000 01ba7328
[   47.138000] dfe0: 0000000c be967a20 b6e6496d b6e9d6bc 40000010 00000001 00000000 00000000
[   47.148482] Backtrace: 
[   47.153195] [<c0216f98>] (kfree) from [<c0520394>] (platform_device_release+0x18/0x3c)
[   47.163431]  r10:ee202400 r9:c0e2cd48 r8:ef1b4c10 r7:ee202418 r6:00000000 r5:ee202410
[   47.173569]  r4:ee202410
[   47.178389] [<c052037c>] (platform_device_release) from [<c0519a30>] (device_release+0x34/0x9c)
[   47.189460]  r5:ee202410 r4:ee202418
[   47.195379] [<c05199fc>] (device_release) from [<c03fc838>] (kobject_release+0x50/0x84)
[   47.205783]  r7:ee202418 r6:ed5b43c0 r5:c0e39884 r4:ee202434
[   47.213839] [<c03fc7e8>] (kobject_release) from [<c03fc8c4>] (kobject_put+0x58/0x88)
[   47.223997]  r7:ef7e5404 r6:00000000 r5:ef7e5548 r4:ee202418
[   47.232039] [<c03fc86c>] (kobject_put) from [<c0519dc0>] (put_device+0x1c/0x20)
[   47.241748]  r4:00000000
[   47.246662] [<c0519da4>] (put_device) from [<c0520378>] (platform_device_put+0x1c/0x20)
[   47.257123] [<c052035c>] (platform_device_put) from [<c048c560>] (imx_gpc_probe+0x1ac/0x308)
[   47.268035] [<c048c3b4>] (imx_gpc_probe) from [<c052088c>] (platform_drv_probe+0x54/0xb8)
[   47.278698]  r10:eda26ccc r9:00000000 r8:00000003 r7:fffffdfb r6:c0e2cdb8 r5:ef1b4c10
[   47.289037]  r4:ef1b4c10
[   47.294055] [<c0520838>] (platform_drv_probe) from [<c051ec64>] (driver_probe_device+0x20c/0x2e4)
[   47.305495]  r7:c0e2cdb8 r6:00000000 r5:c1661940 r4:ef1b4c10
[   47.313716] [<c051ea58>] (driver_probe_device) from [<c051d478>] (bind_store+0xb8/0x14c)
[   47.324392]  r9:00000000 r8:0000000c r7:ef1b4c44 r6:c0e2cdb8 r5:c0e39ec0 r4:ef1b4c10
[   47.334733] [<c051d3c0>] (bind_store) from [<c051cb34>] (drv_attr_store+0x28/0x34)
[   47.344922]  r9:00000000 r8:00000000 r7:ed5b4140 r6:ed5b4140 r5:c051cb0c r4:c051d3c0
[   47.355274] [<c051cb0c>] (drv_attr_store) from [<c0297434>] (sysfs_kf_write+0x54/0x58)
[   47.365798]  r5:c051cb0c r4:0000000c
[   47.371957] [<c02973e0>] (sysfs_kf_write) from [<c0296988>] (kernfs_fop_write+0xfc/0x208)
[   47.382774]  r7:ed5b4140 r6:ed93df80 r5:00000000 r4:eda26cc0
[   47.391069] [<c029688c>] (kernfs_fop_write) from [<c021ea88>] (__vfs_write+0x30/0x120)
[   47.401668]  r10:00000000 r9:ed93c000 r8:c0107f44 r7:ed93df80 r6:ed93df80 r5:c029688c
[   47.412173]  r4:ed609cc0
[   47.417345] [<c021ea58>] (__vfs_write) from [<c022030c>] (vfs_write+0xa8/0x16c)
[   47.427333]  r9:ed93c000 r8:c0107f44 r7:ed93df80 r6:01b9fc08 r5:ed609cc0 r4:0000000c
[   47.437780] [<c0220264>] (vfs_write) from [<c0221130>] (SyS_write+0x4c/0xa8)
[   47.447522]  r9:ed93c000 r8:c0107f44 r7:0000000c r6:01b9fc08 r5:ed609cc0 r4:ed609cc0
[   47.457975] [<c02210e4>] (SyS_write) from [<c0107da0>] (ret_fast_syscall+0x0/0x1c)
[   47.468247]  r7:00000004 r6:01b9fc08 r5:0000000c r4:b6ef55e0
[   47.476613] Code: 1a000003 e5943014 e3130001 1a000000 (e7f001f2) 
[   47.485413] ---[ end trace 4e5758c98dab08c6 ]---

Message from syslogd at arm at Feb 16 01:25:29 ...
 kernel:[   46.752248] Internal error: Oops - BUG: 0 [#1] SMP ARM

Message from syslogd at arm at Feb 16 01:25:29 ...
 kernel:[   46.868524] Process bash (pid: 1899, stack limit = 0xed93c210)

Message from syslogd at arm at Feb 16 01:25:29 ...
 kernel:[   46.876856] Stack: (0xed93dce0 to 0xed93e000)

Message from syslogd at arm at Feb 16 01:25:29 ...
 kernel:[   46.883697] ?
Debian GNU/Linux 7 arm ttymxc0

arm login: 
