From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 7 Dec 2012 14:26:34 -0600
Subject: [PATCH] ARM: OMAP4: Fix EMU clock domain always on
Message-ID: <1354911994-20045-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d043d87 (ARM: OMAP2+: clockdomain: bypass clockdomain handling
when disabling unused clks) skips the decrementing of a clock-domains
use count if the clocks use count is zero. However, for OMAP4 devices
this is causing the EMU clock-domain to be stuck ON as the use count is
not getting decremented correctly.

The scenario that leads to this problem is described below ...

omap_hwmod_setup_all
--> _setup
    --> clkdm_hwmod_enable
    	--> EMU clock domain usecount = 1
    --> _enable_clocks
        --> clk_enable
	    --> trace_clk_div_div usecount = 1
            --> clkdm_hwmod_enable
    	        --> EMU clock domain usecount = 2
--> _idle
    --> _disable_clocks
	--> clk_disable
            --> trace_clk_div_div usecount = 0
            --> clkdm_hwmod_disable
                --> skips decrement of EMU clock domain usecount
		    because trace_clk_div_div is 0!
    	        --> EMU clock domain usecount = 2
    --> clkdm_hwmod_disable
    	--> EMU clock domain usecount = 1

Hence, due to the order that a clocks use count is decremented and the
clock domain is disabled, it is possible that the clock domain can have
a non-zero use count when the actual clock has a use count of 0.
Therefore, we should only bypass the clock-domain handling when both the
clock-domain and clock in the clock-domain have a use count of 0 and
warn when the clock-domain has a zero use count and the clock has a
non-zero use count.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---

Based and test on current linux-next tree. This has been boot tested
on OMAP2420, OMAP3430 and OMAP4430. I have validated suspend is working
on OMAP3430.

 arch/arm/mach-omap2/clockdomain.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 3848735..0b5452d 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -998,7 +998,8 @@ int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	spin_lock_irqsave(&clkdm->lock, flags);
 
 	/* corner case: disabling unused clocks */
-	if (__clk_get_enable_count(clk) == 0)
+	if ((__clk_get_enable_count(clk) == 0) &&
+			(atomic_read(&clkdm->usecount) == 0))
 		goto ccd_exit;
 
 	if (atomic_read(&clkdm->usecount) == 0) {
-- 
1.7.10.4
