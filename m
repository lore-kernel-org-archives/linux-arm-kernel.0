From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 22 Apr 2016 11:14:07 -0600
Subject: [PATCH V3 10/18] coresight: tmc: getting the right read_count on
 tmc_open()
In-Reply-To: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
References: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1461345255-11758-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In function tmc_open(), if tmc_read_prepare() fails variable
drvdata->read_count is not decremented, causing unwanted
access to drvdata->buf and very likely, a crash dump.

By moving the incrementation to a place where we know things
are stable this kind of situation is avoided.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <Suzuki.Poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index e8e12a9b917a..55806352b1f1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -121,13 +121,14 @@ static int tmc_open(struct inode *inode, struct file *file)
 						   struct tmc_drvdata, miscdev);
 	int ret = 0;
 
-	if (drvdata->read_count++)
+	if (drvdata->read_count)
 		goto out;
 
 	ret = tmc_read_prepare(drvdata);
 	if (ret)
 		return ret;
 out:
+	drvdata->read_count++;
 	nonseekable_open(inode, file);
 
 	dev_dbg(drvdata->dev, "%s: successfully opened\n", __func__);
-- 
2.5.0
