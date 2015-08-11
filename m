From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Aug 2015 19:00:12 +0100
Subject: [PATCH v8 2/7] arm64: Add more test functions to insn.c
In-Reply-To: <1439254364-15362-3-git-send-email-dave.long@linaro.org>
References: <1439254364-15362-1-git-send-email-dave.long@linaro.org>
 <1439254364-15362-3-git-send-email-dave.long@linaro.org>
Message-ID: <20150811180012.GE29880@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 01:52:39AM +0100, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> Certain instructions are hard to execute correctly out-of-line (as in
> kprobes).  Test functions are added to insn.[hc] to identify these.  The
> instructions include any that use PC-relative addressing, change the PC,
> or change interrupt masking. For efficiency and simplicity test
> functions are also added for small collections of related instructions.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm64/include/asm/insn.h | 18 ++++++++++++++++++
>  arch/arm64/kernel/insn.c      | 28 ++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index 30e50eb..66bfb21 100644
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

Hmm, so this class also pulls in load-acquire and store-release, which
we *should* be able to single-step, no? Maybe it's worth splitting this
category up (or at least changing aarch64_insn_is_exclusive to be more
permissive).

>  __AARCH64_INSN_FUNCS(stp_post,	0x7FC00000, 0x28800000)
>  __AARCH64_INSN_FUNCS(ldp_post,	0x7FC00000, 0x28C00000)
>  __AARCH64_INSN_FUNCS(stp_pre,	0x7FC00000, 0x29800000)
> @@ -264,19 +269,29 @@ __AARCH64_INSN_FUNCS(ands,	0x7F200000, 0x6A000000)
>  __AARCH64_INSN_FUNCS(bics,	0x7F200000, 0x6A200000)
>  __AARCH64_INSN_FUNCS(b,		0xFC000000, 0x14000000)
>  __AARCH64_INSN_FUNCS(bl,	0xFC000000, 0x94000000)
> +__AARCH64_INSN_FUNCS(b_bl,	0x7C000000, 0x14000000)

Why do we need this when we already have checks for b and bl?

> +__AARCH64_INSN_FUNCS(cb,	0x7E000000, 0x34000000)

Likewise for cbz and cbnz...

>  __AARCH64_INSN_FUNCS(cbz,	0x7F000000, 0x34000000)
>  __AARCH64_INSN_FUNCS(cbnz,	0x7F000000, 0x35000000)
> +__AARCH64_INSN_FUNCS(tb,	0x7E000000, 0x36000000)

... there's a pattern here!

>  __AARCH64_INSN_FUNCS(tbz,	0x7F000000, 0x36000000)
>  __AARCH64_INSN_FUNCS(tbnz,	0x7F000000, 0x37000000)
> +__AARCH64_INSN_FUNCS(b_bl_cb_tb, 0x5C000000, 0x14000000)

I must be missing something :)

>  __AARCH64_INSN_FUNCS(bcond,	0xFF000010, 0x54000000)
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
> +__AARCH64_INSN_FUNCS(msr_imm,	0xFFF8F01F, 0xD500401F)
> +__AARCH64_INSN_FUNCS(msr_reg,	0xFFF00000, 0xD5100000)
> +__AARCH64_INSN_FUNCS(set_clr_daif, 0xFFFFF0DF, 0xD50340DF)
> +__AARCH64_INSN_FUNCS(rd_wr_daif, 0xFFDFFFE0, 0xD51B4220)

I think I'd rather have separate decoders to decode the register field
of an mrs/msr instruction than overload each encoding here.

Anyway, on the whole this looks pretty good, I'd just prefer not to build
compound instruction checks at the encoding level (even though it looks
like you did a good job on the values).

Will
