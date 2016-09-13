From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Sep 2016 09:36:14 +0100
Subject: [PATCH 1/3] arm64: alternative: add auto-nop infrastructure
In-Reply-To: <1473242830-26246-2-git-send-email-mark.rutland@arm.com>
References: <1473242830-26246-1-git-send-email-mark.rutland@arm.com>
 <1473242830-26246-2-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu-KHePVj3gs+Q0wfgkVrD0nB0Yi+xLdbnGz-YZTTsPxFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 September 2016 at 11:07, Mark Rutland <mark.rutland@arm.com> wrote:
> In some cases, one side of an alternative sequence is simply a number of
> NOPs used to balance the other side. Keeping track of this manually is
> tedious, and the presence of large chains of NOPs makes the code more
> painful to read than necessary.
>
> To ameliorate matters, this patch adds a new alternative_else_nop_endif,
> which automatically balances an alternative sequence with a trivial NOP
> sled.
>
> In many cases, we would like a NOP-sled in the default case, and
> instructions patched in in the presence of a feature. To enable the NOPs
> to be generated automatically for this case, this patch also adds a new
> alternative_if, and updates alternative_else and alternative_endif to
> work with either alternative_if or alternative_endif.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/alternative.h | 71 +++++++++++++++++++++++++++---------
>  1 file changed, 54 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> index 8746ff6..4ddbf1c 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -90,34 +90,55 @@ void apply_alternatives(void *start, size_t length);
>  .endm
>
>  /*
> - * Begin an alternative code sequence.
> + * Alternative sequences
> + *
> + * The code for the case where the capability is not present will be
> + * assembled and linked as normal. There are no restrictions on this
> + * code.
> + *
> + * The code for the case where the capability is present will be
> + * assembled into a special section to be used for dynamic patching.
> + * Code for that case must:
> + *
> + * 1. Be exactly the same length (in bytes) as the default code
> + *    sequence.
>   *
> - * The code that follows this macro will be assembled and linked as
> - * normal. There are no restrictions on this code.
> + * 2. Not contain a branch target that is used outside of the
> + *    alternative sequence it is defined in (branches into an
> + *    alternative sequence are not fixed up).
> + */
> +
> +/*
> + * Begin an alternative code sequence.
>   */
>  .macro alternative_if_not cap
> +       .set .Lasm_alt_mode, 0

Given that only a single copy of this symbol will exist in an object
file, is it still possible to use both variants in a single
compilation/assembly unit?

>         .pushsection .altinstructions, "a"
>         altinstruction_entry 661f, 663f, \cap, 662f-661f, 664f-663f
>         .popsection
>  661:
>  .endm
>
> +.macro alternative_if cap
> +       .set .Lasm_alt_mode, 1
> +       .pushsection .altinstructions, "a"
> +       altinstruction_entry 663f, 661f, \cap, 664f-663f, 662f-661f
> +       .popsection
> +       .pushsection .altinstr_replacement, "ax"
> +       .align 2        /* So GAS knows label 661 is suitably aligned */
> +661:
> +.endm
> +
>  /*
> - * Provide the alternative code sequence.
> - *
> - * The code that follows this macro is assembled into a special
> - * section to be used for dynamic patching. Code that follows this
> - * macro must:
> - *
> - * 1. Be exactly the same length (in bytes) as the default code
> - *    sequence.
> - *
> - * 2. Not contain a branch target that is used outside of the
> - *    alternative sequence it is defined in (branches into an
> - *    alternative sequence are not fixed up).
> + * Provide the other half of the alternative code sequence.
>   */
>  .macro alternative_else
> -662:   .pushsection .altinstr_replacement, "ax"
> +662:
> +       .if .Lasm_alt_mode==0
> +       .pushsection .altinstr_replacement, "ax"
> +       .else
> +       .popsection
> +       .endif
>  663:
>  .endm
>
> @@ -125,11 +146,27 @@ void apply_alternatives(void *start, size_t length);
>   * Complete an alternative code sequence.
>   */
>  .macro alternative_endif
> -664:   .popsection
> +664:
> +       .if .Lasm_alt_mode==0
> +       .popsection
> +       .endif
>         .org    . - (664b-663b) + (662b-661b)
>         .org    . - (662b-661b) + (664b-663b)
>  .endm
>
> +/*
> + * Provides a trivial alternative or default sequence consisting solely
> + * of NOPs. The number of NOPs is chosen automatically to match the
> + * previous case.
> + */
> +.macro alternative_else_nop_endif
> +alternative_else
> +.rept (662b-661b) / 4
> +       nop
> +.endr
> +alternative_endif
> +.endm
> +
>  #define _ALTERNATIVE_CFG(insn1, insn2, cap, cfg, ...)  \
>         alternative_insn insn1, insn2, cap, IS_ENABLED(cfg)
>
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
