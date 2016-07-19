From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jul 2016 15:36:50 +0100
Subject: [PATCH 2/4] arm64: debug: remove redundant spsr manipulation
In-Reply-To: <1468937260-23988-2-git-send-email-will.deacon@arm.com>
References: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
 <1468937260-23988-2-git-send-email-will.deacon@arm.com>
Message-ID: <20160719143614.GA22473@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 03:07:38PM +0100, Will Deacon wrote:
> There is no need to explicitly clear the SS bit immediately before
> setting it unconditionally.
> 
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/debug-monitors.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 7a907e401c98..91fff48d0f57 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -170,22 +170,13 @@ postcore_initcall(debug_monitors_init);
>   */
>  static void set_regs_spsr_ss(struct pt_regs *regs)
>  {
> -	unsigned long spsr;
> -
> -	spsr = regs->pstate;
> -	spsr &= ~DBG_SPSR_SS;
> -	spsr |= DBG_SPSR_SS;
> -	regs->pstate = spsr;
> +	regs->pstate |= DBG_SPSR_SS;
>  }
>  NOKPROBE_SYMBOL(set_regs_spsr_ss);
>  
>  static void clear_regs_spsr_ss(struct pt_regs *regs)
>  {
> -	unsigned long spsr;
> -
> -	spsr = regs->pstate;
> -	spsr &= ~DBG_SPSR_SS;
> -	regs->pstate = spsr;
> +	regs->pstate &= ~DBG_SPSR_SS;
>  }
>  NOKPROBE_SYMBOL(clear_regs_spsr_ss);
>  
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
