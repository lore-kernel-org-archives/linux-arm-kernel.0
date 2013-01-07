From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon,  7 Jan 2013 12:21:47 +0100
Subject: [PATCH 05/16] dmaengine: ste_dma40: don't check for
 pm_runtime_suspended()
In-Reply-To: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
References: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1357557718-15676-6-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Narayanan G <narayanan.gopalakrishnan@stericsson.com>

The check for runtime suspend is not needed during a regular suspend, as
the framework takes care of this.  This fixes the issue of DMA driver
not letting the system to go to deepsleep in the first attempt.

Signed-off-by: Narayanan G <narayanan.gopalakrishnan@stericsson.com>
Reviewed-by: Rabin Vincent <rabin.vincent@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/dma/ste_dma40.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 2d0c63d..760576b 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2782,8 +2782,6 @@ static int dma40_pm_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct d40_base *base = platform_get_drvdata(pdev);
 	int ret = 0;
-	if (!pm_runtime_suspended(dev))
-		return -EBUSY;
 
 	if (base->lcpa_regulator)
 		ret = regulator_disable(base->lcpa_regulator);
-- 
1.7.12.1
