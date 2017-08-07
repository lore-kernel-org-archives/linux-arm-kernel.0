From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon,  7 Aug 2017 13:15:19 +0530
Subject: [PATCH 2/2] dmaengine: at_xdmac: Handle return value of
 clk_prepare_enable.
In-Reply-To: <878f9486ee507c227cb8835417c520b489c768c8.1502091778.git.arvind.yadav.cs@gmail.com>
References: <878f9486ee507c227cb8835417c520b489c768c8.1502091778.git.arvind.yadav.cs@gmail.com>
Message-ID: <3c5d3448f8d00995698e2dd905ba0d11a645b35f.1502091778.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/dma/at_xdmac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 6a3cf97..c00e392 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1883,8 +1883,11 @@ static int atmel_xdmac_resume(struct device *dev)
 	struct at_xdmac_chan	*atchan;
 	struct dma_chan		*chan, *_chan;
 	int			i;
+	int ret;
 
-	clk_prepare_enable(atxdmac->clk);
+	ret = clk_prepare_enable(atxdmac->clk);
+	if (ret)
+		return ret;
 
 	/* Clear pending interrupts. */
 	for (i = 0; i < atxdmac->dma.chancnt; i++) {
-- 
1.9.1
