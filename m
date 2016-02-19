From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 19 Feb 2016 10:12:25 +0100
Subject: [PATCH v10 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1455870678-13959-2-git-send-email-jitao.shi@mediatek.com>
References: <1455870678-13959-1-git-send-email-jitao.shi@mediatek.com>
 <1455870678-13959-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <1455873145.5745.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 19.02.2016, 16:31 +0800 schrieb Jitao Shi:
> This patch adds drm_bridge driver for parade DSI to eDP bridge chip.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
> Changes since v9:
>  - replace dev_kmalloc with devm_kmalloc in ps8640_get_modes
>  - remove ps_bridge->dsi = devm_kzalloc(dev, sizeof(struct mipi_dsi_device),
> 					GFP_KERNEL);
>  - fix wrong condition in ps8640_validate_firmware()
> 
> The following patches are needed to support dsi host through none dsi bus:
> 
> https://patchwork.kernel.org/patch/8289181/ ("drm/dsi: check for CONFIG_OF when defining")
> https://patchwork.kernel.org/patch/8289051/ ("drm/dsi: Use mipi_dsi_device_register_full for DSI device")
> https://patchwork.kernel.org/patch/8289081/ ("drm/dsi: Try to match non-DT DSI devices")
> https://patchwork.kernel.org/patch/8289121/ ("drm/dsi: Add routine to unregister a DSI device")
> https://patchwork.kernel.org/patch/8289091/ ("drm/dsi: Get DSI host by DT device node")
> ---
>  drivers/gpu/drm/bridge/Kconfig         |   11 +
>  drivers/gpu/drm/bridge/Makefile        |    1 +
>  drivers/gpu/drm/bridge/parade-ps8640.c | 1057 ++++++++++++++++++++++++++++++++
>  3 files changed, 1069 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/parade-ps8640.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 27e2022..b4edd8c 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -40,4 +40,15 @@ config DRM_PARADE_PS8622
>  	---help---
>  	  Parade eDP-LVDS bridge chip driver.
>  
> +config DRM_PARADE_PS8640
> +	tristate "Parade PS8640 MIPI DSI to eDP Converter"
> +	depends on OF && I2C
> +	select DRM_KMS_HELPER
> +	select DRM_MIPI_DSI
> +	select DRM_PANEL
> +	---help---
> +	  Choose this option if you have PS8640 for display
> +	  The PS8640 is a high-performance and low-power
> +	  MIPI DSI to eDP converter
> +
>  endmenu
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index f13c33d..fbe38dc 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
>  obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
>  obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
>  obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
> +obj-$(CONFIG_DRM_PARADE_PS8640) += parade-ps8640.o
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> new file mode 100644
> index 0000000..5f27548
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -0,0 +1,1057 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_graph.h>
> +#include <linux/regulator/consumer.h>
> +#include <asm/unaligned.h>
> +#include <drm/drm_panel.h>
> +
> +#include <drmP.h>
> +#include <drm_atomic_helper.h>
> +#include <drm_crtc_helper.h>
> +#include <drm_crtc.h>
> +#include <drm_edid.h>
> +#include <drm_mipi_dsi.h>
> +
> +#define PAGE2_SPI_CFG3		0x82
> +#define I2C_TO_SPI_RESET	0x20
> +#define PAGE2_ROMADD_BYTE1	0x8e
> +#define PAGE2_ROMADD_BYTE2	0x8f
> +#define PAGE2_SWSPI_WDATA	0x90
> +#define PAGE2_SWSPI_RDATA	0x91
> +#define PAGE2_SWSPI_LEN		0x92
> +#define PAGE2_SWSPI_CTL		0x93
> +#define TRIGGER_NO_READBACK	0x05
> +#define TRIGGER_READBACK	0x01
> +#define PAGE2_SPI_STATUS	0x9e
> +#define PAGE2_GPIO_L		0xa6
> +#define PAGE2_GPIO_H		0xa7
> +#define PS_GPIO9		BIT(1)
> +#define PAGE2_IROM_CTRL		0xb0
> +#define IROM_ENABLE		0xc0
> +#define IROM_DISABLE		0x80
> +#define PAGE2_SW_REST		0xbc
> +#define SPI_SW_RESET		BIT(7)
> +#define MPU_SW_RESET		BIT(6)
> +#define PAGE2_ENCTLSPI_WR	0xda
> +#define PAGE2_I2C_BYPASS	0xea
> +#define I2C_BYPASS_EN		0xd0
> +#define PAGE3_SET_ADD		0xfe
> +#define PAGE3_SET_VAL		0xff
> +#define VDO_CTL_ADD		0x13
> +#define VDO_DIS			0x18
> +#define VDO_EN			0x1c
> +#define PAGE4_REV_L		0xf0
> +#define PAGE4_REV_H		0xf1
> +#define PAGE4_CHIP_L		0xf2
> +#define PAGE4_CHIP_H		0xf3
> +
> +/* Firmware */
> +#define SPI_MAX_RETRY_CNT	8
> +#define PS_FW_NAME		"ps864x_fw.bin"
> +
> +#define FW_CHIP_ID_OFFSET	0
> +#define FW_VERSION_OFFSET	2
> +#define EDID_I2C_ADDR		0x50
> +
> +#define WRITE_STATUS_REG_CMD	0x01
> +#define READ_STATUS_REG_CMD	0x05
> +#define CLEAR_ALL_PROTECT	0x00
> +#define BLK_PROTECT_BITS	0x0c
> +#define STATUS_REG_PROTECT	BIT(7)
> +#define WRITE_ENABLE_CMD	0x06
> +#define CHIP_ERASE_CMD		0xc7
> +
> +#define bridge_to_ps8640(e)	container_of(e, struct ps8640, bridge)
> +#define connector_to_ps8640(e)	container_of(e, struct ps8640, connector)
> +
> +struct ps8640_info {
> +	u8 family_id;
> +	u8 variant_id;
> +	u16 version;
> +};
> +
> +struct ps8640 {
> +	struct drm_connector connector;
> +	struct drm_bridge bridge;
> +	struct edid *edid;
> +	struct mipi_dsi_device dsi;
> +	struct i2c_client *page[8];
> +	struct i2c_client *ddc_i2c;
> +	struct regulator_bulk_data supplies[2];
> +	struct drm_panel *panel;
> +	struct gpio_desc *gpio_rst_n;
> +	struct gpio_desc *gpio_slp_n;
> +	struct gpio_desc *gpio_mode_sel_n;
> +	bool enabled;
> +
> +	/* firmware file info */
> +	bool in_fw_update;
> +	struct ps8640_info info;
> +};
> +
> +static const u8 enc_ctrl_code[6] = {0xaa, 0x55, 0x50, 0x41, 0x52, 0x44};
> +
> +static int ps8640_read(struct i2c_client *client, u8 reg, u8 *data,
> +		       u16 data_len)
> +{
> +	int ret;
> +	struct i2c_msg msgs[] = {
> +		{
> +		 .addr = client->addr,
> +		 .flags = 0,
> +		 .len = 1,
> +		 .buf = &reg,
> +		 },
> +		{
> +		 .addr = client->addr,
> +		 .flags = I2C_M_RD,
> +		 .len = data_len,
> +		 .buf = data,
> +		 }
> +	};
> +
> +	ret = i2c_transfer(client->adapter, msgs, 2);
> +
> +	if (ret == 2)
> +		return 0;
> +	if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;
> +}
> +
> +static int ps8640_write_bytes(struct i2c_client *client, u8 *data,
> +			      u16 data_len)
> +{
> +	int ret;
> +	struct i2c_msg msg;
> +
> +	msg.addr = client->addr;
> +	msg.flags = 0;
> +	msg.len = data_len;
> +	msg.buf = data;
> +
> +	ret = i2c_transfer(client->adapter, &msg, 1);
> +	if (ret == 1)
> +		return 0;
> +	if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;
> +}
> +
> +static int ps8640_write_byte(struct i2c_client *client, u8 reg,  u8 data)
> +{
> +	int ret;
> +	struct i2c_msg msg;
> +	u8 buf[] = {reg, data};
> +
> +	msg.addr = client->addr;
> +	msg.flags = 0;
> +	msg.len = sizeof(buf);
> +	msg.buf = buf;
> +
> +	ret = i2c_transfer(client->adapter, &msg, 1);
> +	if (ret == 1)
> +		return 0;
> +	if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;
> +}
> +
> +static void ps8640_get_mcu_fw_version(struct ps8640 *ps_bridge)
> +{
> +	struct i2c_client *client = ps_bridge->page[5];
> +	u8 fw_ver[2];
> +
> +	ps8640_read(client, 0x4, fw_ver, 2);
> +	ps_bridge->info.version = (fw_ver[0] << 8) | fw_ver[1];
> +
> +	DRM_INFO_ONCE("ps8640 rom fw version %d.%d\n", fw_ver[0], fw_ver[1]);
> +}
> +
> +static int ps8640_bridge_enable(struct ps8640 *ps_bridge)
> +{
> +	struct i2c_client *client = ps_bridge->page[3];
> +	u8 vdo_ctrl_buf[3] = {PAGE3_SET_ADD, VDO_CTL_ADD, VDO_EN};
> +
> +	return ps8640_write_bytes(client, vdo_ctrl_buf, 3);
> +}
> +
> +static int ps8640_bridge_disable(struct ps8640 *ps_bridge)
> +{
> +	struct i2c_client *client = ps_bridge->page[3];
> +	u8 vdo_ctrl_buf[3] = {PAGE3_SET_ADD, VDO_CTL_ADD, VDO_DIS};
> +
> +	return ps8640_write_bytes(client, vdo_ctrl_buf, 3);
> +}
> +
> +static void ps8640_pre_enable(struct drm_bridge *bridge)
> +{
> +	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +	struct i2c_client *client = ps_bridge->page[2];
> +	int err, retry_cnt = 0;
> +	u8 set_vdo_done;
> +
> +	if (ps_bridge->in_fw_update)
> +		return;
> +
> +	if (ps_bridge->enabled)
> +		return;
> +
> +	err = drm_panel_prepare(ps_bridge->panel);
> +	if (err < 0) {
> +		DRM_ERROR("failed to prepare panel: %d\n", err);
> +		return;
> +	}
> +
> +	gpiod_set_value(ps_bridge->gpio_slp_n, 1);

Is this part:

> +	gpiod_set_value(ps_bridge->gpio_rst_n, 0);
> +
> +	err = regulator_bulk_enable(ARRAY_SIZE(ps_bridge->supplies),
> +				    ps_bridge->supplies);
> +	if (err < 0) {
> +		DRM_ERROR("cannot enable regulators %d\n", err);
> +		goto err_panel_unprepare;
> +	}
> +
> +	usleep_range(500, 700);
> +	gpiod_set_value(ps_bridge->gpio_rst_n, 1);

.. until here an assertion of the reset for 500 ?s plus whatever the
regulator delay is (if any)? It looks like the reset actually is active
low. If so, I think this code should rather be:

	gpiod_set_value(ps_bridge->gpio_rst_n, 1);
	regulator_bulk_enable();
	usleep_range();
	gpiod_set_value(ps_bridge->gpio_rst_n, 0);

And the device tree should contain a reset-gpios property with the
GPIO_ACTIVE_LOW flag set.

Same goes for sleep GPIO, if it is active low, too.

best regards
Philipp
