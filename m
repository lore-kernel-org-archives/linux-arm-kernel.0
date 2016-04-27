From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 27 Apr 2016 10:45:54 +0800
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <20160427015835.GE30692@tiger>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
 <20160421034520.GA19965@shlinux2.ap.freescale.net>
 <20160426012341.GB8870@tiger>
 <CAA+hA=QTNEAaMfjJoMMO5gPR8VPYBWYx=HZgjngUFJK4LxMp=g@mail.gmail.com>
 <1461663072.7839.17.camel@pengutronix.de>
 <CAA+hA=SSQJPbzbhCY7O8JaxiUgMDjG2ATQXsCW-X5zc2inC6kw@mail.gmail.com>
 <CAA+hA=Q5Un7Sib5QEvK4H2PH5qrySAkRR+=ofuaKxX_PCuT-Yw@mail.gmail.com>
 <20160427015835.GE30692@tiger>
Message-ID: <CAA+hA=SNp7bQZSUp5R5v9BfXMffS-4-msv12G5UAQJTxUMKW=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 9:58 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Tue, Apr 26, 2016 at 07:27:03PM +0800, Dong Aisheng wrote:
>> Shawn,
>> What's your suggestion?
>
> I think this needs more discussion, and I just dropped Stefan's patch
> from my tree.
>
> We need to firstly understand why this is happening.  The .prepare hook
> is defined to be non-atomic context, and so that we call sleep function
> in there.  We did everything right.  Why are we getting the warning?  If
> I'm correct, this warning only happens on i.MX7D.  Why is that?
>

This is mainly caused by during kernel early booting, there's only one init idle
task running.
See:
void __init sched_init(void)
{
.....
        /*
         * Make us the idle thread. Technically, schedule() should not be
         * called from this thread, however somewhere below it might be,
         * but because we are the idle thread, we just pick up running again
         * when this runqueue becomes "idle".
         */
        init_idle(current, smp_processor_id());
...
}

And the idle sched class indicates it's not valid to schedule for idle task.
const struct sched_class idle_sched_class = {
        /* .next is NULL */
        /* no enqueue/yield_task for idle tasks */

        /* dequeue is not valid, we print a debug message there: */
        .dequeue_task           = dequeue_task_idle,
...........

}

/*
 * It is not legal to sleep in the idle task - print a warning
 * message if some code attempts to do it:
 */
static void
dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
{
        raw_spin_unlock_irq(&rq->lock);
        printk(KERN_ERR "bad: scheduling from the idle thread!\n");
        dump_stack();
        raw_spin_lock_irq(&rq->lock);
}


Below is the full log of imx7d booting FYI.

You can ignore the first two warning (releasing a pinned lock) which
is a side affection
of idle task schedule during booting.

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.6.0-rc1-00011-gee55b3d17805-dirty
(b29396 at shlinux2) (gcc version 4.9.1 (GCC) ) #779 SMP Tue Apr 26
18:17:26 CST 2016
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: Freescale i.MX7 SabreSD Board
[    0.000000] cma: Reserved 16 MiB at 0xbf000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 262144
[    0.000000] free_area_init_node: node 0, pgdat c0d72900,
node_mem_map ef7f9000
[    0.000000]   Normal zone: 1536 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
[    0.000000] percpu: Embedded 13 pages/cpu @ef7bd000 s20544 r8192
d24512 u53248
[    0.000000] pcpu-alloc: s20544 r8192 d24512 u53248 alloc=13*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 260608
[    0.000000] Kernel command line: console=ttymxc0,115200
root=/dev/nfs ip=dhcp
nfsroot=10.192.224.44:/data/rootfs_home/b29396/rootfs-yocto-L4.1.X-RC5,v3,tcp
log_buf_len=2M
[    0.000000] log_buf_len: 2097152 bytes
[    0.000000] early log buf free: 260724(99%)
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 999884K/1048576K available (8196K kernel code,
464K rwdata, 2828K rodata, 1024K init, 8223K bss, 32308K reserved,
16384K cma-reserved, 245760K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0bc406c   (12017 kB)
[    0.000000]       .init : 0xc0c00000 - 0xc0d00000   (1024 kB)
[    0.000000]       .data : 0xc0d00000 - 0xc0d74100   ( 465 kB)
[    0.000000]        .bss : 0xc0d76000 - 0xc157dfa0   (8224 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:3422
lock_release+0x340/0x378
[    0.000000] releasing a pinned lock
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.6.0-rc1-00011-gee55b3d17805-dirty #779
[    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    0.000000] Backtrace:
[    0.000000] [<c010c42c>] (dump_backtrace) from [<c010c624>]
(show_stack+0x18/0x1c)
[    0.000000]  r6:600000d3 r5:00000000 r4:c0d21f9c r3:00000000
[    0.000000] [<c010c60c>] (show_stack) from [<c03dfec8>]
(dump_stack+0xb4/0xe8)
[    0.000000] [<c03dfe14>] (dump_stack) from [<c0124ce8>] (__warn+0xd8/0x104)
[    0.000000]  r10:c0d069c0 r9:c016e7ec r8:00000d5e r7:00000009
r6:c0ad6a04 r5:00000000
[    0.000000]  r4:c0d01ad8 r3:00000001
[    0.000000] [<c0124c10>] (__warn) from [<c0124d54>]
(warn_slowpath_fmt+0x40/0x48)
[    0.000000]  r9:00000001 r8:c154243c r7:00000002 r6:00000020
r5:c0d06500 r4:c0ad7ac4
[    0.000000] [<c0124d18>] (warn_slowpath_fmt) from [<c016e7ec>]
(lock_release+0x340/0x378)
[    0.000000]  r3:00000001 r2:c0ad7ac4
[    0.000000]  r4:00000001
[    0.000000] [<c016e4ac>] (lock_release) from [<c08f9cf4>]
(_raw_spin_unlock_irq+0x20/0x34)
[    0.000000]  r10:c08f4fdc r9:c0d02b0c r8:c0d06844 r7:ef7c14d0
r6:00000001 r5:ef7c14c0
[    0.000000]  r4:ef7c14c0
[    0.000000] [<c08f9cd4>] (_raw_spin_unlock_irq) from [<c015437c>]
(dequeue_task_idle+0x14/0x30)
[    0.000000]  r4:ef7c14c0 r3:c0154368
[    0.000000] [<c0154368>] (dequeue_task_idle) from [<c014c96c>]
(deactivate_task+0x64/0x68)
[    0.000000]  r4:c0d06500 r3:c0154368
[    0.000000] [<c014c908>] (deactivate_task) from [<c08f4b44>]
(__schedule+0x2e8/0x738)
[    0.000000]  r6:c0d06500 r5:ef7c14c0 r4:c0c754c0 r3:00000002
[    0.000000] [<c08f485c>] (__schedule) from [<c08f4fdc>] (schedule+0x48/0xa0)
[    0.000000]  r10:00000018 r9:0000001c r8:00000003 r7:00000000
r6:0007a120 r5:00000000
[    0.000000]  r4:c0d00000
[    0.000000] [<c08f4f94>] (schedule) from [<c08f9750>]
(schedule_hrtimeout_range_clock+0xac/0x12c)
[    0.000000]  r4:0006ddd0 r3:c0d06500
[    0.000000] [<c08f96a4>] (schedule_hrtimeout_range_clock) from
[<c08f97f4>] (schedule_hrtimeout_range+0x24/0x2c)
[    0.000000]  r7:00000001 r6:c0d02100 r5:ffff8ad1 r4:ef004f80
[    0.000000] [<c08f97d0>] (schedule_hrtimeout_range) from
[<c08f922c>] (usleep_range+0x54/0x5c)
[    0.000000] [<c08f91d8>] (usleep_range) from [<c0698148>]
(clk_pllv3_wait_lock+0x7c/0xb4)
[    0.000000] [<c06980cc>] (clk_pllv3_wait_lock) from [<c06981b0>]
(clk_pllv3_prepare+0x30/0x34)
[    0.000000]  r6:ef007080 r5:ef00ef00 r4:ef007600 r3:000017c0
[    0.000000] [<c0698180>] (clk_pllv3_prepare) from [<c069203c>]
(clk_core_prepare+0x98/0xc4)
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef007900
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef00e800
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef00eb80
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef00ef00
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c0692be8>]
(clk_core_prepare_enable+0x1c/0x5c)
[    0.000000]  r5:ef00ef00 r4:ef011f80
[    0.000000] [<c0692bcc>] (clk_core_prepare_enable) from
[<c0692eb4>] (__clk_set_parent_before+0x38/0x7c)
[    0.000000]  r5:ef00ef00 r4:ef011f80
[    0.000000] [<c0692e7c>] (__clk_set_parent_before) from
[<c0693004>] (clk_core_set_parent+0x10c/0x170)
[    0.000000]  r7:00000001 r6:ef00ef00 r5:00000000 r4:ef011f80
[    0.000000] [<c0692ef8>] (clk_core_set_parent) from [<c069308c>]
(clk_set_parent+0x24/0x28)
[    0.000000]  r8:00000003 r7:c0d5d434 r6:00000000 r5:ef02b440
r4:00000009 r3:c15603bc
[    0.000000] [<c0693068>] (clk_set_parent) from [<c0c4ade8>]
(imx7d_clocks_init+0x5f4c/0x5f8c)
[    0.000000] [<c0c44e9c>] (imx7d_clocks_init) from [<c0c30e00>]
(of_clk_init+0x10c/0x1d4)
[    0.000000]  r10:00000001 r9:c0d01f68 r8:00000000 r7:c0d01f60
r6:ef7e3d60 r5:ef004340
[    0.000000]  r4:00000002
[    0.000000] [<c0c30cf4>] (of_clk_init) from [<c0c048d4>]
(time_init+0x2c/0x38)
[    0.000000]  r10:efffcac0 r9:c0c5da48 r8:c0d76000 r7:c0d028c0
r6:ffffffff r5:c0d76000
[    0.000000]  r4:00000000
[    0.000000] [<c0c048a8>] (time_init) from [<c0c00b7c>]
(start_kernel+0x218/0x398)
[    0.000000] [<c0c00964>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000]  r10:00000000 r9:410fc075 r8:8000406a r7:c0d07e8c
r6:c0c5da44 r5:c0d0296c
[    0.000000]  r4:c0d76294
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:2617
trace_hardirqs_on_caller+0x1ac/0x1f0
[    0.000000] DEBUG_LOCKS_WARN_ON(unlikely(early_boot_irqs_disabled))
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
4.6.0-rc1-00011-gee55b3d17805-dirty #779
[    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    0.000000] Backtrace:
[    0.000000] [<c010c42c>] (dump_backtrace) from [<c010c624>]
(show_stack+0x18/0x1c)
[    0.000000]  r6:600000d3 r5:00000000 r4:c0d21f9c r3:00000000
[    0.000000] [<c010c60c>] (show_stack) from [<c03dfec8>]
(dump_stack+0xb4/0xe8)
[    0.000000] [<c03dfe14>] (dump_stack) from [<c0124ce8>] (__warn+0xd8/0x104)
[    0.000000]  r10:c08f4fdc r9:c016b918 r8:00000a39 r7:00000009
r6:c0ad6a04 r5:00000000
[    0.000000]  r4:c0d01af8 r3:00000000
[    0.000000] [<c0124c10>] (__warn) from [<c0124d54>]
(warn_slowpath_fmt+0x40/0x48)
[    0.000000]  r9:c0d02b0c r8:c0d06844 r7:ef7c14d0 r6:00000001
r5:ef7c14c0 r4:c0ad3ea0
[    0.000000] [<c0124d18>] (warn_slowpath_fmt) from [<c016b918>]
(trace_hardirqs_on_caller+0x1ac/0x1f0)
[    0.000000]  r3:c0ad7890 r2:c0ad3ea0
[    0.000000]  r4:c08f9d00
[    0.000000] [<c016b76c>] (trace_hardirqs_on_caller) from
[<c016b970>] (trace_hardirqs_on+0x14/0x18)
[    0.000000]  r6:00000001 r5:ef7c14c0 r4:ef7c14c0 r3:600000d3
[    0.000000] [<c016b95c>] (trace_hardirqs_on) from [<c08f9d00>]
(_raw_spin_unlock_irq+0x2c/0x34)
[    0.000000] [<c08f9cd4>] (_raw_spin_unlock_irq) from [<c015437c>]
(dequeue_task_idle+0x14/0x30)
[    0.000000]  r4:ef7c14c0 r3:c0154368
[    0.000000] [<c0154368>] (dequeue_task_idle) from [<c014c96c>]
(deactivate_task+0x64/0x68)
[    0.000000]  r4:c0d06500 r3:c0154368
[    0.000000] [<c014c908>] (deactivate_task) from [<c08f4b44>]
(__schedule+0x2e8/0x738)
[    0.000000]  r6:c0d06500 r5:ef7c14c0 r4:c0c754c0 r3:00000002
[    0.000000] [<c08f485c>] (__schedule) from [<c08f4fdc>] (schedule+0x48/0xa0)
[    0.000000]  r10:00000018 r9:0000001c r8:00000003 r7:00000000
r6:0007a120 r5:00000000
[    0.000000]  r4:c0d00000
[    0.000000] [<c08f4f94>] (schedule) from [<c08f9750>]
(schedule_hrtimeout_range_clock+0xac/0x12c)
[    0.000000]  r4:0006ddd0 r3:c0d06500
[    0.000000] [<c08f96a4>] (schedule_hrtimeout_range_clock) from
[<c08f97f4>] (schedule_hrtimeout_range+0x24/0x2c)
[    0.000000]  r7:00000001 r6:c0d02100 r5:ffff8ad1 r4:ef004f80
[    0.000000] [<c08f97d0>] (schedule_hrtimeout_range) from
[<c08f922c>] (usleep_range+0x54/0x5c)
[    0.000000] [<c08f91d8>] (usleep_range) from [<c0698148>]
(clk_pllv3_wait_lock+0x7c/0xb4)
[    0.000000] [<c06980cc>] (clk_pllv3_wait_lock) from [<c06981b0>]
(clk_pllv3_prepare+0x30/0x34)
[    0.000000]  r6:ef007080 r5:ef00ef00 r4:ef007600 r3:000017c0
[    0.000000] [<c0698180>] (clk_pllv3_prepare) from [<c069203c>]
(clk_core_prepare+0x98/0xc4)
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef007900
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef00e800
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef00eb80
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef00ef00
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c0692be8>]
(clk_core_prepare_enable+0x1c/0x5c)
[    0.000000]  r5:ef00ef00 r4:ef011f80
[    0.000000] [<c0692bcc>] (clk_core_prepare_enable) from
[<c0692eb4>] (__clk_set_parent_before+0x38/0x7c)
[    0.000000]  r5:ef00ef00 r4:ef011f80
[    0.000000] [<c0692e7c>] (__clk_set_parent_before) from
[<c0693004>] (clk_core_set_parent+0x10c/0x170)
[    0.000000]  r7:00000001 r6:ef00ef00 r5:00000000 r4:ef011f80
[    0.000000] [<c0692ef8>] (clk_core_set_parent) from [<c069308c>]
(clk_set_parent+0x24/0x28)
[    0.000000]  r8:00000003 r7:c0d5d434 r6:00000000 r5:ef02b440
r4:00000009 r3:c15603bc
[    0.000000] [<c0693068>] (clk_set_parent) from [<c0c4ade8>]
(imx7d_clocks_init+0x5f4c/0x5f8c)
[    0.000000] [<c0c44e9c>] (imx7d_clocks_init) from [<c0c30e00>]
(of_clk_init+0x10c/0x1d4)
[    0.000000]  r10:00000001 r9:c0d01f68 r8:00000000 r7:c0d01f60
r6:ef7e3d60 r5:ef004340
[    0.000000]  r4:00000002
[    0.000000] [<c0c30cf4>] (of_clk_init) from [<c0c048d4>]
(time_init+0x2c/0x38)
[    0.000000]  r10:efffcac0 r9:c0c5da48 r8:c0d76000 r7:c0d028c0
r6:ffffffff r5:c0d76000
[    0.000000]  r4:00000000
[    0.000000] [<c0c048a8>] (time_init) from [<c0c00b7c>]
(start_kernel+0x218/0x398)
[    0.000000] [<c0c00964>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000]  r10:00000000 r9:410fc075 r8:8000406a r7:c0d07e8c
r6:c0c5da44 r5:c0d0296c
[    0.000000]  r4:c0d76294
[    0.000000] ---[ end trace cb88537fdc8fa201 ]---
[    0.000000] bad: scheduling from the idle thread!
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
4.6.0-rc1-00011-gee55b3d17805-dirty #779
[    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    0.000000] Backtrace:
[    0.000000] [<c010c42c>] (dump_backtrace) from [<c010c624>]
(show_stack+0x18/0x1c)
[    0.000000]  r6:60000053 r5:00000000 r4:c0d21f9c r3:00000000
[    0.000000] [<c010c60c>] (show_stack) from [<c03dfec8>]
(dump_stack+0xb4/0xe8)
[    0.000000] [<c03dfe14>] (dump_stack) from [<c0154388>]
(dequeue_task_idle+0x20/0x30)
[    0.000000]  r10:c08f4fdc r9:c0d02b0c r8:c0d06844 r7:ef7c14d0
r6:00000001 r5:ef7c14c0
[    0.000000]  r4:ef7c14c0 r3:00000000
[    0.000000] [<c0154368>] (dequeue_task_idle) from [<c014c96c>]
(deactivate_task+0x64/0x68)
[    0.000000]  r4:c0d06500 r3:c0154368
[    0.000000] [<c014c908>] (deactivate_task) from [<c08f4b44>]
(__schedule+0x2e8/0x738)
[    0.000000]  r6:c0d06500 r5:ef7c14c0 r4:c0c754c0 r3:00000002
[    0.000000] [<c08f485c>] (__schedule) from [<c08f4fdc>] (schedule+0x48/0xa0)
[    0.000000]  r10:00000018 r9:0000001c r8:00000003 r7:00000000
r6:0007a120 r5:00000000
[    0.000000]  r4:c0d00000
[    0.000000] [<c08f4f94>] (schedule) from [<c08f9750>]
(schedule_hrtimeout_range_clock+0xac/0x12c)
[    0.000000]  r4:0006ddd0 r3:c0d06500
[    0.000000] [<c08f96a4>] (schedule_hrtimeout_range_clock) from
[<c08f97f4>] (schedule_hrtimeout_range+0x24/0x2c)
[    0.000000]  r7:00000001 r6:c0d02100 r5:ffff8ad1 r4:ef004f80
[    0.000000] [<c08f97d0>] (schedule_hrtimeout_range) from
[<c08f922c>] (usleep_range+0x54/0x5c)
[    0.000000] [<c08f91d8>] (usleep_range) from [<c0698148>]
(clk_pllv3_wait_lock+0x7c/0xb4)
[    0.000000] [<c06980cc>] (clk_pllv3_wait_lock) from [<c06981b0>]
(clk_pllv3_prepare+0x30/0x34)
[    0.000000]  r6:ef007080 r5:ef00ef00 r4:ef007600 r3:000017c0
[    0.000000] [<c0698180>] (clk_pllv3_prepare) from [<c069203c>]
(clk_core_prepare+0x98/0xc4)
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef007900
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef00e800
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef00eb80
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c069201c>]
(clk_core_prepare+0x78/0xc4)
[    0.000000]  r5:ef00ef00 r4:ef00ef00
[    0.000000] [<c0691fa4>] (clk_core_prepare) from [<c0692be8>]
(clk_core_prepare_enable+0x1c/0x5c)
[    0.000000]  r5:ef00ef00 r4:ef011f80
[    0.000000] [<c0692bcc>] (clk_core_prepare_enable) from
[<c0692eb4>] (__clk_set_parent_before+0x38/0x7c)
[    0.000000]  r5:ef00ef00 r4:ef011f80
[    0.000000] [<c0692e7c>] (__clk_set_parent_before) from
[<c0693004>] (clk_core_set_parent+0x10c/0x170)
[    0.000000]  r7:00000001 r6:ef00ef00 r5:00000000 r4:ef011f80
[    0.000000] [<c0692ef8>] (clk_core_set_parent) from [<c069308c>]
(clk_set_parent+0x24/0x28)
[    0.000000]  r8:00000003 r7:c0d5d434 r6:00000000 r5:ef02b440
r4:00000009 r3:c15603bc
[    0.000000] [<c0693068>] (clk_set_parent) from [<c0c4ade8>]
(imx7d_clocks_init+0x5f4c/0x5f8c)
[    0.000000] [<c0c44e9c>] (imx7d_clocks_init) from [<c0c30e00>]
(of_clk_init+0x10c/0x1d4)
[    0.000000]  r10:00000001 r9:c0d01f68 r8:00000000 r7:c0d01f60
r6:ef7e3d60 r5:ef004340
[    0.000000]  r4:00000002
[    0.000000] [<c0c30cf4>] (of_clk_init) from [<c0c048d4>]
(time_init+0x2c/0x38)
[    0.000000]  r10:efffcac0 r9:c0c5da48 r8:c0d76000 r7:c0d028c0
r6:ffffffff r5:c0d76000
[    0.000000]  r4:00000000
[    0.000000] [<c0c048a8>] (time_init) from [<c0c00b7c>]
(start_kernel+0x218/0x398)
[    0.000000] [<c0c00964>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000]  r10:00000000 r9:410fc075 r8:8000406a r7:c0d07e8c
r6:c0c5da44 r5:c0d0296c
[    0.000000]  r4:c0d76294
[    0.000000] Architected cp15 timer(s) running at 8.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x1d854df40, max_idle_ns: 440795202120 ns
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/time/sched_clock.c:179
sched_clock_register+0x44/0x21c
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
4.6.0-rc1-00011-gee55b3d17805-dirty #779
[    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    0.000000] Backtrace:
[    0.000000] [<c010c42c>] (dump_backtrace) from [<c010c624>]
(show_stack+0x18/0x1c)
[    0.000000]  r6:60000053 r5:00000000 r4:c0d21f9c r3:00000000
[    0.000000] [<c010c60c>] (show_stack) from [<c03dfec8>]
(dump_stack+0xb4/0xe8)
[    0.000000] [<c03dfe14>] (dump_stack) from [<c0124ce8>] (__warn+0xd8/0x104)
[    0.000000]  r10:c0b55504 r9:c0c13a04 r8:000000b3 r7:00000009
r6:c0adb860 r5:00000000
[    0.000000]  r4:00000000 r3:00000000
[    0.000000] [<c0124c10>] (__warn) from [<c0124dc8>]
(warn_slowpath_null+0x28/0x30)
[    0.000000]  r9:6fbdeeb3 r8:07c96afc r7:c067a55c r6:00000038
r5:007a1200 r4:c0d164c0
[    0.000000] [<c0124da0>] (warn_slowpath_null) from [<c0c13a04>]
(sched_clock_register+0x44/0x21c)
[    0.000000] [<c0c139c0>] (sched_clock_register) from [<c0c2e148>]
(arch_timer_common_init+0x1c8/0x22c)
[    0.000000]  r9:6fbdeeb3 r8:07c96afc r7:c155ec88 r6:c0ae143c
r5:c0b5551c r4:c0d5bf00
[    0.000000] [<c0c2df80>] (arch_timer_common_init) from [<c0c2e438>]
(arch_timer_of_init+0x28c/0x2d8)
[    0.000000]  r10:efffcac0 r9:c0c5da48 r8:c0d76000 r7:c0d5bf00
r6:00000000 r5:c155ec88
[    0.000000]  r4:00000012
[    0.000000] [<c0c2e1ac>] (arch_timer_of_init) from [<c0c2de38>]
(clocksource_probe+0x50/0x90)
[    0.000000]  r8:c0d76000 r7:c0d028c0 r6:ffffffff r5:00000001
r4:ef7dae9c r3:c0c2e1ac
[    0.000000] [<c0c2dde8>] (clocksource_probe) from [<c0c048d8>]
(time_init+0x30/0x38)
[    0.000000]  r5:c0d76000 r4:00000000
[    0.000000] [<c0c048a8>] (time_init) from [<c0c00b7c>]
(start_kernel+0x218/0x398)
[    0.000000] [<c0c00964>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000]  r10:00000000 r9:410fc075 r8:8000406a r7:c0d07e8c
r6:c0c5da44 r5:c0d0296c
[    0.000000]  r4:c0d76294
[    0.000000] ---[ end trace cb88537fdc8fa202 ]---
[    0.000007] sched_clock: 56 bits at 8MHz, resolution 125ns, wraps
every 2199023255500ns
[    0.000022] Switching to timer-based delay loop, resolution 125ns
[    0.000575] Switching to timer-based delay loop, resolution 41ns
[    0.000587] ------------[ cut here ]------------
[    0.000604] WARNING: CPU: 0 PID: 0 at kernel/time/sched_clock.c:179
sched_clock_register+0x44/0x21c
[    0.000613] Modules linked in:
[    0.000629] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
4.6.0-rc1-00011-gee55b3d17805-dirty #779
[    0.000638] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    0.000646] Backtrace:
[    0.000667] [<c010c42c>] (dump_backtrace) from [<c010c624>]
(show_stack+0x18/0x1c)
[    0.000676]  r6:60000053 r5:00000000 r4:c0d21f9c r3:00000000
[    0.000712] [<c010c60c>] (show_stack) from [<c03dfec8>]
(dump_stack+0xb4/0xe8)
[    0.000730] [<c03dfe14>] (dump_stack) from [<c0124ce8>] (__warn+0xd8/0x104)
[    0.000739]  r10:efffcac0 r9:c0c13a04 r8:000000b3 r7:00000009
r6:c0adb860 r5:00000000
[    0.000772]  r4:00000000 r3:00000000
[    0.000795] [<c0124c10>] (__warn) from [<c0124dc8>]
(warn_slowpath_null+0x28/0x30)
[    0.000805]  r9:c0c5da48 r8:00000003 r7:c067b098 r6:00000020
r5:016e3600 r4:c0d164c0
[    0.000846] [<c0124da0>] (warn_slowpath_null) from [<c0c13a04>]
(sched_clock_register+0x44/0x21c)
[    0.000866] [<c0c139c0>] (sched_clock_register) from [<c0c2eb5c>]
(_mxc_timer_init+0x144/0x240)
[    0.000875]  r9:c0c5da48 r8:00000003 r7:016e3600 r6:c155ece8
r5:f0880024 r4:ef002400
[    0.000919] [<c0c2ea18>] (_mxc_timer_init) from [<c0c2ed14>]
(mxc_timer_init_dt+0xbc/0xe8)
[    0.000928]  r7:00000000 r6:ef7e084c r5:ef002400 r4:c155ece8
[    0.000965] [<c0c2ec58>] (mxc_timer_init_dt) from [<c0c2ed84>]
(imx6dl_timer_init_dt+0x14/0x18)
[    0.000975]  r8:c0d76000 r7:c0d028c0 r6:ffffffff r5:00000002
r4:ef7e084c r3:c0c2ed70
[    0.001018] [<c0c2ed70>] (imx6dl_timer_init_dt) from [<c0c2de38>]
(clocksource_probe+0x50/0x90)
[    0.001035] [<c0c2dde8>] (clocksource_probe) from [<c0c048d8>]
(time_init+0x30/0x38)
[    0.001045]  r5:c0d76000 r4:00000000
[    0.001069] [<c0c048a8>] (time_init) from [<c0c00b7c>]
(start_kernel+0x218/0x398)
[    0.001083] [<c0c00964>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.001092]  r10:00000000 r9:410fc075 r8:8000406a r7:c0d07e8c
r6:c0c5da44 r5:c0d0296c
[    0.001125]  r4:c0d76294
[    0.001137] ---[ end trace cb88537fdc8fa203 ]---
[    0.001156] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
every 89478484971ns
[    0.001174] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 79635851949 ns
[    0.002055] ------------[ cut here ]------------
[    0.002073] WARNING: CPU: 0 PID: 0 at init/main.c:575
start_kernel+0x240/0x398
[    0.002082] Interrupts were enabled early
[    0.002090] Modules linked in:
[    0.002106] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
4.6.0-rc1-00011-gee55b3d17805-dirty #779
[    0.002116] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    0.002124] Backtrace:
[    0.002145] [<c010c42c>] (dump_backtrace) from [<c010c624>]
(show_stack+0x18/0x1c)
[    0.002155]  r6:60000053 r5:00000000 r4:c0d21f9c r3:00000000
[    0.002191] [<c010c60c>] (show_stack) from [<c03dfec8>]
(dump_stack+0xb4/0xe8)
[    0.002209] [<c03dfe14>] (dump_stack) from [<c0124ce8>] (__warn+0xd8/0x104)
[    0.002219]  r10:efffcac0 r9:c0c00ba4 r8:0000023f r7:00000009
r6:c0acc620 r5:00000000
[    0.002252]  r4:c0d01f88 r3:00000000
[    0.002276] [<c0124c10>] (__warn) from [<c0124d54>]
(warn_slowpath_fmt+0x40/0x48)
[    0.002285]  r9:c0c5da48 r8:c0d76000 r7:c0d028c0 r6:ffffffff
r5:c0d76000 r4:c0acc660
[    0.002326] [<c0124d18>] (warn_slowpath_fmt) from [<c0c00ba4>]
(start_kernel+0x240/0x398)
[    0.002335]  r3:60000053 r2:c0acc660
[    0.002352]  r4:00000000
[    0.002368] [<c0c00964>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.002378]  r10:00000000 r9:410fc075 r8:8000406a r7:c0d07e8c
r6:c0c5da44 r5:c0d0296c
[    0.002411]  r4:c0d76294
[    0.002423] ---[ end trace cb88537fdc8fa204 ]---
[    0.002536] Console: colour dummy device 80x30
[    0.002550] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.002559] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.002568] ... MAX_LOCK_DEPTH:          48
[    0.002576] ... MAX_LOCKDEP_KEYS:        8191
[    0.002585] ... CLASSHASH_SIZE:          4096
[    0.002594] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.002602] ... MAX_LOCKDEP_CHAINS:      65536
[    0.002611] ... CHAINHASH_SIZE:          32768
[    0.002620]  memory used by lock dependency info: 5167 kB
[    0.002629]  per task-struct memory footprint: 1536 bytes
[    0.002652] Calibrating delay loop (skipped), value calculated
using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.002669] pid_max: default: 32768 minimum: 301
[    0.002826] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002842] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
.....................

Regards
Dong Aisheng
