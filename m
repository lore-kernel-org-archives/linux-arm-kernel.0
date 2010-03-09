From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Mar 2010 16:35:00 -0000
Subject: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
In-Reply-To: <20100309162202.GB17251@n2100.arm.linux.org.uk>
References: <1268150768-6597-1-git-send-email-will.deacon@arm.com>
	<20100309162202.GB17251@n2100.arm.linux.org.uk>
Message-ID: <000f01cabfa6$76951ac0$63bf5040$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> On Tue, Mar 09, 2010 at 04:06:08PM +0000, Will Deacon wrote:
> > The cpu_relax() macro is often used in the body of busy-wait loops to ensure
> > that the variable being spun on is re-loaded for each iteration.
> 
> No, cpu_relax() exists to avoid x86 CPUs overheating - if you spin like
> so:
> 
> 	for(;;);
> 
> the CPU will overheat, so it's conventional to write:
> 
> 	for(;;)
> 		cpu_relax();
> 
> so that architectures can prevent those kinds of problems occuring.

Ok. I was going by the comments in Documentation/volatile-considered-harmful.txt
where cpu_relax() is also used as a memory barrier.
 
> cpu_relax() is also defined to be a compiler barrier so that the compiler
> reloads the variable on every iteration.
> 
> > This patch changes the definition of cpu_relax() to smp_mb() for ARMv6 cores,
> > forcing a flushing of the write buffer on SMP systems. If the Kernel is not
> > compiled for SMP support, this will expand to a barrier() as before.
> 
> I don't think this is correct.  You're making a macro do something on ARM
> which no other platform, apart from blackfin (which I believe is wrong)
> makes it do.

In the KGDB case [where this cropped up], if cpu_relax() is left as it is, then
an smp_mb() is required in the architecture independent code. This also seems wrong
because it's only needed for the ARM11MPCore. There may also potentially be other
situations in the Kernel which are prone to deadlock because it is assumed that the
write buffer will always drain.

Since both solutions to this problem are nasty, it would be good to get some
clarification on the definition of cpu_relax() across the Kernel. If the KGDB guys
don't mind adding an extra memory barrier, we can solve the problem that way instead
and hope that it doesn't occur elsewhere.

Thoughts?

Cheers,

Will
