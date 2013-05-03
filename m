From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:32:09 +0100
Subject: [PATCH 23/63] dmaengine: ste_dma40: Also report the number of logical
 channels
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-24-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we know the total of physical and logical channels, we may as
well report them within the information log.

Before:
dma40 dma40.0: hardware revision: 3 @ 0x801c0000 with 8 physical channels

After:
<as above ...> and 256 logical channels

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index e5f0e3c..6d81f44 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3213,8 +3213,9 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 
 	num_log_chans = num_phy_chans * D40_MAX_LOG_CHAN_PER_PHY;
 
-	dev_info(&pdev->dev, "hardware revision: %d @ 0x%x with %d physical channels\n",
-		 rev, res->start, num_phy_chans);
+	dev_info(&pdev->dev,
+		 "hardware rev: %d @ 0x%x with %d physical and %d logical channels\n",
+		 rev, res->start, num_phy_chans, num_log_chans);
 
 	base = kzalloc(ALIGN(sizeof(struct d40_base), 4) +
 		       (num_phy_chans + num_log_chans + ARRAY_SIZE(dma40_memcpy_channels)) *
-- 
1.7.10.4
