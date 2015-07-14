From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 14 Jul 2015 13:44:15 -0300
Subject: mx6: suspicious RCU usage
In-Reply-To: <20150714162600.GJ3717@linux.vnet.ibm.com>
References: <CAOMZO5DeOLORXUAgYN2_BkB1BS8wuF8CoTf=QOfU1fB-je0UHQ@mail.gmail.com>
 <20150714160006.GI3717@linux.vnet.ibm.com>
 <CAOMZO5Bbj2FjWxNGDUHSHXCPFC1A7F6sO6AepZjRZoxHY-kgYg@mail.gmail.com>
 <20150714162600.GJ3717@linux.vnet.ibm.com>
Message-ID: <CAOMZO5AcegpqyDtsyawbSCDZcFnpHjq7uxRQJxBiFjzMH0hyDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Tue, Jul 14, 2015 at 1:26 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:

> Glad it helped!
>
> Russell, did you want me to push this, or would you rather take it?

With your patch applied I am running several suspend/resume cycles and
I am seeing different problems now from time to time (like 1 out 10
times). The kernel dump does not look like the same every time, but
here is one example:

root at freescale /$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.001 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
PM: suspend of devices complete after 36.922 msecs
PM: suspend devices took 0.050 seconds
PM: late suspend of devices complete after 8.133 msecs
PM: noirq suspend of devices complete after 8.036 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1 is up
Unable to handle kernel paging request at virtual address 663bf420
pgd = bd5cc000
[663bf420] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 968 Comm: sh Not tainted 4.2.0-rc2-dirty #249
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
task: bdb78000 ti: bd614000 task.ti: bd614000
PC is at rcu_is_watching+0x28/0x3c
LR is at pick_next_task_fair+0x50c/0x774
pc : [<8007e9b0>]    lr : [<8005d554>]    psr: 600001d3
sp : bd615bd8  ip : bd615be8  fp : bd615be4
r10: be79cfc0  r9 : be79cfd0  r8 : ffff953a
r7 : 00000000  r6 : 0007a11f  r5 : 00000000  r4 : 80ad7cfe
r3 : 80a6e40c  r2 : e5951014  r1 : 00000000  r0 : 00000001
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 4d5cc04a  DAC: 00000015
Process sh (pid: 968, stack limit = 0xbd614210)
Stack: (0xbd615bd8 to 0xbd616000)
5bc0:                                                       bd615c54 bd615be8
5be0: 8005d554 8007e994 00000000 00000000 8005d240 00002627 bd615c24 bdb78000
5c00: 00000001 bdb78000 80a74b2c 80a70fc0 be79cfc0 00000000 bd615c44 bd615c28
5c20: 8004e324 80059bf8 ffffffec bdb78000 be79cfd0 bdb78290 80a74b2c 00000000
5c40: be79cfc0 80a70fc0 bd615c9c bd615c58 80774b40 8005d054 bd615c84 bd615c68
5c60: 8006b864 8006b6d8 600001d3 807751cc be79a440 bd615cb4 be79a440 be79a440
5c80: ffff953a 80a74100 00000010 00000000 bd615cac bd615ca0 807751cc 80774a14
5ca0: bd615d04 bd615cb0 80779408 807751a0 40000153 00000000 be79a564 ffff953a
5cc0: 80084624 bdb78000 00000000 ffffffff 812cbdcc 00000000 00000000 8092ee88
5ce0: bd615d04 00000064 80a79be8 80a79be4 00000002 00000000 bd615d44 bd615d08
5d00: 80775b5c 807792dc c0808000 00000001 bdb78000 8004fb7c 80a79c08 80a79c08
5d20: 00000000 00000002 be077300 80adb360 00000000 be077300 bd615d54 bd615d48
5d40: 80775c20 80775aa0 bd615d74 bd615d58 80015af0 80775c18 00000002 00000000
5d60: 00000002 80a749c4 bd615dac bd615d78 8002b728 80015a48 bd615d9c 0000002a
5d80: 8076f64c 00000002 80adbad0 80a74a7c 80a74a18 80a75429 00000000 00000000
5da0: bd615dcc bd615db0 8076c090 8002b668 20000153 00000000 8128869c 00000003
5dc0: bd615e14 bd615dd0 8007172c 8076c02c 80075040 80074a84 8092d4f0 bd615e0c
5de0: bd615e04 bd615df0 8076f64c 00000000 00000003 812886a8 00000003 bd86dec0
5e00: 00000000 00000004 bd615e34 bd615e18 80071b08 80071420 0000006d 00000003
5e20: 80929290 812886ac bd615e5c bd615e38 80070420 800718a4 bd6f3500 00000004
5e40: bd86dec0 00000004 00000000 00a0f408 bd615e6c bd615e60 802db104 800703bc
5e60: bd615e8c bd615e70 8016a4a0 802db0f4 8016a44c bd6f3500 bd86dec0 bd6f350c
5e80: bd615ed4 bd615e90 801697f0 8016a458 00000000 00000000 80a74ca0 800fe580
5ea0: bd615ee4 bd615f78 8006ae9c 80783d34 00a0f408 bdb1e780 bd615f78 00000004
5ec0: bd614000 00a0f408 bd615f44 bd615ed8 800fd4b0 80169734 bd615f44 bd615ee8
5ee0: 800ff8a8 802fdcf4 00000020 00000000 800fe580 bd615f00 00000000 bdb802e4
5f00: bdb1e780 00000000 bd615f34 bd615f18 800669c4 8006665c bdb78000 bdb1e780
5f20: 00a0f408 bdb1e780 00a0f408 00000004 bd615f78 00000004 bd615f74 bd615f48
5f40: 800fe4e0 800fd488 8011a848 8011a7ac 00000000 00000000 bdb1e780 bdb1e780
5f60: 00000004 00a0f408 bd615fa4 bd615f78 800fe778 800fe454 00000000 00000000
5f80: 00000004 76f155c0 00000004 00000004 8000fd44 00000000 00000000 bd615fa8
5fa0: 8000fb60 800fe740 00000004 76f155c0 00000001 00a0f408 00000004 00000000
5fc0: 00000004 76f155c0 00000004 00000004 00a0f408 00a0d318 7ee5aae8 00000000
5fe0: 00000000 7ee5aa68 76e51690 76ea40bc 60000010 00000001 00000000 00000000
Backtrace:
[<8007e988>] (rcu_is_watching) from [<8005d554>]
(pick_next_task_fair+0x50c/0x774)
[<8005d048>] (pick_next_task_fair) from [<80774b40>] (__schedule+0x138/0x6c4)
 r10:80a70fc0 r9:be79cfc0 r8:00000000 r7:80a74b2c r6:bdb78290 r5:be79cfd0
 r4:bdb78000
[<80774a08>] (__schedule) from [<807751cc>] (schedule+0x38/0x9c)
 r10:00000000 r9:00000010 r8:80a74100 r7:ffff953a r6:be79a440 r5:be79a440
 r4:bd615cb4
[<80775194>] (schedule) from [<80779408>] (schedule_timeout+0x138/0x1cc)
[<807792d0>] (schedule_timeout) from [<80775b5c>] (wait_for_common+0xc8/0x15c)
 r8:00000000 r7:00000002 r6:80a79be4 r5:80a79be8 r4:00000064
[<80775a94>] (wait_for_common) from [<80775c20>]
(wait_for_completion_timeout+0x14/0x18)
 r10:be077300 r8:00000000 r7:80adb360 r6:be077300 r5:00000002 r4:00000000
[<80775c0c>] (wait_for_completion_timeout) from [<80015af0>]
(__cpu_up+0xb4/0x14c)
[<80015a3c>] (__cpu_up) from [<8002b728>] (_cpu_up+0xcc/0x148)
 r7:80a749c4 r6:00000002 r5:00000000 r4:00000002
[<8002b65c>] (_cpu_up) from [<8076c090>] (enable_nonboot_cpus+0x70/0xb8)
 r10:00000000 r9:00000000 r8:80a75429 r7:80a74a18 r6:80a74a7c r5:80adbad0
 r4:00000002
[<8076c020>] (enable_nonboot_cpus) from [<8007172c>]
(suspend_devices_and_enter+0x318/0x484)
 r6:00000003 r5:8128869c r4:00000000 r3:20000153
[<80071414>] (suspend_devices_and_enter) from [<80071b08>]
(pm_suspend+0x270/0x2a8)
 r10:00000004 r9:00000000 r8:bd86dec0 r7:00000003 r6:812886a8 r5:00000003
 r4:00000000
[<80071898>] (pm_suspend) from [<80070420>] (state_store+0x70/0xc0)
 r6:812886ac r5:80929290 r4:00000003 r3:0000006d
[<800703b0>] (state_store) from [<802db104>] (kobj_attr_store+0x1c/0x28)
 r10:00a0f408 r8:00000000 r7:00000004 r6:bd86dec0 r5:00000004 r4:bd6f3500
[<802db0e8>] (kobj_attr_store) from [<8016a4a0>] (sysfs_kf_write+0x54/0x58)
[<8016a44c>] (sysfs_kf_write) from [<801697f0>] (kernfs_fop_write+0xc8/0x1a8)
 r6:bd6f350c r5:bd86dec0 r4:bd6f3500 r3:8016a44c
[<80169728>] (kernfs_fop_write) from [<800fd4b0>] (__vfs_write+0x34/0xe0)
 r10:00a0f408 r9:bd614000 r8:00000004 r7:bd615f78 r6:bdb1e780 r5:00a0f408
 r4:80783d34
[<800fd47c>] (__vfs_write) from [<800fe4e0>] (vfs_write+0x98/0x154)
 r8:00000004 r7:bd615f78 r6:00000004 r5:00a0f408 r4:bdb1e780
[<800fe448>] (vfs_write) from [<800fe778>] (SyS_write+0x44/0x90)
 r10:00a0f408 r8:00000004 r7:bdb1e780 r6:bdb1e780 r5:00000000 r4:00000000
[<800fe734>] (SyS_write) from [<8000fb60>] (ret_fast_syscall+0x0/0x54)
 r10:00000000 r8:8000fd44 r7:00000004 r6:00000004 r5:76f155c0 r4:00000004
Code: e5d72014 e5811010 e55f2010 47922101 (f6130414)
---[ end trace 2d8bb88539a73fb8 ]---
