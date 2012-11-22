From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 Nov 2012 18:32:24 +0100
Subject: [PATCH 4/5] dma: mv_xor: fix error checking of irq_of_parse_and_map()
In-Reply-To: <1353605545-7091-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353605545-7091-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353605545-7091-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_of_parse_and_map() function returns 0 on failure, and does not
return an error code, so we fix the calling site of
irq_of_parse_and_map() in the mv_xor driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 0d4c24e..f2edd6a 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1312,8 +1312,8 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 				dma_cap_set(DMA_INTERRUPT, cap_mask);
 
 			irq = irq_of_parse_and_map(np, 0);
-			if (irq < 0) {
-				ret = irq;
+			if (!irq) {
+				ret = -ENODEV;
 				goto err_channel_add;
 			}
 
-- 
1.7.9.5
