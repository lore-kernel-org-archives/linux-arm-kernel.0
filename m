From: Foster_Brian@emc.com (Foster_Brian at emc.com)
Date: Thu, 25 Feb 2010 07:34:34 -0500
Subject: ARM 2.6.30.9 OOPS question -- stack limit?
Message-ID: <D27CA15508148C428A25104ADEFAAC81057281E1@CORPUSMX50C.corp.emc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm running 2.6.30.9 on a Marvell 88f6281 (sheevaplug) based system and
one of our stress tests occasionally produces the kernel OOPS shown
below. It is always preceded by a futex_wait WARN_ON(), so I've included
that as well.

In short, I'm curious about the state of the stack as shown in the OOPS.
I'm suspicious that excessively large stacks in this app could be
causing a problem, but the OOPS is not clear enough to me to indicate
whether that is the case here (a HUGE stack dump is printed between the
Stack: and Code: lines). From looking at random kernel oops messages via
google, I usually see that the stack limit is above sp at the time of
the crash. In this case, sp blows the stack limit away. Is that the
issue here, or am I misinterpreting what the "stack limit" actually
means? Any insight that could help translate this particular error would
be helpful. Thanks in advance.

Brian

------------[ cut here ]------------
WARNING: at kernel/futex.c:1003 futex_wait+0x3fc/0x504() Modules linked
in: sr_mod cdrom usblp usbhid rt3090sta(P) msdos udf crc_itu_t isofs
ufsd(P) [<c002c834>] (unwind_backtrace+0x0/0xdc) from [<c0038228>]
(warn_slowpath_common+0x4c/0x80) [<c0038228>]
(warn_slowpath_common+0x4c/0x80) from [<c005b650>]
(futex_wait+0x3fc/0x504) [<c005b650>] (futex_wait+0x3fc/0x504) from
[<c005cd4c>] (do_futex+0xac/0x9e8) [<c005cd4c>] (do_futex+0xac/0x9e8)
from [<c005d7ac>] (sys_futex+0x124/0x138) [<c005d7ac>]
(sys_futex+0x124/0x138) from [<c00279a0>] (ret_fast_syscall+0x0/0x2c)
---[ end trace 9837fa0402e69254 ]--- Unable to handle kernel paging
request at virtual address 000b9a34 pgd = cb2e8000 [000b9a34]
*pgd=0f021031, *pte=055de34f, *ppte=055deaae Internal error: Oops: 81f
[#1] PREEMPT Modules linked in: sr_mod cdrom usblp usbhid rt3090sta(P)
msdos udf crc_itu_t isofs ufsd(P)
CPU: 0    Tainted: P        W   (2.6.30.9 #1)
PC is at 0x40a95d60
LR is at 0x40a95d5c
pc : [<40a95d60>]    lr : [<40a95d5c>]    psr: 80000010
sp : bec6a388  ip : 40aa216c  fp : 40aa21b0
r10: 40aa2000  r9 : 000001b4  r8 : 000b9a34
r7 : 000b9a34  r6 : bec6a5c8  r5 : 00000000  r4 : 00000000
r3 : 00000000  r2 : 00000002  r1 : 00000081  r0 : 00000000
Flags: Nzcv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment user
Control: 0005397f  Table: 0b2e8000  DAC: 00000015 Process appweb (pid:
26569, stack limit = 0xcb206268)
Stack: (0xbec6a388 to 0xcb208000)
...
Code: c59f32e4 c79a0003 cbfffdf4 e3a02002 (e5882000) Kernel panic - not
syncing: Fatal exception in interrupt [<c002c834>]
(unwind_backtrace+0x0/0xdc) <4>ttyS0: 1 input overrun(s) from
[<c02e493c>] (panic+0x48/0x12c) [<c02e493c>] (panic+0x48/0x12c) from
[<c002b0f0>] (die+0x160/0x18c) [<c002b0f0>] (die+0x160/0x18c) from
[<c002d95c>] (__do_kernel_fault+0x68/0x80) [<c002d95c>]
(__do_kernel_fault+0x68/0x80) from [<c02e9140>]
(do_page_fault+0x290/0x2b4) [<c02e9140>] (do_page_fault+0x290/0x2b4)
from [<c002724c>] (do_DataAbort+0x30/0x90) [<c002724c>]
(do_DataAbort+0x30/0x90) from [<c02e769c>] (ret_from_exception+0x0/0x10)
Exception stack(0xcb207fb0 to 0xcb207ff8)
7fa0:                                     00000000 00000081 00000002
00000000 
7fc0: 00000000 00000000 bec6a5c8 000b9a34 000b9a34 000001b4 40aa2000
40aa21b0 
7fe0: 40aa216c bec6a388 40a95d5c 40a95d60 80000010 ffffffff           
