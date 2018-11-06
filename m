From: baijiaju1990@gmail.com (Jia-Ju Bai)
Date: Tue,  6 Nov 2018 11:33:48 +0800
Subject: [PATCH] dma: coh901318: Fix a double-lock bug
Message-ID: <20181106033348.27361-1-baijiaju1990@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function coh901318_alloc_chan_resources() calls spin_lock_irqsave() 
before calling coh901318_config().
But coh901318_config() calls spin_lock_irqsave() again in its
definition, which may cause a double-lock bug.

Because coh901318_config() is only called by
coh901318_alloc_chan_resources(), the bug fix is to remove the
calls to spin-lock and -unlock functions in coh901318_config().

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/dma/coh901318.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index eebaba3d9e78..fd862a478738 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1807,8 +1807,6 @@ static int coh901318_config(struct coh901318_chan *cohc,
 	int channel = cohc->id;
 	void __iomem *virtbase = cohc->base->virtbase;
 
-	spin_lock_irqsave(&cohc->lock, flags);
-
 	if (param)
 		p = param;
 	else
@@ -1828,8 +1826,6 @@ static int coh901318_config(struct coh901318_chan *cohc,
 	coh901318_set_conf(cohc, p->config);
 	coh901318_set_ctrl(cohc, p->ctrl_lli_last);
 
-	spin_unlock_irqrestore(&cohc->lock, flags);
-
 	return 0;
 }
 
-- 
2.17.0
