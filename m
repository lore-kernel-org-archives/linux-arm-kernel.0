From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sat, 14 Jun 2014 18:23:27 +0200
Subject: [PATCH v3 05/19] clocksource: sh_tmu: Replace global spinlock with a
 per-device spinlock
In-Reply-To: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1402763021-4067-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The global spinlock is used to protect the shared start/stop register.
Now that all TMU channels are handled by a single device instance, use a
per-device spinlock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_tmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 4363eb7..ef8fb0b 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -61,6 +61,8 @@ struct sh_tmu_device {
 
 	enum sh_tmu_model model;
 
+	raw_spinlock_t lock; /* Protect the shared start/stop register */
+
 	struct sh_tmu_channel *channels;
 	unsigned int num_channels;
 
@@ -68,8 +70,6 @@ struct sh_tmu_device {
 	bool has_clocksource;
 };
 
-static DEFINE_RAW_SPINLOCK(sh_tmu_lock);
-
 #define TSTR -1 /* shared register */
 #define TCOR  0 /* channel register */
 #define TCNT 1 /* channel register */
@@ -132,7 +132,7 @@ static void sh_tmu_start_stop_ch(struct sh_tmu_channel *ch, int start)
 	unsigned long flags, value;
 
 	/* start stop register shared by multiple timer channels */
-	raw_spin_lock_irqsave(&sh_tmu_lock, flags);
+	raw_spin_lock_irqsave(&ch->tmu->lock, flags);
 	value = sh_tmu_read(ch, TSTR);
 
 	if (start)
@@ -141,7 +141,7 @@ static void sh_tmu_start_stop_ch(struct sh_tmu_channel *ch, int start)
 		value &= ~(1 << ch->index);
 
 	sh_tmu_write(ch, TSTR, value);
-	raw_spin_unlock_irqrestore(&sh_tmu_lock, flags);
+	raw_spin_unlock_irqrestore(&ch->tmu->lock, flags);
 }
 
 static int __sh_tmu_enable(struct sh_tmu_channel *ch)
@@ -524,6 +524,8 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 	tmu->pdev = pdev;
 	tmu->model = id->driver_data;
 
+	raw_spin_lock_init(&tmu->lock);
+
 	/* Get hold of clock. */
 	tmu->clk = clk_get(&tmu->pdev->dev, "fck");
 	if (IS_ERR(tmu->clk)) {
-- 
1.8.5.5
