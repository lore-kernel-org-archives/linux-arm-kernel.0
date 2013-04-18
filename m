From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:12:02 +0100
Subject: [PATCH 20/32] dmaengine: ste_dma40: Move rev error-check up to
 revision acquisition
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-21-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment we fetch the hardware revision, then do some stuff, then
check whether the revision is correct and return in error if it's not.
Well we may as well check it as soon as we know what it is, so let's
move the check right up underneath where we acquire the version.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 28fe153..282dd59 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3185,6 +3185,10 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	 * DB8540v1 has revision 4
 	 */
 	rev = AMBA_REV_BITS(pid);
+	if (rev < 2) {
+		d40_err(&pdev->dev, "hardware revision: %d is not supported", rev);
+		goto failure;
+	}
 
 	plat_data = pdev->dev.platform_data;
 
@@ -3199,12 +3203,6 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	dev_info(&pdev->dev, "hardware revision: %d @ 0x%x with %d physical channels\n",
 		 rev, res->start, num_phy_chans);
 
-	if (rev < 2) {
-		d40_err(&pdev->dev, "hardware revision: %d is not supported",
-			rev);
-		goto failure;
-	}
-
 	base = kzalloc(ALIGN(sizeof(struct d40_base), 4) +
 		       (num_phy_chans + num_log_chans + ARRAY_SIZE(dma40_memcpy_channels)) *
 		       sizeof(struct d40_chan), GFP_KERNEL);
-- 
1.7.10.4
