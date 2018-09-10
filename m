From: jolly.shah@xilinx.com (Jolly Shah)
Date: Mon, 10 Sep 2018 13:01:34 -0700
Subject: [PATCH 3/3] firmware: xilinx: Replace if/else with switch case
In-Reply-To: <1536609694-7920-1-git-send-email-jollys@xilinx.com>
References: <1536609694-7920-1-git-send-email-jollys@xilinx.com>
Message-ID: <1536609694-7920-4-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

There will be more query IDs in future so it is better to
use switch case than if/else to avoid unnecessary condition
checks.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index ecbd599..f12dabf 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -117,17 +117,21 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 		if (ret)
 			break;
 
-		if (qdata.qid == PM_QID_CLOCK_GET_NAME)
+		switch (qdata.qid) {
+		case PM_QID_CLOCK_GET_NAME:
 			sprintf(debugfs_buf, "Clock name = %s\n",
 				(char *)pm_api_ret);
-		else if (qdata.qid == PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS)
+			break;
+		case PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS:
 			sprintf(debugfs_buf, "Multiplier = %d, Divider = %d\n",
 				pm_api_ret[1], pm_api_ret[2]);
-		else
+			break;
+		default:
 			sprintf(debugfs_buf,
 				"data[0] = 0x%08x\ndata[1] = 0x%08x\n data[2] = 0x%08x\ndata[3] = 0x%08x\n",
 				pm_api_ret[0], pm_api_ret[1],
 				pm_api_ret[2], pm_api_ret[3]);
+		}
 		break;
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
-- 
2.7.4
