From: jhbird.choi@samsung.com (jhbird.choi at samsung.com)
Date: Thu, 24 Nov 2011 16:06:49 +0900
Subject: [PATCH] ARM: SAMSUNG: Add s3c_setparent_clksrc in s3c_set_clksrc
Message-ID: <1322118409-23817-1-git-send-email-jhbird.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@samsung.com>

Currently we have to run clk_set_parent to change clock source.
But if there are sources & parent defined, it means we will select a parent
in multiple clock sources. So sources & parent are already defined,
set the parent clock int s3c_set_clksrc.
Then we can reduce many clk_set_parent function in driver or setup_clock function.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 arch/arm/plat-samsung/clock-clksrc.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-samsung/clock-clksrc.c
index ae8b850..98bbefc 100644
--- a/arch/arm/plat-samsung/clock-clksrc.c
+++ b/arch/arm/plat-samsung/clock-clksrc.c
@@ -140,6 +140,13 @@ void __init_or_cpufreq s3c_set_clksrc(struct clksrc_clk *clk, bool announce)
 		return;
 	}
 
+	if (clk->sources && clk->clk.parent)
+		if (s3c_setparent_clksrc(&clk->clk, clk->clk.parent)) {
+			printk(KERN_ERR "%s: bad source is %s\n",
+					clk->clk.name, clk->clk.parent->name);
+			return;
+		}
+
 	clksrc = __raw_readl(clk->reg_src.reg);
 	clksrc &= mask;
 	clksrc >>= clk->reg_src.shift;
-- 
1.7.1
