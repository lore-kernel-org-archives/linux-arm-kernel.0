From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:30 +0200
Subject: [PATCH 50/71] clocksource: sh_mtu2: Rename clock to "fck" in the
 non-legacy case
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-50-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The sh_mtu2 driver gets the MTU2 functional clock using a connection ID
of "mtu2_fck". While all SH SoCs create clock lookup entries with a NULL
device ID and a "mtu2_fck" connection ID, the ARM SoCs use the device ID
only with a NULL connection ID. This works on legacy platforms but will
break on ARM with DT boot.

Fix the situation by using a connection ID of "fck" in the non-legacy
platform data case. Clock lookup entries will be renamed to use the
device ID as well as the connection ID as platforms get moved to new
platform data. The legacy code will eventually be dropped, leaving us
with device ID based clock lookup, compatible with DT boot.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Wolfram Sang <wsa@sang-engineering.com>
---
 drivers/clocksource/sh_mtu2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 7cc6d942..3a37857 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -465,7 +465,7 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 	}
 
 	/* Get hold of clock. */
-	mtu->clk = clk_get(&mtu->pdev->dev, "mtu2_fck");
+	mtu->clk = clk_get(&mtu->pdev->dev, mtu->legacy ? "mtu2_fck" : "fck");
 	if (IS_ERR(mtu->clk)) {
 		dev_err(&mtu->pdev->dev, "cannot get clock\n");
 		return PTR_ERR(mtu->clk);
-- 
1.7.9.5
