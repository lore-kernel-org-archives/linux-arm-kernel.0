From: sid@reserved-bit.com (Siddhesh Poyarekar)
Date: Thu, 28 Jan 2016 22:16:31 +0530
Subject: [PATCH] arm64: Add support for Half precision floating point
In-Reply-To: <20160128160747.GN775@arm.com>
References: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
 <20160126160257.GB28238@arm.com> <56A79D17.2000009@arm.com>
 <20160126165538.GC22776@devel.intra.reserved-bit.com>
 <20160128160747.GN775@arm.com>
Message-ID: <20160128164631.GC17552@devel.intra.reserved-bit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 04:07:48PM +0000, Will Deacon wrote:
> My understanding was that libc needed this information extremely early
> on (i.e. before it could even issue system calls), and therefore such
> an approach would be in addition to the proposal here. Am I mistaken?

Not really, glibc will need this information before it can call any of
the ifunc-selected functions, i.e. typically string and some math
functions.  System calls are not an issue since we don't have
microarchitecture-specific system calls.  Suzuki's patch works just
fine, just that to make sure that we're selecting the correct routine,
we may (in the worst case) have to traverse the /sysfs directories to
get information from all of the cpu files.  A single file with all
that information would be much better performance-wise.

> I'm not at all keen on adding a data ABI to the vDSO. I think people
> tried similar things in the past (something on PPC?) and have horror
> stories from that.

It does not have to be a data ABI, it could be a set of functions that
initialize an opaque context and iterate through the cpu data for each
call, something that would allow me to do this:

    cpu_info_context_t *ctx = cpu_info_init_context ();
    unsigned long midr;

    while ((midr = cpu_info_next_midr (ctx)) != 0)
      {
        /* Do stuff.  */
      }

> The architecture makes no guarantees about what will and won't be used
> in different configurations, so we shouldn't try to derive this from the
> MIDR. Even if you figure out a heuristic for today's platforms, it won't
> necessarily hold true in the future.

Another approach could be vendor confirmation that they would never
release cores with the same MIDR value in different configurations.
That is to say, a PE with a specific MIDR value will always be in a
homogenous system and will never be part of a big.little
configuration.  The microarchitecture routines are essentially
vendor-specific, so getting this assurance from them should be
sufficient, shouldn't it?

> By "directory traversal" are you only referring to the /sys portions
> of this? I'm *much* more interested in the utility of the MRS emulation
> part, since that's what could effectively replace HWCAPs in the future.

The MRS emulation may be sufficient for the case where the system is
homogenous and the vendor states that the midr will never be used in a
heterogenous configuration.  If not, we will have no choice but to
traverse the /sys directories to find the midr for all online cpus and
make that decision.

> As for big/little, the kernel view has been pretty consistent on that:
> we will expose a "sanitised" view of the registers (as described in the
> Documentation along with the patch) where we can, and for the per-CPU
> registers such as MIDR, you will read the current CPU register (which
> is why those registers are also exposed in sysfs).

That's a reasonable approach, my only point of contention was to find
a faster alternative to the directory traversal.

Siddhesh
