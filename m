From: m.krawczuk@partner.samsung.com (Mateusz Krawczuk)
Date: Wed, 28 Aug 2013 18:13:02 +0200
Subject: [PATCH v3 4/6] media: s5p-tv: Fix mixer driver to work with CCF
In-Reply-To: <1377706384-3697-1-git-send-email-m.krawczuk@partner.samsung.com>
References: <1377706384-3697-1-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <1377706384-3697-5-git-send-email-m.krawczuk@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace clk_enable by clock_enable_prepare and clk_disable with clk_disable_unprepare.
Clock prepare is required by Clock Common Framework, and old clock driver didn`t support it.
Without it Common Clock Framework prints a warning.

Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
---
 drivers/media/platform/s5p-tv/mixer_drv.c | 35 ++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/s5p-tv/mixer_drv.c b/drivers/media/platform/s5p-tv/mixer_drv.c
index 8ce7c3e..3b2b305 100644
--- a/drivers/media/platform/s5p-tv/mixer_drv.c
+++ b/drivers/media/platform/s5p-tv/mixer_drv.c
@@ -347,19 +347,40 @@ static int mxr_runtime_resume(struct device *dev)
 {
 	struct mxr_device *mdev = to_mdev(dev);
 	struct mxr_resources *res = &mdev->res;
+	int ret;
 
 	dev_dbg(mdev->dev, "resume - start\n");
 	mutex_lock(&mdev->mutex);
 	/* turn clocks on */
-	clk_enable(res->mixer);
-	clk_enable(res->vp);
-	clk_enable(res->sclk_mixer);
+	ret = clk_prepare_enable(res->mixer);
+	if (ret < 0) {
+		dev_err(mdev->dev, "clk_prepare_enable(mixer) failed\n");
+		goto fail;
+	}
+	ret = clk_prepare_enable(res->vp);
+	if (ret < 0) {
+		dev_err(mdev->dev, "clk_prepare_enable(vp) failed\n");
+		goto fail_mixer;
+	}
+	ret = clk_prepare_enable(res->sclk_mixer);
+	if (ret < 0) {
+		dev_err(mdev->dev, "clk_prepare_enable(sclk_mixer) failed\n");
+		goto fail_vp;
+	}
 	/* apply default configuration */
 	mxr_reg_reset(mdev);
-	dev_dbg(mdev->dev, "resume - finished\n");
 
 	mutex_unlock(&mdev->mutex);
+	dev_dbg(mdev->dev, "resume - finished\n");
 	return 0;
+fail_vp:
+	clk_disable_unprepare(res->vp);
+fail_mixer:
+	clk_disable_unprepare(res->mixer);
+fail:
+	mutex_unlock(&mdev->mutex);
+	dev_info(mdev->dev, "resume failed\n");
+	return ret;
 }
 
 static int mxr_runtime_suspend(struct device *dev)
@@ -369,9 +390,9 @@ static int mxr_runtime_suspend(struct device *dev)
 	dev_dbg(mdev->dev, "suspend - start\n");
 	mutex_lock(&mdev->mutex);
 	/* turn clocks off */
-	clk_disable(res->sclk_mixer);
-	clk_disable(res->vp);
-	clk_disable(res->mixer);
+	clk_disable_unprepare(res->sclk_mixer);
+	clk_disable_unprepare(res->vp);
+	clk_disable_unprepare(res->mixer);
 	mutex_unlock(&mdev->mutex);
 	dev_dbg(mdev->dev, "suspend - finished\n");
 	return 0;
-- 
1.8.1.2
