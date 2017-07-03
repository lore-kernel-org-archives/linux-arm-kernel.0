From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 3 Jul 2017 11:51:13 +0530
Subject: [PATCH v4 3/6] drm/bridge/synopsys: Add MIPI DSI host controller
 bridge
In-Reply-To: <247e97ff-e79a-1fbd-d048-f877e0a56f8c@samsung.com>
References: <1497889685-27349-1-git-send-email-philippe.cornu@st.com>
 <1497889685-27349-4-git-send-email-philippe.cornu@st.com>
 <CGME20170628064446epcas2p2465c317167d7bd0448d6f1b80258e8b0@epcas2p2.samsung.com>
 <1aad8695-8527-574c-2b99-9efa88216aa8@codeaurora.org>
 <247e97ff-e79a-1fbd-d048-f877e0a56f8c@samsung.com>
Message-ID: <ce9259f0-11f1-6d51-fceb-241057fb0951@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/28/2017 02:35 PM, Andrzej Hajda wrote:
> On 28.06.2017 08:44, Archit Taneja wrote:
>>
>> On 06/19/2017 09:58 PM, Philippe CORNU wrote:
>>> Add a Synopsys Designware MIPI DSI host DRM bridge driver, based on the
>>> Rockchip version from rockchip/dw-mipi-dsi.c with phy & bridge APIs.
>>>
>>> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
>>> ---
>>>    drivers/gpu/drm/bridge/synopsys/Kconfig       |   6 +
>>>    drivers/gpu/drm/bridge/synopsys/Makefile      |   2 +
>>>    drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 976 ++++++++++++++++++++++++++
>>>    include/drm/bridge/dw_mipi_dsi.h              |  39 +
>>>    4 files changed, 1023 insertions(+)
>>>    create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>>    create mode 100644 include/drm/bridge/dw_mipi_dsi.h
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
>>> index 40d2827..f00ee26 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/Kconfig
>>> +++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
>>> @@ -21,3 +21,9 @@ config DRM_DW_HDMI_I2S_AUDIO
>>>    	help
>>>    	  Support the I2S Audio interface which is part of the Synopsys
>>>    	  Designware HDMI block.
>>> +
>>> +config DRM_DW_MIPI_DSI
>>> +	tristate
>>> +	select DRM_KMS_HELPER
>>> +	select DRM_MIPI_DSI
>>> +	select DRM_PANEL_BRIDGE
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/Makefile b/drivers/gpu/drm/bridge/synopsys/Makefile
>>> index 17aa7a6..5f57d36 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/Makefile
>>> +++ b/drivers/gpu/drm/bridge/synopsys/Makefile
>>> @@ -3,3 +3,5 @@
>>>    obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
>>>    obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
>>>    obj-$(CONFIG_DRM_DW_HDMI_I2S_AUDIO) += dw-hdmi-i2s-audio.o
>>> +
>>> +obj-$(CONFIG_DRM_DW_MIPI_DSI) += dw-mipi-dsi.o
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> new file mode 100644
>>> index 0000000..416ed7f
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> @@ -0,0 +1,976 @@
>>> +/*
>>> + * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>>> + * Copyright (C) STMicroelectronics SA 2017
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * Modified by Philippe Cornu <philippe.cornu@st.com>
>>> + * This generic Synopsys DesignWare MIPI DSI host driver is based on the
>>> + * Rockchip version from rockchip/dw-mipi-dsi.c with phy & bridge APIs.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/component.h>
>>> +#include <linux/iopoll.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/reset.h>
>>> +#include <drm/drmP.h>
>>> +#include <drm/drm_atomic_helper.h>
>>> +#include <drm/drm_bridge.h>
>>> +#include <drm/drm_crtc.h>
>>> +#include <drm/drm_crtc_helper.h>
>>> +#include <drm/drm_mipi_dsi.h>
>>> +#include <drm/drm_of.h>
>>> +#include <drm/bridge/dw_mipi_dsi.h>
>>> +#include <video/mipi_display.h>
>>> +
>>> +#define DSI_VERSION			0x00
>>> +#define DSI_PWR_UP			0x04
>>> +#define RESET				0
>>> +#define POWERUP				BIT(0)
>>> +
>>> +#define DSI_CLKMGR_CFG			0x08
>>> +#define TO_CLK_DIVIDSION(div)		(((div) & 0xff) << 8)
>>> +#define TX_ESC_CLK_DIVIDSION(div)	(((div) & 0xff) << 0)
>>> +
>>> +#define DSI_DPI_VCID			0x0c
>>> +#define DPI_VID(vid)			(((vid) & 0x3) << 0)
>>> +
>>> +#define DSI_DPI_COLOR_CODING		0x10
>>> +#define EN18_LOOSELY			BIT(8)
>>> +#define DPI_COLOR_CODING_16BIT_1	0x0
>>> +#define DPI_COLOR_CODING_16BIT_2	0x1
>>> +#define DPI_COLOR_CODING_16BIT_3	0x2
>>> +#define DPI_COLOR_CODING_18BIT_1	0x3
>>> +#define DPI_COLOR_CODING_18BIT_2	0x4
>>> +#define DPI_COLOR_CODING_24BIT		0x5
>>> +
>>> +#define DSI_DPI_CFG_POL			0x14
>>> +#define COLORM_ACTIVE_LOW		BIT(4)
>>> +#define SHUTD_ACTIVE_LOW		BIT(3)
>>> +#define HSYNC_ACTIVE_LOW		BIT(2)
>>> +#define VSYNC_ACTIVE_LOW		BIT(1)
>>> +#define DATAEN_ACTIVE_LOW		BIT(0)
>>> +
>>> +#define DSI_DPI_LP_CMD_TIM		0x18
>>> +#define OUTVACT_LPCMD_TIME(p)		(((p) & 0xff) << 16)
>>> +#define INVACT_LPCMD_TIME(p)		((p) & 0xff)
>>> +
>>> +#define DSI_DBI_CFG			0x20
>>> +#define DSI_DBI_CMDSIZE			0x28
>>> +
>>> +#define DSI_PCKHDL_CFG			0x2c
>>> +#define EN_CRC_RX			BIT(4)
>>> +#define EN_ECC_RX			BIT(3)
>>> +#define EN_BTA				BIT(2)
>>> +#define EN_EOTP_RX			BIT(1)
>>> +#define EN_EOTP_TX			BIT(0)
>>> +
>>> +#define DSI_MODE_CFG			0x34
>>> +#define ENABLE_VIDEO_MODE		0
>>> +#define ENABLE_CMD_MODE			BIT(0)
>>> +
>>> +#define DSI_VID_MODE_CFG		0x38
>>> +#define FRAME_BTA_ACK			BIT(14)
>>> +#define ENABLE_LOW_POWER		(0x3f << 8)
>>> +#define ENABLE_LOW_POWER_MASK		(0x3f << 8)
>>> +#define VID_MODE_TYPE_NON_BURST_SYNC_PULSES	0x0
>>> +#define VID_MODE_TYPE_NON_BURST_SYNC_EVENTS	0x1
>>> +#define VID_MODE_TYPE_BURST			0x2
>>> +#define VID_MODE_TYPE_MASK			0x3
>>> +
>>> +#define DSI_VID_PKT_SIZE		0x3c
>>> +#define VID_PKT_SIZE(p)			(((p) & 0x3fff) << 0)
>>> +#define VID_PKT_MAX_SIZE		0x3fff
>>> +
>>> +#define DSI_VID_HSA_TIME		0x48
>>> +#define DSI_VID_HBP_TIME		0x4c
>>> +#define DSI_VID_HLINE_TIME		0x50
>>> +#define DSI_VID_VSA_LINES		0x54
>>> +#define DSI_VID_VBP_LINES		0x58
>>> +#define DSI_VID_VFP_LINES		0x5c
>>> +#define DSI_VID_VACTIVE_LINES		0x60
>>> +#define DSI_CMD_MODE_CFG		0x68
>>> +#define MAX_RD_PKT_SIZE_LP		BIT(24)
>>> +#define DCS_LW_TX_LP			BIT(19)
>>> +#define DCS_SR_0P_TX_LP			BIT(18)
>>> +#define DCS_SW_1P_TX_LP			BIT(17)
>>> +#define DCS_SW_0P_TX_LP			BIT(16)
>>> +#define GEN_LW_TX_LP			BIT(14)
>>> +#define GEN_SR_2P_TX_LP			BIT(13)
>>> +#define GEN_SR_1P_TX_LP			BIT(12)
>>> +#define GEN_SR_0P_TX_LP			BIT(11)
>>> +#define GEN_SW_2P_TX_LP			BIT(10)
>>> +#define GEN_SW_1P_TX_LP			BIT(9)
>>> +#define GEN_SW_0P_TX_LP			BIT(8)
>>> +#define EN_ACK_RQST			BIT(1)
>>> +#define EN_TEAR_FX			BIT(0)
>>> +
>>> +#define CMD_MODE_ALL_LP			(MAX_RD_PKT_SIZE_LP | \
>>> +					 DCS_LW_TX_LP | \
>>> +					 DCS_SR_0P_TX_LP | \
>>> +					 DCS_SW_1P_TX_LP | \
>>> +					 DCS_SW_0P_TX_LP | \
>>> +					 GEN_LW_TX_LP | \
>>> +					 GEN_SR_2P_TX_LP | \
>>> +					 GEN_SR_1P_TX_LP | \
>>> +					 GEN_SR_0P_TX_LP | \
>>> +					 GEN_SW_2P_TX_LP | \
>>> +					 GEN_SW_1P_TX_LP | \
>>> +					 GEN_SW_0P_TX_LP)
>>> +
>>> +#define DSI_GEN_HDR			0x6c
>>> +#define GEN_HDATA(data)			(((data) & 0xffff) << 8)
>>> +#define GEN_HDATA_MASK			(0xffff << 8)
>>> +#define GEN_HTYPE(type)			(((type) & 0xff) << 0)
>>> +#define GEN_HTYPE_MASK			0xff
>>> +
>>> +#define DSI_GEN_PLD_DATA		0x70
>>> +
>>> +#define DSI_CMD_PKT_STATUS		0x74
>>> +#define GEN_CMD_EMPTY			BIT(0)
>>> +#define GEN_CMD_FULL			BIT(1)
>>> +#define GEN_PLD_W_EMPTY			BIT(2)
>>> +#define GEN_PLD_W_FULL			BIT(3)
>>> +#define GEN_PLD_R_EMPTY			BIT(4)
>>> +#define GEN_PLD_R_FULL			BIT(5)
>>> +#define GEN_RD_CMD_BUSY			BIT(6)
>>> +
>>> +#define DSI_TO_CNT_CFG			0x78
>>> +#define HSTX_TO_CNT(p)			(((p) & 0xffff) << 16)
>>> +#define LPRX_TO_CNT(p)			((p) & 0xffff)
>>> +
>>> +#define DSI_BTA_TO_CNT			0x8c
>>> +#define DSI_LPCLK_CTRL			0x94
>>> +#define AUTO_CLKLANE_CTRL		BIT(1)
>>> +#define PHY_TXREQUESTCLKHS		BIT(0)
>>> +
>>> +#define DSI_PHY_TMR_LPCLK_CFG		0x98
>>> +#define PHY_CLKHS2LP_TIME(lbcc)		(((lbcc) & 0x3ff) << 16)
>>> +#define PHY_CLKLP2HS_TIME(lbcc)		((lbcc) & 0x3ff)
>>> +
>>> +#define DSI_PHY_TMR_CFG			0x9c
>>> +#define PHY_HS2LP_TIME(lbcc)		(((lbcc) & 0xff) << 24)
>>> +#define PHY_LP2HS_TIME(lbcc)		(((lbcc) & 0xff) << 16)
>>> +#define MAX_RD_TIME(lbcc)		((lbcc) & 0x7fff)
>>> +
>>> +#define DSI_PHY_RSTZ			0xa0
>>> +#define PHY_DISFORCEPLL			0
>>> +#define PHY_ENFORCEPLL			BIT(3)
>>> +#define PHY_DISABLECLK			0
>>> +#define PHY_ENABLECLK			BIT(2)
>>> +#define PHY_RSTZ			0
>>> +#define PHY_UNRSTZ			BIT(1)
>>> +#define PHY_SHUTDOWNZ			0
>>> +#define PHY_UNSHUTDOWNZ			BIT(0)
>>> +
>>> +#define DSI_PHY_IF_CFG			0xa4
>>> +#define N_LANES(n)			((((n) - 1) & 0x3) << 0)
>>> +#define PHY_STOP_WAIT_TIME(cycle)	(((cycle) & 0xff) << 8)
>>> +
>>> +#define DSI_PHY_STATUS			0xb0
>>> +#define LOCK				BIT(0)
>>> +#define STOP_STATE_CLK_LANE		BIT(2)
>>> +
>>> +#define DSI_PHY_TST_CTRL0		0xb4
>>> +#define PHY_TESTCLK			BIT(1)
>>> +#define PHY_UNTESTCLK			0
>>> +#define PHY_TESTCLR			BIT(0)
>>> +#define PHY_UNTESTCLR			0
>>> +
>>> +#define DSI_PHY_TST_CTRL1		0xb8
>>> +#define PHY_TESTEN			BIT(16)
>>> +#define PHY_UNTESTEN			0
>>> +#define PHY_TESTDOUT(n)			(((n) & 0xff) << 8)
>>> +#define PHY_TESTDIN(n)			(((n) & 0xff) << 0)
>>> +
>>> +#define DSI_INT_ST0			0xbc
>>> +#define DSI_INT_ST1			0xc0
>>> +#define DSI_INT_MSK0			0xc4
>>> +#define DSI_INT_MSK1			0xc8
>>> +
>>> +#define PHY_STATUS_TIMEOUT_US		10000
>>> +#define CMD_PKT_STATUS_TIMEOUT_US	20000
>>> +
>>> +struct dw_mipi_dsi {
>>> +	struct drm_bridge bridge;
>>> +	struct mipi_dsi_host dsi_host;
>>> +	struct drm_bridge *panel_bridge;
>>> +	bool is_panel_bridge;
>>> +	struct device *dev;
>>> +	void __iomem *base;
>>> +
>>> +	struct clk *pclk;
>>> +
>>> +	unsigned int lane_mbps; /* per lane */
>>> +	u32 channel;
>>> +	u32 lanes;
>>> +	u32 format;
>>> +	unsigned long mode_flags;
>>> +
>>> +	const struct dw_mipi_dsi_plat_data *plat_data;
>>> +};
>>> +
>>> +/*
>>> + * The controller should generate 2 frames before
>>> + * preparing the peripheral.
>>> + */
>>> +static void dw_mipi_dsi_wait_for_two_frames(struct drm_display_mode *mode)
>>> +{
>>> +	int refresh, two_frames;
>>> +
>>> +	refresh = drm_mode_vrefresh(mode);
>>> +	two_frames = DIV_ROUND_UP(MSEC_PER_SEC, refresh) * 2;
>>> +	msleep(two_frames);
>>> +}
>>> +
>>> +static inline struct dw_mipi_dsi *host_to_dsi(struct mipi_dsi_host *host)
>>> +{
>>> +	return container_of(host, struct dw_mipi_dsi, dsi_host);
>>> +}
>>> +
>>> +static inline struct dw_mipi_dsi *bridge_to_dsi(struct drm_bridge *bridge)
>>> +{
>>> +	return container_of(bridge, struct dw_mipi_dsi, bridge);
>>> +}
>>> +
>>> +static inline void dsi_write(struct dw_mipi_dsi *dsi, u32 reg, u32 val)
>>> +{
>>> +	writel(val, dsi->base + reg);
>>> +}
>>> +
>>> +static inline u32 dsi_read(struct dw_mipi_dsi *dsi, u32 reg)
>>> +{
>>> +	return readl(dsi->base + reg);
>>> +}
>>> +
>>> +static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
>>> +				   struct mipi_dsi_device *device)
>>> +{
>>> +	struct dw_mipi_dsi *dsi = host_to_dsi(host);
>>> +	struct drm_bridge *bridge;
>>> +	struct drm_panel *panel;
>>> +	int ret;
>>> +
>>> +	if (device->lanes > dsi->plat_data->max_data_lanes) {
>>> +		dev_err(dsi->dev, "the number of data lanes(%u) is too many\n",
>>> +			device->lanes);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	dsi->lanes = device->lanes;
>>> +	dsi->channel = device->channel;
>>> +	dsi->format = device->format;
>>> +	dsi->mode_flags = device->mode_flags;
>>> +
>>> +	ret = drm_of_find_panel_or_bridge(host->dev->of_node, 1, 0,
>>> +					  &panel, &bridge);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (panel) {
>>> +		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_DSI);
>>> +		if (IS_ERR(bridge))
>>> +			return PTR_ERR(bridge);
>>> +		dsi->is_panel_bridge = true;
>>> +	}
>>> +
>>> +	dsi->panel_bridge = bridge;
>>> +
>>> +	return drm_bridge_add(&dsi->bridge);
>>> +}
>>> +
>>> +static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
>>> +				   struct mipi_dsi_device *device)
>>> +{
>>> +	struct dw_mipi_dsi *dsi = host_to_dsi(host);
>>> +
>>> +	if (dsi->is_panel_bridge)
>>> +		drm_panel_bridge_remove(dsi->panel_bridge);
>>> +
>>> +	drm_bridge_remove(&dsi->bridge);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void dw_mipi_message_config(struct dw_mipi_dsi *dsi,
>>> +				   const struct mipi_dsi_msg *msg)
>>> +{
>>> +	bool lpm = msg->flags & MIPI_DSI_MSG_USE_LPM;
>>> +	u32 val = 0;
>>> +
>>> +	if (msg->flags & MIPI_DSI_MSG_REQ_ACK)
>>> +		val |= EN_ACK_RQST;
>>> +	if (lpm)
>>> +		val |= CMD_MODE_ALL_LP;
>>> +
>>> +	dsi_write(dsi, DSI_LPCLK_CTRL, lpm ? 0 : PHY_TXREQUESTCLKHS);
>>> +	dsi_write(dsi, DSI_CMD_MODE_CFG, val);
>>> +}
>>> +
>>> +static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>>> +{
>>> +	int ret;
>>> +	u32 val, mask;
>>> +
>>> +	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>>> +				 val, !(val & GEN_CMD_FULL), 1000,
>>> +				 CMD_PKT_STATUS_TIMEOUT_US);
>>> +	if (ret < 0) {
>>> +		dev_err(dsi->dev, "failed to get available command FIFO\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	dsi_write(dsi, DSI_GEN_HDR, hdr_val);
>>> +
>>> +	mask = GEN_CMD_EMPTY | GEN_PLD_W_EMPTY;
>>> +	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>>> +				 val, (val & mask) == mask,
>>> +				 1000, CMD_PKT_STATUS_TIMEOUT_US);
>>> +	if (ret < 0) {
>>> +		dev_err(dsi->dev, "failed to write command FIFO\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
>>> +				       const struct mipi_dsi_msg *msg)
>>> +{
>>> +	const u8 *tx_buf = msg->tx_buf;
>>> +	u16 data = 0;
>>> +	u32 val;
>>> +
>>> +	if (msg->tx_len > 0)
>>> +		data |= tx_buf[0];
>>> +	if (msg->tx_len > 1)
>>> +		data |= tx_buf[1] << 8;
>>> +
>>> +	if (msg->tx_len > 2) {
>>> +		dev_err(dsi->dev, "too long tx buf length %zu for short write\n",
>>> +			msg->tx_len);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	val = GEN_HDATA(data) | GEN_HTYPE(msg->type);
>>> +	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, val);
>>> +}
>>> +
>>> +static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
>>> +				      const struct mipi_dsi_msg *msg)
>>> +{
>>> +	const u8 *tx_buf = msg->tx_buf;
>>> +	int len = msg->tx_len, pld_data_bytes = sizeof(u32), ret;
>>> +	u32 hdr_val = GEN_HDATA(msg->tx_len) | GEN_HTYPE(msg->type);
>>> +	u32 remainder;
>>> +	u32 val;
>>> +
>>> +	if (msg->tx_len < 3) {
>>> +		dev_err(dsi->dev, "wrong tx buf length %zu for long write\n",
>>> +			msg->tx_len);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	while (DIV_ROUND_UP(len, pld_data_bytes)) {
>>> +		if (len < pld_data_bytes) {
>>> +			remainder = 0;
>>> +			memcpy(&remainder, tx_buf, len);
>>> +			dsi_write(dsi, DSI_GEN_PLD_DATA, remainder);
>>> +			len = 0;
>>> +		} else {
>>> +			memcpy(&remainder, tx_buf, pld_data_bytes);
>>> +			dsi_write(dsi, DSI_GEN_PLD_DATA, remainder);
>>> +			tx_buf += pld_data_bytes;
>>> +			len -= pld_data_bytes;
>>> +		}
>>> +
>>> +		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>>> +					 val, !(val & GEN_PLD_W_FULL), 1000,
>>> +					 CMD_PKT_STATUS_TIMEOUT_US);
>>> +		if (ret < 0) {
>>> +			dev_err(dsi->dev,
>>> +				"failed to get available write payload FIFO\n");
>>> +			return ret;
>>> +		}
>>> +	}
>>> +
>>> +	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, hdr_val);
>>> +}
>>> +
>>> +static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>> +					 const struct mipi_dsi_msg *msg)
>>> +{
>>> +	struct dw_mipi_dsi *dsi = host_to_dsi(host);
>>> +	int ret;
>>> +
>>> +	/*
>>> +	 * TODO dw drv improvements
>>> +	 * use mipi_dsi_create_packet() instead of all following
>>> +	 * functions and code (no switch cases, no
>>> +	 * dw_mipi_dsi_dcs_short_write(), only the loop in long_write...)
>>> +	 * and use packet.header...
>>> +	 */
>>> +	dw_mipi_message_config(dsi, msg);
>>> +
>>> +	switch (msg->type) {
>>> +	case MIPI_DSI_DCS_SHORT_WRITE:
>>> +	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
>>> +	case MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE:
>>> +		ret = dw_mipi_dsi_dcs_short_write(dsi, msg);
>>> +		break;
>>> +	case MIPI_DSI_DCS_LONG_WRITE:
>>> +		ret = dw_mipi_dsi_dcs_long_write(dsi, msg);
>>> +		break;
>>> +	default:
>>> +		dev_err(dsi->dev, "unsupported message type 0x%02x\n",
>>> +			msg->type);
>>> +		ret = -EINVAL;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
>>> +	.attach = dw_mipi_dsi_host_attach,
>>> +	.detach = dw_mipi_dsi_host_detach,
>>> +	.transfer = dw_mipi_dsi_host_transfer,
>>> +};
>>> +
>>> +static void dw_mipi_dsi_video_mode_config(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	u32 val;
>>> +
>>> +	/*
>>> +	 * TODO dw drv improvements
>>> +	 * enabling low power is panel-dependent, we should use the
>>> +	 * panel configuration here...
>>> +	 */
>>> +	val = ENABLE_LOW_POWER;
>>> +
>>> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
>>> +		val |= VID_MODE_TYPE_BURST;
>>> +	else if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
>>> +		val |= VID_MODE_TYPE_NON_BURST_SYNC_PULSES;
>>> +	else
>>> +		val |= VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
>>> +
>>> +	dsi_write(dsi, DSI_VID_MODE_CFG, val);
>>> +}
>>> +
>>> +static void dw_mipi_dsi_set_mode(struct dw_mipi_dsi *dsi,
>>> +				 unsigned long mode_flags)
>>> +{
>>> +	dsi_write(dsi, DSI_PWR_UP, RESET);
>>> +
>>> +	if (mode_flags & MIPI_DSI_MODE_VIDEO) {
>>> +		dsi_write(dsi, DSI_MODE_CFG, ENABLE_VIDEO_MODE);
>>> +		dw_mipi_dsi_video_mode_config(dsi);
>>> +		dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
>>> +	} else {
>>> +		dsi_write(dsi, DSI_MODE_CFG, ENABLE_CMD_MODE);
>>> +	}
>>> +
>>> +	dsi_write(dsi, DSI_PWR_UP, POWERUP);
>>> +}
>>> +
>>> +static void dw_mipi_dsi_disable(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	dsi_write(dsi, DSI_PWR_UP, RESET);
>>> +	dsi_write(dsi, DSI_PHY_RSTZ, PHY_RSTZ);
>>> +}
>>> +
>>> +static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	/*
>>> +	 * The maximum permitted escape clock is 20MHz and it is derived from
>>> +	 * lanebyteclk, which is running at "lane_mbps / 8".  Thus we want:
>>> +	 *
>>> +	 *     (lane_mbps >> 3) / esc_clk_division < 20
>>> +	 * which is:
>>> +	 *     (lane_mbps >> 3) / 20 > esc_clk_division
>>> +	 */
>>> +	u32 esc_clk_division = (dsi->lane_mbps >> 3) / 20 + 1;
>>> +
>>> +	dsi_write(dsi, DSI_PWR_UP, RESET);
>>> +
>>> +	/*
>>> +	 * TODO dw drv improvements
>>> +	 * timeout clock division should be computed with the
>>> +	 * high speed transmission counter timeout and byte lane...
>>> +	 */
>>> +	dsi_write(dsi, DSI_CLKMGR_CFG, TO_CLK_DIVIDSION(10) |
>>> +		  TX_ESC_CLK_DIVIDSION(esc_clk_division));
>>> +}
>>> +
>>> +static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
>>> +				   struct drm_display_mode *mode)
>>> +{
>>> +	u32 val = 0, color = 0;
>>> +
>>> +	switch (dsi->format) {
>>> +	case MIPI_DSI_FMT_RGB888:
>>> +		color = DPI_COLOR_CODING_24BIT;
>>> +		break;
>>> +	case MIPI_DSI_FMT_RGB666:
>>> +		color = DPI_COLOR_CODING_18BIT_2 | EN18_LOOSELY;
>>> +		break;
>>> +	case MIPI_DSI_FMT_RGB666_PACKED:
>>> +		color = DPI_COLOR_CODING_18BIT_1;
>>> +		break;
>>> +	case MIPI_DSI_FMT_RGB565:
>>> +		color = DPI_COLOR_CODING_16BIT_1;
>>> +		break;
>>> +	}
>>> +
>>> +	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
>>> +		val |= VSYNC_ACTIVE_LOW;
>>> +	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
>>> +		val |= HSYNC_ACTIVE_LOW;
>>> +
>>> +	dsi_write(dsi, DSI_DPI_VCID, DPI_VID(dsi->channel));
>>> +	dsi_write(dsi, DSI_DPI_COLOR_CODING, color);
>>> +	dsi_write(dsi, DSI_DPI_CFG_POL, val);
>>> +	/*
>>> +	 * TODO dw drv improvements
>>> +	 * largest packet sizes during hfp or during vsa/vpb/vfp
>>> +	 * should be computed according to byte lane, lane number and only
>>> +	 * if sending lp cmds in high speed is enable (PHY_TXREQUESTCLKHS)
>>> +	 */
>>> +	dsi_write(dsi, DSI_DPI_LP_CMD_TIM, OUTVACT_LPCMD_TIME(4)
>>> +		  | INVACT_LPCMD_TIME(4));
>>> +}
>>> +
>>> +static void dw_mipi_dsi_packet_handler_config(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	dsi_write(dsi, DSI_PCKHDL_CFG, EN_CRC_RX | EN_ECC_RX | EN_BTA);
>>> +}
>>> +
>>> +static void dw_mipi_dsi_video_packet_config(struct dw_mipi_dsi *dsi,
>>> +					    struct drm_display_mode *mode)
>>> +{
>>> +	/*
>>> +	 * TODO dw drv improvements
>>> +	 * only burst mode is supported here. For non-burst video modes,
>>> +	 * we should compute DSI_VID_PKT_SIZE, DSI_VCCR.NUMC &
>>> +	 * DSI_VNPCR.NPSIZE... especially because this driver supports
>>> +	 * non-burst video modes, see dw_mipi_dsi_video_mode_config()...
>>> +	 */
>>> +	dsi_write(dsi, DSI_VID_PKT_SIZE, VID_PKT_SIZE(mode->hdisplay));
>>> +}
>>> +
>>> +static void dw_mipi_dsi_command_mode_config(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	/*
>>> +	 * TODO dw drv improvements
>>> +	 * compute high speed transmission counter timeout according
>>> +	 * to the timeout clock division (TO_CLK_DIVIDSION) and byte lane...
>>> +	 */
>>> +	dsi_write(dsi, DSI_TO_CNT_CFG, HSTX_TO_CNT(1000) | LPRX_TO_CNT(1000));
>>> +	/*
>>> +	 * TODO dw drv improvements
>>> +	 * the Bus-Turn-Around Timeout Counter should be computed
>>> +	 * according to byte lane...
>>> +	 */
>>> +	dsi_write(dsi, DSI_BTA_TO_CNT, 0xd00);
>>> +	dsi_write(dsi, DSI_MODE_CFG, ENABLE_CMD_MODE);
>>> +}
>>> +
>>> +/* Get lane byte clock cycles. */
>>> +static u32 dw_mipi_dsi_get_hcomponent_lbcc(struct dw_mipi_dsi *dsi,
>>> +					   struct drm_display_mode *mode,
>>> +					   u32 hcomponent)
>>> +{
>>> +	u32 frac, lbcc;
>>> +
>>> +	lbcc = hcomponent * dsi->lane_mbps * MSEC_PER_SEC / 8;
>>> +
>>> +	frac = lbcc % mode->clock;
>>> +	lbcc = lbcc / mode->clock;
>>> +	if (frac)
>>> +		lbcc++;
>>> +
>>> +	return lbcc;
>>> +}
>>> +
>>> +static void dw_mipi_dsi_line_timer_config(struct dw_mipi_dsi *dsi,
>>> +					  struct drm_display_mode *mode)
>>> +{
>>> +	u32 htotal, hsa, hbp, lbcc;
>>> +
>>> +	htotal = mode->htotal;
>>> +	hsa = mode->hsync_end - mode->hsync_start;
>>> +	hbp = mode->htotal - mode->hsync_end;
>>> +
>>> +	/*
>>> +	 * TODO dw drv improvements
>>> +	 * computations below may be improved...
>>> +	 */
>>> +	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, htotal);
>>> +	dsi_write(dsi, DSI_VID_HLINE_TIME, lbcc);
>>> +
>>> +	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, hsa);
>>> +	dsi_write(dsi, DSI_VID_HSA_TIME, lbcc);
>>> +
>>> +	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, hbp);
>>> +	dsi_write(dsi, DSI_VID_HBP_TIME, lbcc);
>>> +}
>>> +
>>> +static void dw_mipi_dsi_vertical_timing_config(struct dw_mipi_dsi *dsi,
>>> +					       struct drm_display_mode *mode)
>>> +{
>>> +	u32 vactive, vsa, vfp, vbp;
>>> +
>>> +	vactive = mode->vdisplay;
>>> +	vsa = mode->vsync_end - mode->vsync_start;
>>> +	vfp = mode->vsync_start - mode->vdisplay;
>>> +	vbp = mode->vtotal - mode->vsync_end;
>>> +
>>> +	dsi_write(dsi, DSI_VID_VACTIVE_LINES, vactive);
>>> +	dsi_write(dsi, DSI_VID_VSA_LINES, vsa);
>>> +	dsi_write(dsi, DSI_VID_VFP_LINES, vfp);
>>> +	dsi_write(dsi, DSI_VID_VBP_LINES, vbp);
>>> +}
>>> +
>>> +static void dw_mipi_dsi_dphy_timing_config(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	/*
>>> +	 * TODO dw drv improvements
>>> +	 * data & clock lane timers should be computed according to panel
>>> +	 * blankings and to the automatic clock lane control mode...
>>> +	 * note: DSI_PHY_TMR_CFG.MAX_RD_TIME should be in line with
>>> +	 * DSI_CMD_MODE_CFG.MAX_RD_PKT_SIZE_LP (see CMD_MODE_ALL_LP)
>>> +	 */
>>> +	dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME(0x40)
>>> +		  | PHY_LP2HS_TIME(0x40) | MAX_RD_TIME(10000));
>>> +
>>> +	dsi_write(dsi, DSI_PHY_TMR_LPCLK_CFG, PHY_CLKHS2LP_TIME(0x40)
>>> +		  | PHY_CLKLP2HS_TIME(0x40));
>>> +}
>>> +
>>> +static void dw_mipi_dsi_dphy_interface_config(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	/*
>>> +	 * TODO dw drv improvements
>>> +	 * stop wait time should be the maximum between host dsi
>>> +	 * and panel stop wait times
>>> +	 */
>>> +	dsi_write(dsi, DSI_PHY_IF_CFG, PHY_STOP_WAIT_TIME(0x20) |
>>> +		  N_LANES(dsi->lanes));
>>> +}
>>> +
>>> +static void dw_mipi_dsi_dphy_init(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	/* Clear PHY state */
>>> +	dsi_write(dsi, DSI_PHY_RSTZ, PHY_DISFORCEPLL | PHY_DISABLECLK
>>> +		  | PHY_RSTZ | PHY_SHUTDOWNZ);
>>> +	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
>>> +	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLR);
>>> +	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
>>> +}
>>> +
>>> +static void dw_mipi_dsi_dphy_enable(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	u32 val;
>>> +	int ret;
>>> +
>>> +	dsi_write(dsi, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLECLK |
>>> +		  PHY_UNRSTZ | PHY_UNSHUTDOWNZ);
>>> +
>>> +	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
>>> +				 val, val & LOCK, 1000, PHY_STATUS_TIMEOUT_US);
>>> +	if (ret < 0)
>>> +		DRM_DEBUG_DRIVER("failed to wait phy lock state\n");
>>> +
>>> +	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
>>> +				 val, val & STOP_STATE_CLK_LANE, 1000,
>>> +				 PHY_STATUS_TIMEOUT_US);
>>> +	if (ret < 0)
>>> +		DRM_DEBUG_DRIVER("failed to wait phy clk lane stop state\n");
>>> +}
>>> +
>>> +static void dw_mipi_dsi_clear_err(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	dsi_read(dsi, DSI_INT_ST0);
>>> +	dsi_read(dsi, DSI_INT_ST1);
>>> +	dsi_write(dsi, DSI_INT_MSK0, 0);
>>> +	dsi_write(dsi, DSI_INT_MSK1, 0);
>>> +}
>>> +
>>> +static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
>>> +{
>>> +	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
>>> +
>>> +	/*
>>> +	 * Switch to cmd mode before panel-bridge disable & panel unprepare.
>>> +	 * Note: panel-bridge disable & panel disable has been called
>>> +	 * before by the drm framework.
>> I don't think that's exactly the case. I think the sequence should be as in the
>> call chain below.
>>
>>> +	 */
>>> +	dw_mipi_dsi_set_mode(dsi, 0);
>>> +
>>> +	/*
>>> +	 * TODO Only way found to call panel-bridge disable & panel unprepare
>>> +	 * before the dsi "final" disable... can we do better?
>> I agree, this is a problem. More below.
>>
>>> +	 */
>>> +	drm_bridge_post_disable(dsi->panel_bridge);
>>> +
>> I'm guessing our display chain is something like:
>>
>> KMS_encoder -> DW_DSI_bridge -> Panel_bridge -> Panel
>>
>> The order in which the disable ops are called:
>>
>> drm_bridge_disable(Panel_bridge)
>>     - drm_panel_disable(Panel)
>> drm_bridge_disable(DW_DSI_bridge)
>> encoder_funcs->prepare(KMS_encoder)
>> drm_bridge_post_disable(DW_DSI_bridge)
>> drm_bridge_post_disable(Panel_bridge)
>>     - drm_panel_unprepare(Panel)
>>
>> Assuming that only drm_panel_unprepare() requires sending DSI commands, you could have
>> switched to command mode in DW_DSI_bridge's disable() op, and do the "final" DSI disable
>> in DW_DSI_bridge's post_disable(), but that would still result in drm_panel_unprepare()
>> being called with the DSI host dead.
>>
>> The existing call chain of consecutive bridges is the most symmetric one, and the one
>> expected to work in most cases, but it clearly doesn't work in your use case.
>>
>> We have a few options:
>>
>> - Undo the drm-panel-bridge stuff, and have the freedom of calling drm_panel ops in
>> whatever order we want.
>>
>> - Put a big TODO/HACK comment here, saying that this needs to be fixed in the drm_bridge
>> framework and the API needs to be updated to manage our own call chains. Also,
>> instead of calling "drm_bridge_post_disable(dsi->panel_bridge);" explicitly, we
>> can manually call panel_bridge->post_disable() op directly. This avoids us doing
>> things recursively.
>>
>> We would implement the TODO task in drm_bridges only when there are more people
>> desperately in the need to have customizable call chains of bridge ops for long
>> display chains, so I don't see it being implemented in the near future, but I don't
>> think there should be any problem keeping this hack in the dw dsi driver for now.
>>
>> What choice do you prefer?
>>
>> Eric, Daniel,
>>
>> Fyi, this is another case where the panel-bridge stuff doesn't work so well. Not
>> criticizing or anything, just pointing out :)
> 
> I have just looked at existing panel drivers, most of them (probably all
> supporting DCS commands) sends commands to the panel in unprepare
> callback, and it looks correct.
> 
> I am not sure what should be fixed in the framework, some alternatives I
> see:
> 1. change order of disable callbacks, usually it should be reverse of
> order of enable callbacks,
>      but I guess it could break other devices with different requirements,
> 2. do not use call-chain, instead every bridge will be responsible to
> call attached sink's callbacks, this way dsi bridge can turn off dsi
> bus, after calling panel_bridge.post_disable,
> it looks for me the most flexible solution, but it leaves the
> responsibility to the drivers.
> 3. move DSI host power management to mipi_dsi bus, ie it should be
> enabled on dsi device request, and disabled after dsi device does not
> need power anymore.

2) seems the most flexible to me too, it would result in a lot of boilerplate
code in the bridge drivers, 90% of which work with the existing code. We could
consider converting the bridge drivers to explicitly call sink callbacks as a
long term task, though.

3) sounds like a nice idea to abstract away this issue, but would probably be
hard to get right so that it works across multiple DSI controllers.

Thanks,
Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
