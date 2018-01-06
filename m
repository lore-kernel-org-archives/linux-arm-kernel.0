From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 6 Jan 2018 13:13:23 +0000
Subject: [PATCH v2 01/11] arm64: use RET instruction for exiting the
 trampoline
In-Reply-To: <1515157961-20963-2-git-send-email-will.deacon@arm.com>
References: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
 <1515157961-20963-2-git-send-email-will.deacon@arm.com>
Message-ID: <CAKv+Gu-efng1k+QbeKmd2pGz1p4vhoFE4fZ8rZ7bihGvsb-e+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 January 2018 at 13:12, Will Deacon <will.deacon@arm.com> wrote:
> Speculation attacks against the entry trampoline can potentially resteer
> the speculative instruction stream through the indirect branch and into
> arbitrary gadgets within the kernel.
>
> This patch defends against these attacks by forcing a misprediction
> through the return stack: a dummy BL instruction loads an entry into
> the stack, so that the predicted program flow of the subsequent RET
> instruction is to a branch-to-self instruction which is finally resolved
> as a branch to the kernel vectors with speculation suppressed.
>

How safe is it to assume that every microarchitecture will behave as
expected here? Wouldn't it be safer in general not to rely on a memory
load for x30 in the first place? (see below) Or may the speculative
execution still branch anywhere even if the branch target is
guaranteed to be known by that time?


> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/entry.S | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 031392ee5f47..71092ee09b6b 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -1029,6 +1029,14 @@ alternative_else_nop_endif
>         .if     \regsize == 64
>         msr     tpidrro_el0, x30        // Restored in kernel_ventry
>         .endif
> +       /*
> +        * Defend against branch aliasing attacks by pushing a dummy
> +        * entry onto the return stack and using a RET instruction to
> +        * entr the full-fat kernel vectors.
> +        */
> +       bl      2f
> +       b       .
> +2:
>         tramp_map_kernel        x30
>  #ifdef CONFIG_RANDOMIZE_BASE
>         adr     x30, tramp_vectors + PAGE_SIZE
> @@ -1041,7 +1049,7 @@ alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
>         msr     vbar_el1, x30
>         add     x30, x30, #(1b - tramp_vectors)
>         isb
> -       br      x30
> +       ret
>         .endm
>
>         .macro tramp_exit, regsize = 64
> --
> 2.1.4
>

This uses Marc's callback alternative patching for the KASLR case, the
non-KASLR case just uses a plain movz/movk sequence to load the
address of vectors rather than a literal.

(apologies for the patch soup)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 55d05dacd02e..e8a846335e8e 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1031,17 +1031,19 @@ alternative_else_nop_endif
        .endif
        tramp_map_kernel        x30
 #ifdef CONFIG_RANDOMIZE_BASE
-       adr     x30, tramp_vectors + PAGE_SIZE
 alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
-       ldr     x30, [x30]
+       b       tramp_vectors + PAGE_SIZE + .Ltramp_stage2_size * (1b
- tramp_vectors - 0x400) / 0x80
 #else
-       ldr     x30, =vectors
-#endif
+       movz    x30, :abs_g3:vectors
+       movk    x30, :abs_g2_nc:vectors
+       movk    x30, :abs_g1_nc:vectors
+       movk    x30, :abs_g0_nc:vectors
        prfm    plil1strm, [x30, #(1b - tramp_vectors)]
        msr     vbar_el1, x30
        add     x30, x30, #(1b - tramp_vectors)
        isb
        br      x30
+#endif
        .endm

        .macro tramp_exit, regsize = 64
@@ -1080,12 +1082,25 @@ END(tramp_exit_compat)
        .ltorg
        .popsection                             // .entry.tramp.text
 #ifdef CONFIG_RANDOMIZE_BASE
-       .pushsection ".rodata", "a"
+       .pushsection ".text", "ax"
        .align PAGE_SHIFT
        .globl  __entry_tramp_data_start
 __entry_tramp_data_start:
-       .quad   vectors
-       .popsection                             // .rodata
+       .irpc   i, 01234567
+alternative_cb tramp_patch_vectors_address
+       movz    x30, :abs_g3:0
+       movk    x30, :abs_g2_nc:0
+       movk    x30, :abs_g1_nc:0
+       movk    x30, :abs_g0_nc:0
+alternative_cb_end
+       prfm    plil1strm, [x30, #(0x400 + \i * 0x80)]
+       msr     vbar_el1, x30
+       add     x30, x30, 0x400 + \i * 0x80
+       isb
+       br      x30
+       .endr
+       .set    .Ltramp_stage2_size, (. - __entry_tramp_data_start) / 8
+       .popsection                             // .text
 #endif /* CONFIG_RANDOMIZE_BASE */
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 916d9ced1c3f..4a9788e76489 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -547,13 +547,38 @@ static int __init map_entry_trampoline(void)
                extern char __entry_tramp_data_start[];

                __set_fixmap(FIX_ENTRY_TRAMP_DATA,
-                            __pa_symbol(__entry_tramp_data_start),
-                            PAGE_KERNEL_RO);
+                            __pa_symbol(__entry_tramp_data_start), prot);
        }

        return 0;
 }
 core_initcall(map_entry_trampoline);
+
+#ifdef CONFIG_RANDOMIZE_BASE
+void __init tramp_patch_vectors_address(struct alt_instr *alt,
+                                       __le32 *origptr, __le32 *updptr,
+                                       int nr_inst)
+{
+       enum aarch64_insn_movewide_type type;
+       int s;
+
+       /* We only expect a 4 instruction sequence */
+       BUG_ON(nr_inst != 4);
+
+       type = AARCH64_INSN_MOVEWIDE_ZERO;
+       for (s = 0; nr_inst--; s += 16) {
+               extern const char vectors[];
+
+               u32 insn = aarch64_insn_gen_movewide(AARCH64_INSN_REG_30,
+                                                    (u16)((u64)vectors >> s),
+                                                    s,
+                                                    AARCH64_INSN_VARIANT_64BIT,
+                                                    type);
+               *updptr++ = cpu_to_le32(insn);
+               type = AARCH64_INSN_MOVEWIDE_KEEP;
+       }
+}
+#endif
 #endif

 /*
