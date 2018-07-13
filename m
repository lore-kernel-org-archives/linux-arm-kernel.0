From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 13 Jul 2018 12:27:26 +0200
Subject: [PATCH] clk: mvebu: armada-37xx-periph: Fix wrong return value in
 get_parent
Message-ID: <20180713102726.1950-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The return value of the get_parent operation is a u8, whereas a -EINVAL
was returned. This wrong value was return if the value was bigger that
the number of parent but this case was already handled by the core.

So we can just remove this chunk of code to fix the issue.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 9818a7a4fd10 ("clk: mvebu: armada-37xx-periph: prepare cpu clk to
be used with DVFS")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index a51edaab0c5c..287e98a7cff4 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -426,9 +426,6 @@ static u8 clk_pm_cpu_get_parent(struct clk_hw *hw)
 		val &= pm_cpu->mask_mux;
 	}
 
-	if (val >= num_parents)
-		return -EINVAL;
-
 	return val;
 }
 
-- 
2.18.0
