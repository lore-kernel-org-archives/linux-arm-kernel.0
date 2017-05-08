From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 May 2017 14:27:04 +0100
Subject: [PATCH] clocksource: arm_arch_timer: fix
 arch_timer_mem_find_best_frame
In-Reply-To: <1494246747-17267-1-git-send-email-sudeep.holla@arm.com>
References: <1494246747-17267-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20170508132703.GD5480@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 08, 2017 at 01:32:27PM +0100, Sudeep Holla wrote:
> arch_timer_mem_find_best_frame looks through ARCH_TIMER_MEM_MAX_FRAMES
> frames even after finding matches to ensure the best frame is chosen,
> which means the variable frame will point to the last valid frame but
> not necessarily the best frame.
> 
> On Juno, we get the following error as wrong frame is returned as the
> best frame from arch_timer_mem_find_best_frame:
> "
> 	arch_timer: Unable to map frame @ 0x0000000000000000
> 	arch_timer: Frame missing phys irq.
> 	Failed to initialize '/timer at 2a810000': -22
> "
> 
> This patch fixes the issue by correctly returning the best frame from
> arch_timer_mem_find_best_frame.
> 
> Fixes: c389d701dfb7 ("clocksource: arm_arch_timer: split MMIO timer probing.")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Sorry about this; thanks for correcting it.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Daniel, Thomas, could you please pick this up?

Thanks,
Mark.

> ---
>  drivers/clocksource/arm_arch_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index a1fb918b8021..4bed671e490e 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1268,7 +1268,7 @@ arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem)
>  		pr_err("Unable to find a suitable frame in timer @ %pa\n",
>  			&timer_mem->cntctlbase);
>  
> -	return frame;
> +	return best_frame;
>  }
>  
>  static int __init
> -- 
> 2.7.4
