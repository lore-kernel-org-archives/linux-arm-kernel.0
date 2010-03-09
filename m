From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Mar 2010 16:22:02 +0000
Subject: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
In-Reply-To: <1268150768-6597-1-git-send-email-will.deacon@arm.com>
References: <1268150768-6597-1-git-send-email-will.deacon@arm.com>
Message-ID: <20100309162202.GB17251@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 09, 2010 at 04:06:08PM +0000, Will Deacon wrote:
> The cpu_relax() macro is often used in the body of busy-wait loops to ensure
> that the variable being spun on is re-loaded for each iteration.

No, cpu_relax() exists to avoid x86 CPUs overheating - if you spin like
so:

	for(;;);

the CPU will overheat, so it's conventional to write:

	for(;;)
		cpu_relax();

so that architectures can prevent those kinds of problems occuring.

cpu_relax() is also defined to be a compiler barrier so that the compiler
reloads the variable on every iteration.

> This patch changes the definition of cpu_relax() to smp_mb() for ARMv6 cores,
> forcing a flushing of the write buffer on SMP systems. If the Kernel is not
> compiled for SMP support, this will expand to a barrier() as before.

I don't think this is correct.  You're making a macro do something on ARM
which no other platform, apart from blackfin (which I believe is wrong)
makes it do.
