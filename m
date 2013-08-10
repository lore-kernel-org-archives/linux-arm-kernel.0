From: zonque@gmail.com (Daniel Mack)
Date: Sat, 10 Aug 2013 18:52:15 +0200
Subject: [PATCH v2 01/11] dma: mmp_pdma: factor out DRCMR register calculation
In-Reply-To: <1376153545-14361-1-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
Message-ID: <1376153545-14361-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exact same calculation is done twice, so let's factor it out to a
macro.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 2844eaf..8d6aae3 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -47,6 +47,8 @@
 #define DCSR_CMPST	(1 << 10)       /* The Descriptor Compare Status */
 #define DCSR_EORINTR	(1 << 9)        /* The end of Receive */
 
+#define DRCMR(n)	((((n) < 64) ? 0x0100 : 0x1100) + \
+				 (((n) & 0x3f) << 2))
 #define DRCMR_MAPVLD	(1 << 7)	/* Map Valid (read / write) */
 #define DRCMR_CHLNUM	0x1f		/* mask for Channel Number (read / write) */
 
@@ -143,8 +145,7 @@ static void enable_chan(struct mmp_pdma_phy *phy)
 	if (!phy->vchan)
 		return;
 
-	reg = phy->vchan->drcmr;
-	reg = (((reg) < 64) ? 0x0100 : 0x1100) + (((reg) & 0x3f) << 2);
+	reg = DRCMR(phy->vchan->drcmr);
 	writel(DRCMR_MAPVLD | phy->idx, phy->base + reg);
 
 	reg = (phy->idx << 2) + DCSR;
@@ -258,8 +259,7 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
 		return;
 
 	/* clear the channel mapping in DRCMR */
-	reg = pchan->phy->vchan->drcmr;
-	reg = ((reg < 64) ? 0x0100 : 0x1100) + ((reg & 0x3f) << 2);
+	reg = DRCMR(pchan->phy->vchan->drcmr);
 	writel(0, pchan->phy->base + reg);
 
 	spin_lock_irqsave(&pdev->phy_lock, flags);
-- 
1.8.3.1
