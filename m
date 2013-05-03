From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:32:04 +0100
Subject: [PATCH 18/63] dmaengine: ste_dma40: Remove 'always true' checking
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-19-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before allocating memory for logical channels, the current driver
checks to see if there are any. Well as the dma40_memcpy_channels[]
array is always populated, the check is always true. Best to
remove the check.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Rabin Vincent <rabin@rab.in>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 0a5f3705..091d6a5 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3272,17 +3272,11 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	if (!base->lookup_phy_chans)
 		goto failure;
 
-	if (num_log_chans + ARRAY_SIZE(dma40_memcpy_channels)) {
-		/*
-		 * The max number of logical channels are event lines for all
-		 * src devices and dst devices
-		 */
-		base->lookup_log_chans = kzalloc(num_log_chans *
-						 sizeof(struct d40_chan *),
-						 GFP_KERNEL);
-		if (!base->lookup_log_chans)
-			goto failure;
-	}
+	base->lookup_log_chans = kzalloc(num_log_chans *
+					 sizeof(struct d40_chan *),
+					 GFP_KERNEL);
+	if (!base->lookup_log_chans)
+		goto failure;
 
 	base->reg_val_backup_chan = kmalloc(base->num_phy_chans *
 					    sizeof(d40_backup_regs_chan),
-- 
1.7.10.4
