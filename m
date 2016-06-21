From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 21 Jun 2016 12:02:50 +0200
Subject: [RFC PATCH v2 5/9] firmware: scpi: Switch arm_scpi to use new registry
In-Reply-To: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1466503374-28841-6-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the arm_scpi.c to use the registry layer instead of returning it's
context ->ops pointer.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 7e3e595..ba6bc53 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -162,7 +162,6 @@ struct scpi_drvinfo {
 	u32 firmware_version;
 	int num_chans;
 	atomic_t next_chan;
-	struct scpi_ops *scpi_ops;
 	struct scpi_chan *channels;
 	struct scpi_dvfs_info *dvfs[MAX_DVFS_DOMAINS];
 };
@@ -526,7 +525,7 @@ static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
 	return ret;
 }
 
-int scpi_sensor_get_value(u16 sensor, u64 *val)
+static int scpi_sensor_get_value(u16 sensor, u64 *val)
 {
 	__le16 id = cpu_to_le16(sensor);
 	struct sensor_value buf;
@@ -554,12 +553,6 @@ static struct scpi_ops scpi_ops = {
 	.sensor_get_value = scpi_sensor_get_value,
 };
 
-struct scpi_ops *get_scpi_ops(void)
-{
-	return scpi_info ? scpi_info->scpi_ops : NULL;
-}
-EXPORT_SYMBOL_GPL(get_scpi_ops);
-
 static int scpi_init_versions(struct scpi_drvinfo *info)
 {
 	int ret;
@@ -743,7 +736,10 @@ err:
 		  FW_REV_MAJOR(scpi_info->firmware_version),
 		  FW_REV_MINOR(scpi_info->firmware_version),
 		  FW_REV_PATCH(scpi_info->firmware_version));
-	scpi_info->scpi_ops = &scpi_ops;
+
+	ret = devm_scpi_ops_register(dev, &scpi_ops);
+	if (ret)
+		return ret;
 
 	ret = sysfs_create_groups(&dev->kobj, versions_groups);
 	if (ret)
-- 
2.7.0
