From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 18 May 2010 20:18:46 -0600
Subject: [PATCH 07/22] OMAP: hwmod: Replace WARN by pr_warning if clock lookup
	failed
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Message-ID: <20100519021845.19716.65638.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <b-cousson@ti.com>

The WARN is a little bit too verbose and is not providing
usefull information in that case.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index a62920b..5d3a3ea 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -411,9 +411,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		return 0;
 
 	c = omap_clk_get_by_name(oh->main_clk);
-	WARN(!c, "omap_hwmod: %s: cannot clk_get main_clk %s\n",
-	     oh->name, oh->main_clk);
 	if (!c)
+		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
+			   oh->name, oh->main_clk);
 		ret = -EINVAL;
 	oh->_clk = c;
 
@@ -446,9 +446,9 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 			continue;
 
 		c = omap_clk_get_by_name(os->clk);
-		WARN(!c, "omap_hwmod: %s: cannot clk_get interface_clk %s\n",
-		     oh->name, os->clk);
 		if (!c)
+			pr_warning("omap_hwmod: %s: cannot clk_get interface_clk %s\n",
+				   oh->name, os->clk);
 			ret = -EINVAL;
 		os->_clk = c;
 	}
@@ -472,9 +472,9 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++) {
 		c = omap_clk_get_by_name(oc->clk);
-		WARN(!c, "omap_hwmod: %s: cannot clk_get opt_clk %s\n",
-		     oh->name, oc->clk);
 		if (!c)
+			pr_warning("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
+				   oh->name, oc->clk);
 			ret = -EINVAL;
 		oc->_clk = c;
 	}
