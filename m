From: zonque@gmail.com (Daniel Mack)
Date: Sat, 10 Aug 2013 18:52:16 +0200
Subject: [PATCH v2 02/11] dma: mmp_pdma: refactor unlocking path in
 lookup_phy()
In-Reply-To: <1376153545-14361-1-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
Message-ID: <1376153545-14361-3-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by Ezequiel Garc?a, release the spinlock at the end of the
function only, and use a goto for the control flow.

Just a minor cleanup.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 8d6aae3..f253695 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -220,7 +220,7 @@ static struct mmp_pdma_phy *lookup_phy(struct mmp_pdma_chan *pchan)
 {
 	int prio, i;
 	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(pchan->chan.device);
-	struct mmp_pdma_phy *phy;
+	struct mmp_pdma_phy *phy, *found = NULL;
 	unsigned long flags;
 
 	/*
@@ -239,14 +239,15 @@ static struct mmp_pdma_phy *lookup_phy(struct mmp_pdma_chan *pchan)
 			phy = &pdev->phy[i];
 			if (!phy->vchan) {
 				phy->vchan = pchan;
-				spin_unlock_irqrestore(&pdev->phy_lock, flags);
-				return phy;
+				found = phy;
+				goto out_unlock;
 			}
 		}
 	}
 
+out_unlock:
 	spin_unlock_irqrestore(&pdev->phy_lock, flags);
-	return NULL;
+	return found;
 }
 
 static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
-- 
1.8.3.1
