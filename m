From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Feb 2014 01:59:50 +0100
Subject: [PATCH 12/27] clocksource: sh_cmt: Acquire default clock in the
 non-legacy case
In-Reply-To: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1392339605-20691-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sh_cmt driver gets the CMT functional clock using a connection ID of
"cmt_fck". While all SH SoCs create clock lookup entries with a NULL
device ID and a "cmt_fck" connection ID, the ARM SoCs use the device ID
only with a NULL connection ID. This works on legacy platforms but will
break on ARM with DT boot.

Fix the situation by using a NULL connection ID in the non-legacy
platform data case. Clock lookup entries will be renamed as platforms
get moved to new platform data. The legacy code will eventually be
dropped, leaving us with device ID based clock lookup only, compatible
with DT boot.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 8390f0f..2389e33 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1013,7 +1013,7 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 	cmt->legacy = cmt->info ? false : true;
 
 	/* Get hold of clock. */
-	cmt->clk = clk_get(&cmt->pdev->dev, "cmt_fck");
+	cmt->clk = clk_get(&cmt->pdev->dev, cmt->legacy ? "cmt_fck" : NULL);
 	if (IS_ERR(cmt->clk)) {
 		dev_err(&cmt->pdev->dev, "cannot get clock\n");
 		return PTR_ERR(cmt->clk);
-- 
1.8.3.2
