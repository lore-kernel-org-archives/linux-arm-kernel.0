From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 4 Jul 2017 10:40:09 +0100
Subject: [PATCH 1/2] arm64: hw_breakpoint: Allow stepping if a kernel
 mode overflow handler exists
In-Reply-To: <dbbac1fa86f7da197e26245e20b1c8da572ca7fd.1499107909.git.panand@redhat.com>
References: <cover.1499107909.git.panand@redhat.com>
 <dbbac1fa86f7da197e26245e20b1c8da572ca7fd.1499107909.git.panand@redhat.com>
Message-ID: <20170704094008.GA20062@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 12:40:26AM +0530, Pratyush Anand wrote:
> Currently we allow to single step only for the perf user. However, we
> have a kernel sample test (samples/hw_breakpoint/data_breakpoint.c)
> which implements its own overflow handler. Therefore, additionally
> allow single stepping if there exists a overflow handler in kernel mode.
> 
> We still have issues with test, which causes kernel to go into an
> infinite loop of overflow_handler being called, and that reveals a
> corner case bug with perf breakpoint implementation as well. See
> the next patch, which talks more about it and attempts to resolve it.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  arch/arm64/kernel/hw_breakpoint.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 749f81779420..46dbbf94f72d 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -661,7 +661,8 @@ static int breakpoint_handler(unsigned long unused, unsigned int esr,
>  		perf_bp_event(bp, regs);
>  
>  		/* Do we need to handle the stepping? */
> -		if (is_default_overflow_handler(bp))
> +		if (is_default_overflow_handler(bp) ||
> +				(!user_mode(regs) && bp->overflow_handler))

I don't think it makes sense to do this differently dependent on the
regs.

If common code needs a particular single-stepping behaviour that we can
provide, the best thing would be to have a flag on the event, so that we
can do something like:

	if (event_needs_single_step(bp))

Then we can ensure that the events used by GDB *don't* have that flag
set, so we don't step unexpectedly.

Thanks,
Mark.

>  			step = 1;
>  unlock:
>  		rcu_read_unlock();
> @@ -789,7 +790,8 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
>  		perf_bp_event(wp, regs);
>  
>  		/* Do we need to handle the stepping? */
> -		if (is_default_overflow_handler(wp))
> +		if (is_default_overflow_handler(wp) ||
> +				(!user_mode(regs) && wp->overflow_handler))
>  			step = 1;
>  	}
>  	if (min_dist > 0 && min_dist != -1) {
> @@ -800,7 +802,8 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
>  		perf_bp_event(wp, regs);
>  
>  		/* Do we need to handle the stepping? */
> -		if (is_default_overflow_handler(wp))
> +		if (is_default_overflow_handler(wp) ||
> +				(!user_mode(regs) && wp->overflow_handler))
>  			step = 1;
>  	}
>  	rcu_read_unlock();
> -- 
> 2.9.3
> 
