From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Jun 2017 18:15:52 +0100
Subject: [PATCH v2 1/2] arm64: ftrace: don't validate branch via PLT in
 ftrace_make_nop()
In-Reply-To: <20170530135220.20759-2-ard.biesheuvel@linaro.org>
References: <20170530135220.20759-1-ard.biesheuvel@linaro.org>
 <20170530135220.20759-2-ard.biesheuvel@linaro.org>
Message-ID: <20170605171552.GQ21944@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 01:52:19PM +0000, Ard Biesheuvel wrote:
> When turning branch instructions into NOPs, we attempt to validate the
> action by comparing the old value at the call site with the opcode of
> a direct relative branch instruction pointing at the old target.
> 
> However, these call sites are statically initialized to call _mcount(),
> and may be redirected via a PLT entry if the module is loaded far away
> from the kernel text, leading to false negatives and spurious errors.
> 
> So skip the validation if CONFIG_ARM64_MODULE_PLTS is configured.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/ftrace.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 40ad08ac569a..a8db6857cad6 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -84,12 +84,15 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  		    unsigned long addr)
>  {
>  	unsigned long pc = rec->ip;
> -	u32 old, new;
> +	u32 old = 0, new;
>  
> -	old = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
> +	if (!IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
> +		old = aarch64_insn_gen_branch_imm(pc, addr,
> +						  AARCH64_INSN_BRANCH_LINK);
>  	new = aarch64_insn_gen_nop();
>  
> -	return ftrace_modify_code(pc, old, new, true);
> +	return ftrace_modify_code(pc, old, new,
> +				  !IS_ENABLED(CONFIG_ARM64_MODULE_PLTS));

Even in the case of PLTs, the instruction is still a branch instruction,
so could we validate the basic opcode fields rather than disable the check
altogether?

Will
