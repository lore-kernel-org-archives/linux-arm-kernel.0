From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 28 Mar 2012 13:42:20 +0400
Subject: [PATCH] dma: fix sa11x0-dma build error when CONFIG_PM_SLEEP=n
Message-ID: <1332927740-12557-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add no-op sa11x0_dma_suspend/sa11x0_dma_resume for !CONFIG_PM_SLEEP case
to fix following build error:

  CC [M]  drivers/dma/sa11x0-dma.o
drivers/dma/sa11x0-dma.c:1064:19: error: 'sa11x0_dma_suspend' undeclared here (not in a function)
drivers/dma/sa11x0-dma.c:1065:18: error: 'sa11x0_dma_resume' undeclared here (not in a function)

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 drivers/dma/sa11x0-dma.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index 16a6b48..cac4eed 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -1058,6 +1058,9 @@ static int sa11x0_dma_resume(struct device *dev)
 
 	return 0;
 }
+#else
+#define sa11x0_dma_suspend NULL
+#define sa11x0_dma_resume  NULL
 #endif
 
 static const struct dev_pm_ops sa11x0_dma_pm_ops = {
-- 
1.7.5.1.300.gc565c
