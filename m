From: dkos@cadence.com (Damian Kos)
Date: Tue, 24 Jul 2018 12:13:36 +0100
Subject: [PATCH v2 5/5] drm/bridge: add preliminary driver for cadence dpi/dp
 bridge
In-Reply-To: <1532430824-23477-1-git-send-email-dkos@cadence.com>
References: <1532430824-23477-1-git-send-email-dkos@cadence.com>
Message-ID: <1532430824-23477-6-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

This patch finally adds the preliminary driver for Cadence MHDP DPI/DP bridge.

Changes made in the low level driver:
- functions for writing register and register bits are now public
- added functions for reading registers and link training
  adjustment

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/bridge/Makefile           |    2 +-
 drivers/gpu/drm/bridge/cdns-mhdp-common.c |  110 +-
 drivers/gpu/drm/bridge/cdns-mhdp-common.h |   11 +
 drivers/gpu/drm/bridge/cdns-mhdp.c        | 1233 +++++++++++++++++++++
 4 files changed, 1353 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c

diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index c9b35f736a00..5e2a84734c7a 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
 obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
-obj-$(CONFIG_DRM_CDNS_MHDP) += cdns-mhdp-common.o
+obj-$(CONFIG_DRM_CDNS_MHDP) += cdns-mhdp.o cdns-mhdp-common.o
 obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
 obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
 obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp-common.c b/drivers/gpu/drm/bridge/cdns-mhdp-common.c
index 813319481220..5c426b04cf65 100644
--- a/drivers/gpu/drm/bridge/cdns-mhdp-common.c
+++ b/drivers/gpu/drm/bridge/cdns-mhdp-common.c
@@ -191,7 +191,55 @@ static int cdns_mhdp_mailbox_send(struct cdns_mhdp_device *mhdp, u8 module_id,
 	return 0;
 }
 
-static int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
+int cdns_mhdp_reg_read(struct cdns_mhdp_device *mhdp, u32 addr, u32 *value)
+{
+	u8 msg[4], resp[8];
+	int ret;
+
+	if (addr == 0) {
+		ret = -EINVAL;
+		goto err_reg_read;
+	}
+
+	msg[0] = (u8)(addr >> 24);
+	msg[1] = (u8)(addr >> 16);
+	msg[2] = (u8)(addr >> 8);
+	msg[3] = (u8)addr;
+
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_GENERAL,
+				     GENERAL_REGISTER_READ,
+				     sizeof(msg), msg);
+	if (ret)
+		goto err_reg_read;
+
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_GENERAL,
+						 GENERAL_REGISTER_READ,
+						 sizeof(resp));
+	if (ret)
+		goto err_reg_read;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, resp, sizeof(resp));
+	if (ret)
+		goto err_reg_read;
+
+	/* Returned address value should be the same as requested */
+	if (memcmp(msg, resp, sizeof(msg))) {
+		ret = -EINVAL;
+		goto err_reg_read;
+	}
+
+	*value = (resp[4] << 24) | (resp[5] << 16) | (resp[6] << 8) | resp[7];
+
+err_reg_read:
+	if (ret) {
+		DRM_DEV_ERROR(mhdp->dev, "Failed to read register.\n");
+		*value = 0;
+	}
+
+	return ret;
+}
+
+int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
 {
 	u8 msg[6];
 
@@ -205,7 +253,7 @@ static int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
 				      DPTX_WRITE_REGISTER, sizeof(msg), msg);
 }
 
-static int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
+int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
 				   u8 start_bit, u8 bits_no, u32 val)
 {
 	u8 field[8];
@@ -979,3 +1027,61 @@ int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
 		DRM_DEV_ERROR(mhdp->dev, "audio config failed: %d\n", ret);
 	return ret;
 }
+
+int cdns_mhdp_adjust_lt(struct cdns_mhdp_device *mhdp,
+			u8 nlanes, u16 udelay, u8 *lanes_data, u8 *dpcd)
+{
+	u8 payload[7];
+	u8 hdr[5]; /* For DPCD read response header */
+	u32 addr;
+	u8 const nregs = 6; /* Registers 0x202-0x207 */
+	int ret;
+
+	if (nlanes != 4 && nlanes != 2 && nlanes != 1) {
+		DRM_DEV_ERROR(mhdp->dev, "invalid number of lanes: %d\n",
+			      nlanes);
+		ret = -EINVAL;
+		goto err_adjust_lt;
+	}
+
+	payload[0] = nlanes;
+	payload[1] = (u8)(udelay >> 8);
+	payload[2] = (u8)udelay;
+
+	payload[3] = lanes_data[0];
+	if (nlanes > 1)
+		payload[4] = lanes_data[1];
+	if (nlanes > 2) {
+		payload[5] = lanes_data[2];
+		payload[6] = lanes_data[3];
+	}
+
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_ADJUST_LT,
+				     sizeof(payload), payload);
+	if (ret)
+		goto err_adjust_lt;
+
+	/* Yes, read the DPCD read command response */
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_READ_DPCD,
+						 sizeof(hdr) + nregs);
+	if (ret)
+		goto err_adjust_lt;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, hdr, sizeof(hdr));
+	if (ret)
+		goto err_adjust_lt;
+
+	addr = (hdr[2] << 24) | (hdr[3] << 8) | hdr[4];
+	if (addr != DP_LANE0_1_STATUS)
+		goto err_adjust_lt;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, dpcd, nregs);
+
+err_adjust_lt:
+	if (ret)
+		DRM_DEV_ERROR(mhdp->dev, "Failed to adjust Link Training.\n");
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp-common.h b/drivers/gpu/drm/bridge/cdns-mhdp-common.h
index b0101f10594a..bdebe9e0a640 100644
--- a/drivers/gpu/drm/bridge/cdns-mhdp-common.h
+++ b/drivers/gpu/drm/bridge/cdns-mhdp-common.h
@@ -330,6 +330,7 @@
 #define GENERAL_TEST_ECHO               0x02
 #define GENERAL_BUS_SETTINGS            0x03
 #define GENERAL_TEST_ACCESS             0x04
+#define GENERAL_REGISTER_READ           0x07
 
 #define DPTX_SET_POWER_MNG			0x00
 #define DPTX_SET_HOST_CAPABILITIES		0x01
@@ -349,6 +350,7 @@
 #define DPTX_SET_LINK_BREAK_POINT		0x0f
 #define DPTX_FORCE_LANES			0x10
 #define DPTX_HPD_STATE				0x11
+#define DPTX_ADJUST_LT				0x12
 
 #define FW_STANDBY				0
 #define FW_ACTIVE				1
@@ -554,4 +556,13 @@ int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
 int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable);
 int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
 			   struct audio_info *audio);
+int cdns_mhdp_register_read(struct cdns_mhdp_device *mhdp, u32 addr,
+			    u32 *value);
+int cdns_mhdp_reg_read(struct cdns_mhdp_device *mhdp, u32 addr, u32 *value);
+int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val);
+int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
+				   u8 start_bit, u8 bits_no, u32 val);
+int cdns_mhdp_adjust_lt(struct cdns_mhdp_device *mhdp, u8 nlanes,
+			u16 udelay, u8 *lanes_data,
+			u8 *dpcd);
 #endif /* CDNS_MHDP_COMMON_H_ */
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.c b/drivers/gpu/drm/bridge/cdns-mhdp.c
new file mode 100644
index 000000000000..e31a1a11c96f
--- /dev/null
+++ b/drivers/gpu/drm/bridge/cdns-mhdp.c
@@ -0,0 +1,1233 @@
+// SPDX-License-Identifier: GPL v2
+/*
+ * Cadence MHDP DP bridge driver.
+ *
+ * Copyright: 2018 Cadence Design Systems, Inc.
+ *
+ * Author: Quentin Schulz <quentin.schulz@free-electrons.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+
+#include "cdns-mhdp-common.h"
+
+#define DEBUG_MSG
+
+#define IRAM_FW_NAME				"cadence_mhdp_iram_fw.bin"
+#define DRAM_FW_NAME				"cadence_mhdp_dram_fw.bin"
+
+#define CDNS_APB_CFG				0x00000
+#define CDNS_APB_CTRL				(CDNS_APB_CFG + 0x00)
+#define CDNS_MAILBOX_FULL			(CDNS_APB_CFG + 0x08)
+#define CDNS_MAILBOX_EMPTY			(CDNS_APB_CFG + 0x0c)
+#define CDNS_MAILBOX_TX_DATA			(CDNS_APB_CFG + 0x10)
+#define CDNS_MAILBOX_RX_DATA			(CDNS_APB_CFG + 0x14)
+#define CDNS_KEEP_ALIVE				(CDNS_APB_CFG + 0x18)
+#define CDNS_KEEP_ALIVE_MASK			GENMASK(7, 0)
+
+#define CDNS_SW_CLK_L				(CDNS_APB_CFG + 0x3c)
+#define CDNS_SW_CLK_H				(CDNS_APB_CFG + 0x40)
+#define CDNS_SW_EVENT0				(CDNS_APB_CFG + 0x44)
+#define CDNS_DPTX_HPD				BIT(0)
+
+#define CDNS_SW_EVENT1				(CDNS_APB_CFG + 0x48)
+#define CDNS_SW_EVENT2				(CDNS_APB_CFG + 0x4c)
+#define CDNS_SW_EVENT3				(CDNS_APB_CFG + 0x50)
+
+#define CDNS_SOURCE_VIDEO_INTERFACE		0x00b00
+#define CDNS_BND_HSYNC2VSYNC			(CDNS_SOURCE_VIDEO_INTERFACE + \
+						 0x00)
+#define CDNS_IP_DTCT_WIN			GENMASK(11, 0)
+#define CDNS_IP_DET_INTERLACE_FORMAT		BIT(12)
+#define CDNS_IP_BYPASS_V_INTERFACE		BIT(13)
+
+#define CDNS_HSYNC2VSYNC_POL_CTRL		(CDNS_SOURCE_VIDEO_INTERFACE + \
+						 0x10)
+#define CDNS_H2V_HSYNC_POL_ACTIVE_LOW		BIT(1)
+#define CDNS_H2V_VSYNC_POL_ACTIVE_LOW		BIT(2)
+
+#define CDNS_DPTX_PHY_CONFIG			0x02000
+#define CDNS_PHY_TRAINING_EN			BIT(0)
+#define CDNS_PHY_TRAINING_TYPE(x)		(((x) & GENMASK(3, 0)) << 1)
+#define CDNS_PHY_SCRAMBLER_BYPASS		BIT(5)
+#define CDNS_PHY_ENCODER_BYPASS			BIT(6)
+#define CDNS_PHY_SKEW_BYPASS			BIT(7)
+#define CDNS_PHY_TRAINING_AUTO			BIT(8)
+#define CDNS_PHY_LANE0_SKEW(x)			(((x) & GENMASK(2, 0)) << 9)
+#define CDNS_PHY_LANE1_SKEW(x)			(((x) & GENMASK(2, 0)) << 12)
+#define CDNS_PHY_LANE2_SKEW(x)			(((x) & GENMASK(2, 0)) << 15)
+#define CDNS_PHY_LANE3_SKEW(x)			(((x) & GENMASK(2, 0)) << 18)
+#define CDNS_PHY_COMMON_CONFIG			(CDNS_PHY_LANE1_SKEW(1) | \
+						CDNS_PHY_LANE2_SKEW(2) |  \
+						CDNS_PHY_LANE3_SKEW(3))
+#define CDNS_PHY_10BIT_EN			BIT(21)
+
+#define CDNS_DPTX_FRAMER			0x02200
+#define CDNS_DP_FRAMER_GLOBAL_CONFIG		(CDNS_DPTX_FRAMER + 0x00)
+#define CDNS_DP_NUM_LANES(x)			(x - 1)
+#define CDNS_DP_FRAMER_EN			BIT(3)
+#define CDNS_DP_RATE_GOVERNOR_EN		BIT(4)
+#define CDNS_DP_NO_VIDEO_MODE			BIT(5)
+#define CDNS_DP_DISABLE_PHY_RST			BIT(6)
+#define CDNS_DP_WR_FAILING_EDGE_VSYNC		BIT(7)
+
+#define CDNS_DP_SW_RESET			(CDNS_DPTX_FRAMER + 0x04)
+#define CDNS_DP_FRAMER_TU			(CDNS_DPTX_FRAMER + 0x08)
+#define CDNS_DP_FRAMER_TU_SIZE(x)		(((x) & GENMASK(6, 0)) << 8)
+#define CDNS_DP_FRAMER_TU_VS(x)			((x) & GENMASK(5, 0))
+#define CDNS_DP_FRAMER_TU_CNT_RST_EN		BIT(15)
+
+#define CDNS_DPTX_STREAM			0x03000
+#define CDNS_DP_MSA_HORIZONTAL_0		(CDNS_DPTX_STREAM + 0x00)
+#define CDNS_DP_MSAH0_H_TOTAL(x)		(x)
+#define CDNS_DP_MSAH0_HSYNC_START(x)		((x) << 16)
+
+#define CDNS_DP_MSA_HORIZONTAL_1		(CDNS_DPTX_STREAM + 0x04)
+#define CDNS_DP_MSAH1_HSYNC_WIDTH(x)		(x)
+#define CDNS_DP_MSAH1_HSYNC_POL_LOW		BIT(15)
+#define CDNS_DP_MSAH1_HDISP_WIDTH(x)		((x) << 16)
+
+#define CDNS_DP_MSA_VERTICAL_0			(CDNS_DPTX_STREAM + 0x08)
+#define CDNS_DP_MSAV0_V_TOTAL(x)		(x)
+#define CDNS_DP_MSAV0_VSYNC_START(x)		((x) << 16)
+
+#define CDNS_DP_MSA_VERTICAL_1			(CDNS_DPTX_STREAM + 0x0c)
+#define CDNS_DP_MSAV1_VSYNC_WIDTH(x)		(x)
+#define CDNS_DP_MSAV1_VSYNC_POL_LOW		BIT(15)
+#define CDNS_DP_MSAV1_VDISP_WIDTH(x)		((x) << 16)
+
+#define CDNS_DP_MSA_MISC			(CDNS_DPTX_STREAM + 0x10)
+#define CDNS_DP_STREAM_CONFIG			(CDNS_DPTX_STREAM + 0x14)
+#define CDNS_DP_RATE_GOVERNOR_STATUS		(CDNS_DPTX_STREAM + 0x2c)
+#define CDNS_DP_RG_TU_VS_DIFF(x)		((x) << 8)
+
+#define CDNS_DP_HORIZONTAL			(CDNS_DPTX_STREAM + 0x30)
+#define CDNS_DP_H_HSYNC_WIDTH(x)		(x)
+#define CDNS_DP_H_H_TOTAL(x)			((x) << 16)
+
+#define CDNS_DP_VERTICAL_0			(CDNS_DPTX_STREAM + 0x34)
+#define CDNS_DP_V0_VHEIGHT(x)			(x)
+#define CDNS_DP_V0_VSTART(x)			((x) << 16)
+
+#define CDNS_DP_VERTICAL_1			(CDNS_DPTX_STREAM + 0x38)
+#define CDNS_DP_V1_VTOTAL(x)			(x)
+#define CDNS_DP_V1_VTOTAL_EVEN			BIT(16)
+
+#define CDNS_DP_FRAMER_PXL_REPR			(CDNS_DPTX_STREAM + 0x4c)
+#define CDNS_DP_FRAMER_6_BPC			BIT(0)
+#define CDNS_DP_FRAMER_8_BPC			BIT(1)
+#define CDNS_DP_FRAMER_10_BPC			BIT(2)
+#define CDNS_DP_FRAMER_12_BPC			BIT(3)
+#define CDNS_DP_FRAMER_16_BPC			BIT(4)
+#define CDNS_DP_FRAMER_PXL_FORMAT		0x8
+#define CDNS_DP_FRAMER_RGB			BIT(0)
+#define CDNS_DP_FRAMER_YCBCR444			BIT(1)
+#define CDNS_DP_FRAMER_YCBCR422			BIT(2)
+#define CDNS_DP_FRAMER_YCBCR420			BIT(3)
+#define CDNS_DP_FRAMER_Y_ONLY			BIT(4)
+
+#define CDNS_DP_FRAMER_SP			(CDNS_DPTX_STREAM + 0x10)
+#define CDNS_DP_FRAMER_VSYNC_POL_LOW		BIT(0)
+#define CDNS_DP_FRAMER_HSYNC_POL_LOW		BIT(1)
+#define CDNS_DP_FRAMER_INTERLACE		BIT(2)
+
+#define CDNS_DP_LINE_THRESH			(CDNS_DPTX_STREAM + 0x64)
+#define CDNS_DP_VB_ID				(CDNS_DPTX_STREAM + 0x68)
+#define CDNS_DP_VB_ID_INTERLACED		BIT(2)
+
+#define CDNS_DP_FRONT_BACK_PORCH		(CDNS_DPTX_STREAM + 0x78)
+#define CDNS_DP_BACK_PORCH(x)			(x)
+#define CDNS_DP_FRONT_PORCH(x)			((x) << 16)
+
+#define CDNS_DP_BYTE_COUNT			(CDNS_DPTX_STREAM + 0x7c)
+
+#define CDNS_DPTX_GLOBAL			0x02300
+#define CDNS_DP_LANE_EN				(CDNS_DPTX_GLOBAL + 0x00)
+#define CDNS_DP_LANE_EN_LANES(x)		GENMASK(x - 1, 0)
+#define CDNS_DP_ENHNCD				(CDNS_DPTX_GLOBAL + 0x04)
+
+#define CDNS_MHDP_IMEM				0x10000
+#define CDNS_MHDP_DMEM				0x20000
+
+#define CDNS_DP_TRAINING_PATTERN_4		0x7
+
+/* 3min delay because of EDID mb being VERY slow */
+/* FIXME: should be >615000 when upstreaming */
+#define CDNS_TIMEOUT_MAILBOX			(1000 * 1000 * 60 * 3)
+
+/* FIXME: Should be 2000 */
+#define CDNS_KEEP_ALIVE_TIMEOUT			40000
+#define CDNS_SW_EVENT0_TIMEOUT			40000
+
+static const struct of_device_id mhdp_ids[] = {
+	{ .compatible = "cdns,mhdp8546", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mhdp_ids);
+
+#define CDNS_LANE_1				BIT(0)
+#define CDNS_LANE_2				BIT(1)
+#define CDNS_LANE_4				BIT(2)
+#define CDNS_SSC				BIT(3)
+#define CDNS_SCRAMBLER				BIT(4)
+
+#define CDNS_VOLT_SWING(x)			((x) & GENMASK(1, 0))
+#define CDNS_FORCE_VOLT_SWING			BIT(2)
+
+#define CDNS_PRE_EMPHASIS(x)			((x) & GENMASK(1, 0))
+#define CDNS_FORCE_PRE_EMPHASIS			BIT(2)
+
+#define CDNS_SUPPORT_TPS(x)			BIT((x) - 1)
+
+#define CDNS_FAST_LINK_TRAINING			BIT(0)
+
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_0(x)	((x) & GENMASK(1, 0))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_1(x)	((x) & GENMASK(3, 2))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_2(x)	((x) & GENMASK(5, 4))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_3(x)	((x) & GENMASK(7, 6))
+#define CDNS_LANE_MAPPING_NORMAL		0xe4
+#define CDNS_LANE_MAPPING_FLIPPED		0x1b
+
+#define CDNS_DP_MAX_NUM_LANES			4
+#define CDNS_DP_TEST_VSC_SDP			(1 << 6) /* 1.3+ */
+#define CDNS_DP_TEST_COLOR_FORMAT_RAW_Y_ONLY	(1 << 7)
+
+static inline struct cdns_mhdp_device *connector_to_mhdp(
+	struct drm_connector *conn)
+{
+	return container_of(conn, struct cdns_mhdp_device, connector);
+}
+
+static inline struct cdns_mhdp_device *bridge_to_mhdp(
+	struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct cdns_mhdp_device, bridge);
+}
+
+static unsigned int max_link_rate(struct cdns_mhdp_host host,
+				  struct cdns_mhdp_sink sink)
+{
+	return min(host.link_rate, sink.link_rate);
+}
+
+static u8 eq_training_pattern_supported(struct cdns_mhdp_host host,
+					struct cdns_mhdp_sink sink)
+{
+	return fls(host.pattern_supp & sink.pattern_supp);
+}
+
+static ssize_t mhdp_transfer(struct drm_dp_aux *aux,
+			     struct drm_dp_aux_msg *msg)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(aux->dev);
+	int ret;
+
+	if (msg->request != DP_AUX_NATIVE_WRITE &&
+	    msg->request != DP_AUX_NATIVE_READ)
+		return -ENOTSUPP;
+
+	if (msg->request == DP_AUX_NATIVE_WRITE) {
+		int i;
+
+		for (i = 0; i < msg->size; ++i) {
+			ret = cdns_mhdp_dpcd_write(mhdp,
+						   msg->address + i,
+						   *((u8 *)msg->buffer + i));
+			if (!ret)
+				continue;
+
+			DRM_DEV_ERROR(mhdp->dev, "Failed to write DPCD\n");
+
+			return i;
+		}
+	} else {
+		ret = cdns_mhdp_dpcd_read(mhdp, msg->address,
+					  msg->buffer, msg->size);
+		if (ret) {
+			DRM_DEV_ERROR(mhdp->dev, "Failed to read DPCD\n");
+			return 0;
+		}
+	}
+
+	return msg->size;
+}
+
+static int cdns_mhdp_get_modes(struct drm_connector *connector)
+{
+	struct cdns_mhdp_device *mhdp = connector_to_mhdp(connector);
+	struct edid *edid;
+	int num_modes;
+
+	edid = drm_do_get_edid(connector, cdns_mhdp_get_edid_block, mhdp);
+
+	drm_connector_update_edid_property(connector, edid);
+
+	num_modes = drm_add_edid_modes(connector, edid);
+
+	return num_modes;
+}
+
+static const struct drm_connector_helper_funcs cdns_mhdp_conn_helper_funcs = {
+	.get_modes = cdns_mhdp_get_modes,
+};
+
+static enum drm_connector_status cdns_mhdp_detect(struct drm_connector *conn,
+						  bool force)
+{
+	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
+	enum drm_connector_status status = connector_status_disconnected;
+	int ret;
+
+	ret = cdns_mhdp_get_hpd_status(mhdp);
+	if (ret > 0)
+		status = connector_status_connected;
+	else if (ret < 0)
+		dev_err(mhdp->dev, "Failed to obtain HPD state\n");
+
+	return status;
+}
+
+static const struct drm_connector_funcs cdns_mhdp_conn_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.reset = drm_atomic_helper_connector_reset,
+	.destroy = drm_connector_cleanup,
+	.dpms = drm_helper_connector_dpms,
+	.detect = cdns_mhdp_detect,
+};
+
+static int cdns_mhdp_attach(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+	struct drm_connector *conn = &mhdp->connector;
+	int ret;
+
+	conn->polled = DRM_CONNECTOR_POLL_CONNECT |
+		DRM_CONNECTOR_POLL_DISCONNECT;
+
+	ret = drm_connector_init(bridge->dev, conn, &cdns_mhdp_conn_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to init connector\n");
+		return ret;
+	}
+
+	drm_connector_helper_add(conn, &cdns_mhdp_conn_helper_funcs);
+
+	ret = drm_connector_attach_encoder(conn, bridge->encoder);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to attach connector to encoder\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+enum pixel_format {
+	PIXEL_FORMAT_RGB = 1,
+	PIXEL_FORMAT_YCBCR_444 = 2,
+	PIXEL_FORMAT_YCBCR_422 = 4,
+	PIXEL_FORMAT_YCBCR_420 = 8,
+	PIXEL_FORMAT_Y_ONLY = 16,
+};
+
+static void mhdp_link_training_init(struct cdns_mhdp_device *mhdp)
+{
+	u32 reg32;
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	/* Reset PHY configuration */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_ENHNCD,
+			    mhdp->sink.enhanced & mhdp->host.enhanced);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_LANE_EN,
+			    CDNS_DP_LANE_EN_LANES(mhdp->link.num_lanes));
+
+	drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG,
+			    CDNS_PHY_COMMON_CONFIG |
+			    CDNS_PHY_TRAINING_EN |
+			    CDNS_PHY_TRAINING_TYPE(1) |
+			    CDNS_PHY_SCRAMBLER_BYPASS);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_1 | DP_LINK_SCRAMBLING_DISABLE);
+}
+
+static void mhdp_get_adjust_train(struct cdns_mhdp_device *mhdp,
+				  u8 link_status[DP_LINK_STATUS_SIZE],
+				  u8 lanes_data[CDNS_DP_MAX_NUM_LANES])
+{
+	unsigned int i;
+	u8 adjust, max_pre_emphasis, max_volt_swing;
+
+	max_pre_emphasis = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis)
+		<< DP_TRAIN_PRE_EMPHASIS_SHIFT;
+	max_volt_swing = CDNS_VOLT_SWING(mhdp->host.volt_swing);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		adjust = drm_dp_get_adjust_request_voltage(link_status, i);
+		lanes_data[i] = min_t(u8, adjust, max_volt_swing);
+		if (lanes_data[i] != adjust)
+			lanes_data[i] |= DP_TRAIN_MAX_SWING_REACHED;
+
+		adjust = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		lanes_data[i] |= min_t(u8, adjust, max_pre_emphasis);
+		if ((lanes_data[i] >> DP_TRAIN_PRE_EMPHASIS_SHIFT) != adjust)
+			lanes_data[i] |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
+	}
+}
+
+static void mhdp_set_adjust_request_voltage(
+	u8 link_status[DP_LINK_STATUS_SIZE], int lane, u8 volt)
+{
+	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
+	int s = ((lane & 1) ?
+		 DP_ADJUST_VOLTAGE_SWING_LANE1_SHIFT :
+		 DP_ADJUST_VOLTAGE_SWING_LANE0_SHIFT);
+	int idx = i - DP_LANE0_1_STATUS;
+
+	link_status[idx] &= ~(DP_ADJUST_VOLTAGE_SWING_LANE0_MASK << s);
+	link_status[idx] |= volt << s;
+}
+
+static void mhdp_set_adjust_request_pre_emphasis(
+	u8 link_status[DP_LINK_STATUS_SIZE], int lane, u8 pre_emphasis)
+{
+	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
+	int s = ((lane & 1) ?
+		 DP_ADJUST_PRE_EMPHASIS_LANE1_SHIFT :
+		 DP_ADJUST_PRE_EMPHASIS_LANE0_SHIFT);
+	int idx = i - DP_LANE0_1_STATUS;
+
+	link_status[idx] &= ~(DP_ADJUST_PRE_EMPHASIS_LANE0_MASK << s);
+	link_status[idx] |= pre_emphasis << s;
+}
+
+static void mhdp_adjust_requested_eq(struct cdns_mhdp_device *mhdp,
+				     u8 link_status[DP_LINK_STATUS_SIZE])
+{
+	unsigned int i;
+	u8 pre, volt, max_pre = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+	   max_volt = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		volt = drm_dp_get_adjust_request_voltage(link_status, i);
+		pre = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		if (volt + pre > 3)
+			mhdp_set_adjust_request_voltage(link_status, i,
+							3 - pre);
+		if (mhdp->host.volt_swing & CDNS_FORCE_VOLT_SWING)
+			mhdp_set_adjust_request_voltage(link_status, i,
+							max_volt);
+		if (mhdp->host.pre_emphasis & CDNS_FORCE_PRE_EMPHASIS)
+			mhdp_set_adjust_request_pre_emphasis(link_status, i,
+							     max_pre);
+	}
+}
+
+static bool mhdp_link_training_channel_eq(struct cdns_mhdp_device *mhdp,
+					  u8 eq_tps,
+					  unsigned int training_interval)
+{
+	u8 lanes_data[CDNS_DP_MAX_NUM_LANES], fail_counter_short = 0;
+	u8 dpcd[DP_LINK_STATUS_SIZE];
+	u32 reg32;
+
+	dev_dbg(mhdp->dev, "Link training - Starting EQ phase\n");
+
+	/* Enable link training TPS[eq_tps] in PHY */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_EN |
+		CDNS_PHY_TRAINING_TYPE(eq_tps);
+	if (eq_tps != 4)
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   (eq_tps != 4) ? eq_tps | DP_LINK_SCRAMBLING_DISABLE :
+			   CDNS_DP_TRAINING_PATTERN_4);
+
+	drm_dp_dpcd_read_link_status(&mhdp->aux, dpcd);
+
+	do {
+		mhdp_get_adjust_train(mhdp, dpcd, lanes_data);
+
+		cdns_mhdp_adjust_lt(mhdp, mhdp->link.num_lanes,
+				    training_interval, lanes_data, dpcd);
+
+		if (!drm_dp_clock_recovery_ok(dpcd, mhdp->link.num_lanes))
+			goto err;
+
+		if (drm_dp_channel_eq_ok(dpcd, mhdp->link.num_lanes)) {
+			dev_dbg(mhdp->dev,
+				"Link training: EQ phase succeeded\n");
+			return true;
+		}
+
+		fail_counter_short++;
+
+		mhdp_adjust_requested_eq(mhdp, dpcd);
+	} while (fail_counter_short < 5);
+
+err:
+	dev_dbg(mhdp->dev,
+		"Link training - EQ phase failed for %d lanes and %d rate\n",
+		mhdp->link.num_lanes, mhdp->link.rate);
+
+	return false;
+}
+
+static void mhdp_adjust_requested_cr(struct cdns_mhdp_device *mhdp,
+				     u8 link_status[DP_LINK_STATUS_SIZE],
+				     u8 *req_volt, u8 *req_pre)
+{
+	unsigned int i, max_volt = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+		     max_pre = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		if (mhdp->host.volt_swing & CDNS_FORCE_VOLT_SWING)
+			mhdp_set_adjust_request_voltage(link_status, i,
+							max_volt);
+		else
+			mhdp_set_adjust_request_voltage(link_status, i,
+							req_volt[i]);
+
+		if (mhdp->host.pre_emphasis & CDNS_FORCE_PRE_EMPHASIS)
+			mhdp_set_adjust_request_pre_emphasis(link_status, i,
+							     max_pre);
+		else
+			mhdp_set_adjust_request_pre_emphasis(link_status, i,
+							     req_pre[i]);
+	}
+}
+
+static void mhdp_validate_cr(struct cdns_mhdp_device *mhdp, bool *cr_done,
+			     bool *same_before_adjust, bool *max_swing_reached,
+			     u8 before_cr[DP_LINK_STATUS_SIZE],
+			     u8 after_cr[DP_LINK_STATUS_SIZE], u8 *req_volt,
+			     u8 *req_pre)
+{
+	unsigned int i;
+	u8 tmp, max_volt = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+	   max_pre = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis), lane_status;
+	bool same_pre, same_volt;
+
+	*same_before_adjust = false;
+	*max_swing_reached = false;
+	*cr_done = true;
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		tmp = drm_dp_get_adjust_request_voltage(after_cr, i);
+		req_volt[i] = min_t(u8, tmp, max_volt);
+
+		tmp = drm_dp_get_adjust_request_pre_emphasis(after_cr, i) >>
+			DP_TRAIN_PRE_EMPHASIS_SHIFT;
+		req_pre[i] = min_t(u8, tmp, max_pre);
+
+		same_pre = (before_cr[i] & DP_TRAIN_PRE_EMPHASIS_MASK) ==
+			(req_pre[i] << DP_TRAIN_PRE_EMPHASIS_SHIFT);
+		same_volt = (before_cr[i] & DP_TRAIN_VOLTAGE_SWING_MASK) ==
+			req_volt[i];
+		if (same_pre && same_volt)
+			*same_before_adjust = true;
+
+		lane_status = drm_dp_get_lane_status(after_cr, i);
+		if (!(lane_status & DP_LANE_CR_DONE)) {
+			*cr_done = false;
+			/* 3.1.5.2 in DP Standard v1.4. Table 3-1 */
+			if (req_volt[i] + req_pre[i] >= 3) {
+				*max_swing_reached = true;
+				return;
+			}
+		}
+	}
+}
+
+static bool mhdp_link_training_clock_recovery(struct cdns_mhdp_device *mhdp)
+{
+	u8 lanes_data[CDNS_DP_MAX_NUM_LANES], fail_counter_short = 0,
+	   fail_counter_cr_long = 0;
+	u8 dpcd[DP_LINK_STATUS_SIZE];
+	bool cr_done;
+
+	dev_dbg(mhdp->dev, "Link training starting CR phase\n");
+
+	mhdp_link_training_init(mhdp);
+
+	drm_dp_dpcd_read_link_status(&mhdp->aux, dpcd);
+
+	do {
+		u8 requested_adjust_volt_swing[CDNS_DP_MAX_NUM_LANES] = {},
+		   requested_adjust_pre_emphasis[CDNS_DP_MAX_NUM_LANES] = {};
+		bool same_before_adjust, max_swing_reached;
+
+		mhdp_get_adjust_train(mhdp, dpcd, lanes_data);
+
+		cdns_mhdp_adjust_lt(mhdp, mhdp->link.num_lanes, 100,
+				    lanes_data, dpcd);
+
+		mhdp_validate_cr(mhdp, &cr_done, &same_before_adjust,
+				 &max_swing_reached, lanes_data, dpcd,
+				 requested_adjust_volt_swing,
+				 requested_adjust_pre_emphasis);
+
+		if (max_swing_reached)
+			goto err;
+
+		if (cr_done) {
+			dev_dbg(mhdp->dev,
+				"Link training: CR phase succeeded\n");
+			return true;
+		}
+
+		/* Not all CR_DONE bits set */
+		fail_counter_cr_long++;
+
+		if (same_before_adjust) {
+			fail_counter_short++;
+			continue;
+		}
+
+		fail_counter_short = 0;
+		/*
+		 * Voltage swing/pre-emphasis adjust requested
+		 * during CR phase
+		 */
+		mhdp_adjust_requested_cr(mhdp, dpcd,
+					 requested_adjust_volt_swing,
+					 requested_adjust_pre_emphasis);
+	} while (fail_counter_short < 5 && fail_counter_cr_long < 10);
+
+err:
+	dev_dbg(mhdp->dev,
+		"Link training: CR phase failed for %d lanes and %d rate\n",
+		mhdp->link.num_lanes, mhdp->link.rate);
+
+	return false;
+}
+
+static void lower_link_rate(struct drm_dp_link *link)
+{
+	switch (drm_dp_link_rate_to_bw_code(link->rate)) {
+	case DP_LINK_BW_2_7:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_1_62);
+		break;
+	case DP_LINK_BW_5_4:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_2_7);
+		break;
+	case DP_LINK_BW_8_1:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+		break;
+	}
+}
+
+static int mhdp_link_training(struct cdns_mhdp_device *mhdp,
+			      unsigned int video_mode,
+			      unsigned int training_interval)
+{
+	u32 reg32;
+	u8 eq_tps = eq_training_pattern_supported(mhdp->host, mhdp->sink);
+
+	while (1) {
+		if (!mhdp_link_training_clock_recovery(mhdp)) {
+			if (drm_dp_link_rate_to_bw_code(mhdp->link.rate) !=
+			    DP_LINK_BW_1_62) {
+				dev_dbg(mhdp->dev,
+					"Reducing link rate during CR phase\n");
+				lower_link_rate(&mhdp->link);
+				drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+				continue;
+			} else if (mhdp->link.num_lanes > 1) {
+				dev_dbg(mhdp->dev,
+					"Reducing lanes number during CR phase\n");
+				mhdp->link.num_lanes >>= 1;
+				mhdp->link.rate = max_link_rate(mhdp->host,
+								mhdp->sink);
+				drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+				continue;
+			}
+
+			dev_dbg(mhdp->dev,
+				"Link training failed during CR phase\n");
+			goto err;
+		}
+
+		if (mhdp_link_training_channel_eq(mhdp, eq_tps,
+						  training_interval))
+			break;
+
+		if (mhdp->link.num_lanes > 1) {
+			dev_dbg(mhdp->dev,
+				"Reducing lanes number during EQ phase\n");
+			mhdp->link.num_lanes >>= 1;
+			drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+			continue;
+		} else if (drm_dp_link_rate_to_bw_code(mhdp->link.rate) !=
+			   DP_LINK_BW_1_62) {
+			dev_dbg(mhdp->dev,
+				"Reducing link rate during EQ phase\n");
+			lower_link_rate(&mhdp->link);
+			drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+			continue;
+		}
+
+		dev_dbg(mhdp->dev, "Link training failed during EQ phase\n");
+		goto err;
+	}
+
+	dev_dbg(mhdp->dev, "Link training successful\n");
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   (mhdp->host.lanes_cnt & CDNS_SCRAMBLER) ? 0 :
+			   DP_LINK_SCRAMBLING_DISABLE);
+
+	/* SW reset DPTX framer */
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_SW_RESET, 1);
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_SW_RESET, 0);
+
+	/* Enable framer */
+	/* FIXME: update when MST supported, BIT(2) */
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG,
+			    CDNS_DP_FRAMER_EN |
+			    CDNS_DP_NUM_LANES(mhdp->link.num_lanes) |
+			    CDNS_DP_DISABLE_PHY_RST |
+			    CDNS_DP_WR_FAILING_EDGE_VSYNC |
+			    (!video_mode ? CDNS_DP_NO_VIDEO_MODE : 0));
+
+	/* Reset PHY config */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	return 0;
+err:
+	/* Reset PHY config */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	return -EIO;
+}
+
+static void cdns_mhdp_disable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+
+	cdns_mhdp_set_video_status(mhdp, 0);
+
+	drm_dp_link_power_down(&mhdp->aux, &mhdp->link);
+}
+
+static void cdns_mhdp_enable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+	struct drm_display_mode *mode;
+	struct drm_display_info *disp_info = &mhdp->connector.display_info;
+	enum pixel_format pxlfmt;
+	int pxlclock;
+	unsigned int rate, tu_size = 30, vs, vs_f, bpp, required_bandwidth,
+		     available_bandwidth, dp_framer_sp = 0, msa_horizontal_1,
+		     msa_vertical_1, bnd_hsync2vsync, hsync2vsync_pol_ctrl,
+		     misc0 = 0, misc1 = 0, line_thresh = 0, pxl_repr,
+		     front_porch, back_porch, msa_h0, msa_v0, hsync, vsync,
+		     dp_vertical_1, line_thresh1, line_thresh2;
+	u32 resp;
+
+	unsigned int size = DP_RECEIVER_CAP_SIZE, dp_framer_global_config,
+		     video_mode, training_interval_us;
+	u8 reg0[size], reg8, amp[2];
+
+	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	pxlclock = mode->crtc_clock;
+
+	/*
+	 * Upon power-on reset/device disconnection: [2:0] bits should be 0b001
+	 * and [7:5] bits 0b000.
+	 */
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_SET_POWER, 1);
+
+	drm_dp_link_probe(&mhdp->aux, &mhdp->link);
+
+	dev_dbg(mhdp->dev, "Set sink device power state via DPCD\n");
+	drm_dp_link_power_up(&mhdp->aux, &mhdp->link);
+	/* FIXME (CDNS): do we have to wait for 100ms before going on? */
+	mdelay(100);
+
+	mhdp->sink.link_rate = mhdp->link.rate;
+	mhdp->sink.lanes_cnt = mhdp->link.num_lanes;
+	mhdp->sink.enhanced = !!(mhdp->link.capabilities &
+				 DP_LINK_CAP_ENHANCED_FRAMING);
+
+	drm_dp_dpcd_read(&mhdp->aux, DP_DPCD_REV, reg0, size);
+
+	mhdp->sink.pattern_supp = CDNS_SUPPORT_TPS(1) | CDNS_SUPPORT_TPS(2);
+	if (drm_dp_tps3_supported(reg0))
+		mhdp->sink.pattern_supp |= CDNS_SUPPORT_TPS(3);
+	if (drm_dp_tps4_supported(reg0))
+		mhdp->sink.pattern_supp |= CDNS_SUPPORT_TPS(4);
+
+	mhdp->sink.fast_link = !!(reg0[DP_MAX_DOWNSPREAD] &
+				  DP_NO_AUX_HANDSHAKE_LINK_TRAINING);
+
+	mhdp->link.rate = max_link_rate(mhdp->host, mhdp->sink);
+	mhdp->link.num_lanes = min_t(u8, mhdp->sink.lanes_cnt,
+				     mhdp->host.lanes_cnt & GENMASK(2, 0));
+
+	reg8 = reg0[DP_TRAINING_AUX_RD_INTERVAL] &
+		DP_TRAINING_AUX_RD_MASK;
+	switch (reg8) {
+	case 0:
+		training_interval_us = 400;
+		break;
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		training_interval_us = 4000 << (reg8 - 1);
+		break;
+	default:
+		dev_err(mhdp->dev,
+			"wrong training interval returned by DPCD: %d\n", reg8);
+		return;
+	}
+
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &resp);
+
+	dp_framer_global_config = be32_to_cpu(resp);
+
+	video_mode = !(dp_framer_global_config & CDNS_DP_NO_VIDEO_MODE);
+
+	if (dp_framer_global_config & CDNS_DP_FRAMER_EN)
+		cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG,
+				    dp_framer_global_config &
+				    ~CDNS_DP_FRAMER_EN);
+
+	/* Spread AMP if required, enable 8b/10b coding */
+	amp[0] = (mhdp->host.lanes_cnt & CDNS_SSC) ? DP_SPREAD_AMP_0_5 : 0;
+	amp[1] = DP_SET_ANSI_8B10B;
+	drm_dp_dpcd_write(&mhdp->aux, DP_DOWNSPREAD_CTRL, amp, 2);
+
+	if (mhdp->host.fast_link & mhdp->sink.fast_link) {
+		/* FIXME: implement fastlink */
+		dev_dbg(mhdp->dev, "fastlink\n");
+	} else {
+		if (mhdp_link_training(mhdp, video_mode,
+				       training_interval_us)) {
+			dev_err(mhdp->dev, "Link training failed. Exiting.\n");
+			return;
+		}
+	}
+
+	rate = mhdp->link.rate / 1000;
+
+	/* FIXME: what about Y_ONLY? how is it handled in the kernel? */
+	if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+		pxlfmt = PIXEL_FORMAT_YCBCR_444;
+	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+		pxlfmt = PIXEL_FORMAT_YCBCR_422;
+	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB420)
+		pxlfmt = PIXEL_FORMAT_YCBCR_420;
+	else
+		pxlfmt = PIXEL_FORMAT_RGB;
+
+	/* if YCBCR supported and stream not SD, use ITU709 */
+	/* FIXME: handle ITU version with YCBCR420 when supported */
+	if ((pxlfmt == PIXEL_FORMAT_YCBCR_444 ||
+	     pxlfmt == PIXEL_FORMAT_YCBCR_422) && mode->crtc_vdisplay >= 720)
+		misc0 = DP_YCBCR_COEFFICIENTS_ITU709;
+
+	switch (pxlfmt) {
+	case PIXEL_FORMAT_RGB:
+		bpp = disp_info->bpc * 3;
+		pxl_repr = CDNS_DP_FRAMER_RGB << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_RGB;
+		break;
+	case PIXEL_FORMAT_YCBCR_444:
+		bpp = disp_info->bpc * 3;
+		pxl_repr = CDNS_DP_FRAMER_YCBCR444 << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr444 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case PIXEL_FORMAT_YCBCR_422:
+		bpp = disp_info->bpc * 2;
+		pxl_repr = CDNS_DP_FRAMER_YCBCR422 << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr422 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case PIXEL_FORMAT_YCBCR_420:
+		bpp = disp_info->bpc * 3 / 2;
+		pxl_repr = CDNS_DP_FRAMER_YCBCR420 << CDNS_DP_FRAMER_PXL_FORMAT;
+		break;
+	default:
+		bpp = disp_info->bpc;
+		pxl_repr = CDNS_DP_FRAMER_Y_ONLY << CDNS_DP_FRAMER_PXL_FORMAT;
+	}
+
+	switch (disp_info->bpc) {
+	case 6:
+		misc0 |= DP_TEST_BIT_DEPTH_6;
+		pxl_repr |= CDNS_DP_FRAMER_6_BPC;
+		break;
+	case 8:
+		misc0 |= DP_TEST_BIT_DEPTH_8;
+		pxl_repr |= CDNS_DP_FRAMER_8_BPC;
+		break;
+	case 10:
+		misc0 |= DP_TEST_BIT_DEPTH_10;
+		pxl_repr |= CDNS_DP_FRAMER_10_BPC;
+		break;
+	case 12:
+		misc0 |= DP_TEST_BIT_DEPTH_12;
+		pxl_repr |= CDNS_DP_FRAMER_12_BPC;
+		break;
+	case 16:
+		misc0 |= DP_TEST_BIT_DEPTH_16;
+		pxl_repr |= CDNS_DP_FRAMER_16_BPC;
+		break;
+	}
+
+	/* find optimal tu_size */
+	required_bandwidth = pxlclock * bpp / 8;
+	available_bandwidth = mhdp->link.num_lanes * rate;
+	do {
+		tu_size += 2;
+
+		vs_f = tu_size * required_bandwidth / available_bandwidth;
+		vs = vs_f / 1000;
+		vs_f = vs_f % 1000;
+		/*
+		 * FIXME (CDNS): downspreading?
+		 * It's unused is what I've been told.
+		 */
+	} while ((vs == 1 || ((vs_f > 850 || vs_f < 100) && vs_f != 0) ||
+		  tu_size - vs < 2) && tu_size < 64);
+
+	if (vs > 64)
+		return;
+
+	bnd_hsync2vsync = CDNS_IP_BYPASS_V_INTERFACE;
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		bnd_hsync2vsync |= CDNS_IP_DET_INTERLACE_FORMAT;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_BND_HSYNC2VSYNC, bnd_hsync2vsync);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
+	    mode->flags & DRM_MODE_FLAG_PHSYNC)
+		hsync2vsync_pol_ctrl = CDNS_H2V_HSYNC_POL_ACTIVE_LOW |
+			CDNS_H2V_VSYNC_POL_ACTIVE_LOW;
+	else
+		hsync2vsync_pol_ctrl = 0;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_HSYNC2VSYNC_POL_CTRL,
+			    hsync2vsync_pol_ctrl);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_TU,
+			    CDNS_DP_FRAMER_TU_VS(vs) |
+			    CDNS_DP_FRAMER_TU_SIZE(tu_size) |
+			    CDNS_DP_FRAMER_TU_CNT_RST_EN);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_PXL_REPR, pxl_repr);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		dp_framer_sp |= CDNS_DP_FRAMER_INTERLACE;
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		dp_framer_sp |= CDNS_DP_FRAMER_HSYNC_POL_LOW;
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		dp_framer_sp |= CDNS_DP_FRAMER_VSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_SP, dp_framer_sp);
+
+	front_porch = mode->crtc_hsync_start - mode->crtc_hdisplay;
+	back_porch = mode->crtc_htotal - mode->crtc_hsync_end;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRONT_BACK_PORCH,
+			    CDNS_DP_FRONT_PORCH(front_porch) |
+			    CDNS_DP_BACK_PORCH(back_porch));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_BYTE_COUNT,
+			    mode->crtc_hdisplay * bpp / 8);
+
+	msa_h0 = mode->crtc_htotal - mode->crtc_hsync_start;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_0,
+			    CDNS_DP_MSAH0_H_TOTAL(mode->crtc_htotal) |
+			    CDNS_DP_MSAH0_HSYNC_START(msa_h0));
+
+	hsync = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	msa_horizontal_1 = CDNS_DP_MSAH1_HSYNC_WIDTH(hsync) |
+		CDNS_DP_MSAH1_HDISP_WIDTH(mode->crtc_hdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		msa_horizontal_1 |= CDNS_DP_MSAH1_HSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_1,
+			    msa_horizontal_1);
+
+	msa_v0 = mode->crtc_vtotal - mode->crtc_vsync_start;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_0,
+			    CDNS_DP_MSAV0_V_TOTAL(mode->crtc_vtotal) |
+			    CDNS_DP_MSAV0_VSYNC_START(msa_v0));
+
+	vsync = mode->crtc_vsync_end - mode->crtc_vsync_start;
+	msa_vertical_1 = CDNS_DP_MSAV1_VSYNC_WIDTH(vsync) |
+		CDNS_DP_MSAV1_VDISP_WIDTH(mode->crtc_vdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		msa_vertical_1 |= CDNS_DP_MSAV1_VSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_1, msa_vertical_1);
+
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+	    mode->crtc_vtotal % 2 == 0)
+		misc1 = DP_TEST_INTERLACED;
+	if (pxlfmt == PIXEL_FORMAT_Y_ONLY)
+		misc1 |= CDNS_DP_TEST_COLOR_FORMAT_RAW_Y_ONLY;
+	/* FIXME: use VSC SDP for Y420 */
+	/* FIXME: (CDNS) no code for Y420 in bare metal test */
+	if (pxlfmt == PIXEL_FORMAT_YCBCR_420)
+		misc1 = CDNS_DP_TEST_VSC_SDP;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_MISC, misc0 | (misc1 << 8));
+
+	/* FIXME: to be changed if MST mode */
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_STREAM_CONFIG, 1);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_HORIZONTAL,
+			    CDNS_DP_H_HSYNC_WIDTH(hsync) |
+			    CDNS_DP_H_H_TOTAL(mode->crtc_hdisplay));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_0,
+			    CDNS_DP_V0_VHEIGHT(mode->crtc_vdisplay) |
+			    CDNS_DP_V0_VSTART(msa_v0));
+
+	dp_vertical_1 = CDNS_DP_V1_VTOTAL(mode->crtc_vtotal);
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+	    mode->crtc_vtotal % 2 == 0)
+		dp_vertical_1 |= CDNS_DP_V1_VTOTAL_EVEN;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_1, dp_vertical_1);
+
+	cdns_mhdp_reg_write_bit(mhdp, CDNS_DP_VB_ID, 2, 1,
+				(mode->flags & DRM_MODE_FLAG_INTERLACE) ?
+				CDNS_DP_VB_ID_INTERLACED : 0);
+
+	line_thresh1 = ((vs + 1) << 5) * 8 / bpp;
+	line_thresh2 = (pxlclock << 5) / 1000 / rate * (vs + 1) - (1 << 5);
+	line_thresh = line_thresh1 - line_thresh2 / mhdp->link.num_lanes;
+	line_thresh = (line_thresh >> 5) + 2;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_LINE_THRESH,
+			    line_thresh & GENMASK(5, 0));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_RATE_GOVERNOR_STATUS,
+			    CDNS_DP_RG_TU_VS_DIFF((tu_size - vs > 3) ?
+						       0 : tu_size - vs));
+
+	cdns_mhdp_set_video_status(mhdp, 1);
+}
+
+static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
+	.enable = cdns_mhdp_enable,
+	.disable = cdns_mhdp_disable,
+	.attach = cdns_mhdp_attach,
+};
+
+static int load_firmware(struct cdns_mhdp_device *mhdp, const char *name,
+			 unsigned int addr)
+{
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, name, mhdp->dev);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to load firmware (%s), ret: %d\n",
+			name, ret);
+		return ret;
+	}
+
+	memcpy_toio(mhdp->regs + addr, fw->data, fw->size);
+
+	release_firmware(fw);
+
+	return 0;
+}
+
+static int mhdp_probe(struct platform_device *pdev)
+{
+	struct resource *regs;
+	struct cdns_mhdp_device *mhdp;
+	struct clk *clk;
+	int ret;
+	unsigned int reg;
+	unsigned long rate;
+
+	mhdp = devm_kzalloc(&pdev->dev, sizeof(struct cdns_mhdp_device),
+			    GFP_KERNEL);
+	if (!mhdp)
+		return -ENOMEM;
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "couldn't get clk: %ld\n", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	mhdp->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, mhdp);
+
+	drm_dp_aux_init(&mhdp->aux);
+	mhdp->aux.dev = &pdev->dev;
+	mhdp->aux.transfer = mhdp_transfer;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mhdp->regs = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(mhdp->regs))
+		return PTR_ERR(mhdp->regs);
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	mhdp->dbg_regs = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(mhdp->dbg_regs))
+		return PTR_ERR(mhdp->dbg_regs);
+
+	platform_set_drvdata(pdev, mhdp);
+
+	ret = load_firmware(mhdp, IRAM_FW_NAME, CDNS_MHDP_IMEM);
+	if (ret)
+		return ret;
+
+	ret = load_firmware(mhdp, DRAM_FW_NAME, CDNS_MHDP_DMEM);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(clk);
+	writel(rate % 1000000, mhdp->regs + CDNS_SW_CLK_L);
+	writel(rate / 1000000, mhdp->regs + CDNS_SW_CLK_H);
+
+	/* Leave debug mode */
+	writel(0, mhdp->regs + CDNS_APB_CTRL);
+
+	/*
+	 * Wait for the KEEP_ALIVE "message" on the first 8 bits.
+	 * Updated each sched "tick" (~2ms)
+	 */
+	ret = readl_poll_timeout(mhdp->regs + CDNS_KEEP_ALIVE, reg,
+				 reg & CDNS_KEEP_ALIVE_MASK, 500,
+				 CDNS_KEEP_ALIVE_TIMEOUT);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"device didn't give any life sign: reg %d\n", reg);
+		return -EIO;
+	}
+
+	/*
+	 * FIXME (CDNS): how are the characteristics/features of the host
+	 * defined? Will they be always hardcoded?
+	 */
+	/* FIXME: link rate 2.7; num_lanes = 2,	 */
+	/* FIXME: read capabilities from PHY */
+	mhdp->host.link_rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+	mhdp->host.lanes_cnt = CDNS_LANE_4 | CDNS_SCRAMBLER;
+	mhdp->host.volt_swing = CDNS_VOLT_SWING(3);
+	mhdp->host.pre_emphasis = CDNS_PRE_EMPHASIS(2);
+	mhdp->host.pattern_supp = CDNS_SUPPORT_TPS(1) |
+		CDNS_SUPPORT_TPS(2) | CDNS_SUPPORT_TPS(3) |
+		CDNS_SUPPORT_TPS(4);
+	mhdp->host.fast_link = 0;
+	mhdp->host.lane_mapping = CDNS_LANE_MAPPING_FLIPPED;
+	mhdp->host.enhanced = true;
+
+	mhdp->bridge.of_node = pdev->dev.of_node;
+	mhdp->bridge.funcs = &cdns_mhdp_bridge_funcs;
+
+	/* Init events to 0 as it's not cleared by FW at boot but on read */
+	readl(mhdp->regs + CDNS_SW_EVENT0);
+	readl(mhdp->regs + CDNS_SW_EVENT1);
+	readl(mhdp->regs + CDNS_SW_EVENT2);
+	readl(mhdp->regs + CDNS_SW_EVENT3);
+
+	/* Activate uCPU */
+	ret = cdns_mhdp_set_firmware_active(mhdp, true);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to activate DP\n");
+		return ret;
+	}
+
+	/* Loop over HDP change */
+	/*
+	 * FIXME: does not work when put in mhdp_bridge_enable.
+	 * Where should we put it?
+	 */
+	/* Is it still needed with use of mb message HPD STATUS? */
+	ret = readl_poll_timeout(mhdp->regs + CDNS_SW_EVENT0, reg,
+				 reg & CDNS_DPTX_HPD, 500,
+				 CDNS_SW_EVENT0_TIMEOUT);
+	if (ret) {
+		dev_err(mhdp->dev, "no HPD received %d\n", reg);
+		return -ENODEV;
+	}
+
+	drm_bridge_add(&mhdp->bridge);
+
+	return 0;
+}
+
+MODULE_FIRMWARE(IRAM_FW_NAME);
+MODULE_FIRMWARE(DRAM_FW_NAME);
+
+static int mhdp_remove(struct platform_device *pdev)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	drm_bridge_remove(&mhdp->bridge);
+
+	ret = cdns_mhdp_set_firmware_active(mhdp, false);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to de-activate DP\n");
+		return ret;
+	}
+
+	/* FIXME: check for missing functions */
+
+	return 0;
+}
+
+static struct platform_driver mhdp_driver = {
+	.driver	= {
+		.name		= "cdns-mhdp",
+		.of_match_table	= of_match_ptr(mhdp_ids),
+	},
+	.probe	= mhdp_probe,
+	.remove	= mhdp_remove,
+};
+module_platform_driver(mhdp_driver);
+
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
+MODULE_DESCRIPTION("Cadence MHDP DP bridge driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cdns-mhdp");
-- 
2.17.1
