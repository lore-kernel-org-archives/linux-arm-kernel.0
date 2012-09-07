From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri,  7 Sep 2012 11:38:22 +0530
Subject: [PATCH] ARM: SAMSUNG: Use spin_lock_{irqsave,
 irqrestore} in clk_set_rate
Message-ID: <1346998102-5317-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spinlock clocks_lock can be held during ISR, hence it is not safe to
hold that lock with disabling interrupts.

It fixes following potential deadlock.

=========================================================
[ INFO: possible irq lock inversion dependency detected ]
3.6.0-rc4+ #2 Not tainted
---------------------------------------------------------
swapper/0/1 just changed the state of lock:
 (&(&host->lock)->rlock){-.....}, at: [<c027fb0d>] sdhci_irq+0x15/0x564
but this lock took another, HARDIRQ-unsafe lock in the past:
 (clocks_lock){+.+...}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(clocks_lock);
                               local_irq_disable();
                               lock(&(&host->lock)->rlock);
                               lock(clocks_lock);
  <Interrupt>
    lock(&(&host->lock)->rlock);

 *** DEADLOCK ***

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/plat-samsung/clock.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index 65c5eca..9b71719 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -144,6 +144,7 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
+	unsigned long flags;
 	int ret;
 
 	if (IS_ERR(clk))
@@ -159,9 +160,9 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->ops == NULL || clk->ops->set_rate == NULL)
 		return -EINVAL;
 
-	spin_lock(&clocks_lock);
+	spin_lock_irqsave(&clocks_lock, flags);
 	ret = (clk->ops->set_rate)(clk, rate);
-	spin_unlock(&clocks_lock);
+	spin_unlock_irqrestore(&clocks_lock, flags);
 
 	return ret;
 }
-- 
1.7.4.1
