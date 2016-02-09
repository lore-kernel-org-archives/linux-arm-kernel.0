From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue,  9 Feb 2016 14:32:57 +0000
Subject: [PATCH 2/2] hwmon: (scpi) add energy meter support
In-Reply-To: <1455028377-12728-1-git-send-email-sudeep.holla@arm.com>
References: <1455028377-12728-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1455028377-12728-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCPI specification v1.1 adds support for energy sensors. This patch
adds support for the same.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwmon/scpi-hwmon.c    | 8 ++++++++
 include/linux/scpi_protocol.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 7101b14b5137..912b449c8303 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -114,6 +114,7 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 {
 	u16 nr_sensors, i;
 	int num_temp = 0, num_volt = 0, num_current = 0, num_power = 0;
+	int num_energy = 0;
 	struct scpi_ops *scpi_ops;
 	struct device *hwdev, *dev = &pdev->dev;
 	struct scpi_sensors *scpi_sensors;
@@ -182,6 +183,13 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 				 "power%d_label", num_power + 1);
 			num_power++;
 			break;
+		case ENERGY:
+			snprintf(sensor->input, sizeof(sensor->input),
+				 "energy%d_input", num_energy + 1);
+			snprintf(sensor->label, sizeof(sensor->input),
+				 "energy%d_label", num_energy + 1);
+			num_energy++;
+			break;
 		default:
 			continue;
 		}
diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index ecd248d46281..35de50a65665 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -33,6 +33,7 @@ enum scpi_sensor_class {
 	VOLTAGE,
 	CURRENT,
 	POWER,
+	ENERGY,
 };
 
 struct scpi_sensor_info {
-- 
1.9.1
