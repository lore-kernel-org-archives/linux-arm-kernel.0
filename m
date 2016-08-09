From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  9 Aug 2016 12:29:16 +0200
Subject: [RFC PATCH v3 2/8] firmware: scpi: Switch arm_scpi to use new registry
In-Reply-To: <1470738562-20026-1-git-send-email-narmstrong@baylibre.com>
References: <1470738562-20026-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1470738562-20026-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 4388937..c6d6528 100644
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
@@ -580,12 +579,6 @@ static struct scpi_ops scpi_ops = {
 	.device_set_power_state = scpi_device_set_power_state,
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
@@ -769,7 +762,10 @@ err:
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
