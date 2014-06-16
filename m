From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 17:07:19 +0200
Subject: [PATCH v4 07/19] clocksource: sh_mtu2: Replace global spinlock with a
 per-device spinlock
In-Reply-To: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1402931251-22581-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The global spinlock is used to protect the shared start/stop register.
Now that all MTU2 channels are handled by a single device instance, use
a per-device spinlock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Wolfram Sang <wsa@sang-engineering.com>
---
 drivers/clocksource/sh_mtu2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 2931fea..ebdf9d1 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -47,14 +47,14 @@ struct sh_mtu2_device {
 	void __iomem *mapbase;
 	struct clk *clk;
 
+	raw_spinlock_t lock; /* Protect the shared registers */
+
 	struct sh_mtu2_channel *channels;
 	unsigned int num_channels;
 
 	bool has_clockevent;
 };
 
-static DEFINE_RAW_SPINLOCK(sh_mtu2_lock);
-
 #define TSTR -1 /* shared register */
 #define TCR  0 /* channel register */
 #define TMDR 1 /* channel register */
@@ -192,7 +192,7 @@ static void sh_mtu2_start_stop_ch(struct sh_mtu2_channel *ch, int start)
 	unsigned long flags, value;
 
 	/* start stop register shared by multiple timer channels */
-	raw_spin_lock_irqsave(&sh_mtu2_lock, flags);
+	raw_spin_lock_irqsave(&ch->mtu->lock, flags);
 	value = sh_mtu2_read(ch, TSTR);
 
 	if (start)
@@ -201,7 +201,7 @@ static void sh_mtu2_start_stop_ch(struct sh_mtu2_channel *ch, int start)
 		value &= ~(1 << ch->index);
 
 	sh_mtu2_write(ch, TSTR, value);
-	raw_spin_unlock_irqrestore(&sh_mtu2_lock, flags);
+	raw_spin_unlock_irqrestore(&ch->mtu->lock, flags);
 }
 
 static int sh_mtu2_enable(struct sh_mtu2_channel *ch)
@@ -402,6 +402,8 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 
 	mtu->pdev = pdev;
 
+	raw_spin_lock_init(&mtu->lock);
+
 	/* Get hold of clock. */
 	mtu->clk = clk_get(&mtu->pdev->dev, "fck");
 	if (IS_ERR(mtu->clk)) {
-- 
1.8.5.5
