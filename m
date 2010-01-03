From: mkl0301@hotmail.com (mkl lin)
Date: Sun, 3 Jan 2010 08:56:11 +0000
Subject: SMP issues on ARM11 MPCore
In-Reply-To: <20100101205850.GI16220@n2100.arm.linux.org.uk>
References: <SNT109-W391FD03251D32533FAE84DA77F0@phx.gbl>,
	<20100101205850.GI16220@n2100.arm.linux.org.uk>
Message-ID: <SNT109-W65CC8A14EB694801F84BFDA7750@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> I'm using ARM11 MPCore with 2 CPU, Linux-2.6.31.1, SMP enabled,
>> L1 enabled, L2 disabled
> An ARM board - which one?
A proprietary development board which include 2 ARM11 MPCore CPU.

>> Under SMP environment, I have observed following issues:

> Define "console". What is it? Serial port? What messages are slow -
> output from user programs or the kernel? (Your comment seems to imply
> just user programs but please confirm.)
The console here is serial port. Sorry for the unclearness.
Kernel messages seems fine, since message from USB and Magic Sysrq is pretty responsive.
It is user message that are slow, print character by character, 1-2 char per second.

> These two sounds like a problem with interrupts - userspace console IO
> is interrupt driven, whereas kernel console IO is not.
This could be a point, I would look into it.

> Have you tried enabling 'Magic Sysrq' and sending t to list the
> task state in the system. '' there is whatever you need to do
> to cause your serial terminal program to send a break condition. For
> minicom, that defaults to ^A f
Attached the result of some SysRq.
I didn't see any abnormal, however.

>> Without DCache and CONFIG_LOCAL_TIMERS, I can repeat the above procedure
>> for 216 seconds, then it halted as case 4. Case 1 also exists with this
>> config.
> You can't disable the data cache in SMP mode.
I used to do so to clearify whether it is an cache coherency issue or not. Is there any concern with it?

> It could be something to do with write allocate caches - we don't support
> these particularly well in the kernel, and I wouldn't be surprised if
> you've found some problem there.
>
> The fact that it only happens in SMP mode rather points at that, because
> that's one of the few hardware configurations which does have write
> allocate caches. To confirm this, we need someone who can run your
> tests on a UP platform which has write allocate caches...
I'm not familiar with the write allocate cache, but the same test without SMP doesn't have such issue.
Or should I try to run 1CPU in SMP mode?

Best Regards,
Mac Lin.

----

[ 1129.550000] SysRq : Show backtrace of all active CPUs
[ 1129.550000] CPU0:
[ 1129.550000] 
[ 1129.550000] Pid: 0, comm:????????????? swapper
[ 1129.550000] CPU: 0??? Not tainted? (2.6.31.1-XXXX #86)
[ 1129.550000] PC is at default_idle+0x24/0x2c
[ 1129.550000] LR is at default_idle+0x20/0x2c
[ 1129.550000] pc : [<c002c5e0>]??? lr : [<c002c5dc>]??? psr: 60000013
[ 1129.550000] sp : c0349fb8? ip : c0349f58? fp : 00000000
[ 1129.550000] r10: c0023000? r9 : c0023dc0? r8 : c0370804
[ 1129.550000] r7 : 0048c000? r6 : c04ac000? r5 : c036b618? r4 : c0348000
[ 1129.550000] r3 : 00000000? r2 : c0348000? r1 : 00000000? r0 : c02e60a4
[ 1129.550000] Flags: nZCv? IRQs on? FIQs on? Mode SVC_32? ISA ARM? Segment kernel
[ 1129.550000] Control: 00c5787d? Table: 0241c00a? DAC: 00000017

[ 1133.550000] SysRq : Show Memory
[ 1133.550000] Mem-info:
[ 1133.550000] Normal per-cpu:
[ 1133.550000] CPU??? 0: hi:?? 42, btch:?? 7 usd:? 13
[ 1133.550000] CPU??? 1: hi:?? 42, btch:?? 7 usd:? 38
[ 1133.550000] Active_anon:553 active_file:272 inactive_anon:0
[ 1133.550000]? inactive_file:1494 unevictable:0 dirty:1 writeback:0 unstable:0
[ 1133.550000]? free:15032 slab:556 mapped:579 pagetables:42 bounce:0
[ 1133.550000] Normal free:60128kB min:1440kB low:1800kB high:2160kB active_anon:2212kB inactive_anon:0kB active_file:1088kB inactive_file:5976kB unevictable:0kB present:130048kB pages_scanned:0 all_unreclaimable? no
[ 1133.550000] lowmem_reserve[]: 0 0
[ 1133.550000] Normal: 36*4kB 12*8kB 491*16kB 56*32kB 39*64kB 31*128kB 25*256kB 21*512kB 12*1024kB 5*2048kB 1*4096kB 0*8192kB 0*16384kB 0*32768kB 0*65536kB = 60128kB
[ 1133.550000] 1889 total pagecache pages
[ 1133.550000] 32768 pages of RAM
[ 1133.550000] 15160 free pages
[ 1133.550000] 2207 reserved pages
[ 1133.550000] 556 slab pages
[ 1133.550000] 1436 pages shared
[ 1133.550000] 0 pages swap cached


[ 1140.290000] SysRq : Show Regs
[ 1140.290000] 
[ 1140.290000] Pid: 0, comm:????????????? swapper
[ 1140.290000] CPU: 0??? Not tainted? (2.6.31.1-XXXX #86)
[ 1140.290000] PC is at default_idle+0x24/0x2c
[ 1140.290000] LR is at default_idle+0x20/0x2c
[ 1140.290000] pc : [<c002c5e0>]??? lr : [<c002c5dc>]??? psr: 60000013
[ 1140.290000] sp : c0349fb8? ip : c0349f58? fp : 00000000
[ 1140.290000] r10: c0023000? r9 : c0023dc0? r8 : c0370804
[ 1140.290000] r7 : 0048c000? r6 : c04ac000? r5 : c036b618? r4 : c0348000
[ 1140.290000] r3 : 00000000? r2 : c0348000? r1 : 00000000? r0 : c02e60a4
[ 1140.290000] Flags: nZCv? IRQs on? FIQs on? Mode SVC_32? ISA ARM? Segment kernel
[ 1140.290000] Control: 00c5787d? Table: 0241c00a? DAC: 00000017


[ 1144.710000] SysRq : Show clockevent devices & pending hrtimers (no others)
[ 1144.710000] Timer List Version: v0.4
[ 1144.710000] HRTIMER_MAX_CLOCK_BASES: 2
[ 1144.710000] now at 1144710000002 nsecs
[ 1144.710000] 
[ 1144.710000] cpu: 0
[ 1144.710000]? clock 0:
[ 1144.710000]?? .base:?????? c04a6318
[ 1144.710000]?? .index:????? 0
[ 1144.710000]?? .resolution: 10000000 nsecs
[ 1144.710000]?? .get_time:?? ktime_get_real
[ 1144.710000] active timers:
[ 1144.710000]? clock 1:
[ 1144.710000]?? .base:?????? c04a6340
[ 1144.710000]?? .index:????? 1
[ 1144.710000]?? .resolution: 10000000 nsecs
[ 1144.710000]?? .get_time:?? ktime_get
[ 1144.710000] active timers:
[ 1144.710000]? #0: <c2459f10>, hrtimer_wakeup, S:01, <(null)>, /-1
[ 1144.710000]? # expires at 1148370000002-1148370050002 nsecs [in 3660000000 to 3660050000 nsecs]
[ 1144.710000] 
[ 1144.710000] cpu: 1
[ 1144.710000]? clock 0:
[ 1144.710000]?? .base:?????? c04a9318
[ 1144.710000]?? .index:????? 0
[ 1144.710000]?? .resolution: 10000000 nsecs
[ 1144.710000]?? .get_time:?? ktime_get_real
[ 1144.710000] active timers:
[ 1144.710000]? clock 1:
[ 1144.710000]?? .base:?????? c04a9340
[ 1144.710000]?? .index:????? 1
[ 1144.710000]?? .resolution: 10000000 nsecs
[ 1144.710000]?? .get_time:?? ktime_get
[ 1144.710000] active timers:
[ 1144.710000]? #0: <c0ecff10>, hrtimer_wakeup, S:01, <(null)>, /-1
[ 1144.710000]? # expires at 1145510000002-1145510050002 nsecs [in 800000000 to 800050000 nsecs]
[ 1144.710000] 
[ 1144.710000] 
[ 1144.710000] Tick Device: mode:???? 0
[ 1144.710000] Per CPU device: 0
[ 1144.710000] Clock Event Device: local_timer
[ 1144.710000]? max_delta_ns:?? 2147483647
[ 1144.710000]? min_delta_ns:?? 1000
[ 1144.710000]? mult:?????????? 317736
[ 1144.710000]? shift:????????? 20
[ 1144.710000]? mode:?????????? 2
[ 1144.710000]? next_event:???? 2147483646999999999 nsecs
[ 1144.710000]? set_next_event: twd_set_next_event
[ 1144.710000]? set_mode:?????? twd_set_mode
[ 1144.710000]? event_handler:? tick_handle_periodic
[ 1144.710000] 
[ 1144.710000] Tick Device: mode:???? 0
[ 1144.710000] Per CPU device: 1
[ 1144.710000] Clock Event Device: local_timer
[ 1144.710000]? max_delta_ns:?? 2147483647
[ 1144.710000]? min_delta_ns:?? 1000
[ 1144.710000]? mult:?????????? 317736
[ 1144.710000]? shift:????????? 20
[ 1144.710000]? mode:?????????? 2
[ 1144.710000]? next_event:???? 2147483646999999999 nsecs
[ 1144.710000]? set_next_event: twd_set_next_event
[ 1144.710000]? set_mode:?????? twd_set_mode
[ 1144.710000]? event_handler:? tick_handle_periodic
[ 1144.710000] 


[ 1148.080000] SysRq : Show State
[ 1148.080000]?? task??????????????? PC stack?? pid father
[ 1148.080000] linuxrc?????? S c0279a58???? 0???? 1????? 0 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0049788>] (do_wait+0x19c/0x27c)
[ 1148.080000] [<c0049788>] (do_wait+0x19c/0x27c) from [<c0049904>] (sys_wait4+0x9c/0xb4)
[ 1148.080000] [<c0049904>] (sys_wait4+0x9c/0xb4) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)
[ 1148.080000] kthreadd????? S c0279a58???? 0???? 2????? 0 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c005af04>] (kthreadd+0x7c/0x128)
[ 1148.080000] [<c005af04>] (kthreadd+0x7c/0x128) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] migration/0?? S c0279a58???? 0???? 3????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0041bf4>] (migration_thread+0x204/0x3a4)
[ 1148.080000] [<c0041bf4>] (migration_thread+0x204/0x3a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] ksoftirqd/0?? S c0279a58???? 0???? 4????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c004be0c>] (ksoftirqd+0x58/0x11c)
[ 1148.080000] [<c004be0c>] (ksoftirqd+0x58/0x11c) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] watchdog/0??? S c0279a58???? 0???? 5????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0071b64>] (watchdog+0x4c/0x94)
[ 1148.080000] [<c0071b64>] (watchdog+0x4c/0x94) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] migration/1?? S c0279a58???? 0???? 6????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0041bf4>] (migration_thread+0x204/0x3a4)
[ 1148.080000] [<c0041bf4>] (migration_thread+0x204/0x3a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] ksoftirqd/1?? S c0279a58???? 0???? 7????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c004be0c>] (ksoftirqd+0x58/0x11c)
[ 1148.080000] [<c004be0c>] (ksoftirqd+0x58/0x11c) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] watchdog/1??? S c0279a58???? 0???? 8????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0071b64>] (watchdog+0x4c/0x94)
[ 1148.080000] [<c0071b64>] (watchdog+0x4c/0x94) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] events/0????? S c0279a58???? 0???? 9????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0057d7c>] (worker_thread+0x80/0x1a4)
[ 1148.080000] [<c0057d7c>] (worker_thread+0x80/0x1a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] events/1????? S c0279a58???? 0??? 10????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0057d7c>] (worker_thread+0x80/0x1a4)
[ 1148.080000] [<c0057d7c>] (worker_thread+0x80/0x1a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] khelper?????? S c0279a58???? 0??? 11????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0057d7c>] (worker_thread+0x80/0x1a4)
[ 1148.080000] [<c0057d7c>] (worker_thread+0x80/0x1a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] async/mgr???? S c0279a58???? 0??? 15????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0060bd0>] (async_manager_thread+0xc4/0x100)
[ 1148.080000] [<c0060bd0>] (async_manager_thread+0xc4/0x100) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] kblockd/0???? S c0279a58???? 0?? 100????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0057d7c>] (worker_thread+0x80/0x1a4)
[ 1148.080000] [<c0057d7c>] (worker_thread+0x80/0x1a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] kblockd/1???? S c0279a58???? 0?? 101????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0057d7c>] (worker_thread+0x80/0x1a4)
[ 1148.080000] [<c0057d7c>] (worker_thread+0x80/0x1a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] khubd???????? S c0279a58???? 0?? 111????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c01ac40c>] (hub_thread+0xd70/0xed0)
[ 1148.080000] [<c01ac40c>] (hub_thread+0xd70/0xed0) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] kmmcd???????? S c0279a58???? 0?? 114????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0057d7c>] (worker_thread+0x80/0x1a4)
[ 1148.080000] [<c0057d7c>] (worker_thread+0x80/0x1a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] kslowd??????? S c0279a58???? 0?? 123????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0075f04>] (slow_work_thread+0xc0/0x50c)
[ 1148.080000] [<c0075f04>] (slow_work_thread+0xc0/0x50c) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] kslowd??????? S c0279a58???? 0?? 124????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0075f04>] (slow_work_thread+0xc0/0x50c)
[ 1148.080000] [<c0075f04>] (slow_work_thread+0xc0/0x50c) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] khungtaskd??? S c0279a58???? 0?? 141????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0279e3c>] (schedule_timeout+0x16c/0x1b8)
[ 1148.080000] [<c0279e3c>] (schedule_timeout+0x16c/0x1b8) from [<c0071bf8>] (watchdog+0x34/0x210)
[ 1148.080000] [<c0071bf8>] (watchdog+0x34/0x210) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] pdflush?????? S c0279a58???? 0?? 142????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c007ee48>] (pdflush+0xd4/0x23c)
[ 1148.080000] [<c007ee48>] (pdflush+0xd4/0x23c) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] pdflush?????? S c0279a58???? 0?? 143????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c007ee48>] (pdflush+0xd4/0x23c)
[ 1148.080000] [<c007ee48>] (pdflush+0xd4/0x23c) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] kswapd0?????? S c0279a58???? 0?? 144????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0083050>] (kswapd+0xbc/0x4bc)
[ 1148.080000] [<c0083050>] (kswapd+0xbc/0x4bc) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] aio/0???????? S c0279a58???? 0?? 145????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0057d7c>] (worker_thread+0x80/0x1a4)
[ 1148.080000] [<c0057d7c>] (worker_thread+0x80/0x1a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] aio/1???????? S c0279a58???? 0?? 146????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0057d7c>] (worker_thread+0x80/0x1a4)
[ 1148.080000] [<c0057d7c>] (worker_thread+0x80/0x1a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] crypto/0????? S c0279a58???? 0?? 147????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0057d7c>] (worker_thread+0x80/0x1a4)
[ 1148.080000] [<c0057d7c>] (worker_thread+0x80/0x1a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] crypto/1????? S c0279a58???? 0?? 148????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0057d7c>] (worker_thread+0x80/0x1a4)
[ 1148.080000] [<c0057d7c>] (worker_thread+0x80/0x1a4) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] mtdblockd???? S c0279a58???? 0?? 290????? 2 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c019fa20>] (mtd_blktrans_thread+0x7c/0x2d0)
[ 1148.080000] [<c019fa20>] (mtd_blktrans_thread+0x7c/0x2d0) from [<c005b02c>] (kthread+0x7c/0x84)
[ 1148.080000] [<c005b02c>] (kthread+0x7c/0x84) from [<c002c058>] (kernel_thread_exit+0x0/0x8)
[ 1148.080000] udevd???????? S c0279a58???? 0?? 315????? 1 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c027a82c>] (schedule_hrtimeout_range+0x44/0x164)
[ 1148.080000] [<c027a82c>] (schedule_hrtimeout_range+0x44/0x164) from [<c00a6c34>] (poll_schedule_timeout+0x3c/0x64)
[ 1148.080000] [<c00a6c34>] (poll_schedule_timeout+0x3c/0x64) from [<c00a7334>] (do_select+0x184/0x4c8)
[ 1148.080000] [<c00a7334>] (do_select+0x184/0x4c8) from [<c00a7898>] (core_sys_select+0x220/0x2e4)
[ 1148.080000] [<c00a7898>] (core_sys_select+0x220/0x2e4) from [<c00a7a20>] (sys_select+0xc4/0x1c4)
[ 1148.080000] [<c00a7a20>] (sys_select+0xc4/0x1c4) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)
[ 1148.080000] smbd????????? S c0279a58???? 0?? 339????? 1 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c027a82c>] (schedule_hrtimeout_range+0x44/0x164)
[ 1148.080000] [<c027a82c>] (schedule_hrtimeout_range+0x44/0x164) from [<c00a6c34>] (poll_schedule_timeout+0x3c/0x64)
[ 1148.080000] [<c00a6c34>] (poll_schedule_timeout+0x3c/0x64) from [<c00a7334>] (do_select+0x184/0x4c8)
[ 1148.080000] [<c00a7334>] (do_select+0x184/0x4c8) from [<c00a7898>] (core_sys_select+0x220/0x2e4)
[ 1148.080000] [<c00a7898>] (core_sys_select+0x220/0x2e4) from [<c00a7a20>] (sys_select+0xc4/0x1c4)
[ 1148.080000] [<c00a7a20>] (sys_select+0xc4/0x1c4) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)
[ 1148.080000] nmbd????????? S c0279a58???? 0?? 341????? 1 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c027aa04>] (do_nanosleep+0xac/0x108)
[ 1148.080000] [<c027aa04>] (do_nanosleep+0xac/0x108) from [<c005e418>] (hrtimer_nanosleep+0x8c/0x100)
[ 1148.080000] [<c005e418>] (hrtimer_nanosleep+0x8c/0x100) from [<c005e520>] (sys_nanosleep+0x94/0xb0)
[ 1148.080000] [<c005e520>] (sys_nanosleep+0x94/0xb0) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)
[ 1148.080000] getty???????? S c0279a58???? 0?? 344????? 1 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0279cec>] (schedule_timeout+0x1c/0x1b8)
[ 1148.080000] [<c0279cec>] (schedule_timeout+0x1c/0x1b8) from [<c0169168>] (n_tty_read+0x36c/0x5fc)
[ 1148.080000] [<c0169168>] (n_tty_read+0x36c/0x5fc) from [<c0166210>] (tty_read+0x80/0xc8)
[ 1148.080000] [<c0166210>] (tty_read+0x80/0xc8) from [<c009968c>] (vfs_read+0xac/0x158)
[ 1148.080000] [<c009968c>] (vfs_read+0xac/0x158) from [<c0099a80>] (sys_read+0x3c/0x68)
[ 1148.080000] [<c0099a80>] (sys_read+0x3c/0x68) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)
[ 1148.080000] smbd????????? S c0279a58???? 0?? 345??? 339 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c027a82c>] (schedule_hrtimeout_range+0x44/0x164)
[ 1148.080000] [<c027a82c>] (schedule_hrtimeout_range+0x44/0x164) from [<c00a6c34>] (poll_schedule_timeout+0x3c/0x64)
[ 1148.080000] [<c00a6c34>] (poll_schedule_timeout+0x3c/0x64) from [<c00a7334>] (do_select+0x184/0x4c8)
[ 1148.080000] [<c00a7334>] (do_select+0x184/0x4c8) from [<c00a7898>] (core_sys_select+0x220/0x2e4)
[ 1148.080000] [<c00a7898>] (core_sys_select+0x220/0x2e4) from [<c00a7a20>] (sys_select+0xc4/0x1c4)
[ 1148.080000] [<c00a7a20>] (sys_select+0xc4/0x1c4) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)
[ 1148.080000] getty???????? S c0279a58???? 0?? 346????? 1 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0279cec>] (schedule_timeout+0x1c/0x1b8)
[ 1148.080000] [<c0279cec>] (schedule_timeout+0x1c/0x1b8) from [<c0169168>] (n_tty_read+0x36c/0x5fc)
[ 1148.080000] [<c0169168>] (n_tty_read+0x36c/0x5fc) from [<c0166210>] (tty_read+0x80/0xc8)
[ 1148.080000] [<c0166210>] (tty_read+0x80/0xc8) from [<c009968c>] (vfs_read+0xac/0x158)
[ 1148.080000] [<c009968c>] (vfs_read+0xac/0x158) from [<c0099a80>] (sys_read+0x3c/0x68)
[ 1148.080000] [<c0099a80>] (sys_read+0x3c/0x68) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)
[ 1148.080000] syslogd?????? S c0279a58???? 0?? 350????? 1 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0279cec>] (schedule_timeout+0x1c/0x1b8)
[ 1148.080000] [<c0279cec>] (schedule_timeout+0x1c/0x1b8) from [<c01d7824>] (__skb_recv_datagram+0x1dc/0x270)
[ 1148.080000] [<c01d7824>] (__skb_recv_datagram+0x1dc/0x270) from [<c01d78d8>] (skb_recv_datagram+0x20/0x28)
[ 1148.080000] [<c01d78d8>] (skb_recv_datagram+0x20/0x28) from [<c0243ef4>] (unix_dgram_recvmsg+0x50/0x21c)
[ 1148.080000] [<c0243ef4>] (unix_dgram_recvmsg+0x50/0x21c) from [<c01ccbec>] (sock_aio_read+0xdc/0xe4)
[ 1148.080000] [<c01ccbec>] (sock_aio_read+0xdc/0xe4) from [<c0098d70>] (do_sync_read+0xa8/0xf8)
[ 1148.080000] [<c0098d70>] (do_sync_read+0xa8/0xf8) from [<c00996a4>] (vfs_read+0xc4/0x158)
[ 1148.080000] [<c00996a4>] (vfs_read+0xc4/0x158) from [<c0099a80>] (sys_read+0x3c/0x68)
[ 1148.080000] [<c0099a80>] (sys_read+0x3c/0x68) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)
[ 1148.080000] klogd???????? S c0279a58???? 0?? 353????? 1 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0047e98>] (do_syslog+0x12c/0x458)
[ 1148.080000] [<c0047e98>] (do_syslog+0x12c/0x458) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)
[ 1148.080000] tail????????? S c0279a58???? 0?? 354????? 1 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c027aa04>] (do_nanosleep+0xac/0x108)
[ 1148.080000] [<c027aa04>] (do_nanosleep+0xac/0x108) from [<c005e418>] (hrtimer_nanosleep+0x8c/0x100)
[ 1148.080000] [<c005e418>] (hrtimer_nanosleep+0x8c/0x100) from [<c005e520>] (sys_nanosleep+0x94/0xb0)
[ 1148.080000] [<c005e520>] (sys_nanosleep+0x94/0xb0) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)
[ 1148.080000] sh??????????? S c0279a58???? 0?? 359????? 1 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0049788>] (do_wait+0x19c/0x27c)
[ 1148.080000] [<c0049788>] (do_wait+0x19c/0x27c) from [<c0049904>] (sys_wait4+0x9c/0xb4)
[ 1148.080000] [<c0049904>] (sys_wait4+0x9c/0xb4) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)
[ 1148.080000] rmmod???????? S c0279a58???? 0? 1737??? 359 0x00000000
[ 1148.080000] [<c0279a58>] (schedule+0x680/0x744) from [<c0167d74>] (n_tty_write+0x300/0x394)
[ 1148.080000] [<c0167d74>] (n_tty_write+0x300/0x394) from [<c0165420>] (tty_write+0x190/0x234)
[ 1148.080000] [<c0165420>] (tty_write+0x190/0x234) from [<c0099534>] (vfs_write+0xb0/0x15c)
[ 1148.080000] [<c0099534>] (vfs_write+0xb0/0x15c) from [<c0099ae8>] (sys_write+0x3c/0x68)
[ 1148.080000] [<c0099ae8>] (sys_write+0x3c/0x68) from [<c002afc0>] (ret_fast_syscall+0x0/0x2c)


[ 1151.450000] SysRq : Show Blocked State
[ 1151.450000]?? task??????????????? PC stack?? pid father






 		 	   		  
_________________________________________________________________
Windows Live: Friends get your Flickr, Yelp, and Digg updates when they e-mail you.
http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_3:092010
