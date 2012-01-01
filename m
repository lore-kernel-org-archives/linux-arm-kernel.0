From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun,  1 Jan 2012 22:38:11 +0800
Subject: [PATCH v2 1/2] dma/imx-sdma: let sdma_run_channel call
 sdma_enable_channel
In-Reply-To: <1325428692-11473-1-git-send-email-richard.zhao@linaro.org>
References: <1325428692-11473-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1325428692-11473-2-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let all enable channel code call sdma_enable_channel.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/dma/imx-sdma.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 2ebb2bc..f8e87b5 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -392,6 +392,11 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
 	return 0;
 }
 
+static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
+{
+	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
+}
+
 /*
  * sdma_run_channel - run a channel and wait till it's done
  */
@@ -403,7 +408,7 @@ static int sdma_run_channel(struct sdma_channel *sdmac)
 
 	init_completion(&sdmac->done);
 
-	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
+	sdma_enable_channel(sdma, channel);
 
 	ret = wait_for_completion_timeout(&sdmac->done, HZ);
 
@@ -807,11 +812,6 @@ out:
 	return ret;
 }
 
-static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
-{
-	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
-}
-
 static dma_cookie_t sdma_assign_cookie(struct sdma_channel *sdmac)
 {
 	dma_cookie_t cookie = sdmac->chan.cookie;
-- 
1.7.4.1
