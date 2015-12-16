From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Dec 2015 11:13:17 +0000
Subject: [PATCH] arm64: reenable interrupt when handling ptrace breakpoint
In-Reply-To: <1450225088-2456-1-git-send-email-yang.shi@linaro.org>
References: <1450225088-2456-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20151216111316.GD4308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 04:18:08PM -0800, Yang Shi wrote:
> The kernel just send out a SIGTRAP signal when handling ptrace breakpoint in
> debug exception, so it sounds safe to have interrupt enabled if it is not
> disabled by the parent process.

Is this actually fixing an issue you're seeing, or did you just spot this?
Given that force_sig_info disable interrupts, I don't think this is really
worth doing.

> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---
>  arch/arm64/kernel/debug-monitors.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 8aee3ae..90d70e4 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -239,6 +239,9 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>  		return 0;
>  
>  	if (user_mode(regs)) {
> +		if (interrupts_enabled(regs))
> +			local_irq_enable();
> +

My worry here is that we take an interrupt and, on the return path,
decide to reschedule due to CONFIG_PREEMPT. If we somehow end up back
in the debugger, I'm concerned that it could remove the breakpoint and
then later see an unexpected SIGTRAP from the child.

Having said that, I've failed to construct a non-racy scenario in which
that can happen, but I'm just really uncomfortable making this change
unless there's a real problem being solved.

Will
