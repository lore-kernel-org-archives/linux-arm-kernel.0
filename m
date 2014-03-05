From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 5 Mar 2014 15:50:33 +0200
Subject: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
In-Reply-To: <alpine.DEB.2.02.1402201927280.10791@utopia.booyaka.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
 <alpine.DEB.2.02.1402201927280.10791@utopia.booyaka.com>
Message-ID: <53172BA9.2050901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/02/14 21:30, Paul Walmsley wrote:
> On Wed, 19 Feb 2014, Paul Walmsley wrote:
> 
>> On Fri, 17 Jan 2014, Tomi Valkeinen wrote:
>>
>>> This patch adds a simple method of rounding: during the iteration, the 
>>> code keeps track of the closest rate match. If no exact match is found, 
>>> the closest is returned.
>>
>> So that's one possible rounding policy; maybe it works fine for a display 
>> interface PLL, at least for some values of "closest rate".  But another 
>> might be "only allow a selection from a set of pre-determined rates 
>> characterized by the silicon validation team".  Or another rounding 
>> function might need to select a more distant rate that minimizes jitter, 
>> EMI, or power consumption.  
> 
> Thought about this some more.  Do you only need this for the DSS PLL, or 
> do you need it for one of the core OMAP PLLs?
> 
> If the former, then how about modifying your patch to create a separate 
> round_rate function that's only used for the DSS PLL that implements the 
> behavior that you want?
> 
> That would eliminate any risk of impacting other users on the system.  And 
> would also allow this change to get into the codebase much faster, since 
> there's no need for clk API changes, etc.

How about this one:

>From f5a78303411e9192899a6a681acac37f09f4cc3b Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 15 Jan 2014 11:45:07 +0200
Subject: [PATCH] ARM: OMAP2+: fix dpll round_rate() to actually round

omap2_dpll_round_rate() doesn't actually round the given rate, even if
the name and the description so hints. Instead it only tries to find an
exact rate match, or if that fails, return ~0 as an error.

What this basically means is that the user of the clock needs to know
what rates the dpll can support, which obviously isn't right.

This patch adds a simple method of rounding: during the iteration, the
code keeps track of the closest rate match. If no exact match is found,
the closest is returned.

However, as it is unclear whether current drivers rely on the current
behavior, the rounding functionality not enabled by default, but by
setting DPLL_USE_ROUNDED_RATE for the DPLL.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c | 23 ++++++++++++++++++-----
 drivers/clk/ti/dpll.c           |  3 +++
 include/linux/clk/ti.h          |  1 +
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 2649ce445845..fed7538e1eed 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -298,6 +298,8 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 	struct dpll_data *dd;
 	unsigned long ref_rate;
 	const char *clk_name;
+	unsigned long diff, closest_diff = ~0;
+	bool use_rounding = clk->flags & DPLL_USE_ROUNDED_RATE;
 
 	if (!clk || !clk->dpll_data)
 		return ~0;
@@ -345,20 +347,31 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 		pr_debug("clock: %s: m = %d: n = %d: new_rate = %lu\n",
 			 clk_name, m, n, new_rate);
 
-		if (target_rate == new_rate) {
+		diff = max(target_rate, new_rate) - min(target_rate, new_rate);
+
+		if ((use_rounding && diff < closest_diff) ||
+			(!use_rounding && diff == 0)) {
+			closest_diff = diff;
+
 			dd->last_rounded_m = m;
 			dd->last_rounded_n = n;
-			dd->last_rounded_rate = target_rate;
-			break;
+			dd->last_rounded_rate = new_rate;
+
+			if (diff == 0)
+				break;
 		}
 	}
 
-	if (target_rate != new_rate) {
+	if (closest_diff == ~0) {
 		pr_debug("clock: %s: cannot round to rate %lu\n",
 			 clk_name, target_rate);
 		return ~0;
 	}
 
-	return target_rate;
+	if (closest_diff > 0)
+		pr_debug("clock: %s: rounded rate %lu to %lu\n",
+			 clk_name, target_rate, dd->last_rounded_rate);
+
+	return dd->last_rounded_rate;
 }
 
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 7e498a44f97d..c5858c46b58c 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -265,6 +265,9 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 	if (dpll_mode)
 		dd->modes = dpll_mode;
 
+	if (of_property_read_bool(node, "ti,round-rate"))
+		clk_hw->flags |= DPLL_USE_ROUNDED_RATE;
+
 	ti_clk_register_dpll(&clk_hw->hw, node);
 	return;
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 092b64168d7f..c9ed8b6b8513 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -155,6 +155,7 @@ struct clk_hw_omap {
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
 #define CLOCK_CLKOUTX2		(1 << 5)
 #define MEMMAP_ADDRESSING	(1 << 6)
+#define DPLL_USE_ROUNDED_RATE	(1 << 7)	/* dpll's round_rate() returns rounded rate */
 
 /* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
 #define DPLL_LOW_POWER_STOP	0x1
-- 
1.8.3.2



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/3f6d61f6/attachment.sig>
