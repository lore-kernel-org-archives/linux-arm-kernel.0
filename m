From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 15 Feb 2011 23:52:53 -0700
Subject: [PATCH 08/11] OMAP2430/3xxx: clock: add modem clock autoidle support
In-Reply-To: <20110216065030.22089.61217.stgit@twilight.localdomain>
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
Message-ID: <20110216065251.22089.75492.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP2430 and OMAP3xxx have modem autoidle bits that are actually
attached to clocks with CM_FCLKEN bits; add the code and data to
handle these.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clkt_iclk.c |    9 +++++++++
 arch/arm/mach-omap2/clock.h     |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index dd8a6d3..3d43fba 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/arch/arm/mach-omap2/clkt_iclk.c
@@ -71,3 +71,12 @@ const struct clkops clkops_omap2_iclk_idle_only = {
 	.deny_idle	= omap2_clkt_iclk_deny_idle,
 };
 
+const struct clkops clkops_omap2_mdmclk_dflt_wait = {
+	.enable		= omap2_dflt_clk_enable,
+	.disable	= omap2_dflt_clk_disable,
+	.find_companion	= omap2_clk_dflt_find_companion,
+	.find_idlest	= omap2_clk_dflt_find_idlest,
+	.allow_idle	= omap2_clkt_iclk_allow_idle,
+	.deny_idle	= omap2_clkt_iclk_deny_idle,
+};
+
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 5008f14..70f8b07 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -155,6 +155,7 @@ extern void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
 extern const struct clkops clkops_omap2_iclk_dflt_wait;
 extern const struct clkops clkops_omap2_iclk_dflt;
 extern const struct clkops clkops_omap2_iclk_idle_only;
+extern const struct clkops clkops_omap2_mdmclk_dflt_wait;
 extern const struct clkops clkops_omap2xxx_dpll_ops;
 extern const struct clkops clkops_omap3_noncore_dpll_ops;
 extern const struct clkops clkops_omap3_core_dpll_ops;
