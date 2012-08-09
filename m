From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Aug 2012 10:20:21 +0100
Subject: imx6q restart is broken
In-Reply-To: <50232C17.9000700@gmail.com>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
Message-ID: <20120809092021.GQ18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 11:18:47AM +0800, Hui Wang wrote:
> - at the last stage of reset, all non-boot cpus will call  
> ipi_cpu_stop()->cpu_relax(), the cpu_relax() is defined to smp_mb() for  
> V6, and smp_mb() is defined to dmb ("mcr p15, 0, %0, c7, c10, 5")

I suspect having this dmb inside cpu_relax() is flooding the
interconnects with traffic, which then prevents other CPUs getting
a look-in (maybe there's no fairness when it comes to dmb's.

If I'm right, you'll find is that even converting this to the ARMv7
DMB instruction won't fix the problem.  It does, however, point
towards a more serious problem - it means that any tight loop using
dmb is detremental.  I have heard some people mention that even on
various ARM SMP platforms, they have see quite an amount of
interaction between the individual CPU cores, and I'm beginning
to wonder whether this is why.

I think a useful test would be to only execute the DMB maybe once
in 50 or 100 loops - the DMB is there to work around a different
problem with the temporal locality of stores on the local CPU.  So,
the only requirement is that we issue a DMB at some point while
spinning waiting for another CPU to respond to our previous writes.
