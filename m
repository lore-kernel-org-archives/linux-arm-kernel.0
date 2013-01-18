From: novroy@riseup.net (Nestor Ovroy)
Date: Fri, 18 Jan 2013 17:07:39 +0100
Subject: [PATCH] clk: Deduplicate exit code in clk_set_rate
Message-ID: <1358525259-7979-1-git-send-email-novroy@riseup.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On non-out case 'return ret;' is equivalent to 'return 0;' as the ret
variable is initialized at 0 and never changed.

Signed-off-by: Nestor Ovroy <novroy@riseup.net>
---
 drivers/clk/clk.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 251e45d..0e21d7a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -948,13 +948,10 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	}
 
 	/* change the rates */
 	clk_change_rate(top);
 
-	mutex_unlock(&prepare_lock);
-
-	return 0;
 out:
 	mutex_unlock(&prepare_lock);
 
 	return ret;
 }
-- 
1.7.10.4
