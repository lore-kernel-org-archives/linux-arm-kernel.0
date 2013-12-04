From: fkan@apm.com (Feng Kan)
Date: Wed,  4 Dec 2013 10:33:50 -0800
Subject: [PATCH 4/4] arm64: removed using of the mask attribute in the dts for
 reset bit.
Message-ID: <1386182030-26713-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the use of the mask attribute from original reboot driver. The use
of the mask attribute provided unneeded complexity and security risk. Also
fix minor compilation warning.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/power/reset/xgene-reboot.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index ecd55f8..683238c 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -40,7 +40,7 @@ struct xgene_reboot_context {
 
 static struct xgene_reboot_context *xgene_restart_ctx;
 
-static void xgene_restart(char str, const char *cmd)
+static void xgene_restart(enum reboot_mode reboot_mode, const char *cmd)
 {
 	struct xgene_reboot_context *ctx = xgene_restart_ctx;
 	unsigned long timeout;
@@ -73,8 +73,7 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask))
-		ctx->mask = 0xFFFFFFFF;
+	ctx->mask = 0x1;
 
 	ctx->pdev = pdev;
 	arm_pm_restart = xgene_restart;
-- 
1.7.6.1
