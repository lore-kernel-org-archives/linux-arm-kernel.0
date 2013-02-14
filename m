From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 14 Feb 2013 11:00:18 +0200
Subject: [PATCH v2 4/6] dma: coh901318: set residue only if dma is in progress
In-Reply-To: <1360832420-6349-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1360832420-6349-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <1360832420-6349-5-git-send-email-andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When status is DMA_SUCCESS the residue should be zero. Otherwise it's a bug.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/dma/coh901318.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index aa384e5..671e759 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1147,7 +1147,9 @@ coh901318_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	enum dma_status ret;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	/* FIXME: should be conditional on ret != DMA_SUCCESS? */
+	if (ret == DMA_SUCCESS)
+		return ret;
+
 	dma_set_residue(txstate, coh901318_get_bytes_left(chan));
 
 	if (ret == DMA_IN_PROGRESS && cohc->stopped)
-- 
1.7.10.4
