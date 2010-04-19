From: shankar.vk@gmail.com (Uma shankar)
Date: Mon, 19 Apr 2010 19:17:00 +0530
Subject: Kmemcheck on ARMv7
Message-ID: <n2y448a67a1004190647q3ae8b63aqbfb311aade287bf0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

      I  am  trying to   run  Kmemcheck on   a  Cortex ( ARM-v7)
board  running  Linux 2.6.30.9

At boot-up time,  as  soon  as  Timer-device is  enabled,   I  find
that   timer  gets  disabled  because  system   gets spurious
interrupts  on  that  irq  line.


PID hash table entries: 1024 (order: 10, 4096 bytes)
Linux System timer initialize
irq 23: nobody cared (try booting with the "irqpoll" option)
[<c002e148>] (unwind_backtrace+0x0/0xe8) from [<c002c4b8>]
(dump_stack+0x18/0x1c)
[<c002c4b8>] (dump_stack+0x18/0x1c) from [<c006ad74>]
(__report_bad_irq+0x80/0xb0)
[<c006ad74>] (__report_bad_irq+0x80/0xb0) from [<c006af28>]
(note_interrupt+0x184/0x1f0)
[<c006af28>] (note_interrupt+0x184/0x1f0) from [<c006ba38>]
(handle_edge_irq+0xe8/0x160)
[<c006ba38>] (handle_edge_irq+0xe8/0x160) from [<c0027060>]
(asm_do_IRQ+0x60/0x74)
[<c0027060>] (asm_do_IRQ+0x60/0x74) from [<c0027a30>] (__irq_svc+0x30/0x80)
Exception stack(0xc0373ec0 to 0xc0373f08)
3ec0: 00000017 c0372000 00000002 00000000 00000002 c038e8f4 00000000 0aa00000
3ee0: c0372000 c03bfc40 0000001f c0373f44 00000100 c0373f08 c0047ffc c0047c98
3f00: 20000153 ffffffff
[<c0027a30>] (__irq_svc+0x30/0x80) from [<c0047ffc>] (irq_exit+0x44/0x4c)
[<c0047ffc>] (irq_exit+0x44/0x4c) from [<c0047ffc>] (irq_exit+0x44/0x4c)
[<c0047ffc>] (irq_exit+0x44/0x4c) from [<c0027064>] (asm_do_IRQ+0x64/0x74)
[<c0027064>] (asm_do_IRQ+0x64/0x74) from [<c0027a30>] (__irq_svc+0x30/0x80)
Exception stack(0xc0373f78 to 0xc0373fc0)
3f60:                                                       00000000 c037c15c
3f80: 00000001 600001d3 955fffff c00242ec c0399f80 0aa00000 c0023000 412fc082
3fa0: 0000001f c0373ff4 c0373fc0 c0373fc0 c0008974 c0019798 20000153 ffffffff
[<c0027a30>] (__irq_svc+0x30/0x80) from [<c0008974>] (start_kernel+0x168/0x3e4)
[<c0008974>] (start_kernel+0x168/0x3e4) from [<60008034>] (0x60008034)
handlers:
[<c003a604>] (sdp_timer_interrupt+0x0/0x38)
Disabling IRQ #23
Console: colour dummy device 80x30
console [ttyS1] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)


Later,  when  calibrating delay  loop,  the system is hung  as timer
is not working.

The problem happens  even if  I  set    kmemcheck_enabled = 0  (
disabled by default )  .
( I also commented out   pagetable_init(&meminfo)  ).

 If  you have seen this before,  please let me know.

( The kmemcheck  patch  I am using ( written by  Ye Janboe ) was
written for   ARM v6.   I am aware that  I may have to make some
change in the
instruction simulation handling for v7 . )

            thanks
              shankar
