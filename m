From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 26 Sep 2016 15:59:06 +0530
Subject: [PATCH V5 3/4] drm/bridge: Add driver for GE B850v3 LVDS/DP++
 Bridge
In-Reply-To: <37d177d89841be8ff8eec395e3267d1ebf0dfc54.1470739193.git.peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <cover.1470739193.git.peter.senna@collabora.com>
 <37d177d89841be8ff8eec395e3267d1ebf0dfc54.1470739193.git.peter.senna@collabora.com>
Message-ID: <180ae266-a4fb-4432-83dc-e39f2ccb0ad1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some comments.

On 08/09/2016 10:11 PM, Peter Senna Tschudin wrote:
> Add a driver that create a drm_bridge and a drm_connector for the LVDS
> to DP++ display bridge of the GE B850v3.
>
> There are two physical bridges on the video signal pipeline: a
> STDP4028(LVDS to DP) and a STDP2690(DP to DP++).  The hardware and
> firmware made it complicated for this binding to comprise two device
> tree nodes, as the design goal is to configure both bridges based on
> the LVDS signal, which leave the driver powerless to control the video
> processing pipeline. The two bridges behaves as a single bridge, and
> the driver is only needed for telling the host about EDID / HPD, and
> for giving the host powers to ack interrupts. The video signal pipeline
> is as follows:
>
>   Host -> LVDS|--(STDP4028)--|DP -> DP|--(STDP2690)--|DP++ -> Video output
>
> Cc: Martyn Welch <martyn.welch@collabora.co.uk>
> Cc: Martin Donnelly <martin.donnelly@ge.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> CC: David Airlie <airlied@linux.ie>
> CC: Thierry Reding <treding@nvidia.com>
> CC: Thierry Reding <thierry.reding@gmail.com>
> Reviewed-by: Enric Balletbo <enric.balletbo@collabora.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> ---
> Changes from V4:
>  - Check the output of the first call to i2c_smbus_write_word_data() and return
>    it's error code for failing gracefully on i2c issues
>  - Renamed the i2c_driver.name from "ge,b850v3-lvds-dp" to "b850v3-lvds-dp" to
>    remove the comma from the driver name
>
> Changes from V3:
>  - 3/4 instead of 4/5
>  - Tested on next-20160804
>
> Changes from V2:
>  - Made it atomic to be applied on next-20160729 on top of Liu Ying changes
>    that made imx-ldb atomic
>
> Changes from V1:
>  - New commit message
>  - Removed 3 empty entry points
>  - Removed memory leak from ge_b850v3_lvds_dp_get_modes()
>  - Added a lock for mode setting
>  - Removed a few blank lines
>  - Changed the order at Makefile and Kconfig
>
>  MAINTAINERS                                |   8 +
>  drivers/gpu/drm/bridge/Kconfig             |  11 +
>  drivers/gpu/drm/bridge/Makefile            |   1 +
>  drivers/gpu/drm/bridge/ge_b850v3_lvds_dp.c | 405 +++++++++++++++++++++++++++++
>  4 files changed, 425 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/ge_b850v3_lvds_dp.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a306795..e8d106a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5142,6 +5142,14 @@ W:	https://linuxtv.org
>  S:	Maintained
>  F:	drivers/media/radio/radio-gemtek*
>
> +GENERAL ELECTRIC B850V3 LVDS/DP++ BRIDGE
> +M:	Peter Senna Tschudin <peter.senna@collabora.com>
> +M:	Martin Donnelly <martin.donnelly@ge.com>
> +M:	Martyn Welch <martyn.welch@collabora.co.uk>
> +S:	Maintained
> +F:	drivers/gpu/drm/bridge/ge_b850v3_dp2.c
> +F:	Documentation/devicetree/bindings/ge/b850v3_dp2_bridge.txt
> +
>  GENERIC GPIO I2C DRIVER
>  M:	Haavard Skinnemoen <hskinnemoen@gmail.com>
>  S:	Supported

Could you move the MAINTAINERS change to a different patch? It would 
make it easier to integrate separately.

> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index b590e67..b4b70fb 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -32,6 +32,17 @@ config DRM_DW_HDMI_AHB_AUDIO
>  	  Designware HDMI block.  This is used in conjunction with
>  	  the i.MX6 HDMI driver.
>
> +config DRM_GE_B850V3_LVDS_DP
> +	tristate "GE B850v3 LVDS to DP++ display bridge"
> +	depends on OF
> +	select DRM_KMS_HELPER
> +	select DRM_PANEL
> +	---help---
> +          This is a driver for the display bridge of
> +          GE B850v3 that convert dual channel LVDS
> +          to DP++. This is used with the i.MX6 imx-ldb
> +          driver.
> +
>  config DRM_NXP_PTN3460
>  	tristate "NXP PTN3460 DP/LVDS bridge"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index efdb07e..b9606f3 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -3,6 +3,7 @@ ccflags-y := -Iinclude/drm
>  obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
>  obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
>  obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
> +obj-$(CONFIG_DRM_GE_B850V3_LVDS_DP) += ge_b850v3_lvds_dp.o
>  obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
>  obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
>  obj-$(CONFIG_DRM_SII902X) += sii902x.o
> diff --git a/drivers/gpu/drm/bridge/ge_b850v3_lvds_dp.c b/drivers/gpu/drm/bridge/ge_b850v3_lvds_dp.c
> new file mode 100644
> index 0000000..81e9279
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/ge_b850v3_lvds_dp.c
> @@ -0,0 +1,405 @@
> +/*
> + * Driver for GE B850v3 DP display bridge
> +
> + * Copyright (c) 2016, Collabora Ltd.
> + * Copyright (c) 2016, General Electric Company
> +
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> +
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> +
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +
> + * This driver creates a drm_bridge and a drm_connector for the LVDS to DP++
> + * display bridge of the GE B850v3. There are two physical bridges on the video
> + * signal pipeline: a STDP4028(LVDS to DP) and a STDP2690(DP to DP++). However
> + * the physical bridges are automatically configured by the input video signal,
> + * and the driver has no access to the video processing pipeline. The driver is
> + * only needed to read EDID from the STDP2690 and to handle HPD events from the
> + * STDP4028. The driver communicates with both bridges over i2c. The video
> + * signal pipeline is as follows:
> + *
> + *   Host -> LVDS|--(STDP4028)--|DP -> DP|--(STDP2690)--|DP++ -> Video output
> + *
> + */
> +
> +#include <linux/gpio.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_edid.h>
> +#include <drm/drmP.h>
> +
> +/*
> + * 220Mhz is a limitation of the host, as the bridge is capable of up to
> + * 330Mhz. See section 9.2.1.2.4 of the i.MX 6Dual/6Quad Applications
> + * Processor Reference Manual for more information about the 220Mhz limit.
> + * The imx-ldb driver will warn about clocks over 170Mhz, but it seem to work
> + * fine.
> + */
> +#define MAX_PIXEL_CLOCK 220000
> +
> +#define EDID_EXT_BLOCK_CNT 0x7E
> +
> +#define STDP4028_IRQ_OUT_CONF_REG 0x02
> +#define STDP4028_DPTX_IRQ_EN_REG 0x3C
> +#define STDP4028_DPTX_IRQ_STS_REG 0x3D
> +#define STDP4028_DPTX_STS_REG 0x3E
> +
> +#define STDP4028_DPTX_DP_IRQ_EN 0x1000
> +
> +#define STDP4028_DPTX_HOTPLUG_IRQ_EN 0x0400
> +#define STDP4028_DPTX_LINK_CH_IRQ_EN 0x2000
> +#define STDP4028_DPTX_IRQ_CONFIG \
> +		(STDP4028_DPTX_LINK_CH_IRQ_EN | STDP4028_DPTX_HOTPLUG_IRQ_EN)
> +
> +#define STDP4028_DPTX_HOTPLUG_STS 0x0200
> +#define STDP4028_DPTX_LINK_STS 0x1000
> +#define STDP4028_CON_STATE_CONNECTED \
> +		(STDP4028_DPTX_HOTPLUG_STS | STDP4028_DPTX_LINK_STS)
> +
> +#define STDP4028_DPTX_HOTPLUG_CH_STS 0x0400
> +#define STDP4028_DPTX_LINK_CH_STS 0x2000
> +#define STDP4028_DPTX_IRQ_CLEAR \
> +		(STDP4028_DPTX_LINK_CH_STS | STDP4028_DPTX_HOTPLUG_CH_STS)
> +
> +struct ge_b850v3_lvds_dp {
> +	struct drm_connector connector;
> +	struct drm_bridge bridge;
> +	struct i2c_client *ge_b850v3_lvds_dp_i2c;
> +	struct i2c_client *edid_i2c;
> +	struct edid *edid;
> +	struct mutex lock;
> +};
> +
> +static inline struct ge_b850v3_lvds_dp *
> +		bridge_to_ge_b850v3_lvds_dp(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct ge_b850v3_lvds_dp, bridge);
> +}
> +
> +static inline struct ge_b850v3_lvds_dp *
> +		connector_to_ge_b850v3_lvds_dp(struct drm_connector *connector)
> +{
> +	return container_of(connector, struct ge_b850v3_lvds_dp, connector);
> +}
> +
> +u8 *stdp2690_get_edid(struct i2c_client *client)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +	unsigned char start = 0x00;
> +	unsigned int total_size;
> +	u8 *block = kmalloc(EDID_LENGTH, GFP_KERNEL);
> +
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr	= client->addr,
> +			.flags	= 0,
> +			.len	= 1,
> +			.buf	= &start,
> +		}, {
> +			.addr	= client->addr,
> +			.flags	= I2C_M_RD,
> +			.len	= EDID_LENGTH,
> +			.buf	= block,
> +		}
> +	};
> +
> +	if (!block)
> +		return NULL;
> +
> +	if (i2c_transfer(adapter, msgs, 2) != 2) {
> +		DRM_ERROR("Unable to read EDID.\n");
> +		goto err;
> +	}
> +
> +	if (!drm_edid_block_valid(block, 0, false, NULL)) {
> +		DRM_ERROR("Invalid EDID block\n");
> +		goto err;
> +	}
> +
> +	total_size = (block[EDID_EXT_BLOCK_CNT] + 1) * EDID_LENGTH;
> +	if (total_size > EDID_LENGTH) {
> +		kfree(block);
> +		block = kmalloc(total_size, GFP_KERNEL);
> +		if (!block)
> +			return NULL;
> +
> +		/* Yes, read the entire buffer, and do not skip the first
> +		 * EDID_LENGTH bytes.
> +		 */
> +		start = 0x00;
> +		msgs[1].len = total_size;
> +		msgs[1].buf = block;
> +
> +		if (i2c_transfer(adapter, msgs, 2) != 2) {
> +			DRM_ERROR("Unable to read EDID extension blocks.\n");
> +			goto err;
> +		}
> +	}
> +
> +	return block;
> +
> +err:
> +	kfree(block);
> +	return NULL;
> +}
> +
> +static int ge_b850v3_lvds_dp_get_modes(struct drm_connector *connector)
> +{
> +	struct ge_b850v3_lvds_dp *ptn_bridge;
> +	struct i2c_client *client;
> +	int num_modes = 0;
> +
> +	ptn_bridge = connector_to_ge_b850v3_lvds_dp(connector);
> +	client = ptn_bridge->edid_i2c;
> +
> +	mutex_lock(&ptn_bridge->lock);
> +
> +	kfree(ptn_bridge->edid);
> +	ptn_bridge->edid = (struct edid *) stdp2690_get_edid(client);
> +
> +	if (ptn_bridge->edid) {
> +		drm_mode_connector_update_edid_property(connector,
> +				ptn_bridge->edid);
> +		num_modes = drm_add_edid_modes(connector, ptn_bridge->edid);
> +	}
> +
> +	mutex_unlock(&ptn_bridge->lock);
> +
> +	return num_modes;
> +}
> +
> +
> +static enum drm_mode_status ge_b850v3_lvds_dp_mode_valid(
> +		struct drm_connector *connector, struct drm_display_mode *mode)
> +{
> +	if (mode->clock > MAX_PIXEL_CLOCK) {
> +		DRM_INFO("The pixel clock for the mode %s is too high, and not supported.",
> +				mode->name);
> +		return MODE_CLOCK_HIGH;
> +	}
> +
> +	return MODE_OK;
> +}
> +
> +static const struct
> +drm_connector_helper_funcs ge_b850v3_lvds_dp_connector_helper_funcs = {
> +	.get_modes = ge_b850v3_lvds_dp_get_modes,
> +	.mode_valid = ge_b850v3_lvds_dp_mode_valid,
> +};
> +
> +static enum drm_connector_status ge_b850v3_lvds_dp_detect(
> +		struct drm_connector *connector, bool force)
> +{
> +	struct ge_b850v3_lvds_dp *ptn_bridge =
> +			connector_to_ge_b850v3_lvds_dp(connector);
> +	struct i2c_client *ge_b850v3_lvds_dp_i2c =
> +			ptn_bridge->ge_b850v3_lvds_dp_i2c;
> +	s32 link_state;
> +
> +	link_state = i2c_smbus_read_word_data(ge_b850v3_lvds_dp_i2c,
> +			STDP4028_DPTX_STS_REG);
> +
> +	if (link_state == STDP4028_CON_STATE_CONNECTED)
> +		return connector_status_connected;
> +
> +	if (link_state == 0)
> +		return connector_status_disconnected;
> +
> +	return connector_status_unknown;
> +}
> +
> +static const struct drm_connector_funcs ge_b850v3_lvds_dp_connector_funcs = {
> +	.dpms = drm_atomic_helper_connector_dpms,
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.detect = ge_b850v3_lvds_dp_detect,
> +	.destroy = drm_connector_cleanup,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static irqreturn_t ge_b850v3_lvds_dp_irq_handler(int irq, void *dev_id)
> +{
> +	struct ge_b850v3_lvds_dp *ptn_bridge = dev_id;
> +	struct i2c_client *ge_b850v3_lvds_dp_i2c
> +			= ptn_bridge->ge_b850v3_lvds_dp_i2c;
> +
> +	mutex_lock(&ptn_bridge->lock);
> +
> +	i2c_smbus_write_word_data(ge_b850v3_lvds_dp_i2c,
> +			STDP4028_DPTX_IRQ_STS_REG, STDP4028_DPTX_IRQ_CLEAR);
> +
> +	mutex_unlock(&ptn_bridge->lock);
> +
> +	if (ptn_bridge->connector.dev)
> +		drm_kms_helper_hotplug_event(ptn_bridge->connector.dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ge_b850v3_lvds_dp_attach(struct drm_bridge *bridge)
> +{
> +	struct ge_b850v3_lvds_dp *ptn_bridge
> +			= bridge_to_ge_b850v3_lvds_dp(bridge);
> +	struct drm_connector *connector = &ptn_bridge->connector;
> +	struct i2c_client *ge_b850v3_lvds_dp_i2c
> +			= ptn_bridge->ge_b850v3_lvds_dp_i2c;
> +	int ret;
> +
> +	if (!bridge->encoder) {
> +		DRM_ERROR("Parent encoder object not found");
> +		return -ENODEV;
> +	}
> +
> +	connector->polled = DRM_CONNECTOR_POLL_HPD;
> +
> +	drm_connector_helper_add(connector,
> +			&ge_b850v3_lvds_dp_connector_helper_funcs);
> +
> +	ret = drm_connector_init(bridge->dev, connector,
> +			&ge_b850v3_lvds_dp_connector_funcs,
> +			DRM_MODE_CONNECTOR_DisplayPort);
> +	if (ret) {
> +		DRM_ERROR("Failed to initialize connector with drm\n");
> +		return ret;
> +	}
> +
> +	drm_connector_register(connector);

Connectors shouldn't be registered in the bridge driver, they should
be registered by the kms driver after drm_dev_register is called.
The drm_connector_register_all() API is used for that.

> +	ret = drm_mode_connector_attach_encoder(connector, bridge->encoder);
> +	if (ret)
> +		return ret;
> +
> +	drm_bridge_enable(bridge);

This drm_bridge_enable() doesn't seem to serve any purpose here. It also
doesn't seem to make much sense to call drm_bridge_() funcs within a
bridge op itself.

> +	if (ge_b850v3_lvds_dp_i2c->irq) {
> +		drm_helper_hpd_irq_event(connector->dev);
> +
> +		ret = devm_request_threaded_irq(&ge_b850v3_lvds_dp_i2c->dev,
> +				ge_b850v3_lvds_dp_i2c->irq, NULL,
> +				ge_b850v3_lvds_dp_irq_handler,
> +				IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +				"ge-b850v3-lvds-dp", ptn_bridge);

Is there a reason why we register the interrupt handler here and not in
probe?

Thanks,
Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
