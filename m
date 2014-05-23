From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:30:50 +0200
Subject: [PATCH 10/71] clocksource: sh_cmt: Allocate channels dynamically
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-10-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

This prepares the driver for multi-channel support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 0779bf1..f94db32 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -62,7 +62,8 @@ struct sh_cmt_device {
 	void __iomem *mapbase;
 	struct clk *clk;
 
-	struct sh_cmt_channel channel;
+	struct sh_cmt_channel *channels;
+	unsigned int num_channels;
 
 	unsigned long width; /* 16 or 32 bit version of hardware block */
 	unsigned long overflow_bit;
@@ -822,7 +823,15 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
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
 
@@ -830,6 +839,7 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 
 	return 0;
 err4:
+	kfree(cmt->channels);
 	clk_unprepare(cmt->clk);
 err3:
 	clk_put(cmt->clk);
-- 
1.7.9.5
