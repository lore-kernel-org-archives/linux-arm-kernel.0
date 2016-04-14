From: treding@nvidia.com (Thierry Reding)
Date: Thu, 14 Apr 2016 16:28:27 +0200
Subject: [PATCH v14 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1459657245-8971-2-git-send-email-jitao.shi@mediatek.com>
References: <1459657245-8971-1-git-send-email-jitao.shi@mediatek.com>
 <1459657245-8971-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <20160414142826.GC32237@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 03, 2016 at 12:20:45PM +0800, Jitao Shi wrote:
[...]
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> new file mode 100644
> index 0000000..87f8bc7
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -0,0 +1,1066 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.

Presumably the copyright here should be updated?

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
> +#define PAGE2_SW_RESET		0xbc
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
> +#define BUSY			BIT(0)
> +#define CLEAR_ALL_PROTECT	0x00
> +#define BLK_PROTECT_BITS	0x0c
> +#define STATUS_REG_PROTECT	BIT(7)
> +#define WRITE_ENABLE_CMD	0x06
> +#define CHIP_ERASE_CMD		0xc7
> +
> +#define bridge_to_ps8640(e)	container_of(e, struct ps8640, bridge)
> +#define connector_to_ps8640(e)	container_of(e, struct ps8640, connector)

I'd prefer these to be static inline functions.

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
> +static const u8 hw_chip_id[4] = {0x00, 0x0a, 0x00, 0x30};

Spaces after { and before }, please.
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

Please indent properly here. This uses a weird mix of tabs and spaces,
where it should be tabs only.

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
> +static int ps8640_write_bytes(struct i2c_client *client, const u8 *data,
> +			      u16 data_len)
> +{
> +	int ret;
> +	struct i2c_msg msg;
> +
> +	msg.addr = client->addr;
> +	msg.flags = 0;
> +	msg.len = data_len;
> +	msg.buf = (u8 *)data;
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
> +	u8 buf[] = {reg, data};

Spaces after { and before }, please. There are a bunch more of those
below, please fix those up as well.

> +
> +	return ps8640_write_bytes(client, buf, sizeof(buf));
> +}
> +
> +static void ps8640_get_mcu_fw_version(struct ps8640 *ps_bridge)
> +{
> +	struct i2c_client *client = ps_bridge->page[5];
> +	u8 fw_ver[2];
> +
> +	ps8640_read(client, 0x4, fw_ver, 2);

sizeof(fw_ver) perhaps and check for errors?

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

sizeof(vdo_ctrl_buf)? There are more of these in a couple of places.

> +static void ps8640_post_disable(struct drm_bridge *bridge)
> +{
> +	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +	int err;
> +
> +	if (ps_bridge->in_fw_update)
> +		return;

I don't like how this is handled. Consider what happens if you are in
the process of updating the firmware. The above code along with that in
other parts of the driver will silently ignore all operations on the
bridge during an update. I think these places should be updated to
return an error code (-EAGAIN, -EBUSY or the like) or they should block
all operations (perhaps via a mutex) until the firmware update is
complete.

> +static int ps8640_get_modes(struct drm_connector *connector)
> +{
> +	struct ps8640 *ps_bridge = connector_to_ps8640(connector);
> +	struct device *dev = &ps_bridge->page[0]->dev;
> +	u8 *edid;
> +	int ret, num_modes = 0;
> +	bool power_off;
> +
> +	if (ps_bridge->edid)
> +		return drm_add_edid_modes(connector, ps_bridge->edid);
> +
> +	power_off = !ps_bridge->enabled;
> +	ps8640_pre_enable(&ps_bridge->bridge);
> +
> +	edid = devm_kmalloc(dev, EDID_LENGTH, GFP_KERNEL);
> +	if (!edid) {
> +		DRM_ERROR("Failed to allocate EDID\n");
> +		return 0;
> +	}
> +
> +	ret = ps8640_read(ps_bridge->ddc_i2c, 0, edid, EDID_LENGTH);
> +	if (ret)
> +		goto out;

This should be using the standard EDID helpers.

> +/* Firmware Version is returned as Major.Minor.Build */

No, it isn't. The below returns "x.y" (which I assume is "major.minor").

> +static ssize_t ps8640_fw_version_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct ps8640 *ps_bridge = dev_get_drvdata(dev);
> +	struct ps8640_info *info = &ps_bridge->info;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u.%u\n", info->version >> 8,
> +			 info->version & 0xff);
> +}
[...]
> +static int ps8640_spi_send_cmd(struct ps8640 *ps_bridge, u8 *cmd, u8 cmd_len)
> +{
> +	struct i2c_client *client = ps_bridge->page[2];
> +	u8 i, buf[3] = {PAGE2_SWSPI_LEN, cmd_len - 1, TRIGGER_NO_READBACK};
> +	int ret;
> +
> +	ret = ps8640_write_byte(client, PAGE2_IROM_CTRL, IROM_ENABLE);
> +	if (ret)
> +		goto err;
> +
> +	/* write command in write port */
> +	for (i = 0; i < cmd_len; i++) {
> +		ret = ps8640_write_byte(client, PAGE2_SWSPI_WDATA, cmd[i]);
> +		if (ret) {
> +			ps8640_write_byte(client, PAGE2_IROM_CTRL,
> +					  IROM_DISABLE);
> +			goto err;

Can't this simply be "goto err_irom_disable;"?

> +		}
> +	}
> +
> +	ret = ps8640_write_bytes(client, buf, 3);
> +	if (ret)
> +		goto err_irom_disable;
> +
> +	ret = ps8640_write_byte(client, PAGE2_IROM_CTRL, IROM_DISABLE);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err_irom_disable:
> +	ps8640_write_byte(client, PAGE2_IROM_CTRL, IROM_DISABLE);
> +err:
> +	dev_err(&client->dev, "send command err: %d\n", ret);
> +	return ret;
> +}
> +
> +static int ps8640_wait_spi_ready(struct ps8640 *ps_bridge)
> +{
> +	struct i2c_client *client = ps_bridge->page[2];
> +	u8 spi_rdy_st;
> +	ktime_t timeout;
> +
> +	timeout = ktime_add_ms(ktime_get(), 200);
> +	for (;;) {
> +		ps8640_read(client, PAGE2_SPI_STATUS, &spi_rdy_st, 1);
> +		if ((spi_rdy_st & 0x0c) != 0x0c)

Can we get symbolic names for 0x0c, please?

> +			break;
> +
> +		if (ktime_compare(ktime_get(), timeout) > 0) {
> +			dev_err(&client->dev, "wait spi ready timeout\n");
> +			return -EBUSY;
> +		}
> +
> +		msleep(20);
> +	}
> +
> +	return 0;
> +}
[...]
> +static int ps8640_write_rom(struct ps8640 *ps_bridge, const struct firmware *fw)
> +{
> +	struct i2c_client *client = ps_bridge->page[0];
> +	struct device *dev = &client->dev;
> +	struct i2c_client *client2 = ps_bridge->page[2];
> +	struct i2c_client *client7 = ps_bridge->page[7];
> +	unsigned int pos = 0;

Make this size_t since you compare it to fw->size, which is size_t as
well.

> +	u8 buf[257], rom_page_id_buf[3];
> +	int ret;
> +	u16 cpy_len;
> +
> +	ps8640_write_byte(client2, PAGE2_SPI_CFG3, I2C_TO_SPI_RESET);
> +	msleep(100);
> +	ps8640_write_byte(client2, PAGE2_SPI_CFG3, 0x00);
> +
> +	for (pos = 0; pos < fw->size; pos += cpy_len) {
> +		rom_page_id_buf[0] = PAGE2_ROMADD_BYTE1;
> +		rom_page_id_buf[1] = pos >> 8;
> +		rom_page_id_buf[2] = pos >> 16;
> +		ret = ps8640_write_bytes(client2, rom_page_id_buf, 3);
> +		if (ret)
> +			goto error;
> +		cpy_len = fw->size >= 256 + pos ? 256 : fw->size - pos;
> +		buf[0] = 0;
> +		memcpy(buf + 1, fw->data + pos, cpy_len);
> +		ret = ps8640_write_bytes(client7, buf, cpy_len + 1);
> +		if (ret)
> +			goto error;
> +
> +		dev_dbg(dev, "fw update completed %u / %zu bytes\n", pos,
> +			fw->size);
> +	}
> +	return 0;
> +
> +error:
> +	dev_err(dev, "failed write extenal flash, %d\n", ret);

"external"

> +	return ret;
> +}
> +
> +static int ps8640_spi_normal_mode(struct ps8640 *ps_bridge)
> +{
> +	u8 cmd[2];
> +	struct i2c_client *client = ps_bridge->page[2];
> +
> +	/* Enable-Write-Status-Register */
> +	cmd[0] = WRITE_ENABLE_CMD;
> +	ps8640_spi_send_cmd(ps_bridge, cmd, 1);
> +
> +	/* protect BPL/BP0/BP1 */
> +	cmd[0] = WRITE_STATUS_REG_CMD;
> +	cmd[1] = BLK_PROTECT_BITS | STATUS_REG_PROTECT;
> +	ps8640_spi_send_cmd(ps_bridge, cmd, 2);
> +
> +	/* wait for SPI rom ready */
> +	ps8640_wait_rom_idle(ps_bridge);
> +
> +	/* disable PS8640 mapping function */
> +	ps8640_write_byte(client, PAGE2_ENCTLSPI_WR, 0x00);
> +
> +	gpiod_set_value(ps_bridge->gpio_mode_sel_n, 1);
> +	return 0;
> +}
> +
> +static int ps8640_enter_bl(struct ps8640 *ps_bridge)
> +{
> +	ps_bridge->in_fw_update = true;

Besides my other comments on this, I think you'll need proper locking
here, otherwise you might end up in a situation where you can still
power off the chip during firmware update. Consider the case where you
power off the chip, pass the in_fw_update check but then immediately
trigger the firmware update via sysfs and start updating while the chip
is being shut down.

> +	return ps8640_spi_dl_mode(ps_bridge);
> +}
> +
> +static void ps8640_exit_bl(struct ps8640 *ps_bridge, const struct firmware *fw)
> +{
> +	ps8640_spi_normal_mode(ps_bridge);
> +	ps_bridge->in_fw_update = false;
> +}
> +
> +static int ps8640_load_fw(struct ps8640 *ps_bridge, const struct firmware *fw)
> +{
> +	struct i2c_client *client = ps_bridge->page[0];
> +	struct device *dev = &client->dev;
> +	int ret;
> +	bool ps8640_status_backup = ps_bridge->enabled;
> +
> +	ret = ps8640_validate_firmware(ps_bridge, fw);
> +	if (ret)
> +		return ret;
> +
> +	if (!ps_bridge->in_fw_update) {
> +		if (!ps8640_status_backup)
> +			ps8640_pre_enable(&ps_bridge->bridge);
> +
> +		ret = ps8640_enter_bl(ps_bridge);
> +		if (ret)
> +			goto exit;
> +	}
> +
> +	ret = ps8640_rom_prepare(ps_bridge);
> +	if (ret)
> +		goto exit;
> +
> +	ret = ps8640_write_rom(ps_bridge, fw);
> +
> +exit:
> +	if (ret)
> +		dev_err(dev, "Failed to load firmware, %d\n", ret);
> +
> +	ps8640_exit_bl(ps_bridge, fw);
> +	if (!ps8640_status_backup)
> +		ps8640_post_disable(&ps_bridge->bridge);
> +	return ret;

Taking a mutex around all of this code might be the easiest way to
achieve this.

> +}
> +
> +static ssize_t ps8640_update_fw_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct ps8640 *ps_bridge = i2c_get_clientdata(client);
> +	const struct firmware *fw;
> +	int error;
> +
> +	error = request_firmware(&fw, PS_FW_NAME, dev);
> +	if (error) {
> +		dev_err(dev, "Unable to open firmware %s: %d\n",
> +			PS_FW_NAME, error);
> +		return error;
> +	}
> +
> +	error = ps8640_load_fw(ps_bridge, fw);
> +	if (error)
> +		dev_err(dev, "The firmware update failed(%d)\n", error);
> +	else
> +		dev_info(dev, "The firmware update succeeded\n");
> +
> +	release_firmware(fw);
> +	return error ? error : count;
> +}

This sysfs interface is somewhat unintuitive because it triggers no
matter what you write to the file. I find it also a little unusual that
you would trigger a firmware update through sysfs, but then go through
the request_firmware() to obtain it. Is this a common method, or do
other drivers do something different?

> +static int ps8640_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct ps8640 *ps_bridge;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *port, *out_ep;
> +	struct device_node *panel_node = NULL;
> +	int i, ret;

i could be unsigned.

> +
> +	ps_bridge = devm_kzalloc(dev, sizeof(*ps_bridge), GFP_KERNEL);
> +	if (!ps_bridge)
> +		return -ENOMEM;
> +
> +	/* port at 1 is ps8640 output port */
> +	port = of_graph_get_port_by_id(np, 1);
> +	if (port) {
> +		out_ep = of_get_child_by_name(port, "endpoint");
> +		of_node_put(port);
> +		if (out_ep) {
> +			panel_node = of_graph_get_remote_port_parent(out_ep);
> +			of_node_put(out_ep);
> +		}
> +	}
> +	if (panel_node) {
> +		ps_bridge->panel = of_drm_find_panel(panel_node);
> +		of_node_put(panel_node);
> +		if (!ps_bridge->panel)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	ps_bridge->supplies[0].supply = "vdd33";
> +	ps_bridge->supplies[1].supply = "vdd12";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ps_bridge->supplies),
> +				      ps_bridge->supplies);
> +	if (ret) {
> +		dev_info(dev, "failed to get regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ps_bridge->gpio_mode_sel_n = devm_gpiod_get(&client->dev, "mode-sel",
> +						    GPIOD_OUT_HIGH);

This GPIO is used to enable programming mode. Perhaps it should be made
optional, and the programming mode refuse to run if it isn't specified?

> +	if (IS_ERR(ps_bridge->gpio_mode_sel_n)) {
> +		ret = PTR_ERR(ps_bridge->gpio_mode_sel_n);
> +		dev_err(dev, "cannot get mode-sel %d\n", ret);
> +		return ret;
> +	}
> +
> +	ps_bridge->gpio_slp_n = devm_gpiod_get(&client->dev, "sleep",
> +					       GPIOD_OUT_LOW);
> +	if (IS_ERR(ps_bridge->gpio_slp_n)) {
> +		ret = PTR_ERR(ps_bridge->gpio_slp_n);
> +		dev_err(dev, "cannot get sleep: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Request the reset pin low to avoid the bridge being
> +	 * initialized prematurely
> +	 */
> +	ps_bridge->gpio_rst_n = devm_gpiod_get(&client->dev, "reset",
> +					       GPIOD_OUT_LOW);
> +	if (IS_ERR(ps_bridge->gpio_rst_n)) {
> +		ret = PTR_ERR(ps_bridge->gpio_rst_n);
> +		dev_err(dev, "cannot get reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ps_bridge->bridge.funcs = &ps8640_bridge_funcs;
> +	ps_bridge->bridge.of_node = dev->of_node;
> +	ret = drm_bridge_add(&ps_bridge->bridge);

Perhaps postpone the call to drm_bridge_add() until everything has been
properly set up? That way you don't have to undo it again if something
goes wrong in the more likely places.

> +	if (ret) {
> +		dev_err(dev, "Failed to add bridge: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ps_bridge->page[0] = client;
> +	ps_bridge->ddc_i2c = i2c_new_dummy(client->adapter, EDID_I2C_ADDR);
> +	if (!ps_bridge->ddc_i2c) {
> +		dev_err(dev, "failed ddc_i2c dummy device, address%02x\n",
> +			EDID_I2C_ADDR);
> +		ret = -EBUSY;
> +		goto exit_ddc_i2c_dummy;
> +	}
> +	/*
> +	 * ps8640 uses multiple addresses, use dummy devices for them
> +	 * page[0]: for DP control
> +	 * page[1]: for VIDEO Bridge
> +	 * page[2]: for control top
> +	 * page[3]: for DSI Link Control1
> +	 * page[4]: for MIPI Phy
> +	 * page[5]: for VPLL
> +	 * page[6]: for DSI Link Control2
> +	 * page[7]: for spi rom mapping
> +	 */
> +	for (i = 1; i < 8; i++) {
> +		ps_bridge->page[i] = i2c_new_dummy(client->adapter,
> +						   client->addr + i);
> +		if (!ps_bridge->page[i]) {
> +			dev_err(dev, "failed i2c dummy device, address%02x\n",
> +				client->addr + i);
> +			ret = -EBUSY;
> +			goto exit_dummy;
> +		}
> +	}
> +	i2c_set_clientdata(client, ps_bridge);
> +
> +	ret = sysfs_create_group(&client->dev.kobj, &ps8640_attr_group);
> +	if (ret) {
> +		dev_err(dev, "failed to create sysfs entries: %d\n", ret);
> +		goto exit_dummy;
> +	}
> +
> +	ret = devm_add_action(dev, ps8640_remove_sysfs_group, ps_bridge);
> +	if (ret) {
> +		dev_err(dev, "failed to add sysfs cleanup action: %d\n", ret);
> +		goto exit_remove_sysfs;
> +	}
> +	return 0;
> +
> +exit_remove_sysfs:
> +	sysfs_remove_group(&ps_bridge->page[0]->dev.kobj, &ps8640_attr_group);
> +exit_dummy:
> +	for (i = 1; i < 8; i++)
> +		if (ps_bridge->page[i])
> +			i2c_unregister_device(ps_bridge->page[i]);

Might be better to make this into something like:

	while (--i)
		i2c_unregister_device(ps_bridge->page[i]);

That way you can omit the check for valid page because you only
unregister the ones you've successfully registered before.

> +	i2c_unregister_device(ps_bridge->ddc_i2c);
> +exit_ddc_i2c_dummy:
> +	drm_bridge_remove(&ps_bridge->bridge);
> +	return ret;
> +}
> +
> +static int ps8640_remove(struct i2c_client *client)
> +{
> +	struct ps8640 *ps_bridge = i2c_get_clientdata(client);
> +	int i;
> +
> +	for (i = 1; i < 8; i++)
> +		i2c_unregister_device(ps_bridge->page[i]);
> +
> +	i2c_unregister_device(ps_bridge->ddc_i2c);
> +	drm_bridge_remove(&ps_bridge->bridge);
> +
> +	return 0;
> +}

The ordering here should be the reverse of that in ->probe().

> +
> +static const struct i2c_device_id ps8640_i2c_table[] = {
> +	{"parade,ps8640", 0},
> +	{},

Spaces after { and before }. Also is this really correct? I thought for
I2C device IDs we didn't need a vendor prefix.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160414/3536b114/attachment.sig>
