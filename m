From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Sep 2016 17:11:39 +0100
Subject: [PATCH 3/5] arm64: Handle TRAP_HWBRKPT for user mode as well
In-Reply-To: <ebc25cc4a2ea95cace064aa1c3a2407885623d16.1470114993.git.panand@redhat.com>
References: <cover.1470114993.git.panand@redhat.com>
 <ebc25cc4a2ea95cace064aa1c3a2407885623d16.1470114993.git.panand@redhat.com>
Message-ID: <20160906161139.GG19605@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 11:00:07AM +0530, Pratyush Anand wrote:
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -246,6 +246,8 @@ static void send_user_sigtrap(int si_code)
>  static int single_step_handler(unsigned long addr, unsigned int esr,
>  			       struct pt_regs *regs)
>  {
> +	bool handler_found = false;
> +
>  	/*
>  	 * If we are stepping a pending breakpoint, call the hw_breakpoint
>  	 * handler first.
> @@ -253,7 +255,14 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>  	if (!reinstall_suspended_bps(regs))
>  		return 0;
>  
> -	if (user_mode(regs)) {
> +#ifdef	CONFIG_KPROBES
> +	if (kprobe_single_step_handler(regs, esr) == DBG_HOOK_HANDLED)
> +		handler_found = true;
> +#endif
> +	if (!handler_found && call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
> +		handler_found = true;
> +
> +	if (!handler_found && user_mode(regs)) {
>  		send_user_sigtrap(TRAP_HWBKPT);

Could we register kprobe_single_step_handler() via register_set_hook()
and only invoke call_step_hook() above?

-- 
Catalin
