From: hs@denx.de (Heiko Schocher)
Date: Thu, 17 Dec 2009 12:31:31 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
References: <309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
	<c70ff3ad0912070331y751900dbj62847dddb8521f4d@mail.gmail.com>
	<20091207114218.GA19348@n2100.arm.linux.org.uk>
	<4B1CF3ED.9080307@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
	<20091207145235.GD19348@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071027480.31174@xanadu.home>
	<20091207170546.GB26821@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071219100.31174@xanadu.home>
	<20091207175608.GE26821@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
Message-ID: <4B2A1693.6020000@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Christian,

>On Tue, Dec 15, 2009 at 04:31:35PM +0100, christian pellegrin wrote:
>> The patch here does what was described by Russell and seems to solve
>> the read/write and the MAP_PRIVATE in test cases like the one I
>> posted. As noted it may not be enough.
>
> This might be enough (but needs thorough testing).  However, adding
> the requirement for L2 cache flushing in flush_dcache_page() because
> you have an L2 cache is unfair on those L2's which don't suffer from
> this problem.
>
> I think we need to have a little more information about the behaviour
> of the L2 cache so that we can decide how much flushing is required,
> and where.

FYI:
I tried your patch:
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/006192.html

with the testprogramm, I posted here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005489.html

and on my board [1] it works fine [2] with your patch.

Another question comes in my mind:

As we have problems with shared memory, if using more than one
mapping, do we have this problems also when using other "standard"
Linux IPC, like for example semaphores, queues, ... ?

bye,
Heiko

[1]
-bash-3.2# cat /proc/cpuinfo
Processor       : Feroceon 88FR131 rev 1 (v5l)
BogoMIPS        : 799.53
Features        : swp half thumb fastmult edsp
CPU implementer : 0x56
CPU architecture: 5TE
CPU variant     : 0x2
CPU part        : 0x131
CPU revision    : 1

Hardware        : Keymile SUEN3 Board
Revision        : 0000
Serial          : 0000000000000000
-bash-3.2#

[2] log from testprogramm with patch from christian:

-bash-3.2# cat shtest2.sh
#!/bin/sh
echo "Run shmtest2"
./shmtest2 write 1 &
./shmtest2 read 4 &
-bash-3.2# ./shtest2.sh
Run shmtest2
Write to in_msg
Creating thread 0
Shared memory Id:0
attach shared mem:40961000
Start Write Thread 0, addr:40961000
359: write new mesg: 0
Read from in_msg
Creating thread 0
Shared memory Id:0
attach shared mem:40961000
Start Read Thread addr:40961000
Creating thread 1
Shared memory Id:0
attach shared mem:41170000
Start Read Thread addr:41170000
Creating thread 2
Shared memory Id:0
attach shared mem:4197f000
Start Read Thread addr:4197f000
Creating thread 3
Shared memory Id:0
attach shared mem:4218e000
Start Read Thread addr:4218e000
-bash-3.2# 359: write new mesg: 0
361 Read from entry in_msg=1000, out_msg=1000, addr=40961000
361 Read from entry in_msg=2000, out_msg=1000, addr=41170000
361 Read from entry in_msg=3000, out_msg=1000, addr=4197f000
361 Read from entry in_msg=4000, out_msg=1000, addr=4218e000
359: write new mesg: 1000
361 Read from entry in_msg=5000, out_msg=2000, addr=40961000
361 Read from entry in_msg=6000, out_msg=2000, addr=41170000
361 Read from entry in_msg=7000, out_msg=2000, addr=4197f000
361 Read from entry in_msg=8000, out_msg=2000, addr=4218e000
359: write new mesg: 2000
361 Read from entry in_msg=9000, out_msg=3000, addr=40961000
361 Read from entry in_msg=10000, out_msg=3000, addr=41170000
361 Read from entry in_msg=11000, out_msg=3000, addr=4197f000
361 Read from entry in_msg=12000, out_msg=3000, addr=4218e000
359: write new mesg: 3000
[...]
349: write new mesg: 57000
350 Read from entry in_msg=230000, out_msg=58000, addr=4197f000
350 Read from entry in_msg=231000, out_msg=58000, addr=41170000
350 Read from entry in_msg=232000, out_msg=58000, addr=4218e000
350 Read from entry in_msg=233000, out_msg=58000, addr=40961000
349: write new mesg: 58000
350 Read from entry in_msg=234000, out_msg=59000, addr=4197f000
350 Read from entry in_msg=235000, out_msg=59000, addr=41170000
350 Read from entry in_msg=236000, out_msg=59000, addr=4218e000
350 Read from entry in_msg=237000, out_msg=59000, addr=40961000
350 Read from entry in_msg=237000, out_msg=59000, addr=4197f000
350 Read from entry in_msg=237000, out_msg=59000, addr=4218e000
350 Read from entry in_msg=237000, out_msg=59000, addr=41170000
All write threads finished, exit
All read threads finished, exit

-bash-3.2#

out_msg increments as suggested!

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
