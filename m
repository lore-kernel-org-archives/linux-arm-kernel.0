From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 9 Aug 2012 14:03:13 -0500
Subject: imx6q restart is broken
In-Reply-To: <20120809092021.GQ18957@n2100.arm.linux.org.uk>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809092021.GQ18957@n2100.arm.linux.org.uk>
Message-ID: <CAKGA1b=--C_MEHgc4m2f4cQwkx-=njss7bpT+EzXgKZJ2v=+Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 4:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Aug 09, 2012 at 11:18:47AM +0800, Hui Wang wrote:
>> - at the last stage of reset, all non-boot cpus will call
>> ipi_cpu_stop()->cpu_relax(), the cpu_relax() is defined to smp_mb() for
>> V6, and smp_mb() is defined to dmb ("mcr p15, 0, %0, c7, c10, 5")
>
> I suspect having this dmb inside cpu_relax() is flooding the
> interconnects with traffic, which then prevents other CPUs getting
> a look-in (maybe there's no fairness when it comes to dmb's.
>
> If I'm right, you'll find is that even converting this to the ARMv7
> DMB instruction won't fix the problem.  It does, however, point
> towards a more serious problem - it means that any tight loop using
> dmb is detremental.  I have heard some people mention that even on
> various ARM SMP platforms, they have see quite an amount of
> interaction between the individual CPU cores, and I'm beginning
> to wonder whether this is why.

I have an irrelevant but possibly related question here; in
mm/proc-v7.S there's this snip of code;

#ifdef CONFIG_SMP
        ALT_SMP(mrc     p15, 0, r0, c1, c0, 1)
        ALT_UP(mov      r0, #(1 << 6))          @ fake it for UP
        tst     r0, #(1 << 6)                   @ SMP/nAMP mode enabled?
        orreq   r0, r0, #(1 << 6)               @ Enable SMP/nAMP mode
        orreq   r0, r0, r10                     @ Enable CPU-specific SMP bits
        mcreq   p15, 0, r0, c1, c0, 1
#endif

Which I am reading as, read the SMP bit from cp15 and see if it's
enabled, or on UP set the SMP bit and then write it back
regardless.

On a system where !CONFIG_SMP but it's SMP-capable like i.MX6Q, ALT_UP
method will get used and the SMP bit will get
set regardless. No other cores will be enabled (at least the i.MX6Q
you need to turn them on using the System Reset
Controller..) but it's still going to end up involving the processors
in SMP activity on the bus. Or.. actually it just sets the SMP
bit *regardless* on any platform. I don't have my assembly hat on
today. Is this correct? Is this actually architecturally correct?

Does SMP bit get set regardless on any system that has multiple CPU
cores but they're all brought down except the
primary (or only-left-executing) core?

Once you've got all the CPUs down, in my mind, SMP should be unset and
in theory any cache management broadcasts
between the CPUs should stop architecturally (with the caveat that on
CPU hotplug, you need to flush the bejesus out
of the primary CPU cache and invalidate the cache for one you just
brought up). So I assume this is some kind of
performance optimization to enable CPUs to be unplugged and replugged
without expensive cache management? Aren't
caches invalidated/flushed by the kernel anyway at this point, or is
the expectation that the SCU/PL310 or so would
manage this underneath as long as the primary CPU is involved in SMP?

Above that TLB ops broadcasting is turned on for A9 and A15 too. Even
in UP? Are these operations simply essential
to the SCU since it might not have any idea how many CPUs are running,
and just broadcasts changes on the AXI bus
anyway for the one CPU that's left to pick up?

The docs don't make it too clear what's going on here, and the code
doesn't enlighten me. I would think that on a non-SMP
system you'd want to turn all of this off, not "fake it for UP"..?

We think we've had some serious performance problems here which point
to a significant loss of performance on the AXI
bus going to DDR memory. The only thing we can attribute it to is some
misconfiguration of the SCU/PL310 or on MX51
maybe the "M4IF" unit with regards to AXI caching or priority for
different bus masters, and that SMP bus traffic is causing
a bottleneck of cache management operations. Otherwise we'd expect
several gigabytes per second to memory in a
streaming situation and we can architect it to only manage a couple of
hundred, and that doesn't seem at all right (since
beyond using misaligned accesses or plain kooky instruction sequences,
everything gets aligned by the time it gets to
DDR, and the DDR memory controller should be doing huge bursts which
get cached in the bus arbiter..). I can only look
at this from a naive point of view because there's no way to look at
it with the bare minimum code running, we need the
OS around to do what we're doing. Also in other tests (cortex-strings)
we get ridiculously good performance, but that's
mostly because it's single threaded.. no other CPU does anything and
the cache is basically useless with very large
transfers.

Now we know dmb makes things explode, you have to wonder are things
being needlessly involved here or turned on
when they needn't be, just to make the code easier to write?

We also saw a performance decrease by some hard to understand amount
in the lpj calculation on i.MX51 between
a CPU_V7-only kernel based on 2.6.31 and Freescale's BSP, versus a
V6/V7 defconfig kernel direct from mainline.
I wonder if the less efficient V6 stuff is causing that.. it would
really, really bite if that was it... we're still running tests
though. We like to enable errata fixes regardless of whether it's on
our processor since the vast majority of them are
only selected at runtime depending on whether the core or unit
revision affected is present, however...

#if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
#define cpu_relax()                    smp_mb()
#else
#define cpu_relax()                    barrier()
#endif

This dirt-old (pre r2p0) Cortex-A9 erratum being selected will force a
V7-only kernel to use smp_mb rather than
barrier regardless of what the processor type is.. that means every
one-image-for-ARMv7 kernel which included
Tegra2, the appropriate above erratum and a few others would hit this
problem regardless. I assume if looping
and comparing a value of "i" and then calling smp_mb can't break the
procedure being expected then reading out
the CPU core revision from a cached value in memory somewhere and
comparing it and OPTIONALLY running
smp_mb (which is then defined as dmb) would not be bad either?

Maybe I am getting this backwards, but I really want someone to tell me that :)

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
