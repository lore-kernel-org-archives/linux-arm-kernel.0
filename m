From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Oct 2015 11:00:10 +0000
Subject: [PATCH 0/3] Revert arm64 cache geometry
In-Reply-To: <1446159896024.99950@nvidia.com>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
 <20151029114005.GB389@arm.com> <1446159896024.99950@nvidia.com>
Message-ID: <20151030110010.GA2854@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 11:03:27PM +0000, Alexander Van Brunt wrote:
> >My final concern is how this impacts userspace parsing
> >/sys/devices/system/cpu/cpuX/cache/*. Do we need to stub that out with
> >dummy values and extend the device-tree properties to allow inner-cache
> >geometry to be described? I worry that simply removing the files under
> >there could break more than it solves.
> >
> >Perhaps the right solution is to leave the cacheinfo code as-is and extend
> >it so that it prefers to use DT, falling back to the registers if the
> >properties are absent? That matches up with our treatment of MPIDR for
> >topology too and reduces the risk of breaking any existing software.
> 
> I agree with Russel that the kernel really shouldn't be reporting the CPU cache
> geometry at all.

This would be the immediate reaction but people work around it in other
ways like parsing the MIDR from /proc/cpuinfo and hard-coding cache
topology in their code (when they are after a 1-2% improvement in an
artificial benchmark that doesn't always have relevance to the real
world). But, well, benchmarks are user space software that use a kernel
provided ABI.

> I'll add that the problems he described are worse on systems
> with more than one CPU micro-architecture like a big.LITTLE system. In those
> systems the cache geometry of the CPU a thread is executing on can change
> without notice.

This information is not meant to be continuously read at run-time but
rather parsed once and choosing the best implementation that would be
acceptable on all CPUs. Big.LITTLE is one of the reasons for such
information where people would like to see the cache levels, some of
them potentially common to all the clusters in the system.

We've got repeated requests from the toolchain, graphics, Android people
to expose such information, so we gave in and merged the patches. Since
people are doing insane things in user space anyway, I'd rather have a
standard interface for passing the information they need. Similarly, we
have patches for exposing more of the CPUID space to user, though they
are not merged yet.

> While I think that the Linux kernel should be practical, I think that it should
> be written to work with the architectural behavior by default rather than the
> way some processors behave. That is important because there are many
> implementations of the ARM architecture. If we want all of them to run correctly
> by default, then the default must be to use the architectural behavior.

The Linux *kernel* is written to work with the architectural behaviour.
What we are talking about here is user space making use of
implementation specific behaviour.

> I think that by default, there should not be any
> /sys/devices/system/cpu/cpu*/cache/index* nodes. Any user space application
> that accesses these nodes already needs to handle N index* nodes. The N = 0 case
> is valid. However, that assertion is not based on seeing any application that
> uses the nodes.

In general, user space should cope with not seeing these files,
especially since it's new ABI and not present in older kernels. OTOH, it
may directly try to access the current CPU information without bothering
with the whole list (tough for big.LITTLE).

BTW, it looks like I don't get any cache information on Juno with
4.3-rc7, it says "Unable to detect cache hierarchy from DT for CPU 0". I
thought the point of the patch you are trying to revert was to parse
this information from the hardware registers. Sudeep, any idea?

-- 
Catalin
