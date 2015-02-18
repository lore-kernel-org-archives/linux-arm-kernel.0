From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Thu, 19 Feb 2015 00:00:14 +0900
Subject: [PATCH v5 2/6] arm64: Add more test functions to insn.c
In-Reply-To: <1424214701-4899-3-git-send-email-dave.long@linaro.org>
References: <1424214701-4899-1-git-send-email-dave.long@linaro.org>
 <1424214701-4899-3-git-send-email-dave.long@linaro.org>
Message-ID: <54E4A8FE.8050801@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2015/02/18 8:11), David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> Certain instructions are hard to execute correctly out-of-line (as in
> kprobes).  Test functions are added to insn.[hc] to identify these.  The
> instructions include any that use PC-relative addressing, change the PC,
> or change interrupt masking. For efficiency and simplicity test
> functions are also added for small collections of related instructions.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>

Reviewed-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

But I'd like to ask someone who precisely understand aarch64 ISA to Ack...

Thank you,

> ---
>  arch/arm64/include/asm/insn.h | 24 ++++++++++++++++++++++--
>  arch/arm64/kernel/insn.c      | 28 ++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index e2ff32a..4a534ce 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -223,8 +223,13 @@ static __always_inline bool aarch64_insn_is_##abbr(u32 code) \
>  static __always_inline u32 aarch64_insn_get_##abbr##_value(void) \
>  { return (val); }
>  
> +__AARCH64_INSN_FUNCS(adr_adrp,	0x1F000000, 0x10000000)
> +__AARCH64_INSN_FUNCS(prfm_lit,	0xFF000000, 0xD8000000)
>  __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
>  __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
> +__AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
> +__AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
> +__AARCH64_INSN_FUNCS(exclusive,	0x3F000000, 0x08000000)
>  __AARCH64_INSN_FUNCS(stp_post,	0x7FC00000, 0x28800000)
>  __AARCH64_INSN_FUNCS(ldp_post,	0x7FC00000, 0x28C00000)
>  __AARCH64_INSN_FUNCS(stp_pre,	0x7FC00000, 0x29800000)
> @@ -264,17 +269,29 @@ __AARCH64_INSN_FUNCS(ands,	0x7F200000, 0x6A000000)
>  __AARCH64_INSN_FUNCS(bics,	0x7F200000, 0x6A200000)
>  __AARCH64_INSN_FUNCS(b,		0xFC000000, 0x14000000)
>  __AARCH64_INSN_FUNCS(bl,	0xFC000000, 0x94000000)
> -__AARCH64_INSN_FUNCS(cbz,	0xFE000000, 0x34000000)
> -__AARCH64_INSN_FUNCS(cbnz,	0xFE000000, 0x35000000)
> +__AARCH64_INSN_FUNCS(b_bl,	0x7C000000, 0x14000000)
> +__AARCH64_INSN_FUNCS(cb,	0x7E000000, 0x34000000)
> +__AARCH64_INSN_FUNCS(cbz,	0x7F000000, 0x34000000)
> +__AARCH64_INSN_FUNCS(cbnz,	0x7F000000, 0x35000000)
>  __AARCH64_INSN_FUNCS(bcond,	0xFF000010, 0x54000000)
> +__AARCH64_INSN_FUNCS(tb,	0x7E000000, 0x36000000)
> +__AARCH64_INSN_FUNCS(tbz,	0x7F000000, 0x36000000)
> +__AARCH64_INSN_FUNCS(tbnz,	0x7F000000, 0x37000000)
> +__AARCH64_INSN_FUNCS(b_bl_cb_tb, 0x5C000000, 0x14000000)
>  __AARCH64_INSN_FUNCS(svc,	0xFFE0001F, 0xD4000001)
>  __AARCH64_INSN_FUNCS(hvc,	0xFFE0001F, 0xD4000002)
>  __AARCH64_INSN_FUNCS(smc,	0xFFE0001F, 0xD4000003)
>  __AARCH64_INSN_FUNCS(brk,	0xFFE0001F, 0xD4200000)
> +__AARCH64_INSN_FUNCS(exception,	0xFF000000, 0xD4000000)
>  __AARCH64_INSN_FUNCS(hint,	0xFFFFF01F, 0xD503201F)
>  __AARCH64_INSN_FUNCS(br,	0xFFFFFC1F, 0xD61F0000)
>  __AARCH64_INSN_FUNCS(blr,	0xFFFFFC1F, 0xD63F0000)
> +__AARCH64_INSN_FUNCS(br_blr,	0xFFDFFC1F, 0xD61F0000)
>  __AARCH64_INSN_FUNCS(ret,	0xFFFFFC1F, 0xD65F0000)
> +__AARCH64_INSN_FUNCS(msr_imm,	0xFFF8F000, 0xD5004000)
> +__AARCH64_INSN_FUNCS(msr_reg,	0xFFF00000, 0xD5100000)
> +__AARCH64_INSN_FUNCS(set_clr_daif, 0xFFFFF0DF, 0xD50340DF)
> +__AARCH64_INSN_FUNCS(rd_wr_daif, 0xFFDFFFE0, 0xD51B4220)
>  
>  #undef	__AARCH64_INSN_FUNCS
>  
> @@ -283,6 +300,9 @@ bool aarch64_insn_is_nop(u32 insn);
>  int aarch64_insn_read(void *addr, u32 *insnp);
>  int aarch64_insn_write(void *addr, u32 insn);
>  enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
> +bool aarch64_insn_uses_literal(u32 insn);
> +bool aarch64_insn_is_branch(u32 insn);
> +bool aarch64_insn_is_daif_access(u32 insn);
>  u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
>  				  u32 insn, u64 imm);
>  u32 aarch64_insn_gen_branch_imm(unsigned long pc, unsigned long addr,
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index 7e9327a..ec1c707 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -72,6 +72,34 @@ bool __kprobes aarch64_insn_is_nop(u32 insn)
>  	}
>  }
>  
> +bool __kprobes aarch64_insn_uses_literal(u32 insn)
> +{
> +	/* ldr/ldrsw (literal), prfm */
> +
> +	return aarch64_insn_is_ldr_lit(insn) ||
> +		aarch64_insn_is_ldrsw_lit(insn) ||
> +		aarch64_insn_is_adr_adrp(insn) ||
> +		aarch64_insn_is_prfm_lit(insn);
> +}
> +
> +bool __kprobes aarch64_insn_is_branch(u32 insn)
> +{
> +	/* b, bl, cb*, tb*, b.cond, br, blr */
> +
> +	return aarch64_insn_is_b_bl_cb_tb(insn) ||
> +		aarch64_insn_is_br_blr(insn) ||
> +		aarch64_insn_is_ret(insn) ||
> +		aarch64_insn_is_bcond(insn);
> +}
> +
> +bool __kprobes aarch64_insn_is_daif_access(u32 insn)
> +{
> +	/* msr daif, mrs daif, msr daifset, msr daifclr */
> +
> +	return aarch64_insn_is_rd_wr_daif(insn) ||
> +		aarch64_insn_is_set_clr_daif(insn);
> +}
> +
>  /*
>   * In ARMv8-A, A64 instructions have a fixed length of 32 bits and are always
>   * little-endian.
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
