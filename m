From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Sep 2016 17:34:34 +0100
Subject: [PATCH 4/5] arm64: Handle TRAP_BRKPT for user mode as well
In-Reply-To: <9737ec351e2f9f2e7472d8d7133568f7915f20aa.1470114993.git.panand@redhat.com>
References: <cover.1470114993.git.panand@redhat.com>
 <9737ec351e2f9f2e7472d8d7133568f7915f20aa.1470114993.git.panand@redhat.com>
Message-ID: <20160906163434.GH19605@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 11:00:08AM +0530, Pratyush Anand wrote:
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -326,16 +326,20 @@ NOKPROBE_SYMBOL(call_break_hook);
>  static int brk_handler(unsigned long addr, unsigned int esr,
>  		       struct pt_regs *regs)
>  {
> -	if (user_mode(regs)) {
> -		send_user_sigtrap(TRAP_BRKPT);
> -	}
> +	bool handler_found = false;
> +
>  #ifdef	CONFIG_KPROBES
> -	else if ((esr & BRK64_ESR_MASK) == BRK64_ESR_KPROBES) {
> -		if (kprobe_breakpoint_handler(regs, esr) != DBG_HOOK_HANDLED)
> -			return -EFAULT;
> +	if ((esr & BRK64_ESR_MASK) == BRK64_ESR_KPROBES) {
> +		if (kprobe_breakpoint_handler(regs, esr) == DBG_HOOK_HANDLED)
> +			handler_found = true;
>  	}
>  #endif
> -	else if (call_break_hook(regs, esr) != DBG_HOOK_HANDLED) {
> +	if (!handler_found && call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
> +		handler_found = true;
> +
> +	if (!handler_found && user_mode(regs)) {
> +		send_user_sigtrap(TRAP_BRKPT);
> +	} else if (!handler_found) {
>  		pr_warn("Unexpected kernel BRK exception at EL1\n");
>  		return -EFAULT;
>  	}

I think we could do the same here with a single call_break_hook() and
making sure that the corresponding handlers check the esr for the
corresponding BRK encoding.

-- 
Catalin
