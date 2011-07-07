From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu,  7 Jul 2011 12:18:36 +0200
Subject: [PATCH 1/4] arm: plat-s3c24xx: dma: don't use uninitialized variable
In-Reply-To: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
References: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1310033919-4245-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8970ef47 (S3C24XX: Remove hardware specific registers from DMA
calls) removed the parameter dcon in s3c2410_dma_config() and calculates
it on its own. So the debug-output for the old parameter can go, too.
Fixes:

arch/arm/plat-s3c24xx/dma.c: In function 's3c2410_dma_config':
arch/arm/plat-s3c24xx/dma.c:1030:2: warning: 'dcon' is used uninitialized in this function

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s3c24xx/dma.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index 2abf966..a5b3684 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -1027,17 +1027,13 @@ int s3c2410_dma_config(unsigned int channel,
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
 	unsigned int dcon;
 
-	pr_debug("%s: chan=%d, xfer_unit=%d, dcon=%08x\n",
-		 __func__, channel, xferunit, dcon);
+	pr_debug("%s: chan=%d, xfer_unit=%d\n", __func__, channel, xferunit);
 
 	if (chan == NULL)
 		return -EINVAL;
 
-	pr_debug("%s: Initial dcon is %08x\n", __func__, dcon);
-
 	dcon = chan->dcon & dma_sel.dcon_mask;
-
-	pr_debug("%s: New dcon is %08x\n", __func__, dcon);
+	pr_debug("%s: dcon is %08x\n", __func__, dcon);
 
 	switch (chan->req_ch) {
 	case DMACH_I2S_IN:
-- 
1.7.5.4
