From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 10 Mar 2015 00:22:06 +0100
Subject: [PATCH 1/3] regulator: don't emit errors in {devm_}regulator_bulk_get
 when defering
In-Reply-To: <1429128.MSqYm0qZ9p@phil>
References: <1429128.MSqYm0qZ9p@phil>
Message-ID: <9261130.uPvufuEFrr@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When {devm_}regulator_get returns -EPROBE_DEFER the driver in question will
try probing again at a later time. So don't spam the log with failure messages
as this is an expected result of probe ordering.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/regulator/core.c   | 5 +++--
 drivers/regulator/devres.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 52af1d7..07ca6cb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3163,8 +3163,9 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 						      consumers[i].supply);
 		if (IS_ERR(consumers[i].consumer)) {
 			ret = PTR_ERR(consumers[i].consumer);
-			dev_err(dev, "Failed to get supply '%s': %d\n",
-				consumers[i].supply, ret);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to get supply '%s': %d\n",
+					consumers[i].supply, ret);
 			consumers[i].consumer = NULL;
 			goto err;
 		}
diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 6ec1d40..78e460d 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -168,8 +168,9 @@ int devm_regulator_bulk_get(struct device *dev, int num_consumers,
 							   consumers[i].supply);
 		if (IS_ERR(consumers[i].consumer)) {
 			ret = PTR_ERR(consumers[i].consumer);
-			dev_err(dev, "Failed to get supply '%s': %d\n",
-				consumers[i].supply, ret);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to get supply '%s': %d\n",
+					consumers[i].supply, ret);
 			consumers[i].consumer = NULL;
 			goto err;
 		}
-- 
2.1.4
