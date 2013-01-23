From: b32955@freescale.com (Huang Shijie)
Date: Wed, 23 Jan 2013 16:20:53 +0800
Subject: [PATCH] mtd: gpmi: fix a dereferencing freed memory error
Message-ID: <1358929253-29143-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch "490e280 mtd: gpmi-nand: Convert to module_platform_driver()"
introduced a "dereferencing freed memory" error.

This patch fixes it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 631564d..38c8b8b 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1657,8 +1657,8 @@ exit_nfc_init:
 	release_resources(this);
 exit_acquire_resources:
 	platform_set_drvdata(pdev, NULL);
-	kfree(this);
 	dev_err(this->dev, "driver registration failed: %d\n", ret);
+	kfree(this);
 
 	return ret;
 }
-- 
1.7.0.4
