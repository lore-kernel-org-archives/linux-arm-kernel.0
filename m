From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 25 Sep 2012 19:05:39 +0300
Subject: [PATCHv6 08/11] ARM: OMAP4: clock data: set autoidle flag for dss_fck
In-Reply-To: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
References: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
Message-ID: <1348589142-11983-9-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dss_fck is currently being used improperly within the hwmod database
as an interface clock for DSS hwmods. This causes the dss_fck to
be enabled even if the dss powerdomain itself is idle, resulting
in wrong data within the powerdomain usecounts. Marked dss_fck as
autoidle which makes the clock to disappear from usecounts for now.
This patch can be reverted once the interface clocks for DSS hwmods
have been properly fixed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index d7f55e4..95834d7 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1408,6 +1408,7 @@ static struct clk dss_fck = {
 	.clkdm_name	= "l3_dss_clkdm",
 	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
+	.autoidle	= true,
 };
 
 static struct clk efuse_ctrl_cust_fck = {
-- 
1.7.4.1
