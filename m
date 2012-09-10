From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Sep 2012 10:53:37 -0700
Subject: [PATCH v2] perf: Use pre-empt safe cpu_get/put insted of
 smp_processor_id
In-Reply-To: <1347276614-4334-1-git-send-email-rogerq@ti.com>
References: <1347276614-4334-1-git-send-email-rogerq@ti.com>
Message-ID: <504E2921.50408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/12 04:30, Roger Quadros wrote:
> gets rid of below messages with CONFIG_DEBUG_PREEMPT enabled
>
> [   28.832916] debug_smp_processor_id: 18 callbacks suppressed
> [   28.832946] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/1763
> [   28.841491] caller is pwrdm_set_next_pwrst+0x54/0x120
>
> changes in v2:
> - rebased on 3.6-rc5
> - use put_cpu() immediately after get_cpu() in omap3_pm_idle()
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/clock.c       |    9 ++++++---
>  arch/arm/mach-omap2/pm34xx.c      |   12 ++++++++----
>  arch/arm/mach-omap2/powerdomain.c |    6 ++++--
>  3 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index ea3f565..06747b6 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -285,7 +285,8 @@ void omap2_clk_disable(struct clk *clk)
>  	pr_debug("clock: %s: disabling in hardware\n", clk->name);
>  
>  	if (clk->ops && clk->ops->disable) {
> -		trace_clock_disable(clk->name, 0, smp_processor_id());
> +		trace_clock_disable(clk->name, 0, get_cpu());
> +		put_cpu();

Why are you doing this? Why not just use raw_smp_processor_id()? Do you
really care about the CPU number? get_cpu() and put_cpu() are about
non-preemptible sections where you want to ensure the CPU the code is
operating on is actually on that CPU.

How about just put 0 all the time because the CPU number is already part
of the trace event?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
