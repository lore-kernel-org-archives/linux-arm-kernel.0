From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Dec 2010 16:43:10 -0000
Subject: [RFC] Fixing CPU Hotplug for RealView Platforms
Message-ID: <007401cb962d$d53d2500$7fb76f00$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Currently, CPU hotplug is broken for RealView platforms. I posted some
patches previously to try and address this, but they didn't solve the
problems fully:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-September/026157.html

I'm now revisiting the code and it looks like the main problem is when
we wish to *leave* the lowpower state. The enter/leave routines look
like this:


static inline void cpu_enter_lowpower(void)
{
	unsigned int v, smp_ctrl = get_smp_ctrl_mask();

	flush_cache_all();
	dsb();
	asm volatile(
	/*
	 * Turn off coherency
	 */
	"	mrc	p15, 0, %0, c1, c0, 1\n"
	"	bic	%0, %0, %1\n"
	"	mcr	p15, 0, %0, c1, c0, 1\n"
	/* ISB */
	"	mcr	p15, 0, %2, c7, c5, 4\n"
	/* Disable D-cache */
	"	mrc	p15, 0, %0, c1, c0, 0\n"
	"	bic	%0, %0, #0x04\n"
	"	mcr	p15, 0, %0, c1, c0, 0\n"
	  : "=&r" (v)
	  : "r" (smp_ctrl), "r" (0)
	  : "memory");
	isb();
}

static inline void cpu_leave_lowpower(void)
{
	unsigned int v, smp_ctrl = get_smp_ctrl_mask();

	asm volatile(	"mrc	p15, 0, %0, c1, c0, 0\n"
	"	orr	%0, %0, #0x04\n"
	"	mcr	p15, 0, %0, c1, c0, 0\n"
	"	mrc	p15, 0, %0, c1, c0, 1\n"
	"	orr	%0, %0, %1\n"
	"	mcr	p15, 0, %0, c1, c0, 1\n"
	  : "=&r" (v)
	  : "r" (smp_ctrl)
	  : "memory");
	isb();
}


The problem is that by turning off coherency, the contents of the D-cache
becomes stale. If data is prefetched into L1 between the flush_cache_all
invocation and disabling the D-cache then this data will still be present
when we come out of lowpower. Without coherency, we *must not* use this
data and so a D-cache invalidation to the PoC is required in cpu_leave_lowpower().

On v6 this is a simple mcr instruction. On v7, we have to perform a set/way
operation across all ways of each cache until we reach the PoC (see the
scary but well commented v7_flush_dcache_all function). Implementing this
means extending the cpu_cache_fns struct and stubbing out the new function
for other caches, so I'd like to see if anybody has any better ideas before
I go ahead and make these changes.

One possibility is not to turn off coherency, but if platform_do_lowpower
is more than a WFI I don't think this would be suitable.

Any thoughts?

Will
