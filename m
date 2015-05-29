From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 May 2015 11:48:57 +0100
Subject: [PATCH 3/3] arm64: alternative: Work around .inst assembler bugs
In-Reply-To: <1432806053-987-4-git-send-email-marc.zyngier@arm.com>
References: <1432806053-987-1-git-send-email-marc.zyngier@arm.com>
 <1432806053-987-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150529104856.GE6528@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 10:40:53AM +0100, Marc Zyngier wrote:
> AArch64 toolchains suffer from the following bug:
> 
> $ cat blah.S
> 1:
> 	.inst	0x01020304
> 	.if ((. - 1b) != 4)
> 		.error	blah
> 	.endif
> $ aarch64-linux-gnu-gcc -c blah.S
> blah.S: Assembler messages:
> blah.S:3: Error: non-constant expression in ".if" statement
> 
> which precludes the use of msr_s and co as part of alternatives.
> 
> We workaround this issue by not directly testing the labels
> themselves, but by moving the current output pointer by a value
> that should always be zero. if this value is not null, then
> we will trigger a backward move, which is expclicitely forbidden.
> This trigger the error we're after:
> 
>   AS      arch/arm64/kvm/hyp.o
> arch/arm64/kvm/hyp.S: Assembler messages:
> arch/arm64/kvm/hyp.S:1377: Error: attempt to move .org backwards
> scripts/Makefile.build:294: recipe for target 'arch/arm64/kvm/hyp.o' failed
> make[1]: *** [arch/arm64/kvm/hyp.o] Error 1
> Makefile:946: recipe for target 'arch/arm64/kvm' failed
> 
> Not pretty, but at least works on the current toolchains.
> Also merge asm/alternative-asm.h into alternative.h so that we
> slightly limit the duplication of this mess.

This should probably be two patches.

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/alternative-asm.h | 29 ------------------
>  arch/arm64/include/asm/alternative.h     | 52 +++++++++++++++++++++++++++++---
>  arch/arm64/kernel/entry.S                |  2 +-
>  arch/arm64/mm/cache.S                    |  2 +-
>  4 files changed, 50 insertions(+), 35 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/alternative-asm.h
> 
> diff --git a/arch/arm64/include/asm/alternative-asm.h b/arch/arm64/include/asm/alternative-asm.h
> deleted file mode 100644
> index 919a678..0000000
> --- a/arch/arm64/include/asm/alternative-asm.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -#ifndef __ASM_ALTERNATIVE_ASM_H
> -#define __ASM_ALTERNATIVE_ASM_H
> -
> -#ifdef __ASSEMBLY__
> -
> -.macro altinstruction_entry orig_offset alt_offset feature orig_len alt_len
> -	.word \orig_offset - .
> -	.word \alt_offset - .
> -	.hword \feature
> -	.byte \orig_len
> -	.byte \alt_len
> -.endm
> -
> -.macro alternative_insn insn1 insn2 cap
> -661:	\insn1
> -662:	.pushsection .altinstructions, "a"
> -	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
> -	.popsection
> -	.pushsection .altinstr_replacement, "ax"
> -663:	\insn2
> -664:	.popsection
> -	.if ((664b-663b) != (662b-661b))
> -		.error "Alternatives instruction length mismatch"
> -	.endif
> -.endm
> -
> -#endif  /*  __ASSEMBLY__  */
> -
> -#endif /* __ASM_ALTERNATIVE_ASM_H */
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> index d261f01..5195cca 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -1,6 +1,8 @@
>  #ifndef __ASM_ALTERNATIVE_H
>  #define __ASM_ALTERNATIVE_H
>  
> +#ifndef __ASSEMBLY__
> +
>  #include <linux/types.h>
>  #include <linux/stddef.h>
>  #include <linux/stringify.h>
> @@ -24,7 +26,20 @@ void free_alternatives_memory(void);
>  	" .byte 662b-661b\n"				/* source len      */ \
>  	" .byte 664f-663f\n"				/* replacement len */
>  
> -/* alternative assembly primitive: */
> +/*
> + * alternative assembly primitive:
> + *
> + * If any of these .org directive fail, it means that insn1 and insn2
> + * don't have the same length. This used to be written as
> + *
> + * .if ((664b-663b) != (662b-661b))
> + * 	.error "Alternatives instruction length mismatch"
> + * .endif
> + *
> + * but most assemblers die if insn1 or insn2 have a .inst. This should
> + * be fixed in a binutils release posterior to 2.25.51.0.2 (anything
> + * containing commit 4e4d08cf7399b606 or c1baaddf8861).
> + */
>  #define ALTERNATIVE(oldinstr, newinstr, feature)			\
>  	"661:\n\t"							\
>  	oldinstr "\n"							\
> @@ -37,8 +52,37 @@ void free_alternatives_memory(void);
>  	newinstr "\n"							\
>  	"664:\n\t"							\
>  	".popsection\n\t"						\
> -	".if ((664b-663b) != (662b-661b))\n\t"				\
> -	"	.error \"Alternatives instruction length mismatch\"\n\t"\
> -	".endif\n"
> +	".org	. - (664b-663b) + (662b-661b)\n\t"			\
> +	".org	. - (662b-661b) + (664b-663b)\n"
> +
> +#else
> +
> +.macro altinstruction_entry orig_offset alt_offset feature orig_len alt_len
> +	.word \orig_offset - .
> +	.word \alt_offset - .
> +	.hword \feature
> +	.byte \orig_len
> +	.byte \alt_len
> +.endm
> +
> +.macro alternative_insn insn1 insn2 cap
> +661:	\insn1
> +662:	.pushsection .altinstructions, "a"
> +	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
> +	.popsection
> +	.pushsection .altinstr_replacement, "ax"
> +663:	\insn2
> +664:	.popsection
> +	 // If any of these .org fail, it means that insn1 and insn2
> +	 // don't have the same lenght. This used to be written as
> +	 // .if ((664b-663b) != (662b-661b))
> +	 //	.error "Alternatives instruction length mismatch"
> +	 // .endif
> +	 // but most assemblers die if insn1 or insn2 have a .inst.

I think you can drop the duplicate comment now that this is all in one
file.

With that:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
