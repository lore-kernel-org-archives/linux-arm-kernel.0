From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 12 Apr 2012 19:11:38 +0530
Subject: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from both
 clk and hwmod
Message-ID: <1334238098-29859-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On OMAP4+, the clkdm association is moved to hwmod while on older OMAPs'
its associated with a clk.
Hence look for a clkdm in both clk and hwmod and warn only when
its missing in both. Also fix the pr_warning() to print the correct
hwmod name.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2c27fdb..83d56df 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -566,9 +566,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
-	if (!oh->_clk->clkdm)
+	if (!oh->_clk->clkdm && !oh->clkdm_name)
 		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
-			   oh->main_clk, oh->_clk->name);
+			   oh->name, oh->_clk->name);
 
 	return ret;
 }
-- 
1.7.1
