From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Oct 2017 17:17:55 +0100
Subject: [PATCH 3/4] arm64: traps: Pretty-print pstate in register dumps
In-Reply-To: <1508428534-20694-4-git-send-email-will.deacon@arm.com>
References: <1508428534-20694-1-git-send-email-will.deacon@arm.com>
 <1508428534-20694-4-git-send-email-will.deacon@arm.com>
Message-ID: <20171019161754.5xnqloqx52sjbtvr@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 04:55:33PM +0100, Will Deacon wrote:
> We can decode the PSTATE easily enough, so pretty-print it in register
> dumps.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/process.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index c20896b8fb2d..be3cf9cd7dec 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -170,6 +170,23 @@ void machine_restart(char *cmd)
>  	while (1);
>  }
>  
> +static void print_pstate(struct pt_regs *regs)
> +{
> +	u64 pstate = regs->pstate;
> +	printk("pstate: %08llx (%c%c%c%c %c%c%c%c %cPAN %cUAO)\n",
> +		pstate,
> +		pstate & PSR_N_BIT ? 'N' : 'n',
> +		pstate & PSR_Z_BIT ? 'Z' : 'z',
> +		pstate & PSR_C_BIT ? 'C' : 'c',
> +		pstate & PSR_V_BIT ? 'V' : 'v',
> +		pstate & PSR_D_BIT ? 'D' : 'd',
> +		pstate & PSR_A_BIT ? 'A' : 'a',
> +		pstate & PSR_I_BIT ? 'I' : 'i',
> +		pstate & PSR_F_BIT ? 'F' : 'f',
> +		pstate & PSR_PAN_BIT ? '+' : '-',
> +		pstate & PSR_UAO_BIT ? '+' : '-');
> +}

Given we use __show_regs for user state, I think we need to check
compat_user_mode() regs, and adjust the decoding accordingly.

e.g. AArch32 has an E bit where the D in DAIF is.

Thanks,
Mark.

> +
>  void __show_regs(struct pt_regs *regs)
>  {
>  	int i, top_reg;
> @@ -186,9 +203,10 @@ void __show_regs(struct pt_regs *regs)
>  	}
>  
>  	show_regs_print_info(KERN_DEFAULT);
> +	print_pstate(regs);
>  	print_symbol("pc : %s\n", regs->pc);
>  	print_symbol("lr : %s\n", lr);
> -	printk("sp : %016llx pstate : %08llx\n", sp, regs->pstate);
> +	printk("sp : %016llx\n", sp);
>  
>  	i = top_reg;
>  
> -- 
> 2.1.4
> 
