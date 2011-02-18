From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 18 Feb 2011 22:30:28 +0100
Subject: [PATCH 1/5] ARM: mxs: free dma_mask in error path
In-Reply-To: <20110218213022.GJ22310@pengutronix.de>
References: <20110218213022.GJ22310@pengutronix.de>
Message-ID: <1298064632-15262-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lothar Wa?mann <LW@KARO-electronics.de>

This fixes a small memory leak that was only hit in very unlikely error
paths.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/devices.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/devices.c b/arch/arm/mach-mxs/devices.c
index c20d547..cfdb6b2 100644
--- a/arch/arm/mach-mxs/devices.c
+++ b/arch/arm/mach-mxs/devices.c
@@ -66,6 +66,8 @@ struct platform_device *__init mxs_add_platform_device_dmamask(
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
+		if (dmamask)
+			kfree(pdev->dev.dma_mask);
 		platform_device_put(pdev);
 		return ERR_PTR(ret);
 	}
-- 
1.7.2.3
