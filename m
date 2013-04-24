From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Apr 2013 09:39:44 +0100
Subject: [PATCH 21/32 v2] dmaengine: ste_dma40: Also report the number of
 logical channels
In-Reply-To: <1366279934-30761-22-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-22-git-send-email-lee.jones@linaro.org>
Message-ID: <20130424083944.GG17416@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dmaengine: ste_dma40: Also report the number of logical channels

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

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 4c6df0e..d5a15ec 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3200,8 +3200,9 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 
 	num_log_chans = num_phy_chans * D40_MAX_LOG_CHAN_PER_PHY;
 
-	dev_info(&pdev->dev, "hardware revision: %d @ 0x%x with %d physical channels\n",
-		 rev, res->start, num_phy_chans);
+	dev_info(&pdev->dev,
+		 "hardware rev: %d @ 0x%x with %d physical chans and %d logical chans\n",
+		 rev, res->start, num_phy_chans, num_log_chans);
 
 	base = kzalloc(ALIGN(sizeof(struct d40_base), 4) +
 		       (num_phy_chans + num_log_chans + ARRAY_SIZE(dma40_memcpy_channels)) *
