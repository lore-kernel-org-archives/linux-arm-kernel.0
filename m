From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:11:56 +0100
Subject: [PATCH 14/32] dmaengine: ste_dma40: Remove 'always true' checking
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-15-git-send-email-lee.jones@linaro.org>
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
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index a39ef74..ec0d6ab 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3273,17 +3273,11 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
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
