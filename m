From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed,  7 Dec 2016 16:57:53 -0800
Subject: [PATCH 12/12] gpu: ipu-v3: Add smfc and ic client devices
In-Reply-To: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
References: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1481158673-15937-13-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds IPU client devices for the SMFC and IC task units.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-common.c | 87 +++++++++++++++++++++++++++++++++++++++--
 include/video/imx-ipu-v3.h      |  3 ++
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index b6ca36b..729581d 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1161,18 +1161,77 @@ static struct ipu_platform_reg client_reg[] = {
 		.pdata = {
 			.type = IPU_CSI,
 			.csi = 0,
-			.dma[0] = IPUV3_CHANNEL_CSI0,
-			.dma[1] = -EINVAL,
+			.dma[0] = -EINVAL,
 		},
 		.name = "imx-ipuv3-csi",
 	}, {
 		.pdata = {
 			.type = IPU_CSI,
 			.csi = 1,
+			.dma[0] = -EINVAL,
+		},
+		.name = "imx-ipuv3-csi",
+	}, {
+		.pdata = {
+			.type = IPU_SMFC,
+			.smfc = 0,
+			.dma[0] = IPUV3_CHANNEL_CSI0,
+			.dma[1] = -EINVAL,
+		},
+		.name = "imx-ipuv3-smfc",
+	}, {
+		.pdata = {
+			.type = IPU_SMFC,
+			.smfc = 1,
 			.dma[0] = IPUV3_CHANNEL_CSI1,
 			.dma[1] = -EINVAL,
 		},
-		.name = "imx-ipuv3-csi",
+		.name = "imx-ipuv3-smfc",
+	}, {
+		.pdata = {
+			.type = IPU_IC,
+			.ic_task = IC_TASK_ENCODER,
+			.ic = 0,
+			.dma[0] = IPUV3_CHANNEL_IC_PRP_ENC_MEM,
+			.dma[1] = -EINVAL,
+		},
+		.name = "imx-ipuv3-ic",
+	}, {
+		.pdata = {
+			.type = IPU_IC,
+			.ic_task = IC_TASK_VIEWFINDER,
+			.ic = 0,
+			.dma[0] = IPUV3_CHANNEL_IC_PRP_VF_MEM,
+			.dma[1] = -EINVAL,
+		},
+		.name = "imx-ipuv3-ic",
+	}, {
+		.pdata = {
+			.type = IPU_IC,
+			.ic_task = IC_TASK_POST_PROCESSOR,
+			.ic = 0,
+			.dma[0] = IPUV3_CHANNEL_IC_PP_MEM,
+			.dma[1] = -EINVAL,
+		},
+		.name = "imx-ipuv3-ic",
+	}, {
+		.pdata = {
+			.type = IPU_IC,
+			.ic_task = IC_TASK_POST_PROCESSOR,
+			.ic = 1,
+			.dma[0] = IPUV3_CHANNEL_IC_PP_MEM,
+			.dma[1] = -EINVAL,
+		},
+		.name = "imx-ipuv3-ic",
+	}, {
+		.pdata = {
+			.type = IPU_IC,
+			.ic_task = IC_TASK_POST_PROCESSOR,
+			.ic = 2,
+			.dma[0] = IPUV3_CHANNEL_IC_PP_MEM,
+			.dma[1] = -EINVAL,
+		},
+		.name = "imx-ipuv3-ic",
 	}, {
 		.pdata = {
 			.type = IPU_DI,
@@ -1213,6 +1272,28 @@ of_get_ipu_client_node(struct ipu_soc *ipu, struct ipu_platform_reg *reg)
 			 "ipu%d_csi", ipu->id + 1);
 		client_id = reg->pdata.csi;
 		break;
+	case IPU_SMFC:
+		snprintf(node_name, sizeof(node_name), "ipu%d_smfc",
+			 ipu->id + 1);
+		client_id = reg->pdata.smfc;
+		break;
+	case IPU_IC:
+		switch (reg->pdata.ic_task) {
+		case IC_TASK_ENCODER:
+			snprintf(node_name, sizeof(node_name),
+				 "ipu%d_ic_prpenc", ipu->id + 1);
+			break;
+		case IC_TASK_VIEWFINDER:
+			snprintf(node_name, sizeof(node_name),
+				 "ipu%d_ic_prpvf", ipu->id + 1);
+			break;
+		case IC_TASK_POST_PROCESSOR:
+			snprintf(node_name, sizeof(node_name),
+				 "ipu%d_ic_pp", ipu->id + 1);
+			break;
+		}
+		client_id = reg->pdata.ic;
+		break;
 	case IPU_DI:
 		snprintf(node_name, sizeof(node_name),
 			 "ipu%d_di", ipu->id + 1);
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index 7709af7..4e70ca4 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -418,6 +418,9 @@ int ipu_rot_mode_to_degrees(int *degrees, enum ipu_rotate_mode mode,
 struct ipu_client_platformdata {
 	enum ipu_unit_type type;
 	int csi;
+	int smfc;
+	int ic_task;
+	int ic;
 	int di;
 	int dc;
 	int dp;
-- 
2.7.4
