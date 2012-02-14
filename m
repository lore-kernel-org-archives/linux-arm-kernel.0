From: jonkersbart@gmail.com (Bart Jonkers)
Date: Tue, 14 Feb 2012 08:46:01 +0100
Subject: Cache problems in user space - kernel space communication
Message-ID: <CAKPCGKt6U6m8cnagCwgzaLB9R8f73KDWmV58W3ifHQ9n-Y7sTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I'm experiencing problems in our application where a driver and a user
space application performs bi-directional communication through a
memory buffer.

We are running a 2.6.35.14 kernel on an kirkwood based SoC (Marvell 88F6192):
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE),
cr=00053977
[    0.000000] CPU: VIVT data cache, VIVT instruction cache

/root> cat /proc/cpuinfo
Processor       : Feroceon 88FR131 rev 1 (v5l)
BogoMIPS        : 796.44
Features        : swp half thumb fastmult edsp
CPU implementer : 0x56
CPU architecture: 5TE
CPU variant     : 0x2
CPU part        : 0x131
CPU revision    : 1

The kernel driver allocates some page aligned memory which is memory
mapped by the application.
The driver put some data in the memory area and informs the
application. The application processes the data, changes it and
informs the kernel. The kernel then processes the data further and
remove it from the buffer.

We see that the driver doesn't always see the changes of the
application to the data.
We see that the changes by the application near the initial kernel
data are not seen but if data is added on other places in the buffer
which where not accessed earlier by the kernel, the kernel sees the
changes.
It seems that this area which is not updated in the kernel is the size
of a cache line of the L1 cache.

In the mailing list archive I have found the following thread:
http://lists.arm.linux.org.uk/lurker/message/20091204.112345.0fbed99c.en.html
I tried the suggested patch and it solves the problem described in the
thread but not our problem.
The problem in the thread is communication between two user space
programs as ours is between user space and kernel space.

I made a small module and application to reproduce the problem (source
attached).
When it goes wrong i see the following output:

[ 1211.827680] Sending packet with counter 0 to user space
Received packet from kernel with counter 0
[ 1211.834556] removing packet with counter 0

[ 1216.841009]Sending packet with counter 1 to user space
Received packet from kernel with counter 1
[ 1216.852027] Value 5 of packet 1 is not equal.
[ 1216.857752] Value 6 of packet 1 is not equal.
[ 1216.863119] Value 7 of packet 1 is not equal.
[ 1216.867478] Value 8 of packet 1 is not equal.
[ 1216.871838] Value 9 of packet 1 is not equal.
[ 1216.876190] Value 10 of packet 1 is not equal.

[ 1221.854343] Sending packet with counter 2 to user space
Received packet from kernel with counter 3
[ 1226.873237] removing packet with counter 3
[ 1226.878701] Value 5 of packet 3 is not equal.
[ 1226.884422] Value 6 of packet 3 is not equal.
[ 1226.889796] Value 7 of packet 3 is not equal.
[ 1226.894149] Value 8 of packet 3 is not equal.
...

The output shows that a part of the data written in user space is not
read back successful in kernel space.

Regards,
Bart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cachetestprogram.c
Type: text/x-csrc
Size: 2272 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120214/fbd90d50/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cachetest.h
Type: text/x-chdr
Size: 617 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120214/fbd90d50/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cachetestcommands.h
Type: text/x-chdr
Size: 380 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120214/fbd90d50/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cachetestmodule.c
Type: text/x-csrc
Size: 5779 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120214/fbd90d50/attachment-0003.bin>
