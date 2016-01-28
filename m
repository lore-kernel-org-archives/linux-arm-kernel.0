From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jan 2016 17:27:05 +0000
Subject: [PATCH] arm64: Add support for Half precision floating point
In-Reply-To: <20160128164631.GC17552@devel.intra.reserved-bit.com>
References: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
 <20160126160257.GB28238@arm.com> <56A79D17.2000009@arm.com>
 <20160126165538.GC22776@devel.intra.reserved-bit.com>
 <20160128160747.GN775@arm.com>
 <20160128164631.GC17552@devel.intra.reserved-bit.com>
Message-ID: <20160128172705.GC20099@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 10:16:31PM +0530, Siddhesh Poyarekar wrote:
> On Thu, Jan 28, 2016 at 04:07:48PM +0000, Will Deacon wrote:
> > My understanding was that libc needed this information extremely early
> > on (i.e. before it could even issue system calls), and therefore such
> > an approach would be in addition to the proposal here. Am I mistaken?
> 
> Not really, glibc will need this information before it can call any of
> the ifunc-selected functions, i.e. typically string and some math
> functions.  System calls are not an issue since we don't have
> microarchitecture-specific system calls.  Suzuki's patch works just
> fine, just that to make sure that we're selecting the correct routine,
> we may (in the worst case) have to traverse the /sysfs directories to
> get information from all of the cpu files.  A single file with all
> that information would be much better performance-wise.

Suzuki's MRS emulation only exposes the CPU feature registers and not
the MIDR. So this would help with choosing implementation based on
features (e.g. crypto) but not for micro-architecture tuning.

> > The architecture makes no guarantees about what will and won't be used
> > in different configurations, so we shouldn't try to derive this from the
> > MIDR. Even if you figure out a heuristic for today's platforms, it won't
> > necessarily hold true in the future.
> 
> Another approach could be vendor confirmation that they would never
> release cores with the same MIDR value in different configurations.
> That is to say, a PE with a specific MIDR value will always be in a
> homogenous system and will never be part of a big.little
> configuration.  The microarchitecture routines are essentially
> vendor-specific, so getting this assurance from them should be
> sufficient, shouldn't it?

I don't think you would get such assurance. Basically how the CPUs are
connected on a system is the property of a SoC and not of the CPU (nor
MIDR). I know it's not helpful but we don't really have an option (other
than using made-up MIDR values with some reserved vendor id field and a
central, OS-agnostic database to describe the real MIDRs).

> > As for big/little, the kernel view has been pretty consistent on that:
> > we will expose a "sanitised" view of the registers (as described in the
> > Documentation along with the patch) where we can, and for the per-CPU
> > registers such as MIDR, you will read the current CPU register (which
> > is why those registers are also exposed in sysfs).
> 
> That's a reasonable approach, my only point of contention was to find
> a faster alternative to the directory traversal.

So are you only interested in MIDR for microarchitecture tuning? Would
glibc make any use of the feature registers exposed via MRS emulation
(and so far mirrored by HWCAP bits, well, as long as we can still do
this sanely)?

-- 
Catalin
