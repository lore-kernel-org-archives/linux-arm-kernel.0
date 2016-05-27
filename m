From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 27 May 2016 14:02:16 +0800
Subject: [PATCH 3/6] drm/rockchip: vop: add cdn DP support for rk3399
In-Reply-To: <1464328939-8073-1-git-send-email-zyw@rock-chips.com>
References: <1464328939-8073-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1464328939-8073-4-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for cdn DP controller which is embedded in the rk3399
SoCs. The DP is compliant with DisplayPort Specification,
Version 1.3, This IP is compatible with the rockchip type-c PHY IP.
There is a uCPU in DP controller, it need a firmware to work,
please put the firmware file to /lib/firmware/cdn/dptx.bin. The
uCPU in charge of aux communication and link training, the host use
mailbox to communicate with the ucpu.
The dclk pin_pol of vop must not be invert for DP.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/Kconfig            |   9 +
 drivers/gpu/drm/rockchip/Makefile           |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c      | 620 +++++++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.h      |  95 ++++
 drivers/gpu/drm/rockchip/cdn-dp-reg.c       | 730 ++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-reg.h       | 404 +++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   9 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   2 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |   2 +
 include/sound/cdn-dp-audio.h                |  51 ++
 10 files changed, 1922 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.c
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.h
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.h
 create mode 100644 include/sound/cdn-dp-audio.h

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index d30bdc3..20da9a8 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -25,6 +25,15 @@ config ROCKCHIP_ANALOGIX_DP
 	  for the Analogix Core DP driver. If you want to enable DP
 	  on RK3288 based SoC, you should selet this option.
 
+config ROCKCHIP_CDN_DP
+        tristate "Rockchip cdn DP"
+        depends on DRM_ROCKCHIP
+        help
+	  This selects support for Rockchip SoC specific extensions
+	  for the cdn Dp driver. If you want to enable Dp on
+	  RK3399 based SoC, you should selet this
+	  option.
+
 config ROCKCHIP_DW_HDMI
         tristate "Rockchip specific extensions for Synopsys DW HDMI"
         depends on DRM_ROCKCHIP
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index 05d0713..abdecd5 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -7,6 +7,7 @@ rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
 rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
 
 obj-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
+obj-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
 obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 obj-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
 obj-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
new file mode 100644
index 0000000..fdf99f5
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -0,0 +1,620 @@
+/*
+ * cdn dp controller core driver
+ *
+ * Copyright (C) 2016 Chris Zhong <zyw@rock-chips.com>
+ * Copyright (C) 2016 ROCKCHIP, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_of.h>
+
+#include <linux/component.h>
+#include <linux/clk.h>
+#include <linux/firmware.h>
+#include <linux/mfd/syscon.h>
+#include <linux/phy/phy.h>
+#include <linux/phy/phy-rockchip-typec.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include <video/of_videomode.h>
+#include <video/videomode.h>
+
+#include <sound/cdn-dp-audio.h>
+
+#include "rockchip_drm_vop.h"
+#include "cdn-dp-reg.h"
+#include "cdn-dp-core.h"
+
+#define connector_to_dp(c) \
+		container_of(c, struct cdn_dp_device, connector)
+
+#define encoder_to_dp(c) \
+		container_of(c, struct cdn_dp_device, encoder)
+
+/* dp grf register offset */
+#define DP_VOP_SEL		0x6224
+#define DP_SEL_VOP_LIT		BIT(12)
+
+static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
+{
+	int ret = 0;
+	int clk_rate = 200000000;
+
+	ret = clk_prepare_enable(dp->pclk);
+	if (ret < 0) {
+		dev_err(dp->dev, "cannot enable dp pclk %d\n", ret);
+		goto err_pclk;
+	}
+
+	ret = clk_prepare_enable(dp->core_clk);
+	if (ret < 0) {
+		dev_err(dp->dev, "cannot enable core_clk %d\n", ret);
+		goto err_core_clk;
+	}
+
+	ret = clk_set_rate(dp->core_clk, clk_rate);
+	if (ret < 0) {
+		dev_err(dp->dev, "cannot set dp core clk to %d %d\n",
+			clk_rate, ret);
+		goto err_set_rate;
+	}
+
+	/* notice fw the clk freq value */
+	cdn_dp_set_fw_clk(dp, clk_rate);
+
+	return 0;
+
+err_set_rate:
+	clk_disable_unprepare(dp->core_clk);
+err_core_clk:
+	clk_disable_unprepare(dp->pclk);
+err_pclk:
+	return ret;
+}
+
+static enum drm_connector_status
+cdn_dp_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct cdn_dp_device *dp = connector_to_dp(connector);
+	int ret;
+
+	if (!dp->fw_loaded)
+		return connector_status_unknown;
+
+	ret = cdn_dp_get_hpd_status(dp);
+	if (ret < 0)
+		return connector_status_unknown;
+
+	dp->plugged = ret;
+
+	return ret ? connector_status_connected : connector_status_disconnected;
+}
+
+static void cdn_dp_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_unregister(connector);
+	drm_connector_cleanup(connector);
+}
+
+static struct drm_connector_funcs cdn_dp_atomic_connector_funcs = {
+	.dpms = drm_atomic_helper_connector_dpms,
+	.detect = cdn_dp_connector_detect,
+	.destroy = cdn_dp_connector_destroy,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int cdn_dp_connector_get_modes(struct drm_connector *connector)
+{
+	struct cdn_dp_device *dp = connector_to_dp(connector);
+	struct edid *edid;
+	int ret;
+
+	if (!dp->fw_loaded)
+		return 0;
+
+	ret = cdn_dp_set_host_cap(dp);
+	if (ret) {
+		dev_err(dp->dev, "set host capabilities failed:%d\n", ret);
+		return ret;
+	}
+
+	edid = drm_do_get_edid(connector, cdn_dp_get_edid_block, dp);
+	if (edid) {
+		dev_dbg(dp->dev, "got edid: width[%d] x height[%d]\n",
+			edid->width_cm, edid->height_cm);
+
+		dp->sink_has_audio = drm_detect_monitor_audio(edid);
+		drm_mode_connector_update_edid_property(connector, edid);
+		drm_add_edid_modes(connector, edid);
+		/* Store the ELD */
+		drm_edid_to_eld(connector, edid);
+		kfree(edid);
+	} else {
+		dev_dbg(dp->dev, "failed to get edid\n");
+	}
+
+	/*
+	 * put the training process here, since the mode_valid need the
+	 * training result to check if the resolution is support.
+	 */
+	ret = cdn_dp_training_start(dp);
+	if (ret) {
+		dev_err(dp->dev, "hw lt err:%d\n", ret);
+		return ret;
+	}
+
+	ret = cdn_dp_get_lt_status(dp);
+	if (ret) {
+		dev_err(dp->dev, "hw lt get status err:%d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(dp->dev, "rate:%d, lanes:%d\n",
+		dp->link.rate, dp->link.num_lanes);
+	return 0;
+}
+
+static struct drm_encoder *
+	cdn_dp_connector_best_encoder(struct drm_connector *connector)
+{
+	struct cdn_dp_device *dp = connector_to_dp(connector);
+
+	return &dp->encoder;
+}
+
+static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
+				       struct drm_display_mode *mode)
+{
+	struct cdn_dp_device *dp = connector_to_dp(connector);
+	struct drm_display_info *display_info = &dp->connector.display_info;
+	long requested = mode->clock * display_info->bpc * 3 / 1000;
+	long actual, rate;
+
+	rate = drm_dp_bw_code_to_link_rate(dp->link.rate);
+	actual = rate * dp->link.num_lanes / 100;
+
+	/* efficiency is about 0.8 */
+	actual = actual * 8 / 10;
+
+	if (requested > actual) {
+		dev_dbg(dp->dev, "requested=%ld, actual=%ld, clock=%d, bpc= %d\n",
+			requested, actual, mode->clock, display_info->bpc);
+		return MODE_H_ILLEGAL;
+	}
+
+	return MODE_OK;
+}
+
+static struct drm_connector_helper_funcs cdn_dp_connector_helper_funcs = {
+	.get_modes = cdn_dp_connector_get_modes,
+	.best_encoder = cdn_dp_connector_best_encoder,
+	.mode_valid = cdn_dp_connector_mode_valid,
+};
+
+static int cdn_dp_commit(struct drm_encoder *encoder)
+{
+	struct cdn_dp_device *dp = encoder_to_dp(encoder);
+	int ret;
+
+	cdn_dp_set_video_status(dp, CONTROL_VIDEO_IDLE);
+
+	ret = cdn_dp_config_video(dp);
+	if (ret) {
+		dev_err(dp->dev, "unable to config video\n");
+		return ret;
+	}
+
+	cdn_dp_set_video_status(dp, CONTROL_VIDEO_VALID);
+	dp->dpms_mode = DRM_MODE_DPMS_ON;
+
+	return ret;
+}
+
+static void cdn_dp_encoder_mode_set(struct drm_encoder *encoder,
+				    struct drm_display_mode *mode,
+				    struct drm_display_mode *adjusted)
+{
+	struct cdn_dp_device *dp = encoder_to_dp(encoder);
+	struct drm_display_info *display_info = &dp->connector.display_info;
+	struct rockchip_crtc_state *state;
+	struct video_info *video = &dp->video_info;
+	int ret, val;
+
+	switch (display_info->bpc) {
+	case 16:
+	case 12:
+	case 10:
+		video->color_depth = 10;
+		break;
+	case 6:
+		video->color_depth = 6;
+		break;
+	default:
+		video->color_depth = 8;
+		break;
+	}
+
+	video->color_fmt = PXL_RGB;
+
+	video->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NVSYNC);
+	video->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NHSYNC);
+
+	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, encoder);
+	if (ret < 0)
+		return;
+
+	state = to_rockchip_crtc_state(encoder->crtc->state);
+	if (ret) {
+		val = DP_SEL_VOP_LIT | (DP_SEL_VOP_LIT << 16);
+		state->output_mode = ROCKCHIP_OUT_MODE_P888;
+	} else {
+		val = DP_SEL_VOP_LIT << 16;
+		state->output_mode = ROCKCHIP_OUT_MODE_AAAA;
+	}
+	ret = regmap_write(dp->grf, DP_VOP_SEL, val);
+	if (ret != 0)
+		dev_err(dp->dev, "Could not write to GRF: %d\n", ret);
+
+	memcpy(&dp->mode, adjusted, sizeof(*mode));
+}
+
+static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
+{
+	struct cdn_dp_device *dp = encoder_to_dp(encoder);
+
+	if (dp->dpms_mode == DRM_MODE_DPMS_ON)
+		return;
+
+	cdn_dp_commit(encoder);
+}
+
+static void cdn_dp_encoder_disable(struct drm_encoder *encoder)
+{
+	struct cdn_dp_device *dp = encoder_to_dp(encoder);
+
+	if (dp->dpms_mode != DRM_MODE_DPMS_ON)
+		return;
+
+	cdn_dp_set_video_status(dp, CONTROL_VIDEO_IDLE);
+
+	dp->dpms_mode = DRM_MODE_DPMS_OFF;
+}
+
+static int
+cdn_dp_encoder_atomic_check(struct drm_encoder *encoder,
+			    struct drm_crtc_state *crtc_state,
+			    struct drm_connector_state *conn_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+
+	s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
+	s->output_type = DRM_MODE_CONNECTOR_DisplayPort;
+
+	return 0;
+}
+
+static struct drm_encoder_helper_funcs cdn_dp_encoder_helper_funcs = {
+	.mode_set = cdn_dp_encoder_mode_set,
+	.enable = cdn_dp_encoder_enable,
+	.disable = cdn_dp_encoder_disable,
+	.atomic_check = cdn_dp_encoder_atomic_check,
+};
+
+static struct drm_encoder_funcs cdn_dp_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+int cdn_dp_firmware_init(struct cdn_dp_device *dp)
+{
+	int ret;
+	const u32 *iram_data, *dram_data;
+	const struct firmware *fw;
+	const struct cdn_firmware_header *hdr;
+
+	if (dp->fw_loaded)
+		return 0;
+
+	ret = request_firmware(&fw, "cdn/dptx.bin", dp->dev);
+	if (ret < 0) {
+		dev_err(dp->dev, "failed to request firmware %d\n", ret);
+		return ret;
+	}
+
+	hdr = (struct cdn_firmware_header *)fw->data;
+	if (fw->size != le32_to_cpu(hdr->size_bytes))
+		return -EINVAL;
+
+	ret = cdn_dp_clk_enable(dp);
+	if (ret < 0) {
+		dev_err(dp->dev, "cannot enable dp clk %d\n", ret);
+		return ret;
+	}
+
+	dp_clock_reset_seq(dp);
+
+	iram_data = (const u32 *)(fw->data + hdr->header_size);
+	dram_data = (const u32 *)(fw->data + hdr->header_size + hdr->iram_size);
+
+	ret = cdn_dp_load_firmware(dp,
+				   iram_data, hdr->iram_size,
+				   dram_data, hdr->dram_size);
+
+	ret = cdn_dp_active(dp, true);
+	if (ret) {
+		dev_err(dp->dev, "active ucpu failed: %d\n", ret);
+		return ret;
+	}
+
+	cdn_dp_event_config(dp);
+
+	return 0;
+}
+
+static int cdn_dp_init(struct cdn_dp_device *dp)
+{
+	struct device *dev = dp->dev;
+	struct device_node *np = dev->of_node;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+
+	dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	if (IS_ERR(dp->grf)) {
+		dev_err(dev, "cdn-dp needs rockchip,grf property\n");
+		return PTR_ERR(dp->grf);
+	}
+
+	dp->irq = platform_get_irq(pdev, 0);
+	if (dp->irq < 0) {
+		dev_err(dev, "cdn-dp can not get irq\n");
+		return dp->irq;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dp->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dp->regs)) {
+		dev_err(dev, "ioremap reg failed\n");
+		return PTR_ERR(dp->regs);
+	}
+
+	dp->core_clk = devm_clk_get(dev, "core_clk");
+	if (IS_ERR(dp->core_clk)) {
+		dev_err(dev, "cannot get core_clk_dp\n");
+		return PTR_ERR(dp->core_clk);
+	}
+
+	dp->pclk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(dp->pclk)) {
+		dev_err(dev, "cannot get pclk\n");
+		return PTR_ERR(dp->pclk);
+	}
+
+	dp->spdif_clk = devm_clk_get(dev, "spdif");
+	if (IS_ERR(dp->spdif_clk)) {
+		dev_err(dev, "cannot get spdif_clk\n");
+		return PTR_ERR(dp->spdif_clk);
+	}
+
+	dp->dpms_mode = DRM_MODE_DPMS_OFF;
+
+	dev_set_name(dp->dev, "cdn-dp");
+
+	return 0;
+}
+
+static const struct cdn_dp_audio_ops dp_audio_ops = {
+	.audio_startup = cdn_dp_audio_start,
+	.audio_shutdown = cdn_dp_audio_stop,
+	.audio_start = cdn_dp_audio_start,
+	.audio_stop = cdn_dp_audio_stop,
+	.audio_config = cdn_dp_audio_config_set,
+};
+
+static int cdn_dp_pd_event(struct notifier_block *nb,
+			   unsigned long event, void *priv)
+{
+	struct cdn_dp_device *dp;
+	u8 map, is_dp;
+	int value = *(int *)priv;
+
+	dp = container_of(nb, struct cdn_dp_device, event_nb);
+	if (IS_ERR_OR_NULL(dp)) {
+		pr_err("initialization issue");
+		return -1;
+	}
+
+	is_dp = GET_DP(value);
+
+	if (!is_dp)
+		return 0;
+
+	dp->flip = GET_FLIP(value);
+	map = GET_PIN_MAP(value);
+	if (map & (PIN_MAP_B | PIN_MAP_D | PIN_MAP_F))
+		dp->cap_lanes = 2;
+	else
+		dp->cap_lanes = 4;
+
+	schedule_delayed_work_on(0, &dp->event_wq, 100);
+
+	return 0;
+}
+
+static void cdn_dp_pd_event_wq(struct work_struct *work)
+{
+	struct cdn_dp_device *dp;
+
+	dp = container_of(work, struct cdn_dp_device, event_wq.work);
+	if (IS_ERR_OR_NULL(dp)) {
+		pr_err("initialization issue");
+		return;
+	}
+
+	if (cdn_dp_firmware_init(dp))
+		return;
+
+	if ((cdn_dp_get_event(dp) & DPTX_HPD_EVENT) && (dp->drm_dev))
+		drm_helper_hpd_irq_event(dp->drm_dev);
+}
+
+static int cdn_dp_bind(struct device *dev, struct device *master,
+		       void *data)
+{
+	struct cdn_dp_audio_pdata audio_pdata;
+	struct cdn_dp_device *dp = dev_get_drvdata(dev);
+	struct device_node *np = dev->of_node;
+	struct drm_encoder *encoder;
+	struct drm_connector *connector;
+	struct drm_device *drm_dev = data;
+	struct phy *phy = devm_of_phy_get_by_index(dev, np, 0);
+	int ret;
+
+	if (IS_ERR(phy))
+		return -EPROBE_DEFER;
+
+	dp->phy = phy;
+
+	ret = cdn_dp_init(dp);
+	if (ret < 0)
+		return ret;
+
+	dp->drm_dev = drm_dev;
+
+	encoder = &dp->encoder;
+
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
+							     dev->of_node);
+	DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);
+
+	ret = drm_encoder_init(drm_dev, encoder, &cdn_dp_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret) {
+		DRM_ERROR("failed to initialize encoder with drm\n");
+		return ret;
+	}
+
+	drm_encoder_helper_add(encoder, &cdn_dp_encoder_helper_funcs);
+
+	connector = &dp->connector;
+	connector->polled = DRM_CONNECTOR_POLL_HPD;
+	connector->dpms = DRM_MODE_DPMS_OFF;
+
+	ret = drm_connector_init(drm_dev, connector,
+				 &cdn_dp_atomic_connector_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	if (ret) {
+		DRM_ERROR("failed to initialize connector with drm\n");
+		goto err_free_encoder;
+	}
+
+	drm_connector_helper_add(connector, &cdn_dp_connector_helper_funcs);
+
+	ret = drm_mode_connector_attach_encoder(connector, encoder);
+	if (ret) {
+		DRM_ERROR("failed to attach connector and encoder\n");
+		goto err_free_connector;
+	}
+
+	audio_pdata.dev = dev,
+	audio_pdata.ops = &dp_audio_ops,
+	audio_pdata.data = dp;
+
+	dp->audio_pdev = platform_device_register_data(
+		dev, "cdn-dp-audio", PLATFORM_DEVID_NONE,
+		&audio_pdata, sizeof(audio_pdata));
+
+	if (IS_ERR(dp->audio_pdev))
+		return PTR_ERR(dp->audio_pdev);
+
+	dp->event_nb.notifier_call = cdn_dp_pd_event;
+	INIT_DELAYED_WORK(&dp->event_wq, cdn_dp_pd_event_wq);
+	tcphy_register_notifier(phy, &dp->event_nb);
+
+	return 0;
+
+err_free_connector:
+	drm_connector_cleanup(connector);
+err_free_encoder:
+	drm_encoder_cleanup(encoder);
+	return ret;
+}
+
+static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
+{
+	struct cdn_dp_device *dp = dev_get_drvdata(dev);
+	struct drm_encoder *encoder = &dp->encoder;
+
+	platform_device_unregister(dp->audio_pdev);
+	cdn_dp_encoder_disable(encoder);
+	encoder->funcs->destroy(encoder);
+	drm_connector_unregister(&dp->connector);
+	drm_connector_cleanup(&dp->connector);
+	drm_encoder_cleanup(encoder);
+	tcphy_unregister_notifier(dp->phy, &dp->event_nb);
+}
+
+static const struct component_ops cdn_dp_component_ops = {
+	.bind = cdn_dp_bind,
+	.unbind = cdn_dp_unbind,
+};
+
+static int cdn_dp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cdn_dp_device *dp;
+
+	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
+	if (!dp)
+		return -ENOMEM;
+	dp->dev = dev;
+
+	platform_set_drvdata(pdev, dp);
+
+	return component_add(dev, &cdn_dp_component_ops);
+}
+
+static int cdn_dp_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &cdn_dp_component_ops);
+
+	return 0;
+}
+
+static const struct of_device_id cdn_dp_dt_ids[] = {
+	{.compatible = "rockchip,cdn-dp",},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, cdn_dp_dt_ids);
+
+static struct platform_driver cdn_dp_driver = {
+	.probe = cdn_dp_probe,
+	.remove = cdn_dp_remove,
+	.driver = {
+		   .name = "cdn-dp",
+		   .owner = THIS_MODULE,
+		   .of_match_table = of_match_ptr(cdn_dp_dt_ids),
+	},
+};
+
+module_platform_driver(cdn_dp_driver);
+
+MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_DESCRIPTION("cdn DP Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
new file mode 100644
index 0000000..99c0123
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -0,0 +1,95 @@
+/*
+ * Copyright (C) 2016 Chris Zhong <zyw@rock-chips.com>
+ * Copyright (C) 2016 ROCKCHIP, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _ROCKCHIP_EDP_CORE_H
+#define _ROCKCHIP_EDP_CORE_H
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/drm_panel.h>
+#include "rockchip_drm_drv.h"
+#include "cdn-dp-reg.h"
+
+struct video_info {
+	bool h_sync_polarity;
+	bool v_sync_polarity;
+	bool interlaced;
+	int color_depth;
+	enum VIC_PXL_ENCODING_FORMAT color_fmt;
+};
+
+struct cdn_firmware_header {
+	u32 size_bytes; /* size of the entire header+image(s) in bytes */
+	u32 header_size; /* size of just the header in bytes */
+	u32 iram_size; /* size of iram */
+	u32 dram_size; /* size of dram */
+};
+
+struct cdn_dp_device {
+	struct device *dev;
+	struct drm_device *drm_dev;
+	struct drm_connector connector;
+	struct drm_encoder encoder;
+	struct drm_display_mode mode;
+	struct delayed_work hotplug_work;
+	struct platform_device *audio_pdev;
+	bool plugged;
+
+	const struct firmware *fw;	/* cdn dp firmware */
+	unsigned int fw_version;	/* cdn fw version */
+	bool fw_loaded;
+	void __iomem *regs;
+	void __iomem *phy_regs;
+	struct regmap *grf;
+	unsigned int irq;
+	struct clk *core_clk;
+	struct clk *pclk;
+	struct clk *spdif_clk;
+	struct video_info video_info;
+	struct phy *phy;
+	struct notifier_block	event_nb;
+	struct delayed_work	event_wq;
+
+	int cap_lanes;
+	bool flip;
+
+	int dpms_mode;
+	struct drm_dp_link link;
+	bool sink_has_audio;
+};
+
+void dp_clock_reset_seq(struct cdn_dp_device *dp);
+
+void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, int clk);
+int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
+			 u32 i_size, const u32 *d_mem, u32 d_size);
+int cdn_dp_active(struct cdn_dp_device *dp, u8 enable);
+int cdn_dp_set_host_cap(struct cdn_dp_device *dp);
+int cdn_dp_event_config(struct cdn_dp_device *dp);
+int cdn_dp_get_event(struct cdn_dp_device *dp);
+int cdn_dp_get_hpd_status(struct cdn_dp_device *dp);
+int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value);
+int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr);
+int cdn_dp_get_edid_block(void *dp, u8 *edid,
+			  unsigned int block, size_t length);
+int cdn_dp_training_start(struct cdn_dp_device *dp);
+int cdn_dp_get_lt_status(struct cdn_dp_device *dp);
+int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active);
+int cdn_dp_config_video(struct cdn_dp_device *dp);
+int cdn_dp_audio_start(void *dp_dev, struct audio_info *audio);
+int cdn_dp_audio_stop(void *dp_dev, struct audio_info *audio);
+int cdn_dp_audio_config_set(void *dp_dev, struct audio_info *audio);
+
+#endif  /* _ROCKCHIP_EDP_CORE_H */
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
new file mode 100644
index 0000000..d6c9bcb
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -0,0 +1,730 @@
+/*
+ * cdn dp controller register driver
+ *
+ * Copyright (C) 2016 Chris Zhong <zyw@rock-chips.com>
+ * Copyright (C) 2016 ROCKCHIP, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/reset.h>
+
+#include <sound/cdn-dp-audio.h>
+
+#include "cdn-dp-core.h"
+#include "cdn-dp-reg.h"
+
+#define FW_ALIVE_TIMEOUT_US		1000000
+#define MAILBOX_TIMEOUT_US		5000000
+
+/* the max size of read buff is 134 */
+static u8 rx_buff[134];
+
+void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, int clk)
+{
+	writel(clk / 1000000, dp->regs + SW_CLK_H);
+}
+
+void dp_clock_reset_seq(struct cdn_dp_device *dp)
+{
+	writel(0xfff, dp->regs + SOURCE_DPTX_CAR);
+	writel(0x7, dp->regs + SOURCE_PHY_CAR);
+	writel(0xf, dp->regs + SOURCE_PKT_CAR);
+	writel(0xff, dp->regs + SOURCE_AIF_CAR);
+	writel(0xf, dp->regs + SOURCE_CIPHER_CAR);
+	writel(0x3, dp->regs + SOURCE_CRYPTO_CAR);
+	writel(0, dp->regs + APB_INT_MASK);
+}
+
+static u8 cdn_dp_mailbox_read(struct cdn_dp_device *dp)
+{
+	int val, ret;
+
+	if (!dp->fw_loaded)
+		return 0;
+
+	ret = readx_poll_timeout(readl, dp->regs + MAILBOX_EMPTY_ADDR,
+				 val, !val, 1000, MAILBOX_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(dp->dev, "failed to wait mailbox response\n");
+		return 0;
+	}
+
+	return readl(dp->regs + MAILBOX0_RD_DATA) & 0xff;
+}
+
+static void cdp_dp_mailbox_write(struct cdn_dp_device *dp, u8 val)
+{
+	int ret, full;
+
+	if (!dp->fw_loaded)
+		return;
+
+	ret = readx_poll_timeout(readl, dp->regs + MAILBOX_FULL_ADDR,
+				 full, !full, 1000, MAILBOX_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(dp->dev, "mailbox is full\n");
+		return;
+	}
+
+	writel(val, dp->regs + MAILBOX0_WR_DATA);
+}
+
+/* return the size of message */
+int cdn_dp_mailbox_response(struct cdn_dp_device *dp, u8 module_id,
+			    u8 opcode, u8 **message)
+{
+	int size, i = 0;
+
+	memset(rx_buff, 0, 4);
+
+	while (i < sizeof(rx_buff)) {
+		if (i < sizeof(rx_buff))
+			rx_buff[i++] = cdn_dp_mailbox_read(dp);
+
+		size = ((rx_buff[2] << 8) | rx_buff[3]) + 4;
+		if (i >= size)
+			break;
+	}
+
+	if ((opcode != rx_buff[0]) || (module_id != rx_buff[1]))
+		return -EINVAL;
+
+	size = (rx_buff[2] << 8) | rx_buff[3];
+
+	*message = &rx_buff[4];
+
+	return size;
+}
+
+int cdn_dp_mailbox_send(struct cdn_dp_device *dp, u8 module_id, u8 opcode,
+			u16 size, u8 *message)
+{
+	cdp_dp_mailbox_write(dp, opcode);
+	cdp_dp_mailbox_write(dp, module_id);
+	cdp_dp_mailbox_write(dp, size >> 8);
+	cdp_dp_mailbox_write(dp, size & 0xff);
+
+	while (size--)
+		cdp_dp_mailbox_write(dp, *message++);
+
+	return 0;
+}
+
+int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
+			 u32 i_size, const u32 *d_mem, u32 d_size)
+{
+	int i, reg, ret;
+
+	/* reset ucpu before load firmware*/
+	writel(APB_IRAM_PATH | APB_DRAM_PATH | APB_XT_RESET,
+	       dp->regs + APB_CTRL);
+
+	for (i = 0; i < i_size; i += 4)
+		writel(*i_mem++, dp->regs + ADDR_IMEM + i);
+
+	for (i = 0; i < d_size; i += 4)
+		writel(*d_mem++, dp->regs + ADDR_DMEM + i);
+
+	/* un-reset ucpu */
+	writel(0, dp->regs + APB_CTRL);
+
+	/* check the keep alive register to make sure fw working */
+	ret = readx_poll_timeout(readl, dp->regs + KEEP_ALIVE,
+				 reg, reg, 2000, FW_ALIVE_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(dp->dev, "failed to loaded the FW reg = %x\n", reg);
+		return -EINVAL;
+	}
+
+	reg = readl(dp->regs + VER_L) & 0xff;
+	dp->fw_version = reg;
+	reg = readl(dp->regs + VER_H) & 0xff;
+	dp->fw_version |= reg << 8;
+	reg = readl(dp->regs + VER_LIB_L_ADDR) & 0xff;
+	dp->fw_version |= reg << 16;
+	reg = readl(dp->regs + VER_LIB_H_ADDR) & 0xff;
+	dp->fw_version |= reg << 24;
+
+	dp->fw_loaded = 1;
+
+	return 0;
+}
+
+int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val)
+{
+	u8 msg[6];
+
+	msg[0] = (addr >> 8) & 0xff;
+	msg[1] = addr & 0xff;
+	msg[2] = (val >> 24) & 0xff;
+	msg[3] = (val >> 16) & 0xff;
+	msg[4] = (val >> 8) & 0xff;
+	msg[5] = val & 0xff;
+	return cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_REGISTER,
+				   ARRAY_SIZE(msg), msg);
+}
+
+int cdn_dp_reg_read(struct cdn_dp_device *dp, u16 addr)
+{
+	u8 msg[2], *reg = NULL;
+	u16 size;
+
+	msg[0] = (addr >> 8) & 0xff;
+	msg[1] = addr & 0xff;
+	cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_READ_REGISTER,
+			    ARRAY_SIZE(msg), msg);
+
+	size = cdn_dp_mailbox_response(dp, MB_MODULE_ID_DP_TX,
+				       DPTX_READ_REGISTER, &reg);
+	if (size != 6)
+		return -EINVAL;
+
+	if ((msg[0] == reg[0]) && (msg[1] == reg[1]))
+		return (reg[2] << 24) | (reg[3] << 16) | (reg[4] << 8) | reg[5];
+
+	return -EINVAL;
+}
+
+int cdn_dp_reg_write_bit(struct cdn_dp_device *dp, u16 addr, u8 start_bit,
+			 u8 bits_no, u32 val)
+{
+	u8 field[8];
+
+	field[0] = (addr >> 8) & 0xff;
+	field[1] = addr & 0xff;
+	field[2] = start_bit;
+	field[3] = bits_no;
+	field[4] = (val >> 24) & 0xff;
+	field[5] = (val >> 16) & 0xff;
+	field[6] = (val >> 8) & 0xff;
+	field[7] = val & 0xff;
+
+	return cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_FIELD,
+			    sizeof(field), field);
+}
+
+int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
+{
+	u8 msg[6], *reg = NULL;
+	u16 size;
+
+	msg[0] = 0;
+	msg[1] = 1;
+	msg[2] = (addr >> 16) & 0xff;
+	msg[3] = (addr >> 8) & 0xff;
+	msg[4] = addr & 0xff;
+	msg[5] = value;
+	cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_DPCD,
+			    ARRAY_SIZE(msg), msg);
+
+	size = cdn_dp_mailbox_response(dp, MB_MODULE_ID_DP_TX,
+				       DPTX_WRITE_DPCD, &reg);
+	if (size != 5)
+		return -EINVAL;
+
+	if ((msg[2] == reg[2]) && (msg[3] == reg[3]) && (msg[4] == reg[4]))
+		return 0;
+
+	return -EINVAL;
+}
+
+int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr)
+{
+	u8 msg[5], *reg = NULL;
+	u16 size;
+
+	msg[0] = 0;
+	msg[1] = 1;
+	msg[2] = (addr >> 16) & 0xff;
+	msg[3] = (addr >> 8) & 0xff;
+	msg[4] = addr & 0xff;
+	cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_READ_DPCD,
+			    ARRAY_SIZE(msg), msg);
+
+	size = cdn_dp_mailbox_response(dp, MB_MODULE_ID_DP_TX,
+				       DPTX_READ_DPCD, &reg);
+	if (size != 6)
+		return -EINVAL;
+
+	if ((msg[2] == reg[2]) && (msg[3] == reg[3]) && (msg[4] == reg[4]))
+		return reg[5];
+
+	return -EINVAL;
+}
+
+int cdn_dp_active(struct cdn_dp_device *dp, u8 enable)
+{
+	u8 active = enable ? 1 : 0;
+	u8 *resp = NULL;
+	int size;
+
+	/* set firmware status, 1: avtive; 0: standby */
+	cdn_dp_mailbox_send(dp, MB_MODULE_ID_GENERAL, GENERAL_MAIN_CONTROL,
+			    1, &active);
+
+	size = cdn_dp_mailbox_response(dp, MB_MODULE_ID_GENERAL,
+				       GENERAL_MAIN_CONTROL, &resp);
+	if (size != 1)
+		return -EINVAL;
+
+	return *resp ? 0 : -EINVAL;
+}
+
+int cdn_dp_set_host_cap(struct cdn_dp_device *dp)
+{
+	u8 msg[8];
+
+	msg[0] = DP_LINK_BW_5_4;
+	msg[1] = dp->cap_lanes;
+	msg[2] = VOLTAGE_LEVEL_2;
+	msg[3] = PRE_EMPHASIS_LEVEL_3;
+	msg[4] = PRBS7 | D10_2 | TRAINING_PTN1 | TRAINING_PTN2;
+	msg[5] = FAST_LT_NOT_SUPPORT;
+	msg[6] = LANE_MAPPING_NORMAL;
+	msg[7] = ENHANCED;
+
+	cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
+			    DPTX_SET_HOST_CAPABILITIES,
+			    ARRAY_SIZE(msg), msg);
+
+	cdn_dp_reg_write(dp, DP_AUX_SWAP_INVERSION_CONTROL, AUX_HOST_INVERT);
+
+	return 0;
+}
+
+int cdn_dp_event_config(struct cdn_dp_device *dp)
+{
+	u8 msg[5];
+
+	msg[0] = DPTX_EVENT_ENABLE_HPD | DPTX_EVENT_ENABLE_TRAINING;
+
+	return cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_ENABLE_EVENT,
+				    ARRAY_SIZE(msg), msg);
+}
+
+int cdn_dp_get_event(struct cdn_dp_device *dp)
+{
+	return readl(dp->regs + SW_EVENTS0);
+}
+
+int cdn_dp_get_hpd_status(struct cdn_dp_device *dp)
+{
+	u8 *status = NULL;
+	int size;
+
+	cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_HPD_STATE,
+			    0, NULL);
+
+	size = cdn_dp_mailbox_response(dp, MB_MODULE_ID_DP_TX,
+				       DPTX_HPD_STATE, &status);
+	if (size != 1)
+		return -EINVAL;
+
+	return *status;
+}
+
+int cdn_dp_get_edid_block(void *data, u8 *edid,
+			  unsigned int block, size_t length)
+{
+	struct cdn_dp_device *dp = data;
+	int size;
+	u8 msg[2], *reg = NULL;
+
+	if (length != EDID_BLOCK_SIZE)
+		return -EINVAL;
+
+	msg[0] = block / 2;
+	msg[1] = block % 2;
+
+	cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_GET_EDID,
+			    2, msg);
+
+	size = cdn_dp_mailbox_response(dp, MB_MODULE_ID_DP_TX,
+				       DPTX_GET_EDID, &reg);
+
+	if (size != EDID_DATA + EDID_BLOCK_SIZE) {
+		dev_err(dp->dev, "read edid failed\n");
+		return -EINVAL;
+	}
+
+	if ((reg[EDID_LENGTH_BYTE] != EDID_BLOCK_SIZE) ||
+	    (reg[EDID_SEGMENT_BUMBER] != block / 2)) {
+		dev_err(dp->dev, "edid block size err\n");
+		return -EINVAL;
+	}
+
+	memcpy(edid, &reg[EDID_DATA], EDID_BLOCK_SIZE);
+
+	return 0;
+}
+
+int cdn_dp_training_start(struct cdn_dp_device *dp)
+{
+	int size;
+	u8 msg, *event = NULL;
+	unsigned long timeout;
+
+	msg = LINK_TRAINING_RUN;
+
+	/* start training */
+	cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_TRAINING_CONTROL,
+			    1, &msg);
+
+	/* the whole training should finish in 500ms */
+	timeout = jiffies + msecs_to_jiffies(500);
+	while (1) {
+		msleep(20);
+		cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_READ_EVENT,
+				    0, NULL);
+
+		size = cdn_dp_mailbox_response(dp, MB_MODULE_ID_DP_TX,
+					       DPTX_READ_EVENT, &event);
+		if (size != 2)
+			return -EINVAL;
+
+		if (event[1] & EQ_PHASE_FINISHED)
+			break;
+
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+int cdn_dp_get_lt_status(struct cdn_dp_device *dp)
+{
+	u8 *status = NULL;
+	int size;
+
+	cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_READ_LINK_STAT,
+			    0, NULL);
+
+	size = cdn_dp_mailbox_response(dp, MB_MODULE_ID_DP_TX,
+				       DPTX_READ_LINK_STAT, &status);
+
+	if (size != 10)
+		return -EINVAL;
+
+	dp->link.rate = status[0];
+	dp->link.num_lanes = status[1];
+
+	return 0;
+}
+
+int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active)
+{
+	u8 msg;
+
+	msg = !!active;
+
+	cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_SET_VIDEO,
+			    1, &msg);
+
+	return 0;
+}
+
+int cdn_dp_set_audio_status(struct cdn_dp_device *dp, int active)
+{
+	u8 msg;
+
+	msg = !!active;
+
+	cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_SET_AUDIO,
+			    1, &msg);
+
+	return 0;
+}
+
+static int cdn_dp_get_msa_misc(struct video_info *video,
+			       struct drm_display_mode *mode)
+{
+	u8 val0, val1;
+	u32 msa_misc;
+
+	switch (video->color_fmt) {
+	case PXL_RGB:
+	case Y_ONLY:
+		val0 = 0;
+		break;
+	case YCBCR_4_4_4:
+		val0 = 6;
+		break;
+	case YCBCR_4_2_2:
+		val0 = 5;
+		break;
+	case YCBCR_4_2_0:
+		val0 = 5;
+		break;
+	};
+
+	switch (video->color_depth) {
+	case 6:
+		val1 = 0;
+		break;
+	case 8:
+		val1 = 1;
+		break;
+	case 10:
+		val1 = 2;
+		break;
+	case 12:
+		val1 = 3;
+		break;
+	case 16:
+		val1 = 4;
+		break;
+	};
+
+	msa_misc = 2 * val0 + 32 * val1 +
+		   ((video->color_fmt == Y_ONLY) ? (1 << 14) : 0);
+
+	return msa_misc;
+}
+
+int cdn_dp_config_video(struct cdn_dp_device *dp)
+{
+	struct video_info *video = &dp->video_info;
+	struct drm_display_mode *mode = &dp->mode;
+	u32 val, link_rate;
+	u8 bit_per_pix;
+
+	bit_per_pix = (video->color_fmt == YCBCR_4_2_2) ?
+		      (video->color_depth * 2) : (video->color_depth * 3);
+
+	val = VIF_BYPASS_INTERLACE;
+
+	cdn_dp_reg_write(dp, BND_HSYNC2VSYNC, val);
+
+	cdn_dp_reg_write(dp, HSYNC2VSYNC_POL_CTRL, 0);
+
+	link_rate = drm_dp_bw_code_to_link_rate(dp->link.rate) / 1000;
+
+	val = TU_SIZE * mode->clock * bit_per_pix;
+	val /= dp->link.num_lanes * link_rate * 8 * 1000;
+	/* FIXME: need add 1 to symbols 4K display */
+	if (mode->clock > 500000)
+		val += 1;
+
+	val += TU_SIZE << 8;
+
+	cdn_dp_reg_write(dp, DP_FRAMER_TU, val);
+
+	switch (video->color_depth) {
+	case 6:
+		val = BCS_6;
+		break;
+	case 8:
+		val = BCS_8;
+		break;
+	case 10:
+		val = BCS_10;
+		break;
+	case 12:
+		val = BCS_12;
+		break;
+	case 16:
+		val = BCS_16;
+		break;
+	};
+
+	val += video->color_fmt << 8;
+	cdn_dp_reg_write(dp, DP_FRAMER_PXL_REPR, val);
+
+	val = video->h_sync_polarity ? DP_FRAMER_SP_HSP : 0;
+	val |= video->v_sync_polarity ? DP_FRAMER_SP_VSP : 0;
+	cdn_dp_reg_write(dp, DP_FRAMER_SP, val);
+
+	val = (mode->hsync_start - mode->hdisplay) << 16;
+	val |= mode->htotal - mode->hsync_end;
+	cdn_dp_reg_write(dp, DP_FRONT_BACK_PORCH, val);
+
+	val = mode->hdisplay * bit_per_pix / 8;
+	cdn_dp_reg_write(dp, DP_BYTE_COUNT, val);
+
+	val = mode->htotal | ((mode->htotal - mode->hsync_start) << 16);
+	cdn_dp_reg_write(dp, MSA_HORIZONTAL_0, val);
+
+	val = mode->hsync_end - mode->hsync_start;
+	val |= (mode->hdisplay << 16) | (video->h_sync_polarity << 15);
+	cdn_dp_reg_write(dp, MSA_HORIZONTAL_1, val);
+
+	val = mode->vtotal;
+	val |= ((mode->vtotal - mode->vsync_start) << 16);
+
+	cdn_dp_reg_write(dp, MSA_VERTICAL_0, val);
+
+	val = mode->vsync_end - mode->vsync_start;
+	val |= mode->vdisplay << 16;
+	val |= (video->v_sync_polarity << 15);
+	cdn_dp_reg_write(dp, MSA_VERTICAL_1, val);
+
+	val = cdn_dp_get_msa_misc(video, mode);
+	cdn_dp_reg_write(dp, MSA_MISC, val);
+
+	cdn_dp_reg_write(dp, STREAM_CONFIG, 1);
+
+	val = mode->hsync_end - mode->hsync_start;
+	val |= (mode->hdisplay << 16);
+	cdn_dp_reg_write(dp, DP_HORIZONTAL, val);
+
+	val = mode->vtotal;
+	val -= (mode->vtotal - mode->vdisplay);
+	val |= (mode->vtotal - mode->vsync_start) << 16;
+
+	cdn_dp_reg_write(dp, DP_VERTICAL_0, val);
+
+	val = mode->vtotal;
+	cdn_dp_reg_write(dp, DP_VERTICAL_1, val);
+
+	val =  0;
+	cdn_dp_reg_write_bit(dp, DP_VB_ID, 2, 1, val);
+
+	return 0;
+}
+
+int cdn_dp_audio_start(void *dp_dev, struct audio_info *audio)
+{
+	struct cdn_dp_device *dp = (struct cdn_dp_device *)dp_dev;
+
+	if (audio->type == TYPE_SPDIF) {
+		clk_prepare_enable(dp->spdif_clk);
+		clk_set_rate(dp->spdif_clk, 400000000);
+	}
+
+	return cdn_dp_reg_write(dp, AUDIO_PACK_CONTROL, AUDIO_PACK_EN(1));
+}
+
+int cdn_dp_audio_stop(void *dp_dev, struct audio_info *audio)
+{
+	struct cdn_dp_device *dp = (struct cdn_dp_device *)dp_dev;
+
+	cdn_dp_reg_write(dp, AUDIO_PACK_CONTROL, AUDIO_PACK_EN(0));
+
+	if (audio->type == TYPE_SPDIF)
+		clk_disable_unprepare(dp->spdif_clk);
+
+	return 0;
+}
+
+int cdn_dp_audio_config_set(void *dp_dev, struct audio_info *audio)
+{
+	struct cdn_dp_device *dp = (struct cdn_dp_device *)dp_dev;
+	int lanes_param, i2s_port_en_val, val, i;
+
+	if ((audio->channels == 2) && (dp->link.num_lanes == 1))
+		lanes_param = 1;
+	else if (audio->channels == 2)
+		lanes_param = 3;
+	else
+		lanes_param = 0;
+
+	if (audio->channels == 2)
+		i2s_port_en_val = 1;
+	else if (audio->channels == 4)
+		i2s_port_en_val = 3;
+	else
+		i2s_port_en_val = 0xf;
+
+	cdn_dp_reg_write(dp, CM_LANE_CTRL, 0x8000);
+
+	cdn_dp_reg_write(dp, CM_CTRL, 0);
+
+	if (audio->type == TYPE_I2S) {
+		writel(0x0, dp->regs + SPDIF_CTRL_ADDR);
+
+		writel(SYNC_WR_TO_CH_ZERO, dp->regs + FIFO_CNTL);
+
+		val = audio->channels - 1;
+		val |= (audio->channels / 2 - 1) << 5;
+		val |= BIT(8);
+		val |= lanes_param << 11;
+		writel(val, dp->regs + SMPL2PKT_CNFG);
+
+		if (audio->word_length == 16)
+			val = 0;
+		else if (audio->word_length == 24)
+			val = 1 << 9;
+		else
+			val = 2 << 9;
+
+		val |= (audio->channels - 1) << 2;
+		val |= i2s_port_en_val << 17;
+		val |= 2 << 11;
+		writel(val, dp->regs + AUDIO_SRC_CNFG);
+
+		for (i = 0; i < (audio->channels + 1) / 2; i++) {
+			if (audio->word_length == 16)
+				val = (0x08 << 8) | (0x08 << 20);
+			else if (audio->word_length == 24)
+				val = (0x0b << 8) | (0x0b << 20);
+
+			val |= ((2 * i) << 4) | ((2 * i + 1) << 16);
+			writel(val, dp->regs + STTS_BIT_CH(i));
+		}
+
+		switch (audio->freq) {
+		case 32000:
+			val = SAMPLING_FREQ(3) |
+			      ORIGINAL_SAMP_FREQ(0xc);
+			break;
+		case 44100:
+			val = SAMPLING_FREQ(0) |
+			      ORIGINAL_SAMP_FREQ(0xf);
+			break;
+		case 48000:
+			val = SAMPLING_FREQ(2) |
+			      ORIGINAL_SAMP_FREQ(0xd);
+			break;
+		case 88200:
+			val = SAMPLING_FREQ(8) |
+			      ORIGINAL_SAMP_FREQ(0x7);
+			break;
+		case 96000:
+			val = SAMPLING_FREQ(0xa) |
+			      ORIGINAL_SAMP_FREQ(5);
+			break;
+		case 176400:
+			val = SAMPLING_FREQ(0xc) |
+			      ORIGINAL_SAMP_FREQ(3);
+			break;
+		case 192000:
+			val = SAMPLING_FREQ(0xe) |
+			      ORIGINAL_SAMP_FREQ(1);
+			break;
+		}
+		val |= 4;
+		writel(val, dp->regs + COM_CH_STTS_BITS);
+
+		writel(2, dp->regs + SMPL2PKT_CNTL);
+		writel(2, dp->regs + AUDIO_SRC_CNTL);
+		cdn_dp_reg_write_bit(dp, DP_VB_ID, 4, 1, 0);
+	} else {
+		val = 0x1F0707;
+		writel(val, dp->regs + SPDIF_CTRL_ADDR);
+
+		writel(SYNC_WR_TO_CH_ZERO, dp->regs + FIFO_CNTL);
+
+		val = 0x101 | (3 << 11);
+		writel(val, dp->regs + SMPL2PKT_CNFG);
+		writel(2, dp->regs + SMPL2PKT_CNTL);
+
+		val = 0x3F0707;
+		writel(val, dp->regs + SPDIF_CTRL_ADDR);
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
new file mode 100644
index 0000000..74fc7f9
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -0,0 +1,404 @@
+/*
+ * Copyright (C) 2016 Chris Zhong <zyw@rock-chips.com>
+ * Copyright (C) 2016 ROCKCHIP, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _CDN_DP_REG_H
+#define _CDN_DP_REG_H
+
+#include <linux/bitops.h>
+
+#define ADDR_IMEM		0x10000
+#define ADDR_DMEM		0x20000
+
+/* APB CFG addr */
+#define APB_CTRL			0
+#define XT_INT_CTRL			0x04
+#define MAILBOX_FULL_ADDR		0x08
+#define MAILBOX_EMPTY_ADDR		0x0c
+#define MAILBOX0_WR_DATA		0x10
+#define MAILBOX0_RD_DATA		0x14
+#define KEEP_ALIVE			0x18
+#define VER_L				0x1c
+#define VER_H				0x20
+#define VER_LIB_L_ADDR			0x24
+#define VER_LIB_H_ADDR			0x28
+#define SW_DEBUG_L			0x2c
+#define SW_DEBUG_H			0x30
+#define MAILBOX_INT_MASK		0x34
+#define MAILBOX_INT_STATUS		0x38
+#define SW_CLK_L			0x3c
+#define SW_CLK_H			0x40
+#define SW_EVENTS0			0x44
+#define SW_EVENTS1			0x48
+#define SW_EVENTS2			0x4c
+#define SW_EVENTS3			0x50
+#define XT_OCD_CTRL			0x60
+#define APB_INT_MASK			0x6c
+#define APB_STATUS_MASK			0x70
+
+/* audio decoder addr */
+#define AUDIO_SRC_CNTL			0x30000
+#define AUDIO_SRC_CNFG			0x30004
+#define COM_CH_STTS_BITS		0x30008
+#define STTS_BIT_CH(x)			(0x3000c + (x << 2))
+#define SPDIF_CTRL_ADDR			0x3004c
+#define SPDIF_CH1_CS_3100_ADDR		0x30050
+#define SPDIF_CH1_CS_6332_ADDR		0x30054
+#define SPDIF_CH1_CS_9564_ADDR		0x30058
+#define SPDIF_CH1_CS_12796_ADDR		0x3005c
+#define SPDIF_CH1_CS_159128_ADDR	0x30060
+#define SPDIF_CH1_CS_191160_ADDR	0x30064
+#define SPDIF_CH2_CS_3100_ADDR		0x30068
+#define SPDIF_CH2_CS_6332_ADDR		0x3006c
+#define SPDIF_CH2_CS_9564_ADDR		0x30070
+#define SPDIF_CH2_CS_12796_ADDR		0x30074
+#define SPDIF_CH2_CS_159128_ADDR	0x30078
+#define SPDIF_CH2_CS_191160_ADDR	0x3007c
+#define SMPL2PKT_CNTL			0x30080
+#define SMPL2PKT_CNFG			0x30084
+#define FIFO_CNTL			0x30088
+#define FIFO_STTS			0x3008c
+
+/* source pif addr */
+#define SOURCE_PIF_WR_ADDR		0x30800
+#define SOURCE_PIF_WR_REQ		0x30804
+#define SOURCE_PIF_RD_ADDR		0x30808
+#define SOURCE_PIF_RD_REQ		0x3080c
+#define SOURCE_PIF_DATA_WR		0x30810
+#define SOURCE_PIF_DATA_RD		0x30814
+#define SOURCE_PIF_FIFO1_FLUSH		0x30818
+#define SOURCE_PIF_FIFO2_FLUSH		0x3081c
+#define SOURCE_PIF_STATUS		0x30820
+#define SOURCE_PIF_INTERRUPT_SOURCE	0x30824
+#define SOURCE_PIF_INTERRUPT_MASK	0x30828
+#define SOURCE_PIF_PKT_ALLOC_REG	0x3082c
+#define SOURCE_PIF_PKT_ALLOC_WR_EN	0x30830
+#define SOURCE_PIF_SW_RESET		0x30834
+
+/* bellow registers need access by mailbox */
+/* source car addr */
+#define SOURCE_HDTX_CAR			0x0900
+#define SOURCE_DPTX_CAR			0x0904
+#define SOURCE_PHY_CAR			0x0908
+#define SOURCE_CEC_CAR			0x090c
+#define SOURCE_CBUS_CAR			0x0910
+#define SOURCE_PKT_CAR			0x0918
+#define SOURCE_AIF_CAR			0x091c
+#define SOURCE_CIPHER_CAR		0x0920
+#define SOURCE_CRYPTO_CAR		0x0924
+
+/* clock meters addr */
+#define CM_CTRL				0x0a00
+#define CM_I2S_CTRL			0x0a04
+#define CM_SPDIF_CTRL			0x0a08
+#define CM_VID_CTRL			0x0a0c
+#define CM_LANE_CTRL			0x0a10
+#define I2S_NM_STABLE			0x0a14
+#define I2S_NCTS_STABLE			0x0a18
+#define SPDIF_NM_STABLE			0x0a1c
+#define SPDIF_NCTS_STABLE		0x0a20
+#define NMVID_MEAS_STABLE		0x0a24
+#define I2S_MEAS			0x0a40
+#define SPDIF_MEAS			0x0a80
+#define NMVID_MEAS			0x0ac0
+
+/* source vif addr */
+#define BND_HSYNC2VSYNC			0x0b00
+#define HSYNC2VSYNC_F1_L1		0x0b04
+#define HSYNC2VSYNC_F2_L1		0x0b08
+#define HSYNC2VSYNC_STATUS		0x0b0c
+#define HSYNC2VSYNC_POL_CTRL		0x0b10
+
+/* dptx phy addr */
+#define DP_TX_PHY_CONFIG_REG		0x2000
+#define DP_TX_PHY_STATUS_REG		0x2004
+#define DP_TX_PHY_SW_RESET		0x2008
+#define DP_TX_PHY_SCRAMBLER_SEED	0x200c
+#define DP_TX_PHY_TRAINING_01_04	0x2010
+#define DP_TX_PHY_TRAINING_05_08	0x2014
+#define DP_TX_PHY_TRAINING_09_10	0x2018
+#define TEST_COR			0x23fc
+
+/* dptx hpd addr */
+#define HPD_IRQ_DET_MIN_TIMER		0x2100
+#define HPD_IRQ_DET_MAX_TIMER		0x2104
+#define HPD_UNPLGED_DET_MIN_TIMER	0x2108
+#define HPD_STABLE_TIMER		0x210c
+#define HPD_FILTER_TIMER		0x2110
+#define HPD_EVENT_MASK			0x211c
+#define HPD_EVENT_DET			0x2120
+
+/* dpyx framer addr */
+#define DP_FRAMER_GLOBAL_CONFIG		0x2200
+#define DP_SW_RESET			0x2204
+#define DP_FRAMER_TU			0x2208
+#define DP_FRAMER_PXL_REPR		0x220c
+#define DP_FRAMER_SP			0x2210
+#define AUDIO_PACK_CONTROL		0x2214
+#define DP_VC_TABLE(x)			(0x2218 + (x << 2))
+#define DP_VB_ID			0x2258
+#define DP_MTPH_LVP_CONTROL		0x225c
+#define DP_MTPH_SYMBOL_VALUES		0x2260
+#define DP_MTPH_ECF_CONTROL		0x2264
+#define DP_MTPH_ACT_CONTROL		0x2268
+#define DP_MTPH_STATUS			0x226c
+#define DP_INTERRUPT_SOURCE		0x2270
+#define DP_INTERRUPT_MASK		0x2274
+#define DP_FRONT_BACK_PORCH		0x2278
+#define DP_BYTE_COUNT			0x227c
+
+/* dptx stream addr */
+#define MSA_HORIZONTAL_0		0x2280
+#define MSA_HORIZONTAL_1		0x2284
+#define MSA_VERTICAL_0			0x2288
+#define MSA_VERTICAL_1			0x228c
+#define MSA_MISC			0x2290
+#define STREAM_CONFIG			0x2294
+#define AUDIO_PACK_STATUS		0x2298
+#define VIF_STATUS			0x229c
+#define PCK_STUFF_STATUS_0		0x22a0
+#define PCK_STUFF_STATUS_1		0x22a4
+#define INFO_PACK_STATUS		0x22a8
+#define RATE_GOVERNOR_STATUS		0x22ac
+#define DP_HORIZONTAL			0x22b0
+#define DP_VERTICAL_0			0x22b4
+#define DP_VERTICAL_1			0x22b8
+#define DP_BLOCK_SDP			0x22bc
+
+/* dptx glbl addr */
+#define DPTX_LANE_EN			0x2300
+#define DPTX_ENHNCD			0x2304
+#define DPTX_INT_MASK			0x2308
+#define DPTX_INT_STATUS			0x230c
+
+/* dp aux addr */
+#define DP_AUX_HOST_CONTROL		0x2800
+#define DP_AUX_INTERRUPT_SOURCE		0x2804
+#define DP_AUX_INTERRUPT_MASK		0x2808
+#define DP_AUX_SWAP_INVERSION_CONTROL	0x280c
+#define DP_AUX_SEND_NACK_TRANSACTION	0x2810
+#define DP_AUX_CLEAR_RX			0x2814
+#define DP_AUX_CLEAR_TX			0x2818
+#define DP_AUX_TIMER_STOP		0x281c
+#define DP_AUX_TIMER_CLEAR		0x2820
+#define DP_AUX_RESET_SW			0x2824
+#define DP_AUX_DIVIDE_2M		0x2828
+#define DP_AUX_TX_PREACHARGE_LENGTH	0x282c
+#define DP_AUX_FREQUENCY_1M_MAX		0x2830
+#define DP_AUX_FREQUENCY_1M_MIN		0x2834
+#define DP_AUX_RX_PRE_MIN		0x2838
+#define DP_AUX_RX_PRE_MAX		0x283c
+#define DP_AUX_TIMER_PRESET		0x2840
+#define DP_AUX_NACK_FORMAT		0x2844
+#define DP_AUX_TX_DATA			0x2848
+#define DP_AUX_RX_DATA			0x284c
+#define DP_AUX_TX_STATUS		0x2850
+#define DP_AUX_RX_STATUS		0x2854
+#define DP_AUX_RX_CYCLE_COUNTER		0x2858
+#define DP_AUX_MAIN_STATES		0x285c
+#define DP_AUX_MAIN_TIMER		0x2860
+#define DP_AUX_AFE_OUT			0x2864
+
+/* crypto addr */
+#define CRYPTO_HDCP_REVISION		0x5800
+#define HDCP_CRYPTO_CONFIG		0x5804
+#define CRYPTO_INTERRUPT_SOURCE		0x5808
+#define CRYPTO_INTERRUPT_MASK		0x580c
+#define CRYPTO22_CONFIG			0x5818
+#define CRYPTO22_STATUS			0x581c
+#define SHA_256_DATA_IN			0x583c
+#define SHA_256_DATA_OUT_(x)		(0x5850 + (x << 2))
+#define AES_32_KEY_(x)			(0x5870 + (x << 2))
+#define AES_32_DATA_IN			0x5880
+#define AES_32_DATA_OUT_(x)		(0x5884 + (x << 2))
+#define CRYPTO14_CONFIG			0x58a0
+#define CRYPTO14_STATUS			0x58a4
+#define CRYPTO14_PRNM_OUT		0x58a8
+#define CRYPTO14_KM_0			0x58ac
+#define CRYPTO14_KM_1			0x58b0
+#define CRYPTO14_AN_0			0x58b4
+#define CRYPTO14_AN_1			0x58b8
+#define CRYPTO14_YOUR_KSV_0		0x58bc
+#define CRYPTO14_YOUR_KSV_1		0x58c0
+#define CRYPTO14_MI_0			0x58c4
+#define CRYPTO14_MI_1			0x58c8
+#define CRYPTO14_TI_0			0x58cc
+#define CRYPTO14_KI_0			0x58d0
+#define CRYPTO14_KI_1			0x58d4
+#define CRYPTO14_BLOCKS_NUM		0x58d8
+#define CRYPTO14_KEY_MEM_DATA_0		0x58dc
+#define CRYPTO14_KEY_MEM_DATA_1		0x58e0
+#define CRYPTO14_SHA1_MSG_DATA		0x58e4
+#define CRYPTO14_SHA1_V_VALUE_(x)	(0x58e8 + (x << 2))
+#define TRNG_CTRL			0x58fc
+#define TRNG_DATA_RDY			0x5900
+#define TRNG_DATA			0x5904
+
+/* cipher addr */
+#define HDCP_REVISION			0x60000
+#define INTERRUPT_SOURCE		0x60004
+#define INTERRUPT_MASK			0x60008
+#define HDCP_CIPHER_CONFIG		0x6000c
+#define AES_128_KEY_0			0x60010
+#define AES_128_KEY_1			0x60014
+#define AES_128_KEY_2			0x60018
+#define AES_128_KEY_3			0x6001c
+#define AES_128_RANDOM_0		0x60020
+#define AES_128_RANDOM_1		0x60024
+#define CIPHER14_KM_0			0x60028
+#define CIPHER14_KM_1			0x6002c
+#define CIPHER14_STATUS			0x60030
+#define CIPHER14_RI_PJ_STATUS		0x60034
+#define CIPHER_MODE			0x60038
+#define CIPHER14_AN_0			0x6003c
+#define CIPHER14_AN_1			0x60040
+#define CIPHER22_AUTH			0x60044
+#define CIPHER14_R0_DP_STATUS		0x60048
+#define CIPHER14_BOOTSTRAP		0x6004c
+
+#define APB_IRAM_PATH			BIT(2)
+#define APB_DRAM_PATH			BIT(1)
+#define APB_XT_RESET			BIT(0)
+
+/* mailbox */
+#define MB_OPCODE_ID			0
+#define MB_MODULE_ID			1
+#define MB_SIZE_MSB_ID			2
+#define MB_SIZE_LSB_ID			3
+#define MB_DATA_ID			4
+
+#define MB_MODULE_ID_DP_TX		0x01
+#define MB_MODULE_ID_HDCP_TX		0x07
+#define MB_MODULE_ID_HDCP_RX		0x08
+#define MB_MODULE_ID_HDCP_GENERAL	0x09
+#define MB_MODULE_ID_GENERAL		0x0a
+
+/* general opcode */
+#define GENERAL_MAIN_CONTROL            0x01
+#define GENERAL_TEST_ECHO               0x02
+#define GENERAL_BUS_SETTINGS            0x03
+#define GENERAL_TEST_ACCESS             0x04
+
+#define DPTX_SET_POWER_MNG			0x00
+#define DPTX_SET_HOST_CAPABILITIES		0x01
+#define DPTX_GET_EDID				0x02
+#define DPTX_READ_DPCD				0x03
+#define DPTX_WRITE_DPCD				0x04
+#define DPTX_ENABLE_EVENT			0x05
+#define DPTX_WRITE_REGISTER			0x06
+#define DPTX_READ_REGISTER			0x07
+#define DPTX_WRITE_FIELD			0x08
+#define DPTX_TRAINING_CONTROL			0x09
+#define DPTX_READ_EVENT				0x0a
+#define DPTX_READ_LINK_STAT			0x0b
+#define DPTX_SET_VIDEO				0x0c
+#define DPTX_SET_AUDIO				0x0d
+#define DPTX_GET_LAST_AUX_STAUS			0x0e
+#define DPTX_SET_LINK_BREAK_POINT		0x0f
+#define DPTX_FORCE_LANES			0x10
+#define DPTX_HPD_STATE				0x11
+
+#define DPTX_EVENT_ENABLE_HPD			BIT(0)
+#define DPTX_EVENT_ENABLE_TRAINING		BIT(1)
+
+#define LINK_TRAINING_NOT_ACTIVE		0
+#define LINK_TRAINING_RUN			1
+#define LINK_TRAINING_RESTART			2
+
+#define CONTROL_VIDEO_IDLE			0
+#define CONTROL_VIDEO_VALID			1
+
+#define VIF_BYPASS_INTERLACE			BIT(13)
+#define INTERLACE_FMT_DET			BIT(12)
+#define INTERLACE_DTCT_WIN			0x20
+
+#define DP_FRAMER_SP_INTERLACE_EN		BIT(2)
+#define DP_FRAMER_SP_HSP			BIT(1)
+#define DP_FRAMER_SP_VSP			BIT(0)
+
+/* capability */
+#define AUX_HOST_INVERT				3
+#define	FAST_LT_SUPPORT				1
+#define FAST_LT_NOT_SUPPORT			0
+#define LANE_MAPPING_NORMAL			0xe4
+#define LANE_MAPPING_FLIPPED			0x1b
+#define ENHANCED				1
+
+#define	FULL_LT_STARTED				BIT(0)
+#define FASE_LT_STARTED				BIT(1)
+#define CLK_RECOVERY_FINISHED			BIT(2)
+#define EQ_PHASE_FINISHED			BIT(3)
+#define FASE_LT_START_FINISHED			BIT(4)
+#define CLK_RECOVERY_FAILED			BIT(5)
+#define EQ_PHASE_FAILED				BIT(6)
+#define FASE_LT_FAILED				BIT(7)
+
+#define DPTX_HPD_EVENT				BIT(0)
+#define DPTX_TRAINING_EVENT			BIT(1)
+#define HDCP_TX_STATUS_EVENT			BIT(4)
+#define HDCP2_TX_IS_KM_STORED_EVENT		BIT(5)
+#define HDCP2_TX_STORE_KM_EVENT			BIT(6)
+#define HDCP_TX_IS_RECEIVER_ID_VALID_EVENT	BIT(7)
+
+#define EDID_LENGTH_BYTE			0
+#define EDID_SEGMENT_BUMBER			1
+#define EDID_DATA				2
+#define EDID_BLOCK_SIZE				128
+
+#define TU_SIZE					64
+
+/* audio */
+#define AUDIO_PACK_EN(x)			(x << 8)
+#define SAMPLING_FREQ(x)			(x << 16)
+#define ORIGINAL_SAMP_FREQ(x)			(x << 24)
+#define SYNC_WR_TO_CH_ZERO			BIT(1)
+
+enum voltage_swing_level {
+	VOLTAGE_LEVEL_0,
+	VOLTAGE_LEVEL_1,
+	VOLTAGE_LEVEL_2,
+	VOLTAGE_LEVEL_3,
+};
+
+enum pre_emphasis_level {
+	PRE_EMPHASIS_LEVEL_0,
+	PRE_EMPHASIS_LEVEL_1,
+	PRE_EMPHASIS_LEVEL_2,
+	PRE_EMPHASIS_LEVEL_3,
+};
+
+enum pattern_set {
+	PRBS7		= BIT(0),
+	D10_2		= BIT(1),
+	TRAINING_PTN1	= BIT(2),
+	TRAINING_PTN2	= BIT(3),
+	DP_NONE		= BIT(4)
+};
+
+enum VIC_PXL_ENCODING_FORMAT {
+	PXL_RGB = 0x1,
+	YCBCR_4_4_4 = 0x2,
+	YCBCR_4_2_2 = 0x4,
+	YCBCR_4_2_0 = 0x8,
+	Y_ONLY = 0x10,
+};
+
+enum VIC_COLOR_DEPTH {
+	BCS_6 = 0x1,
+	BCS_8 = 0x2,
+	BCS_10 = 0x4,
+	BCS_12 = 0x8,
+	BCS_16 = 0x10,
+};
+
+#endif /* _CDN_DP_REG_H */
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index edd7ec2..623d9e3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -969,7 +969,10 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 		vop_dsp_hold_valid_irq_disable(vop);
 	}
 
-	pin_pol = 0x8;
+	if (s->output_type != DRM_MODE_CONNECTOR_DisplayPort)
+		pin_pol = 0x8;
+	else
+		pin_pol = 0;
 	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC) ? 0 : 1;
 	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC) ? 0 : (1 << 1);
 	VOP_CTRL_SET(vop, pin_pol, pin_pol);
@@ -991,6 +994,10 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 		VOP_CTRL_SET(vop, mipi_pin_pol, pin_pol);
 		VOP_CTRL_SET(vop, mipi_en, 1);
 		break;
+	case DRM_MODE_CONNECTOR_DisplayPort:
+		VOP_CTRL_SET(vop, dp_pin_pol, pin_pol);
+		VOP_CTRL_SET(vop, dp_en, 1);
+		break;
 	default:
 		DRM_ERROR("unsupport connector_type[%d]\n", s->output_type);
 	}
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index ff4f52e..50a045c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -45,6 +45,7 @@ struct vop_ctrl {
 	struct vop_reg edp_en;
 	struct vop_reg hdmi_en;
 	struct vop_reg mipi_en;
+	struct vop_reg dp_en;
 	struct vop_reg out_mode;
 	struct vop_reg dither_down;
 	struct vop_reg dither_up;
@@ -53,6 +54,7 @@ struct vop_ctrl {
 	struct vop_reg hdmi_pin_pol;
 	struct vop_reg edp_pin_pol;
 	struct vop_reg mipi_pin_pol;
+	struct vop_reg dp_pin_pol;
 
 	struct vop_reg htotal_pw;
 	struct vop_reg hact_st_end;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 5b1ae1f..dcf172e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -281,6 +281,7 @@ static const struct vop_data rk3288_vop = {
 static const struct vop_ctrl rk3399_ctrl_data = {
 	.standby = VOP_REG(RK3399_SYS_CTRL, 0x1, 22),
 	.gate_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 23),
+	.dp_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 11),
 	.rgb_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 12),
 	.hdmi_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 13),
 	.edp_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 14),
@@ -290,6 +291,7 @@ static const struct vop_ctrl rk3399_ctrl_data = {
 	.data_blank = VOP_REG(RK3399_DSP_CTRL0, 0x1, 19),
 	.out_mode = VOP_REG(RK3399_DSP_CTRL0, 0xf, 0),
 	.rgb_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0xf, 16),
+	.dp_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0xf, 16),
 	.hdmi_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0xf, 20),
 	.edp_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0xf, 24),
 	.mipi_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0xf, 28),
diff --git a/include/sound/cdn-dp-audio.h b/include/sound/cdn-dp-audio.h
new file mode 100644
index 0000000..8c6e55c
--- /dev/null
+++ b/include/sound/cdn-dp-audio.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2016 Chris Zhong <zyw@rock-chips.com>
+ * Copyright (C) 2016 ROCKCHIP, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __CDN_DP_AUDIO_H__
+#define __CDN_DP_AUDIO_H__
+
+#include <linux/platform_device.h>
+
+#define AUDIO_TYPE_I2S			0
+#define AUDIO_TYPE_SPIDIF_INTERNAL	1
+#define AUDIO_TYPE_SPIDIF_EXTERNAL	2
+
+enum AUDIO_TYPE {
+	TYPE_I2S = 0,
+	TYPE_SPDIF = 1,
+};
+
+struct audio_info {
+	enum AUDIO_TYPE type;
+	int freq;
+	int channels;
+	int word_length;
+};
+
+struct cdn_dp_audio_ops {
+	int (*audio_startup)(void *dp_dev, struct audio_info *audio);
+	int (*audio_shutdown)(void *dp_dev, struct audio_info *audio);
+	int (*audio_start)(void *dp_dev, struct audio_info *audio);
+	int (*audio_stop)(void *dp_dev, struct audio_info *audio);
+	int (*audio_config)(void *dp_dev, struct audio_info *audio);
+};
+
+/* DP audio initalization data */
+struct cdn_dp_audio_pdata {
+	struct device *dev;
+	const struct cdn_dp_audio_ops *ops;
+	void *data;
+};
+
+#endif /* __CDN_DP_AUDIO_H__ */
-- 
2.6.3
