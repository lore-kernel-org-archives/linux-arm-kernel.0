From: jolly.shah@xilinx.com (Jolly Shah)
Date: Tue, 10 Apr 2018 12:38:45 -0700
Subject: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control APIs
In-Reply-To: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
Message-ID: <1523389127-14243-10-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to control clocks using firmware APIs
through debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 48 ++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 1cb69f7..837fcd1 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -34,6 +34,15 @@ static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
 	PM_API(PM_IOCTL),
 	PM_API(PM_QUERY_DATA),
+	PM_API(PM_CLOCK_ENABLE),
+	PM_API(PM_CLOCK_DISABLE),
+	PM_API(PM_CLOCK_GETSTATE),
+	PM_API(PM_CLOCK_SETDIVIDER),
+	PM_API(PM_CLOCK_GETDIVIDER),
+	PM_API(PM_CLOCK_SETRATE),
+	PM_API(PM_CLOCK_GETRATE),
+	PM_API(PM_CLOCK_SETPARENT),
+	PM_API(PM_CLOCK_GETPARENT),
 };
 
 /**
@@ -87,6 +96,7 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	u32 pm_api_version;
 	int ret;
+	u64 rate;
 
 	if (!eemi_ops)
 		return -ENXIO;
@@ -132,6 +142,44 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 				pm_api_ret[2], pm_api_ret[3]);
 		break;
 	}
+	case PM_CLOCK_ENABLE:
+		ret = eemi_ops->clock_enable(pm_api_arg[0]);
+		break;
+	case PM_CLOCK_DISABLE:
+		ret = eemi_ops->clock_disable(pm_api_arg[0]);
+		break;
+	case PM_CLOCK_GETSTATE:
+		ret = eemi_ops->clock_getstate(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf, "Clock state: %u\n",
+				pm_api_ret[0]);
+		break;
+	case PM_CLOCK_SETDIVIDER:
+		ret = eemi_ops->clock_setdivider(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_CLOCK_GETDIVIDER:
+		ret = eemi_ops->clock_getdivider(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf, "Divider Value: %d\n",
+				pm_api_ret[0]);
+		break;
+	case PM_CLOCK_SETRATE:
+		ret = eemi_ops->clock_setrate(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_CLOCK_GETRATE:
+		ret = eemi_ops->clock_getrate(pm_api_arg[0], &rate);
+		if (!ret)
+			sprintf(debugfs_buf, "Clock rate :%llu\n", rate);
+		break;
+	case PM_CLOCK_SETPARENT:
+		ret = eemi_ops->clock_setparent(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_CLOCK_GETPARENT:
+		ret = eemi_ops->clock_getparent(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf,
+				"Clock parent Index: %u\n", pm_api_ret[0]);
+		break;
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4
