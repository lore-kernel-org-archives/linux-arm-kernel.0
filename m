From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Mar 2018 17:18:31 +0000
Subject: [RFC PATCH v3 2/3] arm64/kernel: don't ban ADRP to work around
 Cortex-A53 erratum #843419
In-Reply-To: <20180214113645.16793-3-ard.biesheuvel@linaro.org>
References: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
 <20180214113645.16793-3-ard.biesheuvel@linaro.org>
Message-ID: <20180305171831.GB12869@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 11:36:44AM +0000, Ard Biesheuvel wrote:
> Working around Cortex-A53 erratum #843419 involves special handling of
> ADRP instructions that end up in the last two instruction slots of a
> 4k page, or whose output register gets overwritten without having been
> read. (Note that the latter instruction sequence is never emitted by
> a properly functioning compiler)

Does the workaround currently implemented in the linker also make this
same assumption? If not, I'm a little wary that we're making an assumption
about compiler behaviour with no way to detect whether its been violated or
not.

> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index ea640f92fe5a..93b808056cb4 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -41,6 +41,46 @@ u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
>  	return (u64)&plt[i];
>  }
>  
> +#ifdef CONFIG_ARM64_ERRATUM_843419
> +u64 module_emit_adrp_veneer(struct module *mod, void *loc, u64 val)
> +{
> +	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
> +							  &mod->arch.init;
> +	struct plt_entry *plt = (struct plt_entry *)pltsec->plt->sh_addr;
> +	int i = pltsec->plt_num_entries++;
> +	u32 mov0, mov1, mov2, br;
> +	int rd;
> +
> +	BUG_ON(pltsec->plt_num_entries > pltsec->plt_max_entries);

I'd prefer just to fail loading the module, but I see we already have
a BUG_ON for the existing PLT code. Oh well.

> +
> +	/* get the destination register of the ADRP instruction */
> +	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD,
> +					  le32_to_cpup((__le32 *)loc));
> +
> +	/* generate the veneer instructions */
> +	mov0 = aarch64_insn_gen_movewide(rd, (u16)~val, 0,
> +					 AARCH64_INSN_VARIANT_64BIT,
> +					 AARCH64_INSN_MOVEWIDE_INVERSE);
> +	mov1 = aarch64_insn_gen_movewide(rd, (u16)(val >> 16), 16,
> +					 AARCH64_INSN_VARIANT_64BIT,
> +					 AARCH64_INSN_MOVEWIDE_KEEP);
> +	mov2 = aarch64_insn_gen_movewide(rd, (u16)(val >> 32), 32,
> +					 AARCH64_INSN_VARIANT_64BIT,
> +					 AARCH64_INSN_MOVEWIDE_KEEP);
> +	br = aarch64_insn_gen_branch_imm((u64)&plt[i].br, (u64)loc + 4,
> +					 AARCH64_INSN_BRANCH_NOLINK);
> +
> +	plt[i] = (struct plt_entry){
> +			cpu_to_le32(mov0),
> +			cpu_to_le32(mov1),
> +			cpu_to_le32(mov2),
> +			cpu_to_le32(br)
> +		};
> +
> +	return (u64)&plt[i];
> +}
> +#endif
> +
>  #define cmp_3way(a,b)	((a) < (b) ? -1 : (a) > (b))
>  
>  static int cmp_rela(const void *a, const void *b)
> @@ -68,16 +108,21 @@ static bool duplicate_rel(const Elf64_Rela *rela, int num)
>  }
>  
>  static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
> -			       Elf64_Word dstidx)
> +			       Elf64_Word dstidx, Elf_Shdr *dstsec)
>  {
>  	unsigned int ret = 0;
>  	Elf64_Sym *s;
>  	int i;
>  
>  	for (i = 0; i < num; i++) {
> +		u64 min_align;
> +
>  		switch (ELF64_R_TYPE(rela[i].r_info)) {
>  		case R_AARCH64_JUMP26:
>  		case R_AARCH64_CALL26:
> +			if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +				break;
> +
>  			/*
>  			 * We only have to consider branch targets that resolve
>  			 * to symbols that are defined in a different section.
> @@ -109,6 +154,31 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
>  			if (rela[i].r_addend != 0 || !duplicate_rel(rela, i))
>  				ret++;
>  			break;
> +		case R_AARCH64_ADR_PREL_PG_HI21_NC:
> +		case R_AARCH64_ADR_PREL_PG_HI21:
> +			if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419))
> +				break;
> +
> +			/*
> +			 * Determine the minimal safe alignment for this ADRP
> +			 * instruction: the section alignment at which it is
> +			 * guaranteed not to appear at a vulnerable offset.
> +			 */
> +			min_align = 2 << ffz(rela[i].r_offset | 0x7);

I'm struggling to decipher this, can you give me a hint please? Why 0x7? Is
the "2" because of the two vulnerable offsets?

Will
