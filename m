From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jul 2011 19:40:10 +0100
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <20110711140047.GA346@e102568-lin.cambridge.arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
	<alpine.DEB.2.00.1107081641280.2609@localhost6.localdomain6>
	<20110711140047.GA346@e102568-lin.cambridge.arm.com>
Message-ID: <20110711184010.GB8486@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 03:00:47PM +0100, Lorenzo Pieralisi wrote:
> Well, short answer is no. On SMP we do need to save CPU registers 
> but if just one single cpu is shutdown L2 is still on. 
> cpu_suspend saves regs on the stack that has to be cleaned from
> L2 before shutting a CPU down which make things more complicated than
> they should.

Hang on.  Please explain something to me here.  You've mentioned a few
times that cpu_suspend() can't be used because of the L2 cache.  Why
is this the case?

OMAP appears to have code in its sleep path - which has been converted
to cpu_suspend() support - to deal with the L2 issues.

However, lets recap.  What we do in cpu_suspend() in order is:

- Save the ABI registers onto the stack, and some private state
- Save the CPU specific state onto the stack
- Flush the L1 cache
- Call the platform specific suspend finisher

On resume, with the MMU and caches off:

- Platform defined entry point is called, which _may_ be cpu_resume
  directly.
- Platform initial code is executed to do whatever that requires
- cpu_resume will be called
- cpu_resume loads the previously saved private state
- The CPU specific state is restored
- Page table is modified to permit 1:1 mapping for MMU enable
- MMU is enabled with caches disabled
- Page table modification is undone
- Caches are enabled in the main control register
- CPU exception mode stacks are reinitialized
- CPU specific init function is called
- ABI registers are popped off and 'cpu_suspend' function returns

So, as far as L2 goes, in the suspend finisher:

- If L2 state is lost, the finisher needs to clean dirty data from L2
  to ensure that it is preserved in RAM.
  Note: There is no need to disable or even invalidate the L2 cache as
  we should not be writing any data in the finisher function which we
  later need after resume.

- If L2 state is not lost, the finisher needs to clean the saved state
  as a minimum, to sure that this is visible when the main control register
  C bit is clear.  The easiest way to do that is to find the top of stack
  via current_thread_info() - we have a macro for that, and then add
  THREAD_SIZE to find the top of stack.  'sp' will be the current bottom
  of stack.

In the resume initial code:

- If L2 state was lost, the L2 configuration needs to be restored.
  This generally needs to happen before cpu_resume is called:
  - there are CPUs which need L2 setup before the MMU is enabled.
  - OMAP3 currently does this in its assembly, which is convenient to
    allow it to make the SMI calls to the secure world.  The same will
    be true of any CPU running in non-secure mode.

- If L2 state was not lost, and the platform choses not to clean and
  invalidate the ABI registers from the stack, and the platform restores
  the L2 configuration before calling cpu_resume, then the ABI registers
  will be read out of L2 on return if that's where they are - at that
  point everything will be setup correctly.

  This will give the greatest performance, which is important for CPU
  idle use of these code paths.

Now, considering SMP, there's an issue here: do we know at the point
where one CPU goes down whether L2 state will be lost?

If the answer is that state will not be lost, we can do the minimum.
If all L2 state is lost, we need to do as above.  If we don't know the
answer, then we have to assume that L2 state will be lost.

But wait - L2 cache (or more accurately, the outer cache) is common
between CPUs in a SMP system.  So, if we're _not_ the last CPU to go
down, then we assume that L2 state will not be lost.  It is the last
CPUs responsibility to deal with L2 state when it goes into a PM mode
that results in L2 state being lost.

Lastly, should generic code deal with flushing L2 and setting it back
up on resume?  A couple of points there:

1. Will generic code know whether L2 state will be lost, or should it
   assume that L2 state is always lost and do a full L2 flush.  That
   seems wasteful if we have another CPU still running (which would
   also have to flush L2.)

2. L2 configuration registers are not accessible to CPUs operating in
   non-secure mode like OMAPs.  Generic code on these CPUs has _no_
   way to restore and re-enable the L2 cache.  It needs to make
   implementation specific SMI calls to achieve that.

So, I believe the answer to that is no.  However, I think we can still
do a change to improve the situation:

1. Pass in r2 and r3 to the suspend finisher the bottom and top of the
   stack which needs to be cleaned from L2.  This covers the saved
   state but not the ABI registers.

2. Mandate that L2 configuration is to be restored by platforms in their
   pre-cpu_resume code so L2 is available when the C bit is set.
