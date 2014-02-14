From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Feb 2014 01:59:46 +0100
Subject: [PATCH 08/27] clocksource: sh_cmt: Allocate channels dynamically
In-Reply-To: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1392339605-20691-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares the driver for multi-channel support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index cd3121d..7a65d64 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -63,7 +63,8 @@ struct sh_cmt_device {
 	void __iomem *mapbase;
 	struct clk *clk;
 
-	struct sh_cmt_channel channel;
+	struct sh_cmt_channel *channels;
+	unsigned int num_channels;
 
 	unsigned long width; /* 16 or 32 bit version of hardware block */
 	unsigned long overflow_bit;
@@ -824,7 +825,15 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 		cmt->clear_bits = ~0xc000;
 	}
 
-	ret = sh_cmt_setup_channel(&cmt->channel, cfg->timer_bit, cmt);
+	cmt->channels = kzalloc(sizeof(*cmt->channels), GFP_KERNEL);
+	if (cmt->channels == NULL) {
+		ret = -ENOMEM;
+		goto err4;
+	}
+
+	cmt->num_channels = 1;
+
+	ret = sh_cmt_setup_channel(&cmt->channels[0], cfg->timer_bit, cmt);
 	if (ret < 0)
 		goto err4;
 
@@ -832,6 +841,7 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 
 	return 0;
 err4:
+	kfree(cmt->channels);
 	clk_unprepare(cmt->clk);
 err3:
 	clk_put(cmt->clk);
-- 
1.8.3.2
