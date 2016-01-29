From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Jan 2016 10:30:51 -0800
Subject: [PATCH] clocksource/arm_arch_timer: Enable and verify MMIO access
In-Reply-To: <b4ccba950f8fe0433b8e258a1fc0b8977bbe82d5.1454079150.git.robin.murphy@arm.com>
References: <b4ccba950f8fe0433b8e258a1fc0b8977bbe82d5.1454079150.git.robin.murphy@arm.com>
Message-ID: <20160129183051.GO12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29, Robin Murphy wrote:
> So far, we have been blindly assuming that if a memory-mapped timer
> frame exists, then we have access to it. Whilst it's the firmware's
> job to give us non-secure access to frames in the first place, we
> should not rely on it always being generous enough to also configure
> CNTACR if it's not even using those frames itself.

Hm, that first sentence is sort of misleading. We've been blindly
assuming that the firmware has configured CNTACR to have the
correct bits set for virtual/physical access. We've always relied
on status = "disabled" to figure out if we can access an entire
frame or not.

> 
> Explicitly enable feature-level access per-frame, and verify that the
> access we want is really implemented before trying to make use of it.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/clocksource/arm_arch_timer.c | 39 ++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index c64d543..c88485d 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -765,20 +772,34 @@ static void __init arch_timer_mem_init(struct device_node *np)
>  	 */
>  	for_each_available_child_of_node(np, frame) {
>  		int n;
> +		u32 cntacr;
>  
>  		if (of_property_read_u32(frame, "frame-number", &n)) {
>  			pr_err("arch_timer: Missing frame-number\n");
> -			of_node_put(best_frame);
>  			of_node_put(frame);
> -			return;
> +			goto out;
>  		}
>  
> -		if (cnttidr & CNTTIDR_VIRT(n)) {
> +		/* Try enabling everything, and see what sticks */
> +		cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
> +			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
> +		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
> +		cntacr = readl_relaxed(cntctlbase + CNTACR(n));
> +
> +		if (~cntacr & CNTACR_RFRQ)
> +			continue;

Do we need this check? If we can't read the frequency we fall
back to looking for the DT property, so it shouldn't matter if we
can't read the hardware there.

> +
> +		if ((cnttidr & CNTTIDR_VIRT(n)) &&
> +		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
>  			of_node_put(best_frame);
>  			best_frame = frame;
>  			arch_timer_mem_use_virtual = true;
>  			break;
>  		}
> +
> +		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
> +			continue;
> +
>  		of_node_put(best_frame);
>  		best_frame = of_node_get(frame);
>  	}

Otherwise the patch looks fine and passes some light testing on
qcom devices.

BTW, I'd like to add this patch on top so that we get some info
in /proc/iomem about which frame region is in use.

---8<---
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] clocksource/arm_arch_timer: Map frame with
 of_io_request_and_map()

Let's use the of_io_request_and_map() API so that the frame
region is protected and shows up in /proc/iomem.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/arm_arch_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index c88485d489bf..59a08fd4f76a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -804,7 +804,8 @@ static void __init arch_timer_mem_init(struct device_node *np)
 		best_frame = of_node_get(frame);
 	}
 
-	base = arch_counter_base = of_iomap(best_frame, 0);
+	base = arch_counter_base = of_io_request_and_map(best_frame, 0,
+							 "arch_mem_timer");
 	if (!base) {
 		pr_err("arch_timer: Can't map frame's registers\n");
 		goto out;
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
