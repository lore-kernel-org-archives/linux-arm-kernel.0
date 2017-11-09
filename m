From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 9 Nov 2017 12:35:04 +0000
Subject: [PATCH] arm64/debug: don't duplicate filenames.
In-Reply-To: <20171109121440.6872-1-jamie.iles@oracle.com>
References: <20171109121440.6872-1-jamie.iles@oracle.com>
Message-ID: <20171109123503.GB22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 12:14:40PM +0000, Jamie Iles wrote:
> Rather than explicitly pushing the filename into .rodata.str, use a
> compiler generated string literal and use the address of that as an
> input constraint to the inline assembly.  This allows the compiler to
> emit only one version of the string without relying on the linker to
> deduplicate.

But if the linker does deduplicate, why does it matter?

Or is the linker not removing duplicates that some from the same source
file?

Cheers
---Dave

> 
> Cc: Dave P Martin <Dave.Martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jamie Iles <jamie.iles@oracle.com>
> ---
>  arch/arm64/include/asm/bug.h | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
> index a02a57186f56..a7b05625ef63 100644
> --- a/arch/arm64/include/asm/bug.h
> +++ b/arch/arm64/include/asm/bug.h
> @@ -23,12 +23,8 @@
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  #define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
>  #define __BUGVERBOSE_LOCATION(file, line)				\
> -		".pushsection .rodata.str,\"aMS\", at progbits,1\n"	\
> -	"2:	.string \"" file "\"\n\t"				\
> -		".popsection\n\t"					\
> -									\
> -		".long 2b - 0b\n\t"					\
> -		".short " #line "\n\t"
> +		".long %[file] - 0b\n\t"				\
> +		".short %[line]\n\t"
>  #else
>  #define _BUGVERBOSE_LOCATION(file, line)
>  #endif
> @@ -50,7 +46,9 @@ _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
>  #define __BUG_FLAGS(flags)				\
>  	asm volatile (					\
>  		__BUG_ENTRY(flags)			\
> -		"brk %[imm]" :: [imm] "i" (BUG_BRK_IMM)	\
> +		"brk %[imm]" :: [imm] "i" (BUG_BRK_IMM),\
> +			        [line] "i" (__LINE__),  \
> +			        [file] "i" (__FILE__)   \
>  	);
>  
>  
> -- 
> 2.15.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
