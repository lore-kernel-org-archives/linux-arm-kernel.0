From: jassi.brar@samsung.com (Jassi Brar)
Date: Thu,  5 Nov 2009 13:44:45 +0900
Subject: [PATCH 5/5] S3C64XX DMA: Make src and dst transfer size same
Message-ID: <1257396285-32262-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices don't seem to work if the source and desitnation transfer
widths are not same. For example, SPI dma xfers, with 8bits/word,
don't work without this patch.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/dma.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
index 0971d06..d554b93 100644
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
@@ -151,8 +151,6 @@ static void s3c64xx_dma_fill_lli(struct s3c2410_dma_chan *chan,
 		src = chan->dev_addr;
 		dst = data;
 		control0 = PL080_CONTROL_SRC_AHB2;
-		control0 |= (u32)chan->hw_width << PL080_CONTROL_SWIDTH_SHIFT;
-		control0 |= 2 << PL080_CONTROL_DWIDTH_SHIFT;
 		control0 |= PL080_CONTROL_DST_INCR;
 		break;
 
@@ -160,8 +158,6 @@ static void s3c64xx_dma_fill_lli(struct s3c2410_dma_chan *chan,
 		src = data;
 		dst = chan->dev_addr;
 		control0 = PL080_CONTROL_DST_AHB2;
-		control0 |= (u32)chan->hw_width << PL080_CONTROL_DWIDTH_SHIFT;
-		control0 |= 2 << PL080_CONTROL_SWIDTH_SHIFT;
 		control0 |= PL080_CONTROL_SRC_INCR;
 		break;
 	default:
@@ -173,6 +169,8 @@ static void s3c64xx_dma_fill_lli(struct s3c2410_dma_chan *chan,
 	control1 = size >> chan->hw_width;	/* size in no of xfers */
 	control0 |= PL080_CONTROL_PROT_SYS;	/* always in priv. mode */
 	control0 |= PL080_CONTROL_TC_IRQ_EN;	/* always fire IRQ */
+	control0 |= (u32)chan->hw_width << PL080_CONTROL_DWIDTH_SHIFT;
+	control0 |= (u32)chan->hw_width << PL080_CONTROL_SWIDTH_SHIFT;
 
 	lli->src_addr = src;
 	lli->dst_addr = dst;
-- 
1.6.2.5
