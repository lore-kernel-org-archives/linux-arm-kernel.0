From: jolly.shah@xilinx.com (Jolly Shah)
Date: Wed, 12 Sep 2018 12:38:40 -0700
Subject: [PATCH v12 6/6] firmware: xilinx: Add debugfs for query data API
In-Reply-To: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
Message-ID: <1536781120-22794-7-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to query platform specific data from firmware
using debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index d65cfd2..2771df6 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -32,6 +32,7 @@ static char debugfs_buf[PAGE_SIZE];
 #define PM_API(id)		 {id, #id, strlen(#id)}
 static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
+	PM_API(PM_QUERY_DATA),
 };
 
 struct dentry *firmware_debugfs_root;
@@ -87,6 +88,7 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	u32 pm_api_version;
 	int ret;
+	struct zynqmp_pm_query_data qdata = {0};
 
 	if (!eemi_ops)
 		return -ENXIO;
@@ -97,6 +99,32 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
 			pm_api_version >> 16, pm_api_version & 0xffff);
 		break;
+	case PM_QUERY_DATA:
+		qdata.qid = pm_api_arg[0];
+		qdata.arg1 = pm_api_arg[1];
+		qdata.arg2 = pm_api_arg[2];
+		qdata.arg3 = pm_api_arg[3];
+
+		ret = eemi_ops->query_data(qdata, pm_api_ret);
+		if (ret)
+			break;
+
+		switch (qdata.qid) {
+		case PM_QID_CLOCK_GET_NAME:
+			sprintf(debugfs_buf, "Clock name = %s\n",
+				(char *)pm_api_ret);
+			break;
+		case PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS:
+			sprintf(debugfs_buf, "Multiplier = %d, Divider = %d\n",
+				pm_api_ret[1], pm_api_ret[2]);
+			break;
+		default:
+			sprintf(debugfs_buf,
+				"data[0] = 0x%08x\ndata[1] = 0x%08x\n data[2] = 0x%08x\ndata[3] = 0x%08x\n",
+				pm_api_ret[0], pm_api_ret[1],
+				pm_api_ret[2], pm_api_ret[3]);
+		}
+		break;
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4
