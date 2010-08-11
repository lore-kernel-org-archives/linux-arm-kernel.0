From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 16:19:29 +0300
Subject: [RFC/PATCH 5/6] sdio: enable Runtime PM for SDIO cards
In-Reply-To: <1281532770-27545-1-git-send-email-ohad@wizery.com>
References: <1281532770-27545-1-git-send-email-ohad@wizery.com>
Message-ID: <1281532770-27545-6-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before adding SDIO functions, indicate to the runtime pm core
the card is active, and enable runtime pm.

The power will be released automatically if the card
will be idle.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/sdio.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ddbb9d3..498fdfb 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -610,6 +611,9 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 	if (err)
 		goto remove_added;
 
+	pm_runtime_set_active(&host->card->dev);
+	pm_runtime_enable(&host->card->dev);
+
 	/*
 	 * ...then the SDIO functions.
 	 */
-- 
1.7.0.4
