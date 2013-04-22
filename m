From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 22 Apr 2013 11:59:02 -0700
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <5170B4C6.1030300@gmail.com>
References: <5170B4C6.1030300@gmail.com>
Message-ID: <20130422185902.17530.70477@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rob Herring (2013-04-18 20:06:46)
> drivers/clk/ux500/clk-prcc.c:145:13: error: conflicting types for 'clk_reg_prcc_pclk'
> drivers/clk/ux500/clk-prcc.c:155:13: error: conflicting types for 'clk_reg_prcc_kclk'

I had a hard time compiling for u8500 with linux-next.  Seems lots of
brokenness there.  Anyways the fix seems trivial so here it is, as
applied to clk-next:



>From c700835bf8568f9c183c9b6aa7794d29266da15b Mon Sep 17 00:00:00 2001
From: Mike Turquette <mturquette@linaro.org>
Date: Mon, 22 Apr 2013 11:46:10 -0700
Subject: [PATCH] clk: ux500: fix mismatched types

As reported by Rob Herring[1] there were some mismatched types between
drivers/clk/ux500/clk.h and the corresponding function definitions:

drivers/clk/ux500/clk-prcc.c:145:13: error: conflicting types for 'clk_reg_prcc_pclk'
drivers/clk/ux500/clk-prcc.c:155:13: error: conflicting types for 'clk_reg_prcc_kclk'

[1] http://article.gmane.org/gmane.linux.ports.arm.kernel/232246

Reported-by: Rob Herring <robherring2@gmail.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/ux500/clk.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ux500/clk.h b/drivers/clk/ux500/clk.h
index 3d2dfdc..a2bb92d 100644
--- a/drivers/clk/ux500/clk.h
+++ b/drivers/clk/ux500/clk.h
@@ -12,16 +12,17 @@
 
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/types.h>
 
 struct clk *clk_reg_prcc_pclk(const char *name,
 			      const char *parent_name,
-			      unsigned int phy_base,
+			      resource_size_t phy_base,
 			      u32 cg_sel,
 			      unsigned long flags);
 
 struct clk *clk_reg_prcc_kclk(const char *name,
 			      const char *parent_name,
-			      unsigned int phy_base,
+			      resource_size_t phy_base,
 			      u32 cg_sel,
 			      unsigned long flags);
 
-- 
1.7.10.4
