From: felipensp@gmail.com (Felipe Pena)
Date: Sun,  6 Oct 2013 21:55:17 -0300
Subject: [PATCH 1/1] clk/zynq: Fix possible memory leak
Message-ID: <1381107317-18120-1-git-send-email-felipensp@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zynq_clk_register_fclk function can leak memory (fclk_lock) when unable 
to alloc memory for fclk_gate_lock

Signed-off-by: Felipe Pena <felipensp@gmail.com>
---
 drivers/clk/zynq/clkc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index cc40fe6..7ea4b5c 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -117,6 +117,7 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
 		goto err;
 	fclk_gate_lock = kmalloc(sizeof(*fclk_gate_lock), GFP_KERNEL);
 	if (!fclk_gate_lock)
+		kfree(fclk_lock);
 		goto err;
 	spin_lock_init(fclk_lock);
 	spin_lock_init(fclk_gate_lock);
-- 
1.7.10.4
