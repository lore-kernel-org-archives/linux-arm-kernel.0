From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Mar 2010 17:59:40 -0000
Subject: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
In-Reply-To: <20100309164926.GC17251@n2100.arm.linux.org.uk>
References: <1268150768-6597-1-git-send-email-will.deacon@arm.com>
	<20100309162202.GB17251@n2100.arm.linux.org.uk>
	<000f01cabfa6$76951ac0$63bf5040$@deacon@arm.com>
	<20100309164926.GC17251@n2100.arm.linux.org.uk>
Message-ID: <001001cabfb2$4a75d2c0$df617840$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Ok. I was going by the comments in Documentation/volatile-considered-harmful.txt
> > where cpu_relax() is also used as a memory barrier.
> 
> I thought you might; I've just submitted a patch for that to akpm, lkml
> and linux-arch.

Cheers, I'll take a read.

> > In the KGDB case [where this cropped up], if cpu_relax() is left as it is, then
> > an smp_mb() is required in the architecture independent code. This also seems wrong
> > because it's only needed for the ARM11MPCore. There may also potentially be other
> > situations in the Kernel which are prone to deadlock because it is assumed that the
> > write buffer will always drain.
> 
> Why is KGDB being special about this?  Ah yes, it's being brain dead:

<snip>

> Clearly, kgdb is using atomic_set()/atomic_read() in a way which does not
> match this documentation - it's certainly missing the barriers as required
> by the above quoted paragraphs.
> 
> Let me repeat: atomic_set() and atomic_read() are NOT atomic.  There's
> nothing atomic about them.  All they do is provide a pair of accessors
> to the underlying value in the atomic type.  They are no different to
> declaring a volatile int and reading/writing it directly.

Indeed. I'm not familiar enough with KGDB internals to dive in and look at all the
potential barrier conflicts, so I'll submit a patch that addresses the one that's
bitten me so far. Maybe it will motivate somebody else to take a closer look!

Cheers,

Will
