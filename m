From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 25 Aug 2015 22:06:49 +0800
Subject: ask for help about BUG: soft lockup - CPU#13 stuck for 22s!
 [trinity-c13:6691]
Message-ID: <55DC7679.5090707@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

We got issues about rcu/ soft lockup in trinity test on our arm64 board,
and have no idea to fix this, any advice will be appreciated.

Our board test environment:
1) Kernel version: 3.19.0/3.19.8/4.1.0/4.1.6
2) Hardware: 32cpu, 128G memory
3) CONFIG: based on defconfig, use CONFIG_PREEMPT_NONE=y
4) TEST:  'trinity --dangerous' use root (trinity version 1.5)


And we met rcu/soft lockup once in qemu environment,
1) Qemu:  2.4.0   cpu 8, mem 30G
2) Kernel version: 4.1
3) CONFIG: same as board
3) TEST: same as board

log[1]: logging pieces in board
------------------------------------------------------------------

[ 3430.085690] INFO: rcu_sched self-detected stall on CPU { 13}  (t=21006 jiffies g=10664 c=10663 q=2837)
[ 3430.093697] INFO: rcu_sched detected stalls on CPUs/tasks: { 13} (detected by 16, t=21007 jiffies, g=10664, c=10663, q=2837)
[ 3430.093698] Task dump for CPU 13:
[ 3430.093701] trinity-c13     R  running task        0  6691   6001 0x00000003
[ 3430.093702] Call trace:
[ 3430.093709] [<ffffffc000087438>] __switch_to+0x74/0x8c
[ 3430.104867] Task dump for CPU 13:
[ 3430.104868] trinity-c13     R  running task        0  6691   6001 0x00000003
[ 3430.104872] Call trace:
[ 3430.106019] [<ffffffc00008a1d0>] dump_backtrace+0x0/0x124
[ 3430.106022] [<ffffffc00008a304>] show_stack+0x10/0x1c
[ 3430.106026] [<ffffffc0000d4c4c>] sched_show_task+0x98/0xf8
[ 3430.106030] [<ffffffc0000d7d74>] dump_cpu_task+0x3c/0x4c
[ 3430.106033] [<ffffffc0000f61ac>] rcu_dump_cpu_stacks+0xa4/0xf8
[ 3430.106035] [<ffffffc0000f91cc>] rcu_check_callbacks+0x3d4/0x6a4
[ 3430.106039] [<ffffffc0000fc788>] update_process_times+0x38/0x6c
[ 3430.106042] [<ffffffc00010af34>] tick_sched_handle.isra.16+0x1c/0x68
[ 3430.106044] [<ffffffc00010afc0>] tick_sched_timer+0x40/0x88
[ 3430.106047] [<ffffffc0000fce64>] __run_hrtimer.isra.34+0x4c/0x108
[ 3430.106050] [<ffffffc0000fd53c>] hrtimer_interrupt+0x100/0x2ac
[ 3430.106054] [<ffffffc000594074>] arch_timer_handler_phys+0x28/0x38
[ 3430.106058] [<ffffffc0000f0668>] handle_percpu_devid_irq+0x74/0x9c
[ 3430.106060] [<ffffffc0000ec638>] generic_handle_irq+0x30/0x4c
[ 3430.106062] [<ffffffc0000ec954>] __handle_domain_irq+0x5c/0xac
[ 3430.106065] [<ffffffc0000824f4>] gic_handle_irq+0x88/0xf8
[ 3430.106067] Exception stack(0xffffffdf84c97940 to 0xffffffdf84c97a60)
[ 3430.106070] 7940: 84c97cf0 ffffffdf b46e1d40 ffffffdf 84c97a90 ffffffdf 00162930 ffffffc0
[ 3430.106073] 7960: 80000145 00000000 96000047 00000000 b0aa0228 ffffffdf 7db41000 0000007f
[ 3430.106075] 7980: b0aa0228 ffffffdf 79e422d8 ffffffdf 79e422e8 ffffffdf 7dc0f000 0000007f
[ 3430.106077] 79a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[ 3430.106080] 79c0: 7f7f7f7f 7f7f7f7f 01010101 01010101 00000018 00000000 66666566 66666466
[ 3430.106083] 79e0: 66653766 74202c66 b7ef7529 00091372 000fedf0 ffffffc0 7e5a1ce0 0000007f
[ 3430.106085] 7a00: 00000000 00000000 84c97cf0 ffffffdf b46e1d40 ffffffdf 00000029 00000000
[ 3430.106087] 7a20: 79e42040 ffffffdf 7db41000 0000007f 96000047 00000000 dfff7eff ffffefff
[ 3430.106090] 7a40: 00000002 00000000 b78872c0 ffffffdf b46e1da0 ffffffdf 84c97a90 ffffffdf
[ 3430.106092] [<ffffffc000085da4>] el1_irq+0x64/0xc0
[ 3430.106095] [<ffffffc000096e50>] do_page_fault+0xa4/0x350
[ 3430.106097] [<ffffffc000082294>] do_mem_abort+0x38/0x9c
[ 3430.106098] Exception stack(0xffffffdf84c97c50 to 0xffffffdf84c97d70)
[ 3430.106101] 7c40:                                     48778d1f ffffffdf 00000009 00000000
[ 3430.106103] 7c60: 84c97e10 ffffffdf 0030a74c ffffffc0 00000009 00000000 84c97e10 ffffffdf
[ 3430.106106] 7c80: 0030a74c ffffffc0 60000145 00000000 00000025 00000000 dfff7eff ffffefff
[ 3430.106108] 7ca0: 78a260d8 ffffffdf b78872c0 ffffffdf 009ff100 ffffffc0 84c97e10 ffffffdf
[ 3430.106111] 7cc0: 000ff0dc ffffffc0 84c97cf0 ffffffdf 00085c20 ffffffc0 60000145 00000000
[ 3430.106113] 7ce0: 60000145 00000000 009ffd00 ffffffc0 7db41000 0000007f 84c97e90 ffffffdf
[ 3430.106116] 7d00: fffffffc ffffffff 00000009 00000000 7db41004 0000007f 00000009 00000000
[ 3430.106118] 7d20: 00000073 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[ 3430.106121] 7d40: 7f7f7f7f 7f7f7f7f 01010101 01010101 00000018 00000000 66666566 66666466
[ 3430.106123] 7d60: 66653766 74202c66 b7ef7529 00091372
[ 3430.106125] [<ffffffc000085c24>] el1_da+0x14/0x70
[ 3456.373558] NMI watchdog: BUG: soft lockup - CPU#13 stuck for 22s! [trinity-c13:6691]
[ 3456.380109] Modules linked in: ipmi_si ipmi_devintf ipmi_msghandler

[ 3456.380116] CPU: 13 PID: 6691 Comm: trinity-c13 Tainted: G             L  3.19.8+ #48

[ 3456.380120] task: ffffffdf79e42040 ti: ffffffdf84c94000 task.ti: ffffffdf84c94000
[ 3456.380122] PC is at handle_mm_fault+0x35c/0xdb8
[ 3456.380124] LR is at handle_mm_fault+0x350/0xdb8
[ 3456.380126] pc : [<ffffffc00015f7b8>] lr : [<ffffffc00015f7ac>] pstate: 60000145
[ 3456.380127] sp : ffffffdf84c97a00
[ 3456.380129] x29: ffffffdf84c97a00 x28: ffffffc00098c000
[ 3456.380132] x27: ffffffdfb0aa0228 x26: 00000000000001ed
[ 3456.380134] x25: ffffffbe3ed19ab0 x24: 0000007f7db41000
[ 3456.380137] x23: 0d34000007f7db41 x22: ffffffdf85bd9f68
[ 3456.380140] x21: ffffffdfb46e1d40 x20: ffffffdfb446a000
[ 3456.380142] x19: ffffffbe3ed19a80 x18: 0000000000000000
[ 3456.380145] x17: 0000007f7e5a1ce0 x16: ffffffc0000fedf0
[ 3456.380147] x15: 00091372b7ef7529 x14: 74202c6666653766
[ 3456.380150] x13: 6666646666666566 x12: 0000000000000018
[ 3456.380152] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[ 3456.380155] x9 : 0000000000000000 x8 : 0000000007f7db41
[ 3456.380157] x7 : 0000000000000141 x6 : 02e0002fa95c6751
[ 3456.380160] x5 : 0000000000000a08 x4 : 02e0002fa95c6751
[ 3456.380162] x3 : 02e0002fa95c6751 x2 : ffffffdfb446aa08
[ 3456.380165] x1 : 0000007f7db41000 x0 : 0000000000010d34

[ 3484.373416] NMI watchdog: BUG: soft lockup - CPU#13 stuck for 23s! [trinity-c13:6691]
[ 3484.379975] CPU: 13 PID: 6691 Comm: trinity-c13 Tainted: G             L  3.19.8+ #48
[ 3484.379979] task: ffffffdf79e42040 ti: ffffffdf84c94000 task.ti: ffffffdf84c94000
[ 3484.379981] PC is at handle_mm_fault+0x35c/0xdb8
[ 3484.379983] LR is at handle_mm_fault+0x350/0xdb8
[ 3484.379985] pc : [<ffffffc00015f7b8>] lr : [<ffffffc00015f7ac>] pstate: 60000145
[ 3484.379986] sp : ffffffdf84c97a00
[ 3484.379988] x29: ffffffdf84c97a00 x28: ffffffc00098c000
[ 3484.379990] x27: ffffffdfb0aa0228 x26: 00000000000001ed
[ 3484.379993] x25: ffffffbe3ed19ab0 x24: 0000007f7db41000
[ 3484.379996] x23: 0d34000007f7db41 x22: ffffffdf85bd9f68
[ 3484.379998] x21: ffffffdfb46e1d40 x20: ffffffdfb446a000
[ 3484.380001] x19: ffffffbe3ed19a80 x18: 0000000000000000
[ 3484.380003] x17: 0000007f7e5a1ce0 x16: ffffffc0000fedf0
[ 3484.380006] x15: 00091372b7ef7529 x14: 74202c6666653766
[ 3484.380008] x13: 6666646666666566 x12: 0000000000000018
[ 3484.380011] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[ 3484.380013] x9 : 0000000000000000 x8 : 0000000007f7db41
[ 3484.380016] x7 : 0000000000000141 x6 : 02e0002fa95c6751
[ 3484.380018] x5 : 0000000000000a08 x4 : 02e0002fa95c6751
[ 3484.380021] x3 : 02e0002fa95c6751 x2 : ffffffdfb446aa08
[ 3484.380024] x1 : 0000007f7db41000 x0 : 0000000000010d34



log[2]: logging pieces in QEMU
------------------------------------------------------------------
[ 9720.804545] INFO: rcu_sched detected stalls on CPUs/tasks:
[ 9720.807407] 	0: (166 ticks this GP) idle=cab/140000000000000/0 softirq=114221/114221 fqs=38
[ 9720.808447] 	(detected by 3, t=2102 jiffies, g=84925, c=84924, q=114)
[ 9720.809416] Task dump for CPU 0:
[ 9720.809768] ksoftirqd/0     R  running task        0     3      2 0x00000002
[ 9720.812007] Call trace:
[ 9720.813325] [<ffffffc000086c5c>] __switch_to+0x74/0x8c
[ 9724.041575] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksoftirqd/0:3]
[ 9724.044976] Modules linked in:

[ 9724.047586] CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted 4.1.0 #3
[ 9724.050050] Hardware name: linux,dummy-virt (DT)
[ 9724.050886] NMI watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [trinity-main:1331]
[ 9724.050991] Modules linked in:

[ 9724.051589] CPU: 1 PID: 1331 Comm: trinity-main Not tainted 4.1.0 #3
[ 9724.051610] Hardware name: linux,dummy-virt (DT)
[ 9724.051729] task: ffffffc75db44200 ti: ffffffc755a54000 task.ti: ffffffc755a54000
[ 9724.051888] PC is at run_hrtimer_softirq+0x1c/0x28
[ 9724.051951] LR is at run_hrtimer_softirq+0x18/0x28
[ 9724.052004] pc : [<ffffffc0000fec5c>] lr : [<ffffffc0000fec58>] pstate: 20000145
[ 9724.052033] sp : ffffffc755a57b80
[ 9724.052152] x29: ffffffc755a57b80 x28: 0000000000000000
[ 9724.052211] x27: ffffffc00084a140 x26: ffffffc00084a110
[ 9724.052258] x25: 0000000000000008 x24: 0000000000000100
[ 9724.052304] x23: 0000000000000030 x22: ffffffc755a57ba0
[ 9724.052352] x21: ffffffc000837ab8 x20: ffffffc00084a000
[ 9724.052407] x19: 0000000000000140 x18: 0000007fdf417090
[ 9724.052453] x17: 0000007f7e3ae2c0 x16: ffffffc0000b6104
[ 9724.052497] x15: 0000000000005d67 x14: 0000000000000000
[ 9724.052540] x13: 00000000696e695b x12: ffffffc0005bd43c
[ 9724.052583] x11: 0000000000000005 x10: 0000000000000533
[ 9724.052621] x9 : 0000000000000004 x8 : ffffffc0005bd460
[ 9724.052660] x7 : ffffffc755a54000 x6 : 00119557c0000000
[ 9724.052700] x5 : 0000000010000000 x4 : 0000000000000020
[ 9724.052739] x3 : ffffffc0004b2634 x2 : 00000000000003e8
[ 9724.052779] x1 : 0000000000000001 x0 : 0000000000000000

[ 9724.410042] task: ffffffc75e871600 ti: ffffffc75e994000 task.ti: ffffffc75e994000
[ 9724.483895] PC is at _raw_read_lock+0x8/0x20
[ 9724.485252] LR is at raw_local_deliver+0x48/0x1b0
[ 9724.485939] pc : [<ffffffc0005aa7f4>] lr : [<ffffffc0005437ec>] pstate: a0000145
[ 9724.486792] sp : ffffffc75e997a40
[ 9724.487214] x29: ffffffc75e997a40 x28: ffffffc74e174600
[ 9724.488052] x27: 0000000000000000 x26: 0000000000000000
[ 9724.488854] x25: 000000000000a888 x24: ffffffc7562d20a0
[ 9724.489679] x23: ffffffc0008db000 x22: ffffffc0008a1000
[ 9724.490462] x21: ffffffc0008db578 x20: ffffffc74e174600
[ 9724.491294] x19: ffffffc6af86f990 x18: 00000000000000b9
[ 9724.492142] x17: 0000007fb0630120 x16: ffffffc000196244
[ 9724.555949] x15: 001dcd6500000000 x14: 0000000000000000
[ 9724.556187] x13: 00000000a15d7a92 x12: 0000000000000020
[ 9724.556410] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[ 9724.556629] x9 : fefefefefefefeff x8 : 0000000000000000
[ 9724.556816] x7 : 0000000000000004 x6 : 0000000000000000
[ 9724.557006] x5 : 0000000000000005 x4 : ffffffc756130000
[ 9724.557198] x3 : ffffffc0008db548 x2 : ffffffc0ba9bc7b8
[ 9724.557393] x1 : 0000000000000050 x0 : ffffffc0008db548

Thanks,
Kefeng
