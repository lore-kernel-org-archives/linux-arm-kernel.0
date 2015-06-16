From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Jun 2015 15:49:44 +0100
Subject: [PATCH 10/10] arm64/BUG: Show explicit backtrace for WARNs
In-Reply-To: <1434036566-9848-11-git-send-email-Dave.Martin@arm.com>
References: <1434036566-9848-1-git-send-email-Dave.Martin@arm.com>
 <1434036566-9848-11-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150616144944.GF30522@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 04:29:24PM +0100, Dave P Martin wrote:
> The generic slowpath WARN implementation prints a backtrace, but
> the report_bug() based implementation does not, opting to print the
> registers instead which is generally not as useful.
> 
> Ideally, report_bug() should be fixed to make the behaviour more
> consistent, but in the meantime this patch generates a backtrace
> directly from the arm64 backend instead so that this functionality
> is not lost with the migration to report_bug().
> 
> As a side-effect, the backtrace will be outside the oops end
> marker, but that's hard to avoid without modifying generic code.
> 
> This patch can go away if report_bug() grows the ability in the
> future to generate a backtrace directly or call an arch hook at the
> appropriate time.

Could you propose a patch to the core code, please? I'm happy to merge this
in the interim, but it sounds like a simple oversight.

Will

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/kernel/traps.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 5fdf776..8929c16 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -489,6 +489,9 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
>  		/* die() does not return */
>  
>  	case BUG_TRAP_TYPE_WARN:
> +		/* Ideally, report_bug() should backtrace for us... but no. */
> +		dump_backtrace(regs, NULL);
> +
>  		regs->pc += AARCH64_INSN_SIZE;	/* skip BRK and resume */
>  		return DBG_HOOK_HANDLED;
>  
> -- 
> 1.7.10.4
> 
