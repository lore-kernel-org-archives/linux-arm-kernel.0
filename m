From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Tue, 4 Feb 2014 16:47:11 +0100
Subject: 'unannotated irqs-on' lockdep warning
In-Reply-To: <20140204125839.GC26766@pengutronix.de>
References: <CAH9NwWcVrjV1=rFnHJhDH0yoEkTwUTcq-Tn=R0aaiTr70Fs3hA@mail.gmail.com>
 <20140130155741.GB15937@n2100.arm.linux.org.uk>
 <CAH9NwWdb0fGQTtss2JzXP16jfCJMG6fCkJQBiy6yiOQ5y30kHA@mail.gmail.com>
 <20140204125839.GC26766@pengutronix.de>
Message-ID: <CAH9NwWfcmMWQv4AEW8CxCi=tSR4FeLAy1Jg4JzjxSOM9mmsbJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-02-04 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Tue, Feb 04, 2014 at 11:02:16AM +0100, Christian Gmeiner wrote:
>> Hi
>>
>> 2014-01-30 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> > On Thu, Jan 30, 2014 at 03:31:46PM +0100, Christian Gmeiner wrote:
>> >> [   19.859234] CPU: 0 PID: 1848 Comm: mkdir Not tainted 3.12.4 #44
>> >> [   19.865190] [<c0013900>] (unwind_backtrace+0x0/0xe0) from
>> >> [<c00113b8>] (show_stack+0x10/0x14)
>> >> [   19.873739] [<c00113b8>] (show_stack+0x10/0x14) from [<c044e040>]
>> >> (dump_stack+0x64/0xa4)
>> >> [   19.881851] [<c044e040>] (dump_stack+0x64/0xa4) from [<c0022718>]
>> >> (warn_slowpath_common+0x64/0x84)
>> >> [   19.890828] [<c0022718>] (warn_slowpath_common+0x64/0x84) from
>> >> [<c00227b8>] (warn_slowpath_fmt+0x2c/0x3c)
>> >> [   19.900413] [<c00227b8>] (warn_slowpath_fmt+0x2c/0x3c) from
>> >> [<c0076c84>] (check_flags.part.26+0xb4/0x1e4)
>> >> [   19.910001] [<c0076c84>] (check_flags.part.26+0xb4/0x1e4) from
>> >> [<c0079654>] (lock_release+0x3c/0x100)
>> >> [   19.919243] [<c0079654>] (lock_release+0x3c/0x100) from
>> >> [<c00485b4>] (lg_local_unlock+0x18/0x6c)
>> >> [   19.928055] [<c00485b4>] (lg_local_unlock+0x18/0x6c) from
>> >> [<c012a2cc>] (free_fs_struct+0x18/0x30)
>> >> [   19.936947] [<c012a2cc>] (free_fs_struct+0x18/0x30) from
>> >> [<c0024e24>] (do_exit+0x2ac/0x3f0)
>> >> [   19.945316] [<c0024e24>] (do_exit+0x2ac/0x3f0) from [<c002501c>]
>> >> (do_group_exit+0x88/0xb4)
>> >> [   19.953596] [<c002501c>] (do_group_exit+0x88/0xb4) from
>> >> [<c0025058>] (__wake_up_parent+0x0/0x18)
>> >> [   19.962391] ---[ end trace 98a70b5cdc7b49fe ]---
>> >> [   19.967017] possible reason: unannotated irqs-on.
>> >> [   19.971729] irq event stamp: 2910
>> >> [   19.975050] hardirqs last  enabled at (2909): [<c044a160>]
>> >> __slab_free+0x1c0/0x390
>> >> [   19.982661] hardirqs last disabled at (2910): [<c0456d14>]
>> >> __dabt_svc+0x34/0x60
>> >
>> > So, I wonder how we got from __dabt_svc to __wake_up_parent.  It looks
>> > like the unwinder has failed to do a proper job of unwinding, which
>> > makes this undebuggable.
>> >
>> > Can you rebuild in ARM mode with frame pointers enabled please?
>> >
>>
>> Maybe i am blind but I can not find that option via make menuconfig. hmmm
> config FRAME_POINTER
>         bool
>         depends on !THUMB2_KERNEL
>         default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
>
> so disable THUMB2_KERNEL and ARM_UNWIND.
>

Thanks Uwe.


This is what I get:


    5.761766] udevd[360]: starting version 175
[    6.436175] input: rotary.15 as /devices/rotary.15/input/input1
[    9.689303] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
[    9.960301] [EXT4 FS bs=4096, gc=16, bpg=32768, ipg=8192,
mo=8802c818, mo2=0002]
[    9.960328] EXT4-fs (mmcblk0p2): re-mounted. Opts: debug
[   14.212395] [EXT4 FS bs=4096, gc=13, bpg=32768, ipg=7888,
mo=8802c818, mo2=0002]
[   14.212729] EXT4-fs (mmcblk0p1): mounted filesystem with ordered
data mode. Opts: debug
[   15.063614] ------------[ cut here ]------------
[   15.068272] WARNING: CPU: 1 PID: 1321 at kernel/lockdep.c:3539
check_flags+0xe8/0x1ec()
[   15.076287] DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
[   15.081692] Modules linked in: rotary_encoder
[   15.086296] CPU: 1 PID: 1321 Comm: mountall.sh Not tainted 3.12.9 #1
[   15.092658] Backtrace:
[   15.095153] [<c001213c>] (dump_backtrace+0x0/0x10c) from
[<c00122dc>] (show_stack+0x18/0x1c)
[   15.103601]  r6:ffffffff r5:c06e5660 r4:00000000 r3:00000000
[   15.109365] [<c00122c4>] (show_stack+0x0/0x1c) from [<c04b83cc>]
(dump_stack+0x6c/0xac)
[   15.117394] [<c04b8360>] (dump_stack+0x0/0xac) from [<c0025094>]
(warn_slowpath_common+0x70/0x90)
[   15.126273]  r6:00000dd3 r5:00000009 r4:ec44fd50 r3:c2b62a00
[   15.132028] [<c0025024>] (warn_slowpath_common+0x0/0x90) from
[<c0025158>] (warn_slowpath_fmt+0x38/0x40)
[   15.141515]  r8:ed6a2530 r7:c0128918 r6:c070fe54 r5:ec44e000 r4:c06e5738
[   15.148331] [<c0025120>] (warn_slowpath_fmt+0x0/0x40) from
[<c0083338>] (check_flags+0xe8/0x1ec)
[   15.157123]  r3:c05ef538 r2:c05e6f2c
[   15.160754] [<c0083250>] (check_flags+0x0/0x1ec) from [<c0087334>]
(lock_release+0x48/0x290)
[   15.169199]  r6:c06d16ec r5:00000040 r4:ec44e000 r3:00000000
[   15.174959] [<c00872ec>] (lock_release+0x0/0x290) from [<c0128930>]
(complete_walk+0x6c/0x12c)
[   15.183586] [<c01288c4>] (complete_walk+0x0/0x12c) from
[<c012b000>] (path_lookupat+0x74/0x7a8)
[   15.192291]  r6:00000000 r5:00000040 r4:ec44fe68 r3:ed6a2530
[   15.198042] [<c012af8c>] (path_lookupat+0x0/0x7a8) from
[<c012b75c>] (filename_lookup+0x28/0x68)
[   15.206842] [<c012b734>] (filename_lookup+0x0/0x68) from
[<c012dd9c>] (user_path_at_empty+0x5c/0x84)
[   15.215981]  r7:ffffff9c r6:ec44fe68 r5:00000000 r4:ec477000
[   15.221732] [<c012dd40>] (user_path_at_empty+0x0/0x84) from
[<c012dde0>] (user_path_at+0x1c/0x24)
[   15.230610]  r8:ffffff9c r7:00eb3274 r6:ec44ff40 r5:00000000 r4:ec44ff00
[   15.237425] [<c012ddc4>] (user_path_at+0x0/0x24) from [<c0123fd0>]
(vfs_fstatat+0x54/0x98)
[   15.245703] [<c0123f7c>] (vfs_fstatat+0x0/0x98) from [<c0124038>]
(vfs_lstat+0x24/0x28)
[   15.253722] [<c0124014>] (vfs_lstat+0x0/0x28) from [<c0124270>]
(SyS_lstat64+0x1c/0x38)
[   15.261742] [<c0124254>] (SyS_lstat64+0x0/0x38) from [<c000e5c0>]
(ret_fast_syscall+0x0/0x48)
[   15.270273]  r4:0000000b
[   15.272833] ---[ end trace a6e000210e7fe9c9 ]---
[   15.277457] possible reason: unannotated irqs-on.
[   15.282169] irq event stamp: 37958
[   15.285578] hardirqs last  enabled at (37957): [<c000e650>]
no_work_pending+0x8/0x2c
[   15.293352] hardirqs last disabled at (37958): [<c04beb54>]
__dabt_svc+0x34/0x60
[   15.300780] softirqs last  enabled at (32532): [<c0029b70>]
__do_softirq+0x1bc/0x304
[   15.308556] softirqs last disabled at (32521): [<c0029d80>]
do_softirq+0x70/0x78
[   16.977080] NET: Registered protocol family 10
[   18.394642] fec 2188000.ethernet eth0: Freescale FEC PHY driver
[Generic PHY] (mii_bus:phy_addr=fixed-0:00, irq=-1)
[   18.409077] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready


greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
