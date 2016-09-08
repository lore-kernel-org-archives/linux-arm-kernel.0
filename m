From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu,  8 Sep 2016 16:50:39 -0600
Subject: [PATCH 2/2] coresight: tmc: mark symbols static where possible
In-Reply-To: <1473375039-5783-1-git-send-email-mathieu.poirier@linaro.org>
References: <1473375039-5783-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1473375039-5783-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Baoyou Xie <baoyou.xie@linaro.org>

We get a few warnings when building kernel with W=1:
drivers/hwtracing/coresight/coresight-tmc-etr.c:23:6: warning: no previous prototype for 'tmc_etr_enable_hw' [-Wmissing-prototypes]
drivers/hwtracing/coresight/coresight-tmc-etf.c:25:6: warning: no previous prototype for 'tmc_etb_enable_hw' [-Wmissing-prototypes]
drivers/hwtracing/coresight/coresight-tmc.c:250:9: warning: no previous prototype for ?trigger_cntr_show? [-Wmissing-prototypes]
...

In fact, these functions are only used in the file in which they are
declared and don't need a declaration, but can be made static.
so this patch marks these functions with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 drivers/hwtracing/coresight/coresight-tmc.c     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 5fa49c4252f6..d6941ea24d8d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -22,7 +22,7 @@
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
-void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
+static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 6d7de0309e94..886ea83c68e0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -20,7 +20,7 @@
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
-void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
+static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
 	u32 axictl;
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index a4748630f5d6..d8517d2a968c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -247,8 +247,8 @@ static struct attribute *coresight_tmc_mgmt_attrs[] = {
 	NULL,
 };
 
-ssize_t trigger_cntr_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+static ssize_t trigger_cntr_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->trigger_cntr;
-- 
2.7.4
