From: andre.przywara@linaro.org (Andre Przywara)
Date: Wed, 14 Aug 2013 14:52:09 +0200
Subject: [PATCH 2/2] DMA: fix printk warning in AMBA PL08x DMA driver
In-Reply-To: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
References: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
Message-ID: <1376484729-11826-3-git-send-email-andre.przywara@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Rob's recent pull request the patch
	ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE
promotes dma_addr_t to 64bit, so printk generates a warning about
an incorrect type. Fix this by casting it to u64 and using %llx.
Fixing long lines on the way.

Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
---
 drivers/dma/amba-pl08x.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 29e1cf9..ae19618 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -850,10 +850,13 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 
 		pl08x_choose_master_bus(&bd, &mbus, &sbus, cctl);
 
-		dev_vdbg(&pl08x->adev->dev, "src=0x%08x%s/%u dst=0x%08x%s/%u len=%zu\n",
-			bd.srcbus.addr, cctl & PL080_CONTROL_SRC_INCR ? "+" : "",
+		dev_vdbg(&pl08x->adev->dev,
+			"src=0x%08llx%s/%u dst=0x%08llx%s/%u len=%zu\n",
+			(u64)bd.srcbus.addr,
+			cctl & PL080_CONTROL_SRC_INCR ? "+" : "",
 			bd.srcbus.buswidth,
-			bd.dstbus.addr, cctl & PL080_CONTROL_DST_INCR ? "+" : "",
+			(u64)bd.dstbus.addr,
+			cctl & PL080_CONTROL_DST_INCR ? "+" : "",
 			bd.dstbus.buswidth,
 			bd.remainder);
 		dev_vdbg(&pl08x->adev->dev, "mbus=%s sbus=%s\n",
-- 
1.7.12.1
