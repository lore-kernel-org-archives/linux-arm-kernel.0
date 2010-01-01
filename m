From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jan 2010 20:58:50 +0000
Subject: SMP issues on ARM11 MPCore
In-Reply-To: <SNT109-W391FD03251D32533FAE84DA77F0@phx.gbl>
References: <SNT109-W391FD03251D32533FAE84DA77F0@phx.gbl>
Message-ID: <20100101205850.GI16220@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2009 at 03:27:09PM +0000, mkl lin wrote:
> 
> hi, 
> 
> I'm using ARM11 MPCore with 2 CPU, Linux-2.6.31.1, SMP enabled,
> L1 enabled, L2 disabled

An ARM board - which one?

> Under SMP environment, I have observed following issues:
> 
> case 1
> Sometimes, console became extremely slow, print 1 character for 1-2 seconds
> RVDS say that both CPU are idling.  kernel seems find because messages
> response to inserting USB flash is quick and correct.

Define "console".  What is it?  Serial port?  What messages are slow -
output from user programs or the kernel?  (Your comment seems to imply
just user programs but please confirm.)

> case 2
> Sometimes,  the Linux console halt and canot accept any input.
> RVDS say that both CPU are idling.  kernel seems fine because messages
> response to inserting USB flash is quick and correct.

These two sounds like a problem with interrupts - userspace console IO
is interrupt driven, whereas kernel console IO is not.

> case 3
> Sometimes, the test stop with no reason or some fault like segmantation
> fault and return to console prompt or login prompt.

No idea without further information.  Try enabling the user debugging
options, and pass user_debug=31 to the kernel to get messages from the
kernel on userspace segfaults.

> case 4
> Sometimes,
> the test stop with no reason, but not returning to console prompt. The
> console can accept input, but no further response, nor prompt.

Have you tried enabling 'Magic Sysrq' and sending <break>t to list the
task state in the system.  '<break>' there is whatever you need to do
to cause your serial terminal program to send a break condition.  For
minicom, that defaults to ^A f

> [   57.090000] MYDRIVER_exit:
> [   57.110000] MYDRIVER_init:
> [   57.150000] MYDRIVER_exit:
> [   57.180000] MYDRIVER_init:
> [   57.210000] MYDRIVER_exit:
> [   57.240000] MYDRIVER_init:
> [   57.270000] MYDRIVER_exit:
> [   57.300000] MYDRIVER_init:
> [   57.320000] sh: unhandled page fault (11) at 0x000b7dfc, code 0x017
> [   57.320000] pgd = c78b4000
> [   57.330000] [000b7dfc] *pgd=038f4031, *pte=00000000, *ppte=00000000
> [   57.350000]
> [   57.360000] Pid: 350, comm:                   sh
> [   57.370000] CPU: 1    Not tainted  (2.6.31.1-cavm1 #53)
> [   57.390000] PC is at 0x40058d04
> [   57.400000] LR is at 0xb7df8
> [   57.400000] pc : [<40058d04>]    lr : [<000b7df8>]    psr: 60000010
> [   57.400000] sp : bec8b6b8  ip : 0001d020  fp : 00000000
> [   57.440000] r10: 00000000  r9 : bec8b728  r8 : 00000002
> [   57.460000] r7 : 0009c038  r6 : 0001d028  r5 : 4009fe40  r4 : 400a02f8
> [   57.470000] r3 : 00000049  r2 : 0009add8  r1 : 0009add8  r0 : 00000049
> [   57.490000] Flags: nZCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment user
> [   57.520000] Control: 00c5787d  Table: 078b400a  DAC: 00000015
> Segmentation fault

This seems to imply that 0xb7dfc is an invalid address for 'sh'.

> -------
> 
> Without DCache and CONFIG_LOCAL_TIMERS, I can repeat the above procedure
> for 216 seconds, then it halted as case 4. Case 1 also exists with this
> config.

You can't disable the data cache in SMP mode.

It could be something to do with write allocate caches - we don't support
these particularly well in the kernel, and I wouldn't be surprised if
you've found some problem there.

The fact that it only happens in SMP mode rather points at that, because
that's one of the few hardware configurations which does have write 
allocate caches.  To confirm this, we need someone who can run your
tests on a UP platform which has write allocate caches...
