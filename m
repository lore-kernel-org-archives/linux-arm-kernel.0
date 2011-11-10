From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Thu, 10 Nov 2011 15:32:52 +0100
Subject: machine_halt issue
Message-ID: <4EBBE094.3040300@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After updating my kernel to 3.0.4 I noticed such an error after halting my ks8695 based system running Debian/Buildroot:

Will now halt.
System halted.
BUG: soft lockup - CPU#0 stuck for 22s! [halt:2132]

Pid: 2132, comm:                 halt
CPU: 0    Not tainted  (3.0.4-1.0.0-vs #1)
PC is at machine_halt+0x0/0x4
LR is at sys_reboot+0x104/0x1b8
pc : [<c002adbc>]    lr : [<c00468bc>]    psr: 60000013
sp : c37d9e90  ip : 00000000  fp : 00000001
r10: 00000000  r9 : c37d8000  r8 : c0029ee8
r7 : 00000001  r6 : cdef0123  r5 : 28121969  r4 : c03f1378
r3 : c03f03fc  r2 : 60000013  r1 : c040aa80  r0 : 00002c29
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user

This commit seems to be responsible for this behavior:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=3d3f78d752bfada5b6041f2f7bd0833d8bdf7a4a

earlier kernel (2.6.33 for example) makes not trouble with its empty machine_halt(). I get this behavior because of while(1) loop. If I remove this line, the system behaves as expected. 

What is the reason for this loop? Is it relevant for single core systems?

Regards,
Yegor
