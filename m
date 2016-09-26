From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Sep 2016 15:06:42 +0100
Subject: [PATCH 2/3] arm64: hw_breakpoint: Handle inexact watchpoint
 addresses
In-Reply-To: <1474643941-109020-2-git-send-email-labath@google.com>
References: <1474643941-109020-1-git-send-email-labath@google.com>
 <1474643941-109020-2-git-send-email-labath@google.com>
Message-ID: <20160926140642.GL5317@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Fri, Sep 23, 2016 at 04:19:00PM +0100, Pavel Labath wrote:
> Arm64 hardware does not always report a watchpoint hit address that
> matches one of the watchpoints set. It can also report an address
> "near" the watchpoint if a single instruction access both watched and
> unwatched addresses. There is no straight-forward way, short of
> disassembling the offending instruction, to map that address back to
> the watchpoint.
> 
> Previously, when the hardware reported a watchpoint hit on an address
> that did not match our watchpoint (this happens in case of instructions
> which access large chunks of memory such as "stp") the process would
> enter a loop where we would be continually resuming it (because we did
> not recognise that watchpoint hit) and it would keep hitting the
> watchpoint again and again. The tracing process would never get
> notified of the watchpoint hit.
> 
> This commit fixes the problem by looking at the watchpoints near the
> address reported by the hardware. If the address does not exactly match
> one of the watchpoints we have set, it attributes the hit to the
> nearest watchpoint we have.  This heuristic is a bit dodgy, but I don't
> think we can do much more, given the hardware limitations.
> 
> Signed-off-by: Pavel Labath <labath@google.com>
> ---
>  arch/arm64/kernel/hw_breakpoint.c | 98 +++++++++++++++++++++++++--------------
>  1 file changed, 64 insertions(+), 34 deletions(-)

If the first patch in the series is no longer required (as you stated in
your follow-up reply), then you can just drop it.

> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 14562ae..3ce27ea 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -664,49 +664,63 @@ unlock:
>  }
>  NOKPROBE_SYMBOL(breakpoint_handler);
>  
> +/*
> + * Arm64 hardware does not always report a watchpoint hit address that matches
> + * one of the watchpoints set. It can also report an address "near" the
> + * watchpoint if a single instruction access both watched and unwatched
> + * addresses. There is no straight-forward way, short of disassembling the
> + * offending instruction, to map that address back to the watchpoint. This
> + * function computes the distance of the memory access from the watchpoint as a
> + * heuristic for the likelyhood that a given access triggered the watchpoint.
> + *
> + * See Section D2.10.5 "Determining the memory location that caused a Watchpoint
> + * exception" of ARMv8 Architecture Reference Manual for details.
> + *
> + * The function returns the distance of the address from the bytes watched by
> + * the watchpoint. In case of an exact match, it returns 0.
> + */
> +static u64 get_distance_from_watchpoint(unsigned long addr, int i,
> +					struct arch_hw_breakpoint *info)
> +{
> +	u64 wp_low, wp_high;
> +	int first_bit;
> +
> +	first_bit = ffs(info->ctrl.len);
> +	if (first_bit == 0)
> +		return -1;
> +
> +	wp_low = info->address + first_bit - 1;
> +	wp_high = info->address + fls(info->ctrl.len) - 1;

This would all be cleaner if you just called get_hbp_len(info->ctrl.len)
to get the size of the watchpoint. We don't do anything sophisticated
with the BAS, so you can assume everything is base + len.

> @@ -723,10 +748,15 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
>  		/* Do we need to handle the stepping? */
>  		if (is_default_overflow_handler(wp))
>  			step = 1;
> -
> -unlock:
> -		rcu_read_unlock();
>  	}
> +	if (min_dist > 0 && min_dist != -1) {

min_dist is unsigned, so this could be:

	if (min_dist + 1 > 1)

Will
