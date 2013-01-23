From: rajanikanth.hv@stericsson.com (Rajanikanth H.V)
Date: Wed, 23 Jan 2013 09:56:45 +0530
Subject: [PATCH] ab8500: btemp: demote initcall sequence
Message-ID: <1358915205-7786-1-git-send-email-rajanikanth.hv@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

Power supply subsystem creates thermal zone device for
the property 'POWER_SUPPLY_PROP_TEMP' which requires
thermal subsystem to be ready before 'ab8500 battery temperature monitor'
driver is initialized.
ab8500 btemp driver is initialized with subsys_initcall whereas thermal
subsystem is initialized with fs_initcall which causes
thermal_zone_device_register(...) to crash since the required structure
'thermal_class' is not initialized yet.

crash log:
===================================================================
Unable to handle kernel NULL pointer dereference at virtual address 000000a4
pgd = c0004000
[000000a4] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0    Tainted: G        W     (3.8.0-rc4-00001-g632fda8-dirty #1)
PC is at _raw_spin_lock+0x18/0x54
LR is at get_device_parent+0x50/0x1b8
pc : [<c02f1dd0>]    lr : [<c01cb248>]    psr: 60000013
sp : ef04bdc8  ip : 00000000  fp : c0446180
r10: ef216e38  r9 : c03af5d0  r8 : ef275c18
r7 : 00000000  r6 : c0476c14  r5 : ef275c18  r4 : ef095840
r3 : ef04a000  r2 : 00000001  r1 : 00000000  r0 : 000000a4
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5787d  Table: 0000404a  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0xef04a238)
Stack: (0xef04bdc8 to 0xef04c000)
bdc0:                   ef275c18 00000000 00000000 c01cb8d8 00000000 ef275c18
bde0: ef275c80 00000000 c0446180 c01d3edc ef275c18 ef275c00 00000000 00000000
be00: c03af5d0 ef275c18 c03af5d0 ef216e38 c0446180 c020b91c 00000000 ef275c04
be20: ef04be48 ef1ad000 ef216e38 ef1ad000 ef216e38 00000000 ef1b9010 00000002
be40: c03af5d0 00000000 c0446058 c0202030 c0445400 00000000 00000000 00000000
be60: ef216e10 ef1b9000 c04457f4 c02055ec 00000000 c01d57ac ef216e38 ef037a00
be80: ef181fc0 00000000 ef1b9010 c0476c38 ef1b9010 ef1b9044 c0446008 c041bbb0
bea0: c044d940 ef04a000 c0414b68 c01cf0dc c01cf0c8 c01cde70 00000000 ef1b9010
bec0: c0446008 ef1b9044 00000000 c01ce094 00000000 c0446008 c01ce008 c01cc640
bee0: ef032258 ef180334 ef222f00 c0446008 c0441778 c01cd6b4 c03ab170 c0446008
bf00: c0446008 c041bbd0 00000005 c044d940 c041bbb0 c01ce54c 00000000 c0422988
bf20: c041bbd0 00000005 c044d940 c041bbb0 ef04a000 c00086ac 00000049 c00360cc
bf40: ef04bf6c 00000000 c0388c34 c03e1a78 00000004 00000004 c0436998 c0422988
bf60: c041bbd0 00000005 c044d940 c041bbb0 c040027c 00000049 00000000 c02e89c8
bf80: 00000004 00000004 c040027c c0c88340 00000000 c02e88a8 00000000 00000000
bfa0: 00000000 00000000 00000000 c000e358 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 80800004 00304600
[<c02f1dd0>] (_raw_spin_lock+0x18/0x54) from [<c01cb248>] (get_device_parent+0x50/0x1b8)
[<c01cb248>] (get_device_parent+0x50/0x1b8) from [<c01cb8d8>] (device_add+0xa4/0x574)
[<c01cb8d8>] (device_add+0xa4/0x574) from [<c020b91c>] (thermal_zone_device_register+0x118/0x938)
[<c020b91c>] (thermal_zone_device_register+0x118/0x938) from [<c0202030>] (power_supply_register+0x170/0x1f8)
[<c0202030>] (power_supply_register+0x170/0x1f8) from [<c02055ec>] (ab8500_btemp_probe+0x208/0x47c)
[<c02055ec>] (ab8500_btemp_probe+0x208/0x47c) from [<c01cf0dc>] (platform_drv_probe+0x14/0x18)
[<c01cf0dc>] (platform_drv_probe+0x14/0x18) from [<c01cde70>] (driver_probe_device+0x74/0x20c)
[<c01cde70>] (driver_probe_device+0x74/0x20c) from [<c01ce094>] (__driver_attach+0x8c/0x90)
[<c01ce094>] (__driver_attach+0x8c/0x90) from [<c01cc640>] (bus_for_each_dev+0x4c/0x80)
[<c01cc640>] (bus_for_each_dev+0x4c/0x80) from [<c01cd6b4>] (bus_add_driver+0x16c/0x23c)
[<c01cd6b4>] (bus_add_driver+0x16c/0x23c) from [<c01ce54c>] (driver_register+0x78/0x14c)
[<c01ce54c>] (driver_register+0x78/0x14c) from [<c00086ac>] (do_one_initcall+0xfc/0x164)
[<c00086ac>] (do_one_initcall+0xfc/0x164) from [<c02e89c8>] (kernel_init+0x120/0x2b8)
[<c02e89c8>] (kernel_init+0x120/0x2b8) from [<c000e358>] (ret_from_fork+0x14/0x3c)
Code: e3c3303f e5932004 e2822001 e5832004 (e1903f9f)
---[ end trace ed9df72941b5bada ]---
===================================================================

Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
---
 drivers/power/ab8500_btemp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index 20e2a7d..056222e 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -1123,7 +1123,7 @@ static void __exit ab8500_btemp_exit(void)
 	platform_driver_unregister(&ab8500_btemp_driver);
 }
 
-subsys_initcall_sync(ab8500_btemp_init);
+device_initcall(ab8500_btemp_init);
 module_exit(ab8500_btemp_exit);
 
 MODULE_LICENSE("GPL v2");
-- 
1.7.10.4
