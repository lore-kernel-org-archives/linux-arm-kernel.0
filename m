From: yt.shen@mediatek.com (YT Shen)
Date: Wed, 11 Jan 2017 14:51:10 +0800
Subject: [PATCH v11 09/12] drm/mediatek: add dsi transfer function
In-Reply-To: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
References: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1484117473-46644-10-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: shaoming chen <shaoming.chen@mediatek.com>

add dsi read/write commands for transfer function

Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 168 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 474861a..b3c7fd8 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -24,6 +24,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <video/mipi_display.h>
 #include <video/videomode.h>
 
 #include "mtk_drm_ddp_comp.h"
@@ -80,8 +81,16 @@
 #define DSI_HBP_WC		0x54
 #define DSI_HFP_WC		0x58
 
+#define DSI_CMDQ_SIZE		0x60
+#define CMDQ_SIZE			0x3f
+
 #define DSI_HSTX_CKL_WC		0x64
 
+#define DSI_RX_DATA0		0x74
+#define DSI_RX_DATA1		0x78
+#define DSI_RX_DATA2		0x7c
+#define DSI_RX_DATA3		0x80
+
 #define DSI_RACK		0x84
 #define RACK				BIT(0)
 
@@ -117,6 +126,15 @@
 #define CLK_HS_POST			(0xff << 8)
 #define CLK_HS_EXIT			(0xff << 16)
 
+#define DSI_CMDQ0		0x180
+#define CONFIG				(0xff << 0)
+#define SHORT_PACKET			0
+#define LONG_PACKET			2
+#define BTA				BIT(2)
+#define DATA_ID				(0xff << 8)
+#define DATA_0				(0xff << 16)
+#define DATA_1				(0xff << 24)
+
 #define T_LPX		5
 #define T_HS_PREP	6
 #define T_HS_TRAIL	8
@@ -125,6 +143,12 @@
 
 #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
 
+#define MTK_DSI_HOST_IS_READ(type) \
+	((type == MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM) || \
+	(type == MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM) || \
+	(type == MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM) || \
+	(type == MIPI_DSI_DCS_READ))
+
 struct phy;
 
 struct mtk_dsi {
@@ -497,12 +521,12 @@ static void mtk_dsi_irq_data_set(struct mtk_dsi *dsi, u32 irq_bit)
 	dsi->irq_data |= irq_bit;
 }
 
-static __maybe_unused void mtk_dsi_irq_data_clear(struct mtk_dsi *dsi, u32 irq_bit)
+static void mtk_dsi_irq_data_clear(struct mtk_dsi *dsi, u32 irq_bit)
 {
 	dsi->irq_data &= ~irq_bit;
 }
 
-static __maybe_unused s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
+static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
 				     unsigned int timeout)
 {
 	s32 ret = 0;
@@ -832,9 +856,149 @@ static int mtk_dsi_host_detach(struct mipi_dsi_host *host,
 	return 0;
 }
 
+static void mtk_dsi_wait_for_idle(struct mtk_dsi *dsi)
+{
+	u32 timeout_ms = 500000; /* total 1s ~ 2s timeout */
+
+	while (timeout_ms--) {
+		if (!(readl(dsi->regs + DSI_INTSTA) & DSI_BUSY))
+			break;
+
+		usleep_range(2, 4);
+	}
+
+	if (timeout_ms == 0) {
+		DRM_WARN("polling dsi wait not busy timeout!\n");
+
+		mtk_dsi_enable(dsi);
+		mtk_dsi_reset_engine(dsi);
+	}
+}
+
+static u32 mtk_dsi_recv_cnt(u8 type, u8 *read_data)
+{
+	switch (type) {
+	case MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_1BYTE:
+	case MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE:
+		return 1;
+	case MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_2BYTE:
+	case MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE:
+		return 2;
+	case MIPI_DSI_RX_GENERIC_LONG_READ_RESPONSE:
+	case MIPI_DSI_RX_DCS_LONG_READ_RESPONSE:
+		return read_data[1] + read_data[2] * 16;
+	case MIPI_DSI_RX_ACKNOWLEDGE_AND_ERROR_REPORT:
+		DRM_INFO("type is 0x02, try again\n");
+		break;
+	default:
+		DRM_INFO("type(0x%x) cannot be non-recognite\n", type);
+		break;
+	}
+
+	return 0;
+}
+
+static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
+{
+	const char *tx_buf = msg->tx_buf;
+	u8 config, cmdq_size, cmdq_off, type = msg->type;
+	u32 reg_val, cmdq_mask, i;
+
+	if (MTK_DSI_HOST_IS_READ(type))
+		config = BTA;
+	else
+		config = (msg->tx_len > 2) ? LONG_PACKET : SHORT_PACKET;
+
+	if (msg->tx_len > 2) {
+		cmdq_size = 1 + (msg->tx_len + 3) / 4;
+		cmdq_off = 4;
+		cmdq_mask = CONFIG | DATA_ID | DATA_0 | DATA_1;
+		reg_val = (msg->tx_len << 16) | (type << 8) | config;
+	} else {
+		cmdq_size = 1;
+		cmdq_off = 2;
+		cmdq_mask = CONFIG | DATA_ID;
+		reg_val = (type << 8) | config;
+	}
+
+	for (i = 0; i < msg->tx_len; i++)
+		writeb(tx_buf[i], dsi->regs + DSI_CMDQ0 + cmdq_off + i);
+
+	mtk_dsi_mask(dsi, DSI_CMDQ0, cmdq_mask, reg_val);
+	mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, cmdq_size);
+}
+
+static ssize_t mtk_dsi_host_send_cmd(struct mtk_dsi *dsi,
+				     const struct mipi_dsi_msg *msg, u8 flag)
+{
+	mtk_dsi_wait_for_idle(dsi);
+	mtk_dsi_irq_data_clear(dsi, flag);
+	mtk_dsi_cmdq(dsi, msg);
+	mtk_dsi_start(dsi);
+
+	if (!mtk_dsi_wait_for_irq_done(dsi, flag, 2000))
+		return -ETIME;
+	else
+		return 0;
+}
+
+static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
+				     const struct mipi_dsi_msg *msg)
+{
+	struct mtk_dsi *dsi = host_to_dsi(host);
+	u32 recv_cnt, i;
+	u8 read_data[16];
+	void *src_addr;
+	u8 irq_flag = CMD_DONE_INT_FLAG;
+
+	if (readl(dsi->regs + DSI_MODE_CTRL) & MODE) {
+		DRM_ERROR("dsi engine is not command mode\n");
+		return -EINVAL;
+	}
+
+	if (MTK_DSI_HOST_IS_READ(msg->type))
+		irq_flag |= LPRX_RD_RDY_INT_FLAG;
+
+	if (mtk_dsi_host_send_cmd(dsi, msg, irq_flag) < 0)
+		return -ETIME;
+
+	if (!MTK_DSI_HOST_IS_READ(msg->type))
+		return 0;
+
+	if (!msg->rx_buf) {
+		DRM_ERROR("dsi receive buffer size may be NULL\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < 16; i++)
+		*(read_data + i) = readb(dsi->regs + DSI_RX_DATA0 + i);
+
+	recv_cnt = mtk_dsi_recv_cnt(read_data[0], read_data);
+
+	if (recv_cnt > 2)
+		src_addr = &read_data[4];
+	else
+		src_addr = &read_data[1];
+
+	if (recv_cnt > 10)
+		recv_cnt = 10;
+
+	if (recv_cnt > msg->rx_len)
+		recv_cnt = msg->rx_len;
+
+	if (recv_cnt)
+		memcpy(msg->rx_buf, src_addr, recv_cnt);
+
+	DRM_INFO("dsi get %d byte data from the panel address(0x%x)\n",
+		 recv_cnt, *((u8 *)(msg->tx_buf)));
+
+	return recv_cnt;
+}
+
 static const struct mipi_dsi_host_ops mtk_dsi_ops = {
 	.attach = mtk_dsi_host_attach,
 	.detach = mtk_dsi_host_detach,
+	.transfer = mtk_dsi_host_transfer,
 };
 
 static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
-- 
1.9.1
