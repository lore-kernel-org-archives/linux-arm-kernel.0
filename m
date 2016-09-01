From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Thu, 1 Sep 2016 11:38:10 +0900
Subject: [PATCH] arm64: Improve kprobes test for atomic sequence
In-Reply-To: <1472676742-2250-1-git-send-email-dave.long@linaro.org>
References: <1472676742-2250-1-git-send-email-dave.long@linaro.org>
Message-ID: <20160901113810.91a6c6aefcdab761c9fb1ff0@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Wed, 31 Aug 2016 16:52:22 -0400
David Long <dave.long@linaro.org> wrote:

> From: "David A. Long" <dave.long@linaro.org>
> 
> Kprobes searches backwards a finite number of instructions to determine if
> there is an attempt to probe a load/store exclusive sequence. It stops when
> it hits the maximum number of instructions or a load or store exclusive.

Hmm, so on aarch64, we can not put a kprobe between load exclusive and
store exclusive, because kprobe always breaks the atomicity, am I correct?
If so, what happen if any branch in the sequence? e.g.

  load-ex
  (do something)
l1:
  store-ex
...
  load-ex
  (do something)
  branch l1;

> However this means it can run up past the beginning of the function and
> start looking at literal constants. This has been shown to cause a false
> positive and blocks insertion of the probe. To fix this add a test to see
> if the typical:
> 
> 	"stp x29, x30, [sp, #n]!"
> 
> instruction beginning a function gets hit. This also improves efficiency by
> not testing code that is not part of the function. There is some
> possibility that a function will not begin with this instruction, in which
> case the fixed code will behave no worse than before.

If the function boundary is the problem, why you wouldn't use kallsyms information
as I did in can_optimize()@arch/x86/kernel/kprobes/opt.c ?

        /* Lookup symbol including addr */
        if (!kallsyms_lookup_size_offset(paddr, &size, &offset))
                return 0;

With this call, symbol start address is (paddr - offset) and end address
is (paddr - offset + size).

Thank you,

> 
> There could also be the case that the stp instruction is found further in
> the body of the function, which could theoretically allow probing of an
> atomic squence. The likelihood of this seems low, and this would not be the
> only aspect of kprobes where the user needs to be careful to avoid
> problems.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm64/kernel/probes/decode-insn.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
> index 37e47a9..248e820 100644
> --- a/arch/arm64/kernel/probes/decode-insn.c
> +++ b/arch/arm64/kernel/probes/decode-insn.c
> @@ -122,16 +122,28 @@ arm_probe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
>  static bool __kprobes
>  is_probed_address_atomic(kprobe_opcode_t *scan_start, kprobe_opcode_t *scan_end)
>  {
> +	const u32 stp_x29_x30_sp_pre = 0xa9807bfd;
> +	const u32 stp_ignore_index_mask = 0xffc07fff;
> +	u32 instruction = le32_to_cpu(*scan_start);
> +
>  	while (scan_start > scan_end) {
>  		/*
> -		 * atomic region starts from exclusive load and ends with
> -		 * exclusive store.
> +		 * Atomic region starts from exclusive load and ends with
> +		 * exclusive store. If we hit a "stp x29, x30, [sp, #n]!"
> +		 * assume it is the beginning of the function and end the
> +		 * search. This helps avoid false positives from literal
> +		 * constants that look like a load-exclusive, in addition
> +		 * to being more efficient.
>  		 */
> -		if (aarch64_insn_is_store_ex(le32_to_cpu(*scan_start)))
> +		if ((instruction & stp_ignore_index_mask) == stp_x29_x30_sp_pre)
>  			return false;
> -		else if (aarch64_insn_is_load_ex(le32_to_cpu(*scan_start)))
> -			return true;
> +
>  		scan_start--;
> +		instruction = le32_to_cpu(*scan_start);
> +		if (aarch64_insn_is_store_ex(instruction))
> +			return false;
> +		else if (aarch64_insn_is_load_ex(instruction))
> +			return true;
>  	}
>  
>  	return false;
> @@ -142,7 +154,6 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
>  {
>  	enum kprobe_insn decoded;
>  	kprobe_opcode_t insn = le32_to_cpu(*addr);
> -	kprobe_opcode_t *scan_start = addr - 1;
>  	kprobe_opcode_t *scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
>  #if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
>  	struct module *mod;
> @@ -167,7 +178,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
>  	decoded = arm_probe_decode_insn(insn, asi);
>  
>  	if (decoded == INSN_REJECTED ||
> -			is_probed_address_atomic(scan_start, scan_end))
> +			is_probed_address_atomic(addr, scan_end))
>  		return INSN_REJECTED;
>  
>  	return decoded;
> -- 
> 2.5.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
