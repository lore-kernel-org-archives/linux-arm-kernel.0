From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Jan 2018 12:42:15 +0000
Subject: [PATCH v2 1/2] arm64: capabilities: Clarify argument passed to
 enable call back
In-Reply-To: <20180117174220.7959-2-suzuki.poulose@arm.com>
References: <20180117174220.7959-1-suzuki.poulose@arm.com>
 <20180117174220.7959-2-suzuki.poulose@arm.com>
Message-ID: <20180122124214.GA28589@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 05:42:19PM +0000, Suzuki K Poulose wrote:
> We issue the enable() call back for all CPU hwcaps capabilities
> available on the system, on all the CPUs. So far we have ignored
> the argument passed to the call back, which had a prototype to
> accept a "void *" for use with on_each_cpu() and later with
> stop_machine(). However, with commit 0a0d111d40fd1
> ("arm64: cpufeature: Pass capability structure to ->enable callback"),
> there are some users of the argument who wants the matching capability
> struct pointer where there are multiple matching criteria for a single
> capability. Changing the prototype is quite an invasive change and
> will be part of a future series. For now, add a comment to clarify
> what is expected.
> 
> Suggested-by: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index ac67cfc2585a..c049e28274d4 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -97,7 +97,14 @@ struct arm64_cpu_capabilities {
>  	u16 capability;
>  	int def_scope;			/* default scope */
>  	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
> -	int (*enable)(void *);		/* Called on all active CPUs */
> +	/*
> +	 * For each @capability set in CPU hwcaps, @enable() is called on all
> +	 * active CPUs with const struct arm64_cpu_capabilities * as argument.

its argument.

> +	 * It is upto the callback (especially when multiple entries for the

s/upto/up to/

> +	 * same capability exists) to determine if any action should be taken

s/exists/exit/

> +	 * based on @matches() applies to thie CPU.

s/thie/this/

Still, the second half of the sentence doesn't really make a lot of
sense. Instead of:

  "to determine if any action should be taken based on @matches() applies
   to this CPU"

how about:

  "to determine if any action should be taken based on the result of
   @matches() for the local CPU."

Otherwise:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
