From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 26 Apr 2018 10:53:09 +0200
Subject: [PATCH 10/11] soundwire: Respect all error codes from
 dev_pm_domain_attach()
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1524732790-2234-11-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/soundwire/bus_type.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index d5f3a70..283b283 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -83,17 +83,16 @@ static int sdw_drv_probe(struct device *dev)
 	 * attach to power domain but don't turn on (last arg)
 	 */
 	ret = dev_pm_domain_attach(dev, false);
-	if (ret != -EPROBE_DEFER) {
-		ret = drv->probe(slave, id);
-		if (ret) {
-			dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
-			dev_pm_domain_detach(dev, false);
-		}
-	}
-
 	if (ret)
 		return ret;
 
+	ret = drv->probe(slave, id);
+	if (ret) {
+		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
+		dev_pm_domain_detach(dev, false);
+		return ret;
+	}
+
 	/* device is probed so let's read the properties now */
 	if (slave->ops && slave->ops->read_prop)
 		slave->ops->read_prop(slave);
-- 
2.7.4
