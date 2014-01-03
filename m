From: axel.lin@ingics.com (Axel Lin)
Date: Fri, 03 Jan 2014 22:46:25 +0800
Subject: Question about debugging Bad mode in =?ISO-8859-1?Q?=E2?= handler
 detected
Message-ID: <1388760385.31617.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi list,

I hit a "Bad mode in ? handler detected" oops.
The first line of the message looks un-readable, so I print the reason index as well.
The reason index is "4", so it does not exist in the handler array.
static const char *handler[]= { "prefetch abort", "data abort", "address exception", "interrupt" };
I'd appreciate if someone can give me advices and comments to debug this.

I'm testing on Linus' tree + out-of-tree patches for this ARM7TDMI SoC.

BTW,
It seems I can hit his oops only when CONFIG_DEBUG_MUTEXES is not set.
If I set CONFIG_DEBUG_MUTEXES, the system can boot to busybox.

Below is the oops message:

Bad mode in ? handler detected reason=4
Internal error: Oops - bad mode: 0 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 19 Comm: spi0 Not tainted 3.13.0-rc6-00247-g228432c-dirty #2347
task: 01e4efc0 ti: 01eec000 task.ti: 01eec000
PC is at 0xa04
LR is at gpl327xx_spi_transfer_one+0xb0/0x238
pc : [<00000a04>]    lr : [<00127f94>]    psr: 200000d2
sp : 01eedea8  ip : 0000131f  fp : 001cf02c
r10: 01eec000  r9 : 00000000  r8 : 0000105e
r7 : 00000000  r6 : 000000f1  r5 : 01e7b570  r4 : 00000004
r3 : fffff104  r2 : c0080000  r1 : 00008000  r0 : 01e7b570
Flags: nzCv  IRQs off  FIQs off  Mode IRQ_32  ISA ARM  Segment kernel
Process spi0 (pid: 19, stack limit = 0x01eec1c0)
Stack: (0x01eedea8 to 0x01eee000)
dea0:                   01e7b570 00008000 c0080000 fffff104 00000004 01e7b570
dec0: 000000f1 00000000 0000105e 00000000 01eec000 001cf02c 0000131f 01eedea8
dee0: 00127f94 00000a04 200000d2 ffffffff 01e35db8 00000000 01e7b400 01e35d90
df00: 00000001 00126cf0 00000000 01e7b540 0018de00 01e7b514 01e7b400 60000053
df20: 00000001 00000001 00000000 00000000 00000000 00126b28 01e4efc0 01e7b500
df40: 01e7b514 01eec000 00000000 00028f6c 00000000 01eeb0c0 00000000 01e7b500
df60: 00028eac 00000000 00000000 00029184 00000000 00000000 00000000 01e7b500
df80: 00000000 01eedf84 01eedf84 00000000 01eedf90 01eedf90 01eedfac 01eeb0c0
dfa0: 000290d4 00000000 00000000 000091f0 00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<00127f94>] (gpl327xx_spi_transfer_one+0xb0/0x238) from [<01e7b570>] (0x1e7b570)
Code: e7fddef1 e7fddef1 e7fddef1 e7fdf1f1 (e7fddef1)
---[ end trace 546fedf9b22de3f0 ]---

$ echo "Code: e7fddef1 e7fddef1 e7fddef1 e7fdf1f1 (e7fddef1)" |scripts/decodecode 
Code: e7fddef1 e7fddef1 e7fddef1 e7fdf1f1 (e7fddef1)
All code
========
   0:	e7fddef1 			; <UNDEFINED> instruction: 0xe7fddef1
   4:	e7fddef1 			; <UNDEFINED> instruction: 0xe7fddef1
   8:	e7fddef1 			; <UNDEFINED> instruction: 0xe7fddef1
   c:	e7fdf1f1 			; <UNDEFINED> instruction: 0xe7fdf1f1
  10:	e7fddef1 			; <UNDEFINED> instruction:* 0xe7fddef1		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	e7fddef1 			; <UNDEFINED> instruction: 0xe7fddef1
