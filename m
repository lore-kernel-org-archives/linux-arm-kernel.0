From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 5 Oct 2012 09:43:32 +0200
Subject: [PATCH] spi/pl022: Activate resourses before deactivate them in
 suspend
Message-ID: <1349423012-18048-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

To be able to deactivate resourses in suspend, the resourses must
first be surely active. This is done with a pm_runtime_get_sync.
Once the resourses are restored to active state again in resume,
the runtime pm usage count can be decreased with a pm_runtime_put.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/spi/spi-pl022.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 9194641..c3590e0 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2350,6 +2350,8 @@ static int pl022_suspend(struct device *dev)
 		dev_warn(dev, "cannot suspend master\n");
 		return ret;
 	}
+
+	pm_runtime_get_sync(dev);
 	pl022_suspend_resources(pl022);
 
 	dev_dbg(dev, "suspended\n");
@@ -2362,6 +2364,7 @@ static int pl022_resume(struct device *dev)
 	int ret;
 
 	pl022_resume_resources(pl022);
+	pm_runtime_put(dev);
 
 	/* Start the queue running */
 	ret = spi_master_resume(pl022->master);
-- 
1.7.10
