From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon, 29 May 2017 17:46:03 +0200
Subject: [PATCH 15/15] media: exynos4-is: use devm_of_platform_populate()
In-Reply-To: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1496072763-31209-16-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of devm_of_platform_populate() simplify driver code
and save somes lines

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

CC: Kyungmin Park <kyungmin.park@samsung.com>
CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>
CC: linux-media at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
CC: linux-samsung-soc at vger.kernel.org
CC: linux-kernel at vger.kernel.org
---
 drivers/media/platform/exynos4-is/fimc-is.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
index 7f92144..340d906 100644
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -854,7 +854,7 @@ static int fimc_is_probe(struct platform_device *pdev)
 
 	vb2_dma_contig_set_max_seg_size(dev, DMA_BIT_MASK(32));
 
-	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	ret = devm_of_platform_populate(dev);
 	if (ret < 0)
 		goto err_pm;
 
@@ -864,7 +864,7 @@ static int fimc_is_probe(struct platform_device *pdev)
 	 */
 	ret = fimc_is_register_subdevs(is);
 	if (ret < 0)
-		goto err_of_dep;
+		goto err_pm;
 
 	ret = fimc_is_debugfs_create(is);
 	if (ret < 0)
@@ -883,8 +883,6 @@ static int fimc_is_probe(struct platform_device *pdev)
 	fimc_is_debugfs_remove(is);
 err_sd:
 	fimc_is_unregister_subdevs(is);
-err_of_dep:
-	of_platform_depopulate(dev);
 err_pm:
 	if (!pm_runtime_enabled(dev))
 		fimc_is_runtime_suspend(dev);
@@ -946,7 +944,6 @@ static int fimc_is_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(dev))
 		fimc_is_runtime_suspend(dev);
 	free_irq(is->irq, is);
-	of_platform_depopulate(dev);
 	fimc_is_unregister_subdevs(is);
 	vb2_dma_contig_clear_max_seg_size(dev);
 	fimc_is_put_clocks(is);
-- 
1.9.1
