From: js@sig21.net (Johannes Stezenbach)
Date: Wed, 1 Sep 2010 17:19:20 +0200
Subject: ARM926EJ-S TLB lockdown
Message-ID: <20100901151920.GA6019@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is just a FYI in case someone is interested, but comments
are of course welcome.

ARM926EJ-S has two TLBs, one is 64-entry 2-way set associative,
the other is 8-entry fully associative for lockdown TLB entries.
The lockdown TLB is currently unused in Linux.  I thought maybe
I could get a performance win so I added the following to
the MACHINE_START's .map_io function of my platform:

#define tlb_lockdown(addr) \
	__asm__ volatile ( \
		"  ldr r1, =" #addr "		@ virtual address\n" \
		"  mrc p15,0,r0,c10,c0,0	@ read lockdown register\n" \
		"  orr r0,r0,#1			@ set preserve bit\n" \
		"  mcr p15,0,r0,c10,c0,0	@ write lockdown register\n" \
		"  mcr p15,0,r1,c8,c7,1		@ invalidate TLB single entry\n" \
		"  ldr r1,[r1]			@ cause TLB miss to load TLB entry\n" \
		"  mrc p15,0,r0,c10,c0,0	@ read lockdown register\n" \
		"  bic r0,r0,#1			@ clear preserve bit\n" \
		"  mcr p15,0,r0,c10,c0,0	@ write lockdown register\n" \
		: : : "r0", "r1")

		tlb_lockdown(0xffff0000);	// exception vectors
		tlb_lockdown(0xc0000000);	// kernel code / data
		tlb_lockdown(0xc0100000);	// kernel code / data
		tlb_lockdown(0xc0200000);	// kernel code / data
		tlb_lockdown(0xc0300000);	// kernel code / data
		tlb_lockdown(0xc0400000);	// kernel code / data
		tlb_lockdown(0xc0500000);	// kernel code / data
		tlb_lockdown(0xc0600000);	// kernel code / data
#undef tlb_lockdown

I used a JTAG debugger to dump the TLB to confirm the lockdown entries
are correct and stay in the TLB during run time.

Then I compared lmbench results (with init=/bin/sh):

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
plain     Linux 2.6.32.  330 1.15 2.72 14.9 21.5 89.7 5.33 12.5 2497 9497 15.K
tlb       Linux 2.6.32.  330 1.11 1.96 14.8 21.1 89.3 3.90 12.4 2461 9392 15.K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
plain     Linux 2.6.32.  139.2  221.6  144.0  237.4  161.3   241.0   162.8
tlb       Linux 2.6.32.  134.3  216.0  139.6  228.2  158.4   234.1   158.6

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
plain     Linux 2.6.32.   56.0   30.0  262.1   69.6  2764.0 2.817    21.9  43.4
tlb       Linux 2.6.32.   53.7   28.9  266.8   65.7  2806.0 2.500    21.9  44.3

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
plain     Linux 2.6.32. 33.6 36.3 30.6   44.3  115.1   95.5   83.9 113. 212.2
tlb       Linux 2.6.32. 34.0 34.6 30.9   45.7  117.9   95.5   83.9 115. 212.3


It seems syscall-heavy micro benchmarks like "null I/O" benefit, but most
of the result changes are within the measurement noise.
I also ran iperf TCP benchmark and got no improvement.

BTW, I updated elinux.org Wiki page about lmbench.
http://elinux.org/Benchmark_Programs


Cheers,
Johannes
