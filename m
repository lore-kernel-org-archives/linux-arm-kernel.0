From: Konstantin.Malolin@palm.com (Konstantin Malolin)
Date: Mon, 30 Nov 2009 20:12:32 -0800
Subject: strace failure on ARM Linux 2.6.31-rc7 running on TI OMAP3 hardware 
In-Reply-To: <9C159646F76EA0498E7891D8121707A523CD024CC3@ushqwmb02.palm1.palmone.com>
References: <9C159646F76EA0498E7891D8121707A523CD024CC2@ushqwmb02.palm1.palmone.com>,
	<9C159646F76EA0498E7891D8121707A523CD024CC3@ushqwmb02.palm1.palmone.com>
Message-ID: <9C159646F76EA0498E7891D8121707A523CD024CC5@ushqwmb02.palm1.palmone.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I believe this must be a kernel bug.
Attached are two strace binaries :

strace_arm and strace_t2

The difference between them is that strace_arm is compiled as an original ARM ISA,
strace_t2 is compiled for Thumb2 (-mthumb -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=softfp).

I tried these compilers :

gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)
gcc version 4.3.3 (Sourcery G++ 4.3-234)
gcc version 4.4.1 (Sourcery G++ 4.4-71)

The bug shows up with all of them, most easily reproduces with an strace binary built with 2007q3-51.

If run by this way on an OMAP3 system, 2.6.31-rc7 plain vanilla kernel :

./strace_arm ./strace_t2 echo "abc" 2> /dev/null

the strace_arm fails randomly with either signal 11 or 4
The PC locations point to some junk areas in functions padding.
Please note that the only scheme when the failure occures is this : ARM binary traces Thumb2 binary.
When ARM traces ARM, Thumb2 traces Thumb2, Thumb2 traces ARM, the failure doesn't show up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: strace_arm
Type: application/octet-stream
Size: 205669 bytes
Desc: strace_arm
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091130/bf8d952e/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: strace_t2
Type: application/octet-stream
Size: 191476 bytes
Desc: strace_t2
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091130/bf8d952e/attachment-0003.obj>
