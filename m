From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jun 2017 23:58:38 +0200
Subject: [PATCH] clk: bcm: don't mark iproc_pll_clk_setup as __init
Message-ID: <20170621215851.4052618-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is now called from the probe() function of a
platform driver, which may be called later than __init,
which triggers a lot of warnings like:

WARNING: drivers/clk/built-in.o(.text+0x1a41c): Section mismatch in reference from the function sr_lcpll1_clk_init() to the function .init.text:iproc_pll_clk_setup()

This removes the annotation on iproc_pll_clk_setup to address
all those warnings.

Fixes: 654cdd3229cd ("clk: bcm: Add clocks for Stingray SOC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/bcm/clk-iproc-pll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index 2d61893da024..375d8dd80d45 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -617,12 +617,12 @@ static void iproc_pll_sw_cfg(struct iproc_pll *pll)
 	}
 }
 
-void __init iproc_pll_clk_setup(struct device_node *node,
-				const struct iproc_pll_ctrl *pll_ctrl,
-				const struct iproc_pll_vco_param *vco,
-				unsigned int num_vco_entries,
-				const struct iproc_clk_ctrl *clk_ctrl,
-				unsigned int num_clks)
+void iproc_pll_clk_setup(struct device_node *node,
+			 const struct iproc_pll_ctrl *pll_ctrl,
+			 const struct iproc_pll_vco_param *vco,
+			 unsigned int num_vco_entries,
+			 const struct iproc_clk_ctrl *clk_ctrl,
+			 unsigned int num_clks)
 {
 	int i, ret;
 	struct iproc_pll *pll;
-- 
2.9.0
