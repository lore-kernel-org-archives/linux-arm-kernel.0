From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 18:41:14 -0500
Subject: [PATCH 3/5] ARM: keystone: Avoid calling of_clk_init() twice
In-Reply-To: <1385250076-9596-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385250076-9596-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385250076-9596-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 4178bac4f {ARM: call of_clk_init from default time_init
handler}, of_clk_init() is always called on machines using default
time_init handler.

So drop the of_clk_init() from keystone code to avoid below
boot errors because of double call.

_of_pll_clk_init: error initializing pll mainpllclk
_of_pll_clk_init: error initializing pll papllclk
_of_pll_clk_init: error initializing pll ddr3apllclk
_of_pll_clk_init: error initializing pll ddr3bpllclk
_of_pll_clk_init: error initializing pll armpllclk

Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/pm_domain.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index 065f2e3..ca79dda 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -74,7 +74,6 @@ int __init keystone_pm_runtime_init(void)
 	if (!np)
 		return 0;
 
-	of_clk_init(NULL);
 	pm_clk_add_notifier(&platform_bus_type, &platform_domain_notifier);
 
 	return 0;
-- 
1.7.9.5
