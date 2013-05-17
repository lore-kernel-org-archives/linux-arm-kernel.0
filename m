From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 18 May 2013 09:18:49 +1200
Subject: [PATCH 1/4] clk: vt8500: Fix unbalanced spinlock in
 vt8500_dclk_set_rate()
In-Reply-To: <1368825532-30917-1-git-send-email-linux@prisktech.co.nz>
References: <1368825532-30917-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1368825532-30917-2-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the addition of a DVO clock, a bug is now evident in the vt8500
clock code:
[    0.290000] WARNING: at init/main.c:698 do_one_initcall+0x158/0x18c()
[    0.300000] initcall wm8505fb_driver_init+0x0/0xc returned with disabled int

This is caused by an unbalanced spinlock in vt8500_dclk_set_rate().
Replace the second call to spin_lock_irqsave() with spin_unlock_irqrestore().

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/clk/clk-vt8500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index debf688..553ac35 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -183,7 +183,7 @@ static int vt8500_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
 	writel(divisor, cdev->div_reg);
 	vt8500_pmc_wait_busy();
 
-	spin_lock_irqsave(cdev->lock, flags);
+	spin_unlock_irqrestore(cdev->lock, flags);
 
 	return 0;
 }
-- 
1.7.9.5
