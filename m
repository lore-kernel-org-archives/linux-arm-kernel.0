From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 14 Feb 2013 11:00:17 +0200
Subject: [PATCH v2 3/6] dma: coh901318: avoid unbalanced locking
In-Reply-To: <1360832420-6349-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1360832420-6349-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <1360832420-6349-4-git-send-email-andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the len is 0 we must return without trying to unlock the lock that was
not locked.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/dma/coh901318_lli.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/coh901318_lli.c b/drivers/dma/coh901318_lli.c
index 780e042..fe9cc5e 100644
--- a/drivers/dma/coh901318_lli.c
+++ b/drivers/dma/coh901318_lli.c
@@ -61,7 +61,7 @@ coh901318_lli_alloc(struct coh901318_pool *pool, unsigned int len)
 	dma_addr_t phy;
 
 	if (len == 0)
-		goto err;
+		return NULL;
 
 	spin_lock(&pool->lock);
 
-- 
1.7.10.4
