From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 23 Jan 2018 14:52:06 +0000
Subject: [PATCH 01/16] arm64: capabilities: Update prototype for enable
 call back
In-Reply-To: <20180123122809.16269-2-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-2-suzuki.poulose@arm.com>
Message-ID: <20180123145204.GR22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 12:27:54PM +0000, Suzuki K Poulose wrote:
> From: Dave Martin <dave.martin@arm.com>
> 
> We issue the enable() call back for all CPU hwcaps capabilities
> available on the system, on all the CPUs. So far we have ignored
> the argument passed to the call back, which had a prototype to
> accept a "void *" for use with on_each_cpu() and later with
> stop_machine(). However, with commit 0a0d111d40fd1
> ("arm64: cpufeature: Pass capability structure to ->enable callback"),
> there are some users of the argument who wants the matching capability
> struct pointer where there are multiple matching criteria for a single
> capability. Update the prototype for enable to accept a const pointer.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> Signed-off-by: Dave Martin <dave.martin@arm.com>
> [ Rebased to for-next/core converting more users ]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  3 ++-
>  arch/arm64/include/asm/fpsimd.h     |  4 +++-
>  arch/arm64/include/asm/processor.h  |  7 ++++---
>  arch/arm64/kernel/cpu_errata.c      | 14 ++++++--------
>  arch/arm64/kernel/cpufeature.c      | 16 ++++++++++++----
>  arch/arm64/kernel/fpsimd.c          |  3 ++-
>  arch/arm64/kernel/traps.c           |  3 ++-
>  arch/arm64/mm/fault.c               |  2 +-
>  8 files changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index ac67cfc2585a..cefbd685292c 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -97,7 +97,8 @@ struct arm64_cpu_capabilities {
>  	u16 capability;
>  	int def_scope;			/* default scope */
>  	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
> -	int (*enable)(void *);		/* Called on all active CPUs */
> +	/* Called on all active CPUs for all  "available" capabilities */

Nit: Odd spacing?  Also, "available" doesn't really make sense for errata
workarounds.

Maybe applicable would be a better word?

> +	int (*enable)(const struct arm64_cpu_capabilities *caps);

Alternatively, if the comment is liable to be ambiguous, maybe it would
be better to delete it.  The explicit argument type already makes this
more self-documenting than previously.

I don't feel that strongly either way though; probably not worth a
respin unless you have other things to change.

Also please note that I didn't test the original patch here (in case
I didn't point that out already...)

[...]

Cheers
---Dave
