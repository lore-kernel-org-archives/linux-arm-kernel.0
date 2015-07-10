From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:36:50 +0900
Subject: [PATCH 03/16] ARM: shmobile: r8a7779: Remove GENPD_FLAG_PM_CLK flag
In-Reply-To: <cover.1436509680.git.horms+renesas@verge.net.au>
References: <cover.1436509680.git.horms+renesas@verge.net.au>
Message-ID: <564ec128320b3a69e7be6bed938be5b78e5aac95.1436509680.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The R-Car SYSC PM Domain only manages power domains for the main CPUs
and for coprocessors. It does not fill in the genpd .{at,de}tach_dev()
callbacks, and no power management clocks are registered for devices.
Hence pm_clk_{suspend,resume}() are no-ops, and setting of the
GENPD_FLAG_PM_CLK flag can be removed.

Originally the clock handling was copied from the R-Mobile PM Domain
code, which does manage a clock domain, in addition to device power
domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-r8a7779.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 44a74c4c5a01..d5f258e4d890 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -83,7 +83,6 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
 {
 	struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
 
-	genpd->flags = GENPD_FLAG_PM_CLK;
 	pm_genpd_init(genpd, NULL, false);
 	genpd->dev_ops.active_wakeup = pd_active_wakeup;
 	genpd->power_off = pd_power_down;
-- 
2.1.4
