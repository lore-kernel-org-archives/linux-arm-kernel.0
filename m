From: richard.zhao@linaro.org (Richard Zhao)
Date: Tue, 10 Jan 2012 15:01:50 +0800
Subject: [PATCH 6/6] dma/imx-sdma: check whether event_id0 < 32 when set
 event_mask
In-Reply-To: <1326178910-14044-1-git-send-email-richard.zhao@linaro.org>
References: <1326178910-14044-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1326178910-14044-6-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/dma/imx-sdma.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 22fd561..1d5b6ab 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -753,8 +753,11 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
 			if (sdmac->event_id0 > 31)
 				sdmac->watermark_level |= 1 << 30;
 		} else {
-			sdmac->event_mask0 = 1 << sdmac->event_id0;
-			sdmac->event_mask1 = 1 << (sdmac->event_id0 - 32);
+			if (sdmac->event_id0 < 32)
+				sdmac->event_mask0 = 1 << sdmac->event_id0;
+			else
+				sdmac->event_mask1 =
+						1 << (sdmac->event_id0 - 32);
 		}
 		/* Watermark Level */
 		sdmac->watermark_level |= sdmac->watermark_level;
-- 
1.7.5.4
