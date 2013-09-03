From: jochen.armkernel@leahnim.org (Jochen De Smet)
Date: Tue, 03 Sep 2013 13:39:17 -0400
Subject: Unhandled prefetch abort on mirabox with 3.11-rc7
In-Reply-To: <20130903181428.150556af@skate>
References: <52253229.2050103@leahnim.org>
 <20130903104817.GE19598@titan.lakedaemon.net>
 <20130903155537.GI6617@n2100.arm.linux.org.uk> <52260977.9090103@leahnim.org>
 <20130903181428.150556af@skate>
Message-ID: <52261EC5.5020908@leahnim.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/3/2013 12:14, Thomas Petazzoni wrote:
> Dear Jochen De Smet,
>
> On Tue, 03 Sep 2013 12:08:23 -0400, Jochen De Smet wrote:
>
>>>>> Keep on posting the oopses though, there may be a pattern to them.
>> Another clue in the heat direction might be that with the rain the last
>> few days things seem
>> at least a bit better, though it's probably too early to draw
>> conclusions.  First box's been up
>> for 2 days 10 hours now, and the with this oops above 18 hours.
> Sorry if those questions have already been posted in the previous
> thread. What kind of tests / workload are you running on your Mirabox
> to trigger the crash? I might be able to get one or two Mirabox running
> here, so I could see if the problem is reproducible.
Nothing too fancy.   They're running a corosync/pacemaker cluster with 
apache, bind,
openvpn, dovecot, postfix and mysql,  all for personal use only, so a 
fairly light load.
CPU idle generally hovers just below 80%.

That said, I think at least one of the oopses happened while I was 
updating the kernel;
IIRC it happened either during the git pull or make clean though, not 
during the actual
make.
>
> Also, is this something you're seeing only since 3.11-rc7 ? Is the
> kernel originally provided with the Mirabox more stable ? Are earlier
> kernel versions (such as 3.10 or earlier) more stable ?
Things get a bit murky here.

I did not get any problems with the included (with the marvell patches) 
2.6.35, but I didn't
run it all that long since I don't like debian and it didn't work with a 
recent fedora because
of systemd.  I was running that kernel + a cgroup patch for quite a 
while without any issues.

A stock 3.10 kernel compiled on fedora 18 has been working without any 
issues for at least
a month.  That exact same kernel and exact same config compiled on 
fedora 19 results in an
oops shortly after boot however.  (First oops below)

3.11-rc3 compiled on FC19 results in another oops (second one below); 
compiled on FC18
I initially thought it worked fine but I think it eventually oopsed as 
well (didn't save it, sorry),
so I went back to my 3.10 kernel.

And my current 3.11-rc7 is the next one I tried. I don't have a FC18 box 
anymore so kernel is
compiled on FC19 (directly on the mirabox).

One other thing with the stock kernels is that the network interfaces 
will not work properly
unless they're activated from u-boot, i.e. if I just do an sdcard boot 
the interfaces will show
up and appear ok but won't actually send/receive any data. Simply doing 
a "dhcp ; setact
egiga1 ; dhcp" before continuing the boot makes them work fine. This 
wasn't a problem with
the original kernel.

J.


>
> Thanks,
>
> Thomas
Unable to handle kernel NULL pointer dereference at virtual address 0000001c
pgd = ee0b8000
[0000001c] *pgd=2e2c2831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] ARM
Modules linked in: ipt_MASQUERADE iscsi_tcp libiscsi_tcp libiscsi 
iptable_nat nf_nat_ipv4 nf_nat drbd lru_cache scsi_transport_iscsi 
iptable_mangle ipt_REJECT xt_conntrack iptable_filter ip_tables ext3 jbd 
autofs4 ext4 jbd2 mbcache sd_mod usb_storage mmc_block mvsdio mmc_core 
ehci_orion
CPU: 0 PID: -1073560872 Comm: bash Not tainted 3.10.0-stock1 #23
task: ee1df440 ti: ee154000 task.ti: ee154000
PC is at __task_pid_nr_ns+0x40/0xa4
LR is at schedule_tail+0x44/0x64
pc : [<c0037c4c>]    lr : [<c00439e0>]    psr: 60000013
sp : ee155f88  ip : ee155f88  fp : ee155f94
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : bf000000  r4 : ee154000
r3 : ef181efc  r2 : 00000000  r1 : 00000000  r0 : ee1df440
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 2e0b8019  DAC: 00000015
Process bash (pid: -1073560872, stack limit = 0xee154230)
Stack: (0xee155f88 to 0xee156000)
5f80:                   ee155fac ee155f98 c00439e0 c0037c18 00000000 
00000000
5fa0: 00000000 ee155fb0 c000df48 c00439a8 00000000 00000000 00000000 
00000000
5fc0: b6fc3068 bed65f08 48a50000 00000078 000d6d64 b6fc3000 000d63cc 
bed65f34
5fe0: b6fc34c0 bed65f08 00000a18 489aa0cc 60000010 01200011 00000000 
00000000
Backtrace:
[<c0037c0c>] (__task_pid_nr_ns+0x0/0xa4) from [<c00439e0>] 
(schedule_tail+0x44/0x64)
[<c004399c>] (schedule_tail+0x0/0x64) from [<c000df48>] 
(ret_from_fork+0x4/0x3c)
  r5:00000000 r4:00000000
Code: e0831101 e5913120 e3530000 0a00000c (e592101c)
---[ end trace 20369176bc42626e ]---
Unable to handle kernel paging request at virtual address 2e6f2e7a
pgd = c0004000
[2e6f2e7a] *pgd=00000000
Internal error: Oops: 15 [#2] ARM
Modules linked in: ipt_MASQUERADE iscsi_tcp libiscsi_tcp libiscsi 
iptable_nat nf_nat_ipv4 nf_nat drbd lru_cache scsi_transport_iscsi 
iptable_mangle ipt_REJECT xt_conntrack iptable_filter ip_tables ext3 jbd 
autofs4 ext4 jbd2 mbcache sd_mod usb_storage mmc_block mvsdio mmc_core 
ehci_orion
CPU: 0 PID: -1073560872 Comm: bash Tainted: G      D 3.10.0-stock1 #23
task: ee1df440 ti: ee154000 task.ti: ee154000
PC is at acct_process+0x34/0x88
LR is at acct_process+0x20/0x88
pc : [<c005bb78>]    lr : [<c005bb64>]    psr: 20000013
sp : ee155d48  ip : ee155d48  fp : ee155d5c
r10: ef238080  r9 : ee1df440  r8 : 00000017
r7 : ee154000  r6 : c034afb0  r5 : e5911018  r4 : ee154020
r3 : 00000000  r2 : ee155d48  r1 : ef238080  r0 : 2e6f2e72
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 2f35c019  DAC: 00000015
Process bash (pid: -1073560872, stack limit = 0xee154230)
Stack: (0xee155d48 to 0xee156000)
5d40:                   ee154020 00000000 ee155d94 ee155d60 c0022070 
c005bb50
5d60: c03c45f0 00000001 ef2380b8 00000017 ee1df440 c03e0ac0 ee155d94 
ee155d88
5d80: c001decc ee154000 ee155dd4 ee155d98 c0011afc c00219f4 ee154230 
0000000b
5da0: 60000113 ee154000 c0356054 0000001c 00000017 ef238080 ee155f40 
ef238080
5dc0: ee1df440 00000028 ee155dec ee155dd8 c02bd6dc c0011984 ee155f40 
0000001c
5de0: ee155e8c ee155df0 c02c3794 c02bd67c ee155e14 ee155e00 c004374c 
c00435a4
5e00: ee7b1b80 00000000 00010000 00000000 ef2380b8 00000000 c03c9ea0 
00000001
5e20: ee155e64 ee155e30 c00465a0 c03c9ed8 ee1dfb78 00000400 ee155e5c 
ee155e48
5e40: ffffffff 00000000 ee155e7c ee155e58 c02c3a88 c0009038 ffffffff 
ef18001c
5e60: ee1df440 00000017 c02c35b0 c03c5064 0000001c ee155f40 00000000 
00000000
5e80: ee155f3c ee155e90 c0008428 c02c35bc c02c22b4 c02c3af8 ee155f44 
ee155ea8
5ea0: c002dab0 c0022f58 00000011 c02c128c c03f6ab0 c03c00d0 c03e07c6 
ee154018
5ec0: 00000000 00000000 ee155ef4 ee155ed8 c0042cbc c00465c4 00000000 
ee1df440
5ee0: 00000001 ee1df440 ee155f14 ee155ef8 c0044cf8 c0042c98 00000000 
ee1df440
5f00: 00000004 ee0bcb80 c03cb00c ee154000 00000000 ee1df534 ee1df438 
c0037c4c
5f20: 60000013 ffffffff ee155f74 00000000 ee155f94 ee155f40 c02c1f18 
c00083f4
5f40: ee1df440 00000000 00000000 ef181efc ee154000 bf000000 00000000 
00000000
5f60: 00000000 00000000 00000000 ee155f94 ee155f88 ee155f88 c00439e0 
c0037c4c
5f80: 60000013 ffffffff ee155fac ee155f98 c00439e0 c0037c18 00000000 
00000000
5fa0: 00000000 ee155fb0 c000df48 c00439a8 00000000 00000000 00000000 
00000000
5fc0: b6fc3068 bed65f08 48a50000 00000078 000d6d64 b6fc3000 000d63cc 
bed65f34
5fe0: b6fc34c0 bed65f08 00000a18 489aa0cc 60000010 01200011 00000000 
00000000
Backtrace:
[<c005bb44>] (acct_process+0x0/0x88) from [<c0022070>] (do_exit+0x688/0x87c)
  r5:00000000 r4:ee154020
[<c00219e8>] (do_exit+0x0/0x87c) from [<c0011afc>] (die+0x184/0x238)
  r7:ee154000
[<c0011978>] (die+0x0/0x238) from [<c02bd6dc>] 
(__do_kernel_fault.part.9+0x6c/0x7c)
[<c02bd670>] (__do_kernel_fault.part.9+0x0/0x7c) from [<c02c3794>] 
(do_page_fault+0x1e4/0x3e4)
  r7:0000001c r3:ee155f40
[<c02c35b0>] (do_page_fault+0x0/0x3e4) from [<c0008428>] 
(do_DataAbort+0x40/0xa0)
[<c00083e8>] (do_DataAbort+0x0/0xa0) from [<c02c1f18>] 
(__dabt_svc+0x38/0x60)
Exception stack(0xee155f40 to 0xee155f88)
5f40: ee1df440 00000000 00000000 ef181efc ee154000 bf000000 00000000 
00000000
5f60: 00000000 00000000 00000000 ee155f94 ee155f88 ee155f88 c00439e0 
c0037c4c
5f80: 60000013 ffffffff
  r8:00000000 r7:ee155f74 r6:ffffffff r5:60000013 r4:c0037c4c
[<c0037c0c>] (__task_pid_nr_ns+0x0/0xa4) from [<c00439e0>] 
(schedule_tail+0x44/0x64)
[<c004399c>] (schedule_tail+0x0/0x64) from [<c000df48>] 
(ret_from_fork+0x4/0x3c)
  r5:00000000 r4:00000000
Code: 089da830 e595002c e3500000 0a00000f (e5903008)
---[ end trace 20369176bc42626f ]---
Code: 089da830 e595002c e3500000 0a00000f (e5903008)
All code
========
    0:   089da830        ldmeq   sp, {r4, r5, fp, sp, pc}
    4:   e595002c        ldr     r0, [r5, #44]   ; 0x2c
    8:   e3500000        cmp     r0, #0
    c:   0a00000f        beq     0x50
   10:*  e5903008        ldr     r3, [r0, #8]            <-- trapping 
instruction

Code starting with the faulting instruction
===========================================
    0:   e5903008        ldr     r3, [r0, #8]


--- second oops ---
[  330.307636] Unable to handle kernel paging request at virtual address 
bf370a58
[  330.314988] pgd = ee12c000
[  330.316393] [bf370a58] *pgd=2dd00811, *pte=00000000, *ppte=00000000
[  330.321402] Internal error: Oops: 7 [#1] ARM
[  330.324371] Modules linked in: tun gfs2 sha1_generic drbd lru_cache 
dlm sctp configfs ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat 
iptable_mangle ipt_REJECT xt_conntrack ebtable_filter ebtables 
iptable_filter ip_tables ext3 jbd autofs4 ext4 jbd2 mbcache sd_mod 
usb_storage mmc_block xhci_hcd mvsdio mmc_core ehci_orion
[  330.351619] CPU: 0 PID: 1774 Comm: lrmd Not tainted 3.11.0-rc3-stock1 #26
[  330.357111] task: ee098540 ti: ee102000 task.ti: ee102000
[  330.361220] PC is at copy_process.part.65+0x9ac/0xdd0
[  330.364980] LR is@recalc_sigpending+0x20/0x70
[  330.368299] pc : [<c001e1c0>]    lr : [<c002cd48>] psr: 20000093
sp : ee103f00  ip : ee103efc  fp : ee103f4c
[  330.377183] r10: b6fde068  r9 : ed126b40  r8 : c03ffbf8
[  330.381111] r7 : ed126c7c  r6 : c0417f40  r5 : ee102000  r4 : 01200011
[  330.386342] r3 : bf370a3c  r2 : eea65a40  r1 : ee098540  r0 : 00000000
[  330.391575] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[  330.397503] Control: 10c5387d  Table: 2e12c019  DAC: 00000015
[  330.401951] Process lrmd (pid: 1774, stack limit = 0xee102230)
[  330.406487] Stack: (0xee103f00 to 0xee104000)
[  330.409549] 3f00: ed126cb4 00000000 ed126c3c 00000000 00000000 
00000000 ee103f78 fffffff4
[  330.416436] 3f20: ee102000 01200011 00020200 00000000 00000000 
00000000 ee102000 00000000
[  330.423323] 3f40: ee103f8c ee103f50 c001e734 c001d820 ee103efc 
00000000 00000000 c0157bb4
[  330.430211] 3f60: ee103f94 ee103f70 c00ba6b8 b6fde068 bee38828 
48a50000 00000078 c000e6a8
[  330.437098] 3f80: ee103fa4 ee103f90 c001ea18 c001e6a4 b6fde068 
c00ba614 00000000 ee103fa8
[  330.443986] 3fa0: c000e500 c001ea00 b6fde068 bee38828 01200011 
00000000 00000000 00000000
[  330.450874] 3fc0: b6fde068 bee38828 48a50000 00000078 46ba4000 
b6fde000 0003c138 bee38864
[  330.457761] 3fe0: b6fde4c0 bee38828 000006ee 489aa0cc 60000010 
01200011 3ec52a3e 3ec53a3e
[  330.464643] Backtrace:
[  330.465805] [<c001d814>] (copy_process.part.65+0x0/0xdd0) from 
[<c001e734>] (do_fork+0x9c/0x2c4)
[  330.473303] [<c001e698>] (do_fork+0x0/0x2c4) from [<c001ea18>] 
(SyS_clone+0x24/0x2c)
[  330.479750]  r8:c000e6a8 r7:00000078 r6:48a50000 r5:bee38828 r4:b6fde068
[  330.485218] [<c001e9f4>] (SyS_clone+0x0/0x2c) from [<c000e500>] 
(ret_fast_syscall+0x0/0x30)
[  330.492279] Code: e5933138 e5893138 e59c3004 e08c3203 (e593201c)
[  330.497077] ---[ end trace 836c3039ee5ba43a ]---
[  333.601499] ------------[ cut here ]------------
[  333.605836] Kernel BUG at c00c4f18 [verbose debug info unavailable]
[  333.610809] Internal error: Oops - BUG: 0 [#2] ARM
[  333.614300] Modules linked in: tun gfs2 sha1_generic drbd lru_cache 
dlm sctp configfs ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat 
iptable_mangle ipt_REJECT xt_conntrack ebtable_filter ebtables 
iptable_filter ip_tables ext3 jbd autofs4 ext4 jbd2 mbcache sd_mod 
usb_storage mmc_block xhci_hcd mvsdio mmc_core ehci_orion
[  333.641540] CPU: 0 PID: 3498 Comm: httpd Tainted: G      D 
3.11.0-rc3-stock1 #26
[  333.648077] task: ed17f480 ti: ed228000 task.ti: ed228000
[  333.652188] PC is at dput+0x150/0x154
[  333.654552] LR is at __fput+0x108/0x1f4
[  333.657090] pc : [<c00c4f18>]    lr : [<c00b3a78>] psr: 60000013
sp : ed229f10  ip : ed229f28  fp : ed229f24
[  333.665974] r10: ee359b08  r9 : 00000000  r8 : 40000010
[  333.669901] r7 : ed8fe080  r6 : ee7fb810  r5 : ed903778  r4 : ed903778
[  333.675132] r3 : 00000000  r2 : 20000013  r1 : c04020c8  r0 : ed903778
[  333.680364] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[  333.686204] Control: 10c5387d  Table: 2d1c4019  DAC: 00000015
[  333.690653] Process httpd (pid: 3498, stack limit = 0xed228230)
[  333.695276] Stack: (0xed229f10 to 0xed22a000)
[  333.698336] 9f00:                                     ee359b00 
ed903778 ed229f5c ed229f28
[  333.705224] 9f20: c00b3a78 c00c4dd4 00000000 00000000 c00b3efc 
ed17f738 ed17f480 c041e694
[  333.712111] 9f40: 00000000 c000e6a8 ed228000 00000000 ed229f6c 
ed229f60 c00b3bbc c00b397c
[  333.718999] 9f60: ed229f8c ed229f70 c00398a4 c00b3bb8 ed228010 
ed228000 c000e6a8 ed229fb0
[  333.725887] 9f80: ed229fac ed229f90 c00118b0 c0039810 00000004 
b705d790 b7023a68 00000006
[  333.732774] 9fa0: 00000000 ed229fb0 c000e540 c0011830 00000000 
00000000 00000001 00000001
[  333.739662] 9fc0: 00000004 b705d790 b7023a68 00000006 b705d8d8 
b705d770 b6fcb0a8 bedac5e8
[  333.746549] 9fe0: 00000000 bedabf00 b6bad2b8 b6b76294 60000010 
00000004 00000000 00000000
[  333.753431] Backtrace:
[  333.754592] [<c00c4dc8>] (dput+0x0/0x154) from [<c00b3a78>] 
(__fput+0x108/0x1f4)
[  333.760692]  r5:ed903778 r4:ee359b00
[  333.762991] [<c00b3970>] (__fput+0x0/0x1f4) from [<c00b3bbc>] 
(____fput+0x10/0x14)
[  333.769277] [<c00b3bac>] (____fput+0x0/0x14) from [<c00398a4>] 
(task_work_run+0xa0/0xb4)
[  333.776086] [<c0039804>] (task_work_run+0x0/0xb4) from [<c00118b0>] 
(do_work_pending+0x8c/0xac)
[  333.783490]  r7:ed229fb0 r6:c000e6a8 r5:ed228000 r4:ed228010
[  333.787902] [<c0011824>] (do_work_pending+0x0/0xac) from [<c000e540>] 
(work_pending+0xc/0x20)
[  333.795131]  r7:00000006 r6:b7023a68 r5:b705d790 r4:00000004
[  333.799540] Code: e5820004 e2812001 e583207c eaffffe4 (e7f001f2)
[  333.804339] ---[ end trace 836c3039ee5ba43b ]---
[ 333.799540] Code: e5820004 e2812001 e583207c eaffffe4 (e7f001f2)
All code
========
    0:   e5820004        str     r0, [r2, #4]
    4:   e2812001        add     r2, r1, #1
    8:   e583207c        str     r2, [r3, #124]  ; 0x7c
    c:   eaffffe4        b       0xffffffa4
   10:   e7f001f2                        ; <UNDEFINED> instruction:* 
0xe7f001f2          <-- trapping instruction

Code starting with the faulting instruction
===========================================
    0:   e7f001f2                        ; <UNDEFINED> instruction: 
0xe7f001f2
