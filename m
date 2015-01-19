From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 19 Jan 2015 14:22:35 +0100
Subject: [PATCH V2 3/8] [media] exynos-gsc: Make driver functional when
 CONFIG_PM is unset
In-Reply-To: <1421673760-2600-1-git-send-email-ulf.hansson@linaro.org>
References: <1421673760-2600-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1421673760-2600-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver depended on CONFIG_PM to be functional. Let's remove that
dependency, by enable the runtime PM resourses during ->probe() and
update the device's runtime PM status to reflect this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/media/platform/exynos-gsc/gsc-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index 1865738..532daa8 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -1088,7 +1088,7 @@ static int gsc_probe(struct platform_device *pdev)
 		return PTR_ERR(gsc->clock);
 	}
 
-	ret = clk_prepare(gsc->clock);
+	ret = clk_prepare_enable(gsc->clock);
 	if (ret) {
 		dev_err(&gsc->pdev->dev, "clock prepare failed for clock: %s\n",
 			GSC_CLOCK_GATE_NAME);
@@ -1111,30 +1111,29 @@ static int gsc_probe(struct platform_device *pdev)
 		goto err_v4l2;
 
 	platform_set_drvdata(pdev, gsc);
-	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
-		goto err_m2m;
+
+	gsc_hw_set_sw_reset(gsc);
+	gsc_wait_reset(gsc);
 
 	/* Initialize continious memory allocator */
 	gsc->alloc_ctx = vb2_dma_contig_init_ctx(dev);
 	if (IS_ERR(gsc->alloc_ctx)) {
 		ret = PTR_ERR(gsc->alloc_ctx);
-		goto err_pm;
+		goto err_m2m;
 	}
 
 	dev_dbg(dev, "gsc-%d registered successfully\n", gsc->id);
 
-	pm_runtime_put(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return 0;
-err_pm:
-	pm_runtime_put(dev);
 err_m2m:
 	gsc_unregister_m2m_device(gsc);
 err_v4l2:
 	v4l2_device_unregister(&gsc->v4l2_dev);
 err_clk:
-	clk_unprepare(gsc->clock);
+	clk_disable_unprepare(gsc->clock);
 	return ret;
 }
 
-- 
1.9.1
