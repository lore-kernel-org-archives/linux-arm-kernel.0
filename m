From: alex@asyring.de (Alexander Syring)
Date: Thu, 14 Sep 2017 14:05:19 +0200
Subject: [PATCH] clk: sunxi-ng: Fix missing CLK_SET_RATE_PARENT in
 ccu-sun4i-a10.c
Message-ID: <20170914120519.2006-1-alex@asyring.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using cpufreq-dt with default govenor other than "performance"
system freezes while booting.
Adding CLK_SET_RATE_PARENT | CLK_IS_CRITICAL to clk_cpu fixes the
problem.

Tested on Cubietruck (A20).

Fixes: c84f5683f6E ("clk: sunxi-ng: Add sun4i/sun7i CCU driver")

Reported-by: Alexander Syring <alex@asyring.de>
Signed-off-by: Alexander Syring <alex@asyring.de>
---
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index 286b0049b7b6..a48fde191c0a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -223,7 +223,7 @@ static struct ccu_mux cpu_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS("cpu",
 						      cpu_parents,
 						      &ccu_mux_ops,
-						      CLK_IS_CRITICAL),
+						      CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
 	}
 };
 
-- 
2.11.0
