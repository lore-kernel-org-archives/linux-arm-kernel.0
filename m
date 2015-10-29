From: avanbrunt@nvidia.com (Alexander Van Brunt)
Date: Thu, 29 Oct 2015 23:03:27 +0000
Subject: [PATCH 0/3] Revert arm64 cache geometry
In-Reply-To: <20151029114005.GB389@arm.com>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>,
 <20151029114005.GB389@arm.com>
Message-ID: <1446159896024.99950@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> The only place that the cache geometry is used is to determine if there can be
>> aliasing for a VIPT (virtually-indexed, physically-tagged) instruction cache.
>> The code assumes that there is no need to flush the entire instruction cache
>> if the size of a cache set is less than or equal to a page size. However, the
>> architectural definition of VIPT says "The only architecturally-guaranteed way
>> to invalidate all aliases of a physical address from a VIPT instruction cache
>> is to invalidate the entire instruction cache." Not only are the parameters not
>> guaranteed to be correct, it is explicitly not legal to ignore aliasing even if
>> the parameters were correct.
>
>This is useful detail -- can you include it in the relevant commit messages
>too, please? You can also drop the ChangeId tags and probably add Cc:
><stable@vger.kernel.org> tags as well.
>
>We should also add a comment to the I-cache aliasing code to state why
>we always nuke the entire I-cache, so that we don't "optimise" it again
>in the future!
>

I'll take care of those.

>My final concern is how this impacts userspace parsing
>/sys/devices/system/cpu/cpuX/cache/*. Do we need to stub that out with
>dummy values and extend the device-tree properties to allow inner-cache
>geometry to be described? I worry that simply removing the files under
>there could break more than it solves.
>
>Perhaps the right solution is to leave the cacheinfo code as-is and extend
>it so that it prefers to use DT, falling back to the registers if the
>properties are absent? That matches up with our treatment of MPIDR for
>topology too and reduces the risk of breaking any existing software.
>

I agree with Russel that the kernel really shouldn't be reporting the CPU cache
geometry at all. I'll add that the problems he described are worse on systems
with more than one CPU micro-architecture like a big.LITTLE system. In those
systems the cache geometry of the CPU a thread is executing on can change
without notice.

While I think that the Linux kernel should be practical, I think that it should
be written to work with the architectural behavior by default rather than the
way some processors behave. That is important because there are many
implementations of the ARM architecture. If we want all of them to run correctly
by default, then the default must be to use the architectural behavior.

I think that by default, there should not be any
/sys/devices/system/cpu/cpu*/cache/index* nodes. Any user space application
that accesses these nodes already needs to handle N index* nodes. The N = 0 case
is valid. However, that assertion is not based on seeing any application that
uses the nodes.

BTW, it is possible to find the cache line size using CTR_EL0.DminLine and
CTR_EL0.IminLine. It is accessible form userspace. But, it isn't very useful for
application optimization though.

________________________________________
From: Will Deacon <will.deacon@arm.com>
Sent: Thursday, October 29, 2015 4:40 AM
To: Alexander Van Brunt
Cc: linux-arm-kernel at lists.infradead.org; Ard Biesheuvel; Sudeep Holla; Catalin Marinas
Subject: Re: [PATCH 0/3] Revert arm64 cache geometry

Hi Alex,

Thanks for describing the problem in depth here. I'm not at all happy
about the conclusion, but you're right and thanks for the report.
Minor comments below.

On Wed, Oct 28, 2015 at 02:43:54PM -0700, Alex Van Brunt wrote:
> This patchset reverts three patches that attempt to query the CPU for cache
> geometry and then make use of that information. Those patches rely on the
> NumSets and LineSize fields of CCSIDR to determine the cache geometry. However,
> the architectural documentation for these registers forbids such use:
>
>       The parameters NumSets, Associativity, and LineSize in these registers
>       define the architecturally visible parameters that are required for the
>       cache maintenance by Set/Way instructions. They are not guaranteed to
>       represent the actual microarchitectural features of a design. You cannot
>       make any inference about the actual sizes of caches based on these
>       parameters.
>
> It is not just theoretical. For example, the Denver CPU will report one set and
> one way in CCSIDR even though the actual microarchitectural implementation has
> many sets and many ways.
>
> I have two suggestions for how to get the cache geometry on an ARMv8 processor:
>   1. Specify the information in the device tree. The purpose of the deivce tree
>      is to specify information that software cannot query at run-time. Becuase
>      the architecture does not have an architectural way to query the cache
>      geometry this may be a good fit.
>   2. Add a function pointer to cpu_table that gives a implementation specific
>      way to query the cache geometry. For an A57, for example, the function
>      could read the CCSIDR register because it happens to report the
>      microarchitectural geometry. The Denver CPU has implementation defined
>      registers that can be used to determine the microarchitectural geometry.
>      However, the implementation for the default "AArch64 Processor", must
>      return an error.
>
> The only place that the cache geometry is used is to determine if there can be
> aliasing for a VIPT (virtually-indexed, physically-tagged) instruction cache.
> The code assumes that there is no need to flush the entire instruction cache
> if the size of a cache set is less than or equal to a page size. However, the
> architectural definition of VIPT says "The only architecturally-guaranteed way
> to invalidate all aliases of a physical address from a VIPT instruction cache
> is to invalidate the entire instruction cache." Not only are the parameters not
> guaranteed to be correct, it is explicitly not legal to ignore aliasing even if
> the parameters were correct.

This is useful detail -- can you include it in the relevant commit messages
too, please? You can also drop the ChangeId tags and probably add Cc:
<stable@vger.kernel.org> tags as well.

We should also add a comment to the I-cache aliasing code to state why
we always nuke the entire I-cache, so that we don't "optimise" it again
in the future!

My final concern is how this impacts userspace parsing
/sys/devices/system/cpu/cpuX/cache/*. Do we need to stub that out with
dummy values and extend the device-tree properties to allow inner-cache
geometry to be described? I worry that simply removing the files under
there could break more than it solves.

Perhaps the right solution is to leave the cacheinfo code as-is and extend
it so that it prefers to use DT, falling back to the registers if the
properties are absent? That matches up with our treatment of MPIDR for
topology too and reduces the risk of breaking any existing software.

Patch 2 and 3 look fine as straight reverts, though (module my previous
comments about commit messages).

Will
