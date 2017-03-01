From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Wed, 1 Mar 2017 11:38:47 +0100
Subject: [PATCH V2 3/4] drm/bridge: Drivers for
 megachips-stdpxxxx-ge-b850v3-fw (LVDS-DP++)
In-Reply-To: <8f61b5c1-3c99-6657-2c0b-41a070b322af@codeaurora.org>
References: <cover.1488287639.git.peter.senna@collabora.com>
 <5278cd3e4c409ace0d62d6aedcc555b38b8a89a9.1488287639.git.peter.senna@collabora.com>
 <8f61b5c1-3c99-6657-2c0b-41a070b322af@codeaurora.org>
Message-ID: <20170301103847.GC15134@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Archit,

Thank you for the review!

On Wed, Mar 01, 2017 at 09:38:48AM +0530, Archit Taneja wrote:
> 
> 
> On 02/28/2017 07:58 PM, Peter Senna Tschudin wrote:
> > The video processing pipeline on the second output on the GE B850v3:
> > 
> >   Host -> LVDS|--(STDP4028)--|DP -> DP|--(STDP2690)--|DP++ -> Video output
> > 
> > Each bridge has a dedicated flash containing firmware for supporting the
> > custom design. The result is that in this design neither the STDP4028
> > nor the STDP2690 behave as the stock bridges would. The compatible
> > strings include the suffix "-ge-b850v3-fw" to make it clear that the
> > driver is for the bridges with the firmware which is specific for the GE
> > B850v3.
> > 
> > The driver is powerless to control the video processing pipeline, as the
> > two bridges behaves as a single one. The driver is only needed for
> > telling the host about EDID / HPD, and for giving the host powers to ack
> > interrupts.
> > 
> > This driver adds one i2c_device for each bridge, but only one
> > drm_bridge. This design allows the creation of a functional connector
> > that is capable of reading EDID from the STDP2690 while handling
> > interrupts on the STDP4028.
> > 
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Martyn Welch <martyn.welch@collabora.co.uk>
> > Cc: Martin Donnelly <martin.donnelly@ge.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Archit Taneja <architt@codeaurora.org>
> > Cc: Enric Balletbo <enric.balletbo@collabora.com>
> > Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> > ---
> > Changes from V1:
> >  - Updated copyright year
> >  - Fixed blank line issues
> >  - Updated ge_b850v3_lvds_remove() to not rely on ge_b850v3_lvds_ptr->edid and
> >    added a comment to explain the test.
> >  - Fixed checkpatch strict warnings about continuation lines. In one case
> >    fixing the warning would cause the continuation line to be over 80 chars and
> >    that strict warning remains.
> > 
> >  drivers/gpu/drm/bridge/Kconfig                     |  11 +
> >  drivers/gpu/drm/bridge/Makefile                    |   1 +
> >  .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   | 411 +++++++++++++++++++++
> >  3 files changed, 423 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > 
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index eb8688e..4a937f1 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -48,6 +48,17 @@ config DRM_DW_HDMI_I2S_AUDIO
> >  	  Support the I2S Audio interface which is part of the Synopsis
> >  	  Designware HDMI block.
> > 
> > +config DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW
> > +	tristate "MegaChips stdp4028-ge-b850v3-fw and stdp2690-ge-b850v3-fw"
> > +	depends on OF
> > +	select DRM_KMS_HELPER
> > +	select DRM_PANEL
> > +	---help---
> > +          This is a driver for the display bridges of
> > +          GE B850v3 that convert dual channel LVDS
> > +          to DP++. This is used with the i.MX6 imx-ldb
> > +          driver. You are likely to say N here.
> > +
> >  config DRM_NXP_PTN3460
> >  	tristate "NXP PTN3460 DP/LVDS bridge"
> >  	depends on OF
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> > index 2e83a785..af0b7cc 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -5,6 +5,7 @@ obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
> >  obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
> >  obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
> >  obj-$(CONFIG_DRM_DW_HDMI_I2S_AUDIO) += dw-hdmi-i2s-audio.o
> > +obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
> >  obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
> >  obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
> >  obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
> > diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > new file mode 100644
> > index 0000000..6f82a44
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > @@ -0,0 +1,411 @@
> > +/*
> > + * Driver for MegaChips STDP4028 with GE B850v3 firmware (LVDS-DP)
> > + * Driver for MegaChips STDP2690 with GE B850v3 firmware (DP-DP++)
> > +
> > + * Copyright (c) 2017, Collabora Ltd.
> > + * Copyright (c) 2017, General Electric Company
> > +
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > +
> > + * This program is distributed in the hope it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > +
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > +
> > + * This driver creates a drm_bridge and a drm_connector for the LVDS to DP++
> > + * display bridge of the GE B850v3. There are two physical bridges on the video
> > + * signal pipeline: a STDP4028(LVDS to DP) and a STDP2690(DP to DP++). The
> > + * physical bridges are automatically configured by the input video signal, and
> > + * the driver has no access to the video processing pipeline. The driver is
> > + * only needed to read EDID from the STDP2690 and to handle HPD events from the
> > + * STDP4028. The driver communicates with both bridges over i2c. The video
> > + * signal pipeline is as follows:
> > + *
> > + *   Host -> LVDS|--(STDP4028)--|DP -> DP|--(STDP2690)--|DP++ -> Video output
> > + *
> > + */
> > +
> > +#include <linux/gpio.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <drm/drm_atomic.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_edid.h>
> > +#include <drm/drmP.h>
> > +
> > +#define EDID_EXT_BLOCK_CNT 0x7E
> > +
> > +#define STDP4028_IRQ_OUT_CONF_REG 0x02
> > +#define STDP4028_DPTX_IRQ_EN_REG 0x3C
> > +#define STDP4028_DPTX_IRQ_STS_REG 0x3D
> > +#define STDP4028_DPTX_STS_REG 0x3E
> > +
> > +#define STDP4028_DPTX_DP_IRQ_EN 0x1000
> > +
> > +#define STDP4028_DPTX_HOTPLUG_IRQ_EN 0x0400
> > +#define STDP4028_DPTX_LINK_CH_IRQ_EN 0x2000
> > +#define STDP4028_DPTX_IRQ_CONFIG \
> > +		(STDP4028_DPTX_LINK_CH_IRQ_EN | STDP4028_DPTX_HOTPLUG_IRQ_EN)
> > +
> > +#define STDP4028_DPTX_HOTPLUG_STS 0x0200
> > +#define STDP4028_DPTX_LINK_STS 0x1000
> > +#define STDP4028_CON_STATE_CONNECTED \
> > +		(STDP4028_DPTX_HOTPLUG_STS | STDP4028_DPTX_LINK_STS)
> > +
> > +#define STDP4028_DPTX_HOTPLUG_CH_STS 0x0400
> > +#define STDP4028_DPTX_LINK_CH_STS 0x2000
> > +#define STDP4028_DPTX_IRQ_CLEAR \
> > +		(STDP4028_DPTX_LINK_CH_STS | STDP4028_DPTX_HOTPLUG_CH_STS)
> > +
> > +static DEFINE_MUTEX(ge_b850v3_lvds_dev_mutex);
> > +
> > +struct ge_b850v3_lvds {
> > +	struct drm_connector connector;
> > +	struct drm_bridge bridge;
> > +	struct i2c_client *stdp4028_i2c;
> > +	struct i2c_client *stdp2690_i2c;
> > +	struct edid *edid;
> > +};
> > +
> > +static struct ge_b850v3_lvds *ge_b850v3_lvds_ptr;
> > +
> > +u8 *stdp2690_get_edid(struct i2c_client *client)
> > +{
> > +	struct i2c_adapter *adapter = client->adapter;
> > +	unsigned char start = 0x00;
> > +	unsigned int total_size;
> > +	u8 *block = kmalloc(EDID_LENGTH, GFP_KERNEL);
> > +
> > +	struct i2c_msg msgs[] = {
> > +		{
> > +			.addr	= client->addr,
> > +			.flags	= 0,
> > +			.len	= 1,
> > +			.buf	= &start,
> > +		}, {
> > +			.addr	= client->addr,
> > +			.flags	= I2C_M_RD,
> > +			.len	= EDID_LENGTH,
> > +			.buf	= block,
> > +		}
> > +	};
> > +
> > +	if (!block)
> > +		return NULL;
> > +
> > +	if (i2c_transfer(adapter, msgs, 2) != 2) {
> > +		DRM_ERROR("Unable to read EDID.\n");
> > +		goto err;
> > +	}
> > +
> > +	if (!drm_edid_block_valid(block, 0, false, NULL)) {
> > +		DRM_ERROR("Invalid EDID data\n");
> > +		goto err;
> > +	}
> > +
> > +	total_size = (block[EDID_EXT_BLOCK_CNT] + 1) * EDID_LENGTH;
> > +	if (total_size > EDID_LENGTH) {
> > +		kfree(block);
> > +		block = kmalloc(total_size, GFP_KERNEL);
> > +		if (!block)
> > +			return NULL;
> > +
> > +		/* Yes, read the entire buffer, and do not skip the first
> > +		 * EDID_LENGTH bytes.
> > +		 */
> > +		start = 0x00;
> > +		msgs[1].len = total_size;
> > +		msgs[1].buf = block;
> > +
> > +		if (i2c_transfer(adapter, msgs, 2) != 2) {
> > +			DRM_ERROR("Unable to read EDID extension blocks.\n");
> > +			goto err;
> > +		}
> > +		if (!drm_edid_block_valid(block, 1, false, NULL)) {
> > +			DRM_ERROR("Invalid EDID data\n");
> > +			goto err;
> > +		}
> > +	}
> > +
> > +	return block;
> > +
> > +err:
> > +	kfree(block);
> > +	return NULL;
> > +}
> > +
> > +static int ge_b850v3_lvds_get_modes(struct drm_connector *connector)
> > +{
> > +	struct i2c_client *client;
> > +	int num_modes = 0;
> > +
> > +	client = ge_b850v3_lvds_ptr->stdp2690_i2c;
> > +
> > +	kfree(ge_b850v3_lvds_ptr->edid);
> > +	ge_b850v3_lvds_ptr->edid = (struct edid *)stdp2690_get_edid(client);
> > +
> > +	if (ge_b850v3_lvds_ptr->edid) {
> > +		drm_mode_connector_update_edid_property(connector,
> > +						      ge_b850v3_lvds_ptr->edid);
> > +		num_modes = drm_add_edid_modes(connector,
> > +					       ge_b850v3_lvds_ptr->edid);
> > +	}
> > +
> > +	return num_modes;
> > +}
> > +
> > +static enum drm_mode_status ge_b850v3_lvds_mode_valid(
> > +		struct drm_connector *connector, struct drm_display_mode *mode)
> > +{
> > +	return MODE_OK;
> > +}
> > +
> > +static const struct
> > +drm_connector_helper_funcs ge_b850v3_lvds_connector_helper_funcs = {
> > +	.get_modes = ge_b850v3_lvds_get_modes,
> > +	.mode_valid = ge_b850v3_lvds_mode_valid,
> > +};
> > +
> > +static enum drm_connector_status ge_b850v3_lvds_detect(
> > +		struct drm_connector *connector, bool force)
> > +{
> > +	struct i2c_client *stdp4028_i2c =
> > +			ge_b850v3_lvds_ptr->stdp4028_i2c;
> > +	s32 link_state;
> > +
> > +	link_state = i2c_smbus_read_word_data(stdp4028_i2c,
> > +					      STDP4028_DPTX_STS_REG);
> > +
> > +	if (link_state == STDP4028_CON_STATE_CONNECTED)
> > +		return connector_status_connected;
> > +
> > +	if (link_state == 0)
> > +		return connector_status_disconnected;
> > +
> > +	return connector_status_unknown;
> > +}
> > +
> > +static const struct drm_connector_funcs ge_b850v3_lvds_connector_funcs = {
> > +	.dpms = drm_atomic_helper_connector_dpms,
> > +	.fill_modes = drm_helper_probe_single_connector_modes,
> > +	.detect = ge_b850v3_lvds_detect,
> > +	.destroy = drm_connector_cleanup,
> > +	.reset = drm_atomic_helper_connector_reset,
> > +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> > +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > +};
> > +
> > +static irqreturn_t ge_b850v3_lvds_irq_handler(int irq, void *dev_id)
> > +{
> > +	struct i2c_client *stdp4028_i2c
> > +			= ge_b850v3_lvds_ptr->stdp4028_i2c;
> > +
> > +	i2c_smbus_write_word_data(stdp4028_i2c,
> > +				  STDP4028_DPTX_IRQ_STS_REG,
> > +				  STDP4028_DPTX_IRQ_CLEAR);
> > +
> > +	if (ge_b850v3_lvds_ptr->connector.dev)
> > +		drm_kms_helper_hotplug_event(ge_b850v3_lvds_ptr->connector.dev);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int ge_b850v3_lvds_attach(struct drm_bridge *bridge)
> > +{
> > +	struct drm_connector *connector = &ge_b850v3_lvds_ptr->connector;
> > +	struct i2c_client *stdp4028_i2c
> > +			= ge_b850v3_lvds_ptr->stdp4028_i2c;
> > +	int ret;
> > +
> > +	if (!bridge->encoder) {
> > +		DRM_ERROR("Parent encoder object not found");
> > +		return -ENODEV;
> > +	}
> > +
> > +	connector->polled = DRM_CONNECTOR_POLL_HPD;
> > +
> > +	drm_connector_helper_add(connector,
> > +				 &ge_b850v3_lvds_connector_helper_funcs);
> > +
> > +	ret = drm_connector_init(bridge->dev, connector,
> > +				 &ge_b850v3_lvds_connector_funcs,
> > +				 DRM_MODE_CONNECTOR_DisplayPort);
> > +	if (ret) {
> > +		DRM_ERROR("Failed to initialize connector with drm\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = drm_mode_connector_attach_encoder(connector, bridge->encoder);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Configures the bridge to re-enable interrupts after each ack. */
> > +	i2c_smbus_write_word_data(stdp4028_i2c,
> > +				  STDP4028_IRQ_OUT_CONF_REG,
> > +				  STDP4028_DPTX_DP_IRQ_EN);
> > +
> > +	/* Enable interrupts */
> > +	i2c_smbus_write_word_data(stdp4028_i2c,
> > +				  STDP4028_DPTX_IRQ_EN_REG,
> > +				  STDP4028_DPTX_IRQ_CONFIG);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct drm_bridge_funcs ge_b850v3_lvds_funcs = {
> > +	.attach = ge_b850v3_lvds_attach,
> > +};
> > +
> > +static int ge_b850v3_lvds_init(struct device *dev)
> > +{
> > +	mutex_lock(&ge_b850v3_lvds_dev_mutex);
> > +
> > +	if (ge_b850v3_lvds_ptr)
> > +		goto success;
> > +
> > +	ge_b850v3_lvds_ptr = devm_kzalloc(dev,
> > +					  sizeof(*ge_b850v3_lvds_ptr),
> > +					  GFP_KERNEL);
> > +
> > +	if (!ge_b850v3_lvds_ptr) {
> > +		mutex_unlock(&ge_b850v3_lvds_dev_mutex);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ge_b850v3_lvds_ptr->bridge.funcs = &ge_b850v3_lvds_funcs;
> > +	ge_b850v3_lvds_ptr->bridge.of_node = dev->of_node;
> > +	drm_bridge_add(&ge_b850v3_lvds_ptr->bridge);
> > +
> > +success:
> > +	mutex_unlock(&ge_b850v3_lvds_dev_mutex);
> > +	return 0;
> > +}
> > +
> > +static void ge_b850v3_lvds_remove(void)
> > +{
> > +	mutex_lock(&ge_b850v3_lvds_dev_mutex);
> > +	/*
> > +	 * This check is to avoid both the drivers
> > +	 * removing the bridge in their remove() function
> > +	 */
> > +	if (!ge_b850v3_lvds_ptr)
> > +		goto out;
> > +
> > +	drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
> > +
> > +	kfree(ge_b850v3_lvds_ptr->edid);
> > +
> > +	ge_b850v3_lvds_ptr = NULL;
> > +out:
> > +	mutex_unlock(&ge_b850v3_lvds_dev_mutex);
> > +}
> > +
> > +static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c,
> > +				       const struct i2c_device_id *id)
> > +{
> > +	struct device *dev = &stdp4028_i2c->dev;
> > +
> > +	ge_b850v3_lvds_init(dev);
> > +
> > +	ge_b850v3_lvds_ptr->stdp4028_i2c = stdp4028_i2c;
> > +	i2c_set_clientdata(stdp4028_i2c, ge_b850v3_lvds_ptr);
> > +
> > +	/* Clear pending interrupts since power up. */
> > +	i2c_smbus_write_word_data(stdp4028_i2c,
> > +				  STDP4028_DPTX_IRQ_STS_REG,
> > +				  STDP4028_DPTX_IRQ_CLEAR);
> > +
> > +	if (!stdp4028_i2c->irq)
> > +		return 0;
> > +
> > +	return devm_request_threaded_irq(&stdp4028_i2c->dev,
> > +			stdp4028_i2c->irq, NULL,
> > +			ge_b850v3_lvds_irq_handler,
> > +			IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +			"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
> > +}
> > +
> > +static int stdp4028_ge_b850v3_fw_remove(struct i2c_client *stdp4028_i2c)
> > +{
> > +	ge_b850v3_lvds_remove();
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id stdp4028_ge_b850v3_fw_i2c_table[] = {
> > +	{"stdp4028_ge_fw", 0},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, stdp4028_ge_b850v3_fw_i2c_table);
> > +
> > +static const struct of_device_id stdp4028_ge_b850v3_fw_match[] = {
> > +	{ .compatible = "megachips,stdp4028-ge-b850v3-fw" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, stdp4028_ge_b850v3_fw_match);
> > +
> > +static struct i2c_driver stdp4028_ge_b850v3_fw_driver = {
> > +	.id_table	= stdp4028_ge_b850v3_fw_i2c_table,
> > +	.probe		= stdp4028_ge_b850v3_fw_probe,
> > +	.remove		= stdp4028_ge_b850v3_fw_remove,
> > +	.driver		= {
> > +		.name		= "stdp4028-ge-b850v3-fw",
> > +		.of_match_table = stdp4028_ge_b850v3_fw_match,
> > +	},
> > +};
> > +module_i2c_driver(stdp4028_ge_b850v3_fw_driver);
> > +
> > +static int stdp2690_ge_b850v3_fw_probe(struct i2c_client *stdp2690_i2c,
> > +				       const struct i2c_device_id *id)
> > +{
> > +	struct device *dev = &stdp2690_i2c->dev;
> > +
> > +	ge_b850v3_lvds_init(dev);
> > +
> > +	ge_b850v3_lvds_ptr->stdp2690_i2c = stdp2690_i2c;
> > +	i2c_set_clientdata(stdp2690_i2c, ge_b850v3_lvds_ptr);
> > +
> > +	return 0;
> > +}
> > +
> > +static int stdp2690_ge_b850v3_fw_remove(struct i2c_client *stdp2690_i2c)
> > +{
> > +	ge_b850v3_lvds_remove();
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id stdp2690_ge_b850v3_fw_i2c_table[] = {
> > +	{"stdp2690_ge_fw", 0},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, stdp2690_ge_b850v3_fw_i2c_table);
> > +
> > +static const struct of_device_id stdp2690_ge_b850v3_fw_match[] = {
> > +	{ .compatible = "megachips,stdp2690-ge-b850v3-fw" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, stdp2690_ge_b850v3_fw_match);
> > +
> > +static struct i2c_driver stdp2690_ge_b850v3_fw_driver = {
> > +	.id_table	= stdp2690_ge_b850v3_fw_i2c_table,
> > +	.probe		= stdp2690_ge_b850v3_fw_probe,
> > +	.remove		= stdp2690_ge_b850v3_fw_remove,
> > +	.driver		= {
> > +		.name		= "stdp2690-ge-b850v3-fw",
> > +		.of_match_table = stdp2690_ge_b850v3_fw_match,
> > +	},
> > +};
> > +module_i2c_driver(stdp2690_ge_b850v3_fw_driver);
> 
> Didn't catch this in the last series, but there can only be one
> module_init call per module. This breaks compilation when the
> driver is built as a module.

Unfortunately yes. Got loads of errors when trying to compile as a
module.

> 
> You could do something like:
> 
> static int __init stdpxxxx_ge_b850v3_init(void)
> {
> 	int ret;
> 
> 	ret = i2c_add_driver(&stdp4028_ge_b850v3_fw_driver);
> 	if (ret)
> 		return ret;
> 
> 	return i2c_add_driver(&stdp2690_ge_b850v3_fw_driver);
> }
> module_init(stdpxxxx_ge_b850v3_init);
> 
> static void __exit stdpxxxx_ge_b850v3_exit(void)
> {
> 	i2c_del_driver(&stdp2690_ge_b850v3_fw_driver);
> 	i2c_del_driver(&stdp4028_ge_b850v3_fw_driver);
> }
> module_exit(stdpxxxx_ge_b850v3_exit);

Thank you! I was wondering if merging ge_b850v3_lvds_init() with
stdpxxxx_ge_b850v3_init() and ge_b850v3_lvds_remove() with
stdpxxxx_ge_b850v3_exit() make sense as it can probably eliminate the
need for the mutex.

> 
> Thanks,
> Archit
> 
> > +
> > +MODULE_AUTHOR("Peter Senna Tschudin <peter.senna@collabora.com>");
> > +MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.co.uk>");
> > +MODULE_DESCRIPTION("GE LVDS to DP++ display bridge)");
> > +MODULE_LICENSE("GPL v2");
> > 
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
