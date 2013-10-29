From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 15:30:45 +0100
Subject: [PATCH v2 2/2] clocksource: sh_mtu2: Add clk_prepare/unprepare support
In-Reply-To: <1383057045-22608-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057045-22608-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383057045-22608-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the clock at probe time, as there is no other appropriate place
in the driver where we're allowed to sleep.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index e6cfb32..3cf1283 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -313,13 +313,18 @@ static int sh_mtu2_setup(struct sh_mtu2_priv *p, struct platform_device *pdev)
 		goto err1;
 	}
 
+	ret = clk_prepare(p->clk);
+	if (ret < 0)
+		goto err2;
+
 	ret = sh_mtu2_register(p, (char *)dev_name(&p->pdev->dev),
 			       cfg->clockevent_rating);
 	if (ret < 0)
-		goto err2;
+		goto err3;
 
 	return 0;
-
+ err3:
+	clk_unprepare(p->clk);
  err2:
 	clk_put(p->clk);
  err1:
-- 
1.8.1.5
