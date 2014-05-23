From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:30:57 +0200
Subject: [PATCH 17/71] clocksource: sh_cmt: Rename clock to "fck" in the
 non-legacy case
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-17-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The sh_cmt driver gets the CMT functional clock using a connection ID of
"cmt_fck". While all SH SoCs create clock lookup entries with a NULL
device ID and a "cmt_fck" connection ID, the ARM SoCs use the device ID
only with a NULL connection ID. This works on legacy platforms but will
break on ARM with DT boot.

Fix the situation by using a connection ID of "fck" in the non-legacy
platform data case. Clock lookup entries will be renamed to use the
device ID as well as the connection ID as platforms get moved to new
platform data. The legacy code will eventually be dropped, leaving us
with device ID based clock lookup, compatible with DT boot.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 1efe7d6..a5ea9ae 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1007,7 +1007,7 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *pdev)
 	cmt->legacy = cmt->info ? false : true;
 
 	/* Get hold of clock. */
-	cmt->clk = clk_get(&cmt->pdev->dev, "cmt_fck");
+	cmt->clk = clk_get(&cmt->pdev->dev, cmt->legacy ? "cmt_fck" : "fck");
 	if (IS_ERR(cmt->clk)) {
 		dev_err(&cmt->pdev->dev, "cannot get clock\n");
 		return PTR_ERR(cmt->clk);
-- 
1.7.9.5
