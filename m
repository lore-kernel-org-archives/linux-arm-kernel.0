From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 29 May 2018 14:15:26 +0100
Subject: [PATCH v2 01/12] coresight: ETM: Add support for Arm Cortex-A73 and
 Cortex-A35
In-Reply-To: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
References: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1527599737-28408-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ETM PIDs of the Arm cortex-A CPUs to the white list of ETMs.
While at it add a helper macro to make it easier to add the new
entries.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since last version:
 - Use ETM's ID register to dump the version, rather than hard
   coding it for each CPU.
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 31 ++++++++++++---------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 9bc04c5..1d94ebe 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1027,7 +1027,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "%s initialized\n", (char *)id->data);
+	dev_info(dev, "CPU%d: ETM v%d.%d initialized\n",
+		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -1045,23 +1046,19 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+#define ETM4x_AMBA_ID(pid)			\
+	{					\
+		.id	= pid,			\
+		.mask	= 0x000fffff,		\
+	}
+
 static const struct amba_id etm4_ids[] = {
-	{       /* ETM 4.0 - Cortex-A53  */
-		.id	= 0x000bb95d,
-		.mask	= 0x000fffff,
-		.data	= "ETM 4.0",
-	},
-	{       /* ETM 4.0 - Cortex-A57 */
-		.id	= 0x000bb95e,
-		.mask	= 0x000fffff,
-		.data	= "ETM 4.0",
-	},
-	{       /* ETM 4.0 - A72, Maia, HiSilicon */
-		.id = 0x000bb95a,
-		.mask = 0x000fffff,
-		.data = "ETM 4.0",
-	},
-	{ 0, 0},
+	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
+	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
+	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
+	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
+	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
+	{},
 };
 
 static struct amba_driver etm4x_driver = {
-- 
2.7.4
