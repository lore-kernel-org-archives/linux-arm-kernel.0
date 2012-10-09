From: vipin.kumar@st.com (Vipin Kumar)
Date: Tue, 9 Oct 2012 16:14:48 +0530
Subject: [PATCH 06/11] fsmc/nand: Modify the wait to uninterruptible
In-Reply-To: <cover.1349778820.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
Message-ID: <3dcb002d0ad03dde9a91e8128dbaa320b8a264a9.1349778821.git.vipin.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interruptible wait caused trouble in fsmc hardware state machine if the
application was killed abruptly. To make fsmc operation safe turn wait in to
un-interruptible.

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
---
 drivers/mtd/nand/fsmc_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index eaffd3b..4b29a64 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -607,7 +607,7 @@ static int dma_xfer(struct fsmc_nand_data *host, void *buffer, int len,
 	dma_async_issue_pending(chan);
 
 	ret =
-	wait_for_completion_interruptible_timeout(&host->dma_access_complete,
+	wait_for_completion_timeout(&host->dma_access_complete,
 				msecs_to_jiffies(3000));
 	if (ret <= 0) {
 		chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
-- 
1.7.11.4
