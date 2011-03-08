From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 8 Mar 2011 11:53:06 +0200
Subject: SMP soft lockup on smp_call_function_many when doing flush_tlb_page
Message-ID: <AANLkTimk6zmQNdZaVaxDbd5Ff+75RERhrxgmsbM55vs1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
    The lockup below happens on my SMP system that doesn't support hw
tlb broadcast.
    after some debug I found that the mask inside
smp_call_function_many() which points to mm_cpumask, get changed
asynchronously, apparently by reset_context() that called from IPI
that was issued by another cpu.
    when I disable interrupts in smp_call_function_many around the
code that uses the mask, the issue disappears.
    also, reverting the patch "ARM: 5905/1: ARM: Global ASID
allocation on SMP" eliminates this specific bug.



BUG: soft lockup - CPU#0 stuck for 61s! [aptitude:1721]
Modules linked in:
Pid: 1721, comm:             aptitude
CPU: 0    Not tainted  (2.6.35.9-00005-g106dd76 #4)
PC is at csd_lock_wait+0x14/0x28
LR is at smp_call_function_many+0x1f0/0x21c
pc : [<c01b70d8>]    lr : [<c01b7804>]    psr: 20000113
sp : e19b5d30  ip : e19b5d40  fp : e19b5d3c
r10: c05560e0  r9 : 00da3000  r8 : 00000001
r7 : c002ea00  r6 : c0dd1a00  r5 : 00000000  r4 : c0dd1a18
r3 : 00000000  r2 : 00000e00  r1 : 00000004  r0 : c0dd1a00
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387d  Table: 21b6001a  DAC: 00000015
[<c014e5c0>] (show_regs+0x0/0x50) from [<c01bdc64>] (softlockup_tick+0x160/0x1c8
)
 r4:e19b5ce8 r3:c002db44
[<c01bdb04>] (softlockup_tick+0x0/0x1c8) from [<c019c330>] (run_local_timers+0x1
c/0x20)
[<c019c314>] (run_local_timers+0x0/0x20) from [<c019c368>] (update_process_times
+0x34/0x58)
[<c019c334>] (update_process_times+0x0/0x58) from [<c01b33d4>] (tick_periodic+0x
e8/0x114)
 r6:c0dd0050 r5:c05a3dc0 r4:c0dd0050 r3:20000113
[<c01b32ec>] (tick_periodic+0x0/0x114) from [<c01b342c>] (tick_handle_periodic+0
x2c/0xd4)
[<c01b3400>] (tick_handle_periodic+0x0/0xd4) from [<c01529cc>] (ipi_timer+0x3c/0
x4c)
 r7:c002ea00 r6:80000020 r5:c05a3dc0 r4:c0dd0050
[<c0152990>] (ipi_timer+0x0/0x4c) from [<c002f3fc>] (do_local_timer+0x58/0x88)
 r4:00000000 r3:00003687
[<c002f3a4>] (do_local_timer+0x0/0x88) from [<c0043f74>] (__irq_svc+0x34/0x100)
Exception stack(0xe19b5ce8 to 0xe19b5d30)
5ce0:                   c0dd1a00 00000004 00000e00 00000000 c0dd1a18 00000000
5d00: c0dd1a00 c002ea00 00000001 00da3000 c05560e0 e19b5d3c e19b5d40 e19b5d30
5d20: c01b7804 c01b70d8 20000113 ffffffff
 r5:fbb21000 r4:ffffffff
[<c01b70c4>] (csd_lock_wait+0x0/0x28) from [<c01b7804>] (smp_call_function_many+
0x1f0/0x21c)
[<c01b7614>] (smp_call_function_many+0x0/0x21c) from [<c0152bac>] (T.319+0x2c/0x
6c)
[<c0152b80>] (T.319+0x0/0x6c) from [<c0152ca8>] (flush_tlb_page+0x40/0xa4)
 r6:41fb1000 r5:e1b906a8 r4:00000000 r3:00000000
[<c0152c68>] (flush_tlb_page+0x0/0xa4) from [<c01e653c>] (do_wp_page+0x3c0/0x7cc
)
[<c01e617c>] (do_wp_page+0x0/0x7cc) from [<c01e735c>] (handle_mm_fault+0x6e4/0x7
a8)
[<c01e6c78>] (handle_mm_fault+0x0/0x7a8) from [<c0046014>] (do_page_fault+0x130/
0x2f8)
[<c0045ee4>] (do_page_fault+0x0/0x2f8) from [<c002f590>] (do_DataAbort+0x3c/0xa0
)
[<c002f554>] (do_DataAbort+0x0/0xa0) from [<c00443c4>] (ret_from_exception+0x0/0
x10)
