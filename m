From: neilb@suse.de (NeilBrown)
Date: Thu, 24 Oct 2013 17:57:40 +1100
Subject: [PATCH 1/2] ARM: OMAP2+: dmtimer: allow counter to be set at any time.
In-Reply-To: <20131024065536.16889.49902.stgit@notabene.brown>
References: <20131024065536.16889.49902.stgit@notabene.brown>
Message-ID: <20131024065740.16889.96134.stgit@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is perfectly appropriate to set the counter register
when the timer isn't running.  The value set will be where
the counter starts counting from.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 arch/arm/plat-omap/dmtimer.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 869254c..d80d2c4 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -752,15 +752,16 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
 int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
-		pr_err("%s: timer not available or enabled.\n", __func__);
+	if (unlikely(!timer))
 		return -EINVAL;
-	}
+
+	omap_dm_timer_enable(timer);
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, value);
 
 	/* Save the context */
 	timer->context.tcrr = value;
+	omap_dm_timer_disable(timer);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
