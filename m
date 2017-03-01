From: j-keerthy@ti.com (Keerthy)
Date: Wed, 1 Mar 2017 15:59:48 +0530
Subject: [PATCH 5/7] thermal: ti-soc-thermal: Fetch slope and offset from DT
In-Reply-To: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
References: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1488364190-23488-6-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently slope and offset values for calculating the hot spot
temperature of a thermal zone is being taken directly from driver
data. So try fetching it from device tree if not present only then
take it from driver data.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 0586bd0..6d9399f 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -96,8 +96,14 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 		return ret;
 
 	/* Default constants */
-	slope = s->slope;
-	constant = s->constant;
+	slope = thermal_zone_get_slope(data->ti_thermal);
+	constant = thermal_zone_get_offset(data->ti_thermal);
+
+	if (slope == 1 && constant == 0) {
+		/* In case of default values fallback to driver data */
+		slope = s->slope;
+		constant = s->constant;
+	}
 
 	pcb_tz = data->pcb_tz;
 	/* In case pcb zone is available, use the extrapolation rule with it */
-- 
1.9.1
