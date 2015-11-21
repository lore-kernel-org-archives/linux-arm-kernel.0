From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sat, 21 Nov 2015 11:50:28 +0000
Subject: [RFC/PATCH 3/3] ARM: Replace calls to __aeabi_{u}idiv with
 udiv/sdiv instructions
In-Reply-To: <1448068997-26631-4-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Fri, 20 Nov 2015 17:23:17 -0800")
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <1448068997-26631-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <yw1xd1v3d117.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> +static int module_patch_aeabi_uidiv(unsigned long loc, const Elf32_Sym *sym)
> +{
> +	extern char __aeabi_uidiv[], __aeabi_idiv[];
> +	unsigned long udiv_addr = (unsigned long)__aeabi_uidiv;
> +	unsigned long sdiv_addr = (unsigned long)__aeabi_idiv;
> +	unsigned int udiv_insn, sdiv_insn, mask;
> +
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> +		mask = HWCAP_IDIVT;
> +		udiv_insn = __opcode_to_mem_thumb32(0xfbb0f0f1);
> +		sdiv_insn = __opcode_to_mem_thumb32(0xfb90f0f1);
> +	} else {
> +		mask = HWCAP_IDIVA;
> +		udiv_insn = __opcode_to_mem_arm(0xe730f110);
> +		sdiv_insn = __opcode_to_mem_arm(0xe710f110);
> +	}
> +
> +	if (elf_hwcap & mask) {
> +		if (sym->st_value == udiv_addr) {
> +			*(u32 *)loc = udiv_insn;
> +			return 1;
> +		} else if (sym->st_value == sdiv_addr) {
> +			*(u32 *)loc = sdiv_insn;
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}

[...]

> +static void __init patch_aeabi_uidiv(void)
> +{
> +	extern unsigned long *__start_udiv_loc[], *__stop_udiv_loc[];
> +	extern unsigned long *__start_idiv_loc[], *__stop_idiv_loc[];
> +	unsigned long **p;
> +	unsigned int udiv_insn, sdiv_insn, mask;
> +
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> +		mask = HWCAP_IDIVT;
> +		udiv_insn = __opcode_to_mem_thumb32(0xfbb0f0f1);
> +		sdiv_insn = __opcode_to_mem_thumb32(0xfb90f0f1);
> +	} else {
> +		mask = HWCAP_IDIVA;
> +		udiv_insn = __opcode_to_mem_arm(0xe730f110);
> +		sdiv_insn = __opcode_to_mem_arm(0xe710f110);
> +	}
> +
> +	if (elf_hwcap & mask) {
> +		for (p = __start_udiv_loc; p < __stop_udiv_loc; p++) {
> +			unsigned long *inst = *p;
> +			*inst = udiv_insn;
> +		}
> +		for (p = __start_idiv_loc; p < __stop_idiv_loc; p++) {
> +			unsigned long *inst = *p;
> +			*inst = sdiv_insn;
> +		}
> +	}
> +}

These functions are rather similar.  Perhaps they could be combined
somehow.

-- 
M?ns Rullg?rd
mans at mansr.com
