From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 30 Nov 2017 10:35:15 +0800
Subject: [PATCH] clk: rockchip: protect cpu and ddr clks
Message-ID: <20171130023515.27833-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These clks can never be turned off, so protect them as what we do in
the sunxi clock-tree.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/clk/rockchip/clk-cpu.c | 5 +++++
 drivers/clk/rockchip/clk-ddr.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 32c19c0f1e14..b741c23a18d1 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include "clk.h"
 
@@ -334,6 +335,10 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 		goto free_rate_table;
 	}
 
+	/* Protect CPU clock */
+	__clk_get(cclk);
+	clk_prepare_enable(cclk);
+
 	return cclk;
 
 free_rate_table:
diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
index e8075359366b..9f85335d92f2 100644
--- a/drivers/clk/rockchip/clk-ddr.c
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -15,6 +15,7 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -147,5 +148,9 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
 	if (IS_ERR(clk))
 		kfree(ddrclk);
 
+	/* Protect DDR clock */
+	__clk_get(clk);
+	clk_prepare_enable(clk);
+
 	return clk;
 }
-- 
2.11.0
