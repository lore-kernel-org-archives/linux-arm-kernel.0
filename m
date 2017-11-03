From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 18:38:52 +0000
Subject: [PATCH 13/15] arm64: fix mrs_s/msr_s macros for clang LTO
In-Reply-To: <20171103171203.107569-18-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-18-samitolvanen@google.com>
Message-ID: <20171103183852.4exnloq52mmrnsts@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 10:12:01AM -0700, Sami Tolvanen wrote:
> Clang's integrated assembler does not allow assembly macros defined
> in one inline asm block using the .macro directive to be used across
> separate asm blocks. LLVM developers consider this a feature and not a
> bug, recommending code refactoring:
> 
>   https://bugs.llvm.org/show_bug.cgi?id=19749

I agree that this a construct to be avoided if possible.

[...]

> +/*
> + * llvm-as doesn't allow macros defined in an asm block to be used in other
> + * asm blocks, which means we cannot define them globally.
> + */
> +#if !defined(CONFIG_CLANG_LTO)

Can the integrated assembler not be used in the absence of LTO?

> +asm(
> +	___MRS_MSR_S_REGNUM
> +	___MRS_S
> +	___MSR_S
>  );
>  
> +#undef  ___MRS_MSR_S_REGNUM
> +#define ___MRS_MSR_S_REGNUM
> +#undef  ___MRS_S
> +#define ___MRS_S
> +#undef  ___MSR_S
> +#define ___MSR_S
> +#endif

It would be much nicer if we could use one code path regardless here.

Can we fold the asm macros into the CPP macros somehow instead?

IIRC the only reason we use asm macros for the inline assembly case was
because we couldn't figure out how to token-paste with %N in CPP, but
there might be another way around that.

Thanks,
Mark.
