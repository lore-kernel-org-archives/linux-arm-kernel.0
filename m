From: risingsunxy@googlemail.com (Xu Yang)
Date: Wed, 2 Sep 2009 15:38:45 +0200
Subject: how to restrict the arm1176 cache size to 16K in the linux kernel?
Message-ID: <ab40e9c0909020638r40cca92ela5809cc3490e8713@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

I would like to restirct the cache size to 16K to make it compatible
with another configuration.

according to the arm1176 documentation 6.11.3

I added the followings three lines:

 mrc p15, 0, r0, c1, c0, 1
 orr r0, r0, #(1<<6)
 mcr p15, 0, r0, c1, c0, 1

after /arch/arm/mm/proc-v6.S line 163 (mcr p15, 0, r0, c7, c10, 4
@drain write buffer)
to restrict the cache size to 16.
but it seems that it leads kernel panic after "Freeing init memory:104K


BUG: soft lockup - CPU#0 stuck for 61s! [linuxrc:1]

Modules linked in:



Pid: 1, comm:              linuxrc

CPU: 0    Not tainted  (2.6.29 #37)

PC is at handle_mm_fault+0x47c/0x5b4

LR is@0xc3a02890

pc : [<c0080958>]    lr : [<c3a02890>]    psr: 00000113

sp : c381fc78  ip : 01903a58  fp : c381fccc

r10: c21ec000  r9 : c39c7000  r8 : 40024000

r7 : c3a2a1b8  r6 : 605241cf  r5 : 40024000  r4 : 00001000

r3 : 00100090  r2 : c3a02800  r1 : 00000090  r0 : c39c7000

Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user

Control: 00c5387d  Table: 621ec008  DAC: 00000015

[<c0023dd4>] (show_regs+0x0/0x50) from [<c0061d4c>]
(softlockup_tick+0x108/0x158)

 r4:026258ea

[<c0061c44>] (softlockup_tick+0x0/0x158) from [<c0043828>]
(run_local_timers+0x1c/0x20)

[<c004380c>] (run_local_timers+0x0/0x20) from [<c0043858>]
(update_process_times+0x2c/0x5c)

[<c004382c>] (update_process_times+0x0/0x5c) from [<c00263e0>]
(timer_tick+0xe8/0x10c)

 r5:00000000 r4:c036a050

[<c00262f8>] (timer_tick+0x0/0x10c) from [<c002b758>]
(xgold_timer_interrupt+0x58/0x64)

 r5:00000000 r4:c02ed344

[<c002b700>] (xgold_timer_interrupt+0x0/0x64) from [<c00622dc>]
(handle_IRQ_event+0x3c/0x74)

[<c00622a0>] (handle_IRQ_event+0x0/0x74) from [<c0063c6c>]
(handle_level_irq+0xd4/0xf0)

 r7:c3a2a1b8 r6:e0000484 r5:00000055 r4:c02f0ec0

[<c0063b98>] (handle_level_irq+0x0/0xf0) from [<c0022054>]
(__exception_text_start+0x54/0x6c)

 r5:00000000 r4:00000055

[<c0022000>] (__exception_text_start+0x0/0x6c) from [<c022c390>]
(__irq_svc+0x30/0x60)

Exception stack(0xc381fc30 to 0xc381fc78)

fc20:                                     c39c7000 00000090 c3a02800 00100090

fc40: 00001000 40024000 605241cf c3a2a1b8 40024000 c39c7000 c21ec000 c381fccc

fc60: 01903a58 c381fc78 c3a02890 c0080958 00000113 ffffffff

 r5:c381fc64 r4:ffffffff

[<c00804dc>] (handle_mm_fault+0x0/0x5b4) from [<c022e174>]
(do_page_fault+0x118/0x268)

[<c022e05c>] (do_page_fault+0x0/0x268) from [<c022e2e0>]
(do_translation_fault+0x1c/0x84)

[<c022e2c4>] (do_translation_fault+0x0/0x84) from [<c00221f0>]
(do_DataAbort+0x3c/0xa0)

 r6:00000805 r5:c02ec650 r4:ffffffff

[<c00221b4>] (do_DataAbort+0x0/0xa0) from [<c022c34c>] (__dabt_svc+0x4c/0x60)

Exception stack(0xc381fde8 to 0xc381fe30)

fde0:                   4002464c 000009ac 00000000 00000000 c22326e0 00023db0

fe00: 40000000 c2232600 c2281c80 4002464c 40023000 c381fe44 00000000 c381fe30

fe20: c00c7a44 c012dc58 20000113 ffffffff

 r8:c2281c80 r7:c2232600 r6:40000000 r5:c381fe1c r4:ffffffff

[<c00c7a00>] (padzero+0x0/0x5c) from [<c00c8884>] (load_elf_binary+0xa68/0x1200)

[<c00c7e1c>] (load_elf_binary+0x0/0x1200) from [<c0098cf4>]
(search_binary_handler+0xb0/0x258)

[<c0098c44>] (search_binary_handler+0x0/0x258) from [<c0099d7c>]
(do_execve+0x168/0x218)

[<c0099c14>] (do_execve+0x0/0x218) from [<c0025ac8>] (kernel_execve+0x40/0x88)

[<c0025a88>] (kernel_execve+0x0/0x88) from [<c00223f4>]
(run_init_process+0x20/0x2c)

 r7:00000000 r6:00000000 r5:c001ee2c r4:c0346374

[<c00223d4>] (run_init_process+0x0/0x2c) from [<c00224a4>]
(init_post+0xa4/0x108)

[<c0022400>] (init_post+0x0/0x108) from [<c000877c>] (kernel_init+0xb4/0xd8)

 r4:c0346378

[<c00086c8>] (kernel_init+0x0/0xd8) from [<c003cf08>] (do_exit+0x0/0x6b4)

 r5:00000000 r4:00000000

is there anything else I should do in order to restrict the cache
size? or I added the code to the wrong place?

thanks,

Best regards,

Yang
