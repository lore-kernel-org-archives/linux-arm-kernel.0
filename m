From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:18:53 +0100
Subject: [PATCH 00/23] entry assembly cleanups
Message-ID: <20110629091853.GK21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series cleans up the entry assembly and CPU abort helpers.
Notable things about this patch series:

1. We now call the data and prefetch abort handlers with interrupts
   disabled.  This makes us more like x86 in this regard, and means
   we can move the PMU abort special case out of the assembly.

   As a result of this, we now always tell the irqs tracing code that
   irqs are turned off whenever we enter an exception handler from SVC
   mode.

2. The CPU abort helpers are no longer functions in their own right -
   they tail-call through to the main C abort handlers now, resulting
   in less entry code.

3. IRQs off tracing is implemented more accurately for user aborts.

4. Avoid reloading PSR into r5 on return in SVC exception handlers as
   we now preserve the value across the code.  There is no reason for
   PSR to be changed while processing an SVC mode interrupt, prefetch
   or data abort.

I did notice this though in abort-lv4t.S:

        tst     r8, #1 << 20                    @ L = 1 -> write?

where the comment is wrong.  L means load.  Set for load, so it's a
read.  The ARM610/ARM710 (proc-arm6_7.S) got this right, so I'm not
sure why abort-lv4t.S (which is basically a copy plus thumb handling)
decided to change this to be incorrect.  I haven't fixed this in this
series.
