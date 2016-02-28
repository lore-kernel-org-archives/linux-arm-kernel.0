From: djkurtz@chromium.org (Daniel Kurtz)
Date: Sun, 28 Feb 2016 11:32:34 +0800
Subject: [PATCH v11 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1456212937-7635-2-git-send-email-jitao.shi@mediatek.com>
References: <1456212937-7635-1-git-send-email-jitao.shi@mediatek.com>
 <1456212937-7635-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <CAGS+omAbro1goiLK2-UUbf3-0ShBFSD2xVc-pTPZDMSaygAk-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

Getting very close now...

Comments inline...

On Tue, Feb 23, 2016 at 3:35 PM, Jitao Shi <jitao.shi@mediatek.com> wrote:
> This patch adds drm_bridge driver for parade DSI to eDP bridge chip.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  Changes since v10:
>  - Tuning PS8640 reset sleep pins squence
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
>  drivers/gpu/drm/bridge/parade-ps8640.c | 1060 ++++++++++++++++++++++++++++++++
>  3 files changed, 1072 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/parade-ps8640.c
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 27e2022..b4edd8c 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -40,4 +40,15 @@ config DRM_PARADE_PS8622
>         ---help---
>           Parade eDP-LVDS bridge chip driver.
>
> +config DRM_PARADE_PS8640
> +       tristate "Parade PS8640 MIPI DSI to eDP Converter"
> +       depends on OF && I2C

To remove the cyclic dependency on I2C, remove the I2C, and replace with:

depends on DRM
depends on OF

> +       select DRM_KMS_HELPER
> +       select DRM_MIPI_DSI
> +       select DRM_PANEL
> +       ---help---
> +         Choose this option if you have PS8640 for display
> +         The PS8640 is a high-performance and low-power
> +         MIPI DSI to eDP converter
> +
>  endmenu

[snip]

> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> new file mode 100644
> index 0000000..d7410df
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c

[snip]

> +static int ps8640_write_bytes(struct i2c_client *client, u8 *data,
> +                             u16 data_len)

const u8 *data

> +{
> +       int ret;
> +       struct i2c_msg msg;
> +
> +       msg.addr = client->addr;
> +       msg.flags = 0;
> +       msg.len = data_len;
> +       msg.buf = data;
> +
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret == 1)
> +               return 0;
> +       if (ret < 0)
> +               return ret;
> +       else
> +               return -EIO;
> +}
> +
> +static int ps8640_write_byte(struct i2c_client *client, u8 reg,  u8 data)

nit: (extra space before "u8 data".

Also, just reuse ps8640_write_bytes, so like this:

static int ps8640_write_byte(struct i2c_client *client, u8 reg, u8 data)
{
  u8 buf[] = {reg, data};
  return ps8640_write_bytes(client, buf, 2);
}

> +{
> +       int ret;
> +       struct i2c_msg msg;
> +       u8 buf[] = {reg, data};
> +
> +       msg.addr = client->addr;
> +       msg.flags = 0;
> +       msg.len = sizeof(buf);
> +       msg.buf = buf;
> +
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret == 1)
> +               return 0;
> +       if (ret < 0)
> +               return ret;
> +       else
> +               return -EIO;
> +}

[snip]

> +static void ps8640_pre_enable(struct drm_bridge *bridge)
> +{
> +       struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +       struct i2c_client *client = ps_bridge->page[2];
> +       int err, retry_cnt = 0;
> +       u8 set_vdo_done;
> +
> +       if (ps_bridge->in_fw_update)
> +               return;
> +
> +       if (ps_bridge->enabled)
> +               return;
> +
> +       err = drm_panel_prepare(ps_bridge->panel);
> +       if (err < 0) {
> +               DRM_ERROR("failed to prepare panel: %d\n", err);
> +               return;
> +       }
> +
> +       err = regulator_bulk_enable(ARRAY_SIZE(ps_bridge->supplies),
> +                                   ps_bridge->supplies);
> +       if (err < 0) {
> +               DRM_ERROR("cannot enable regulators %d\n", err);
> +               goto err_panel_unprepare;
> +       }
> +
> +       gpiod_set_value(ps_bridge->gpio_slp_n, 1);
> +       gpiod_set_value(ps_bridge->gpio_rst_n, 0);
> +       usleep_range(2000, 2500);
> +       gpiod_set_value(ps_bridge->gpio_rst_n, 1);
> +
> +       /*
> +        * Wait for the ps8640 embed mcu ready
> +        * First wait 200ms and then check the mcu ready flag every 20ms
> +        */
> +       msleep(200);
> +       do {
> +               err = ps8640_read(client, PAGE2_GPIO_H, &set_vdo_done, 1);
> +               if (err < 0) {
> +                       DRM_ERROR("failed read PAGE2_GPIO_H: %d\n", err);
> +                       goto err_regulators_disable;
> +               }
> +               msleep(20);

This wastes 20 ms on success.
Use the routines in <linux/iopoll.h> for polling loops like this.

> +       } while ((retry_cnt++ < 10) && ((set_vdo_done & PS_GPIO9) != PS_GPIO9));
> +
> +       if (ps_bridge->info.version == 0)
> +               ps8640_get_mcu_fw_version(ps_bridge);
> +       /* Switch access edp panel's edid through i2c */
> +       ps8640_write_byte(client, PAGE2_I2C_BYPASS, I2C_BYPASS_EN);
> +       ps_bridge->enabled = true;
> +
> +       return;
> +
> +err_regulators_disable:
> +       regulator_bulk_disable(ARRAY_SIZE(ps_bridge->supplies),
> +                              ps_bridge->supplies);
> +err_panel_unprepare:
> +       drm_panel_unprepare(ps_bridge->panel);
> +}

[snip]

> +static int ps8640_get_modes(struct drm_connector *connector)
> +{
> +       struct ps8640 *ps_bridge = connector_to_ps8640(connector);
> +       struct device *dev = &ps_bridge->page[0]->dev;
> +       u8 *edid;
> +       int ret, num_modes = 0;
> +       bool power_off;
> +
> +       if (ps_bridge->edid)
> +               return drm_add_edid_modes(connector, ps_bridge->edid);
> +
> +       power_off = !ps_bridge->enabled;
> +       ps8640_pre_enable(&ps_bridge->bridge);
> +
> +       edid = devm_kmalloc(dev, EDID_LENGTH, GFP_KERNEL);
> +       if (!edid) {
> +               DRM_ERROR("Failed to allocate EDID\n");
> +               return 0;
> +       }
> +
> +       ret = ps8640_read(ps_bridge->ddc_i2c, 0, edid, EDID_LENGTH);
> +       if (ret)
> +               goto out;
> +
> +       ps_bridge->edid = (struct edid *)edid;
> +       drm_mode_connector_update_edid_property(connector, ps_bridge->edid);
> +
> +       num_modes = drm_add_edid_modes(connector, ps_bridge->edid);
> +
> +out:
> +       if (power_off)
> +               ps8640_post_disable(&ps_bridge->bridge);
> +
> +       return num_modes;
> +}
> +
> +static struct drm_encoder *ps8640_best_encoder(struct drm_connector *connector)
> +{
> +       struct ps8640 *ps_bridge;
> +
> +       ps_bridge = connector_to_ps8640(connector);

nit:
        struct ps8640 *ps_bridge = connector_to_ps8640(connector);

> +       return ps_bridge->bridge.encoder;
> +}

[snip]

> +int ps8640_bridge_attach(struct drm_bridge *bridge)
> +{
> +       struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +       struct device *dev = &ps_bridge->page[0]->dev;
> +       struct device_node *np = dev->of_node;
> +       struct device_node *port, *in_ep;
> +       struct device_node *dsi_node = NULL;
> +       struct mipi_dsi_host *host = ps_bridge->dsi.host;
> +       int ret;
> +
> +       ret = drm_connector_init(bridge->dev, &ps_bridge->connector,
> +                                &ps8640_connector_funcs,
> +                                DRM_MODE_CONNECTOR_eDP);
> +
> +       if (ret) {
> +               DRM_ERROR("Failed to initialize connector with drm: %d\n", ret);
> +               return ret;
> +       }
> +
> +       drm_connector_helper_add(&ps_bridge->connector,
> +                                &ps8640_connector_helper_funcs);
> +       drm_connector_register(&ps_bridge->connector);
> +
> +       ps_bridge->connector.dpms = DRM_MODE_DPMS_ON;
> +       drm_mode_connector_attach_encoder(&ps_bridge->connector,
> +                                         bridge->encoder);
> +
> +       if (ps_bridge->panel)
> +               drm_panel_attach(ps_bridge->panel, &ps_bridge->connector);
> +
> +       /* port at 0 is ps8640 dsi input port */
> +       port = of_graph_get_port_by_id(np, 0);
> +       if (port) {
> +               in_ep = of_get_child_by_name(port, "endpoint");
> +               of_node_put(port);
> +               if (in_ep) {
> +                       dsi_node = of_graph_get_remote_port_parent(in_ep);
> +                       of_node_put(in_ep);
> +               }
> +       }
> +       if (dsi_node) {
> +               host = of_find_mipi_dsi_host_by_node(dsi_node);
> +               of_node_put(dsi_node);
> +               if (!host)
> +                       return -ENODEV;

Missing drm_panel_detach on error
Missing drm_connector_unregister/drm_connector_cleanup on error

> +       }
> +
> +       ps_bridge->dsi.host = host;
> +       ps_bridge->dsi.mode_flags = MIPI_DSI_MODE_VIDEO |
> +                                    MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> +       ps_bridge->dsi.format = MIPI_DSI_FMT_RGB888;
> +       ps_bridge->dsi.lanes = 4;
> +       ret = mipi_dsi_attach(&ps_bridge->dsi);
> +       if (ret) {
> +               drm_panel_detach(ps_bridge->panel);
> +               return ret;

Missing drm_connector_unregister/drm_connector_cleanup on error

> +       }
> +
> +       return ret;
> +}
> +
> +static const struct drm_bridge_funcs ps8640_bridge_funcs = {
> +       .attach = ps8640_bridge_attach,
> +       .disable = ps8640_disable,
> +       .post_disable = ps8640_post_disable,
> +       .pre_enable = ps8640_pre_enable,
> +       .enable = ps8640_enable,
> +};
> +
> +/* Firmware Version is returned as Major.Minor.Build */
> +static ssize_t ps8640_fw_version_show(struct device *dev,
> +                                     struct device_attribute *attr, char *buf)
> +{
> +       struct ps8640 *ps_bridge = dev_get_drvdata(dev);
> +       struct ps8640_info *info = &ps_bridge->info;
> +
> +       return scnprintf(buf, PAGE_SIZE, "%u.%u\n", info->version >> 8,
> +                        info->version & 0xff);
> +}
> +
> +/* Hardware Version is returned as FamilyID.VariantID */
> +static ssize_t ps8640_hw_version_show(struct device *dev,
> +                                     struct device_attribute *attr, char *buf)
> +{
> +       struct ps8640 *ps_bridge = dev_get_drvdata(dev);
> +       struct ps8640_info *info = &ps_bridge->info;
> +
> +       return scnprintf(buf, PAGE_SIZE, "ps%u.%u\n", info->family_id,
> +                        info->variant_id);
> +}
> +
> +static int ps8640_spi_send_cmd(struct ps8640 *ps_bridge, u8 *cmd, u8 cmd_len)
> +{
> +       struct i2c_client *client = ps_bridge->page[2];
> +       u8 i, buf[3];
> +       int ret;
> +
> +       ret = ps8640_write_byte(client, PAGE2_IROM_CTRL, IROM_ENABLE);
> +       if (ret)
> +               goto err;
> +
> +       /* write command in write port */
> +       for (i = 0; i < cmd_len; i++) {
> +               ret = ps8640_write_byte(client, PAGE2_SWSPI_WDATA, cmd[i]);
> +               if (ret)
> +                       goto err;

Still do IROM_DISABLE on failure?

> +       }
> +
> +       buf[0] = PAGE2_SWSPI_LEN;
> +       buf[1] = cmd_len - 1;
> +       buf[2] = TRIGGER_NO_READBACK;
> +       ret = ps8640_write_bytes(client, buf, 3);
> +       if (ret)
> +               goto err;

Still do IROM_DISABLE on failure?

> +
> +       ret = ps8640_write_byte(client, PAGE2_IROM_CTRL, IROM_DISABLE);
> +       if (ret)
> +               goto err;
> +
> +       return 0;
> +
> +err:
> +       dev_err(&client->dev, "send command err: %d\n", ret);
> +       return ret;
> +}
> +
> +static int ps8640_wait_spi_ready(struct ps8640 *ps_bridge)
> +{
> +       struct i2c_client *client = ps_bridge->page[2];
> +       u8 spi_rdy_st, retry_cnt = 0;
> +
> +       do {
> +               ps8640_read(client, PAGE2_SPI_STATUS, &spi_rdy_st, 1);
> +               msleep(20);

This wastes 20 ms on success.
Use the routines in <linux/iopoll.h> for polling loops like this.

> +               if ((retry_cnt == SPI_MAX_RETRY_CNT) &&
> +                   ((spi_rdy_st & 0x0c) != 0x0c)) {
> +                       dev_err(&client->dev, "wait spi ready timeout\n");
> +                       return -EBUSY;
> +               }
> +       } while ((retry_cnt++ < SPI_MAX_RETRY_CNT) &&
> +                (spi_rdy_st & 0x0c) == 0x0c);
> +
> +       return 0;
> +}
> +
> +static int ps8640_wait_spi_nobusy(struct ps8640 *ps_bridge)
> +{
> +       struct i2c_client *client = ps_bridge->page[2];
> +       u8 spi_status, buf[3], retry_cnt = 0;
> +       int ret;
> +
> +       do {
> +               /* 0x05 RDSR; Read-Status-Register */
> +               ret = ps8640_write_byte(client, PAGE2_SWSPI_WDATA,
> +                                       READ_STATUS_REG_CMD);
> +               if (ret)
> +                       goto err_send_cmd_exit;
> +
> +               buf[0] = PAGE2_SWSPI_LEN;
> +               buf[1] = 0;
> +               buf[2] = TRIGGER_READBACK;
> +               ret = ps8640_write_bytes(client, buf, 3);
> +               if (ret)
> +                       goto err_send_cmd_exit;
> +
> +               /* delay for cmd send */
> +               usleep_range(100, 300);
> +               /* wait for SPI ROM until not busy */
> +               ret = ps8640_read(client, PAGE2_SWSPI_RDATA, &spi_status, 1);
> +               if (ret)
> +                       goto err_send_cmd_exit;
> +       } while ((retry_cnt++ < SPI_MAX_RETRY_CNT) &&
> +                (spi_status & BLK_PROTECT_BITS) == BLK_PROTECT_BITS);
> +
> +       if ((retry_cnt > SPI_MAX_RETRY_CNT) &&
> +           (spi_status & BLK_PROTECT_BITS) != BLK_PROTECT_BITS) {
> +               ret = -EBUSY;
> +               dev_err(&client->dev, "wait spi no busy timeout: %d\n", ret);
> +               goto err_timeout;

just "return -EBUSY".

> +       }
> +
> +       return 0;
> +
> +err_send_cmd_exit:
> +       dev_err(&client->dev, "send command err: %d\n", ret);
> +
> +err_timeout:
> +       return ret;
> +}
> +
> +static int ps8640_wait_rom_idle(struct ps8640 *ps_bridge)
> +{
> +       struct i2c_client *client = ps_bridge->page[0];
> +       int ret;
> +
> +       ret = ps8640_write_byte(client, PAGE2_IROM_CTRL, IROM_ENABLE);
> +       if (ret)
> +               goto exit;
> +
> +       ret = ps8640_wait_spi_ready(ps_bridge);
> +       if (ret)
> +               goto exit;
> +
> +       ret = ps8640_wait_spi_nobusy(ps_bridge);
> +       if (ret)

If either ready/nobusy fail, should we still do IROM_DISABLE?

> +               goto exit;
> +
> +       ret = ps8640_write_byte(client, PAGE2_IROM_CTRL, IROM_DISABLE);
> +       if (ret)
> +               goto exit;
> +
> +exit:
> +       if (ret)
> +               dev_err(&client->dev, "wait ps8640 rom idle fail: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int ps8640_spi_dl_mode(struct ps8640 *ps_bridge)
> +{
> +       struct i2c_client *client = ps_bridge->page[2];
> +       int ret;
> +
> +       /* switch ps8640 mode to spi dl mode */
> +       gpiod_set_value(ps_bridge->gpio_mode_sel_n, 0);
> +
> +       /* reset spi interface */
> +       ret = ps8640_write_byte(client, PAGE2_SW_REST,
> +                               SPI_SW_RESET | MPU_SW_RESET);
> +       if (ret)
> +               goto exit;
> +
> +       ret = ps8640_write_byte(client, PAGE2_SW_REST, MPU_SW_RESET);
> +       if (ret)
> +               goto exit;
> +
> +exit:
> +       if (ret)
> +               dev_err(&client->dev, "fail reset spi interface: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int ps8640_rom_prepare(struct ps8640 *ps_bridge)
> +{
> +       struct i2c_client *client = ps_bridge->page[2];
> +       struct device *dev = &client->dev;
> +       u8 i, cmd[2];
> +       int ret;
> +
> +       cmd[0] = WRITE_ENABLE_CMD;
> +       ret = ps8640_spi_send_cmd(ps_bridge, cmd, 1);
> +       if (ret) {
> +               dev_err(dev, "failed enable-write-status-register: %d\n", ret);
> +               return ret;
> +       }
> +
> +       cmd[0] = WRITE_STATUS_REG_CMD;
> +       cmd[1] = CLEAR_ALL_PROTECT;
> +       ret = ps8640_spi_send_cmd(ps_bridge, cmd, 2);
> +       if (ret) {
> +               dev_err(dev, "fail disable all protection: %d\n", ret);
> +               return ret;
> +       }
> +
> +       /* wait for SPI module ready */
> +       ret = ps8640_wait_rom_idle(ps_bridge);
> +       if (ret) {
> +               dev_err(dev, "fail wait rom idle: %d\n", ret);

If this fails, should we undo "WRITE_ENABLE_CMD" and/or
"CLEAR_ALL_PROTECT" above?

> +               return ret;
> +       }
> +
> +       ps8640_write_byte(client, PAGE2_IROM_CTRL, IROM_ENABLE);
> +       for (i = 0; i < 6; i++)
> +               ps8640_write_byte(client, PAGE2_ENCTLSPI_WR, enc_ctrl_code[i]);
> +       ps8640_write_byte(client, PAGE2_IROM_CTRL, IROM_DISABLE);
> +
> +       /* Enable-Write-Status-Register */
> +       cmd[0] = WRITE_ENABLE_CMD;
> +       ret = ps8640_spi_send_cmd(ps_bridge, cmd, 1);
> +       if (ret) {
> +               dev_err(dev, "fail enable-write-status-register: %d\n", ret);
> +               return ret;
> +       }
> +
> +       /* chip erase command */
> +       cmd[0] = CHIP_ERASE_CMD;
> +       ret = ps8640_spi_send_cmd(ps_bridge, cmd, 1);
> +       if (ret) {
> +               dev_err(dev, "fail disable all protection: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = ps8640_wait_rom_idle(ps_bridge);
> +       if (ret) {
> +               dev_err(dev, "fail wait rom idle: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int ps8640_validate_firmware(struct ps8640 *ps_bridge,
> +                                   const struct firmware *fw)
> +{
> +       struct i2c_client *client = ps_bridge->page[0];
> +       struct ps8640_info *info = &ps_bridge->info;
> +       u16 fw_chip_id, fw_version_id;
> +
> +       /*
> +        * Get the chip_id from the firmware. Make sure that it is the
> +        * right controller to do the firmware and config update.
> +        */
> +       fw_chip_id = get_unaligned_le16(fw->data + FW_CHIP_ID_OFFSET);
> +
> +       if (fw_chip_id != 0x8640) {

Shouldn't we be comparing to something read from the device rather than a
hard-coded value?  Perhaps (info->family_id, info->variant_id)?

> +               dev_err(&client->dev,
> +                       "chip id mismatch: fw 0x%x vs. chip 0x8640\n",
> +                       fw_chip_id);
> +               return -ENODEV;

This error means that the firmware file provided by userspace is invalid, so:
  return -EINVAL;

> +       }
> +
> +       fw_version_id = get_unaligned_le16(fw->data + FW_VERSION_OFFSET);
> +
> +       if (fw_version_id == info->version) {
> +               dev_err(&client->dev,
> +                       "no need update fw version same: fw %d.%d vs. chip %d.%d\n",
> +                       fw_version_id >> 8, fw_version_id & 0xff,
> +                       info->version >> 8, info->version & 0xff);
> +               return -ENODEV;

This is not an error.  Just return 0.
Or, perhaps just remove this check and just allow userspace to
re-write the same version.
There are cases where this is valid:
 (a) to test firmware update
 (b) b/c userspace doesn't trust the old firmware despite what version
it reports
 (c) b/c of suspected flash corruption, etc.
Anyway, this is 'policy', and shouldn't be handled here in the kernel driver.

> +       }
> +
> +       return 0;
> +}
> +
> +static int ps8640_write_rom(struct ps8640 *ps_bridge, const struct firmware *fw)
> +{
> +       struct i2c_client *client = ps_bridge->page[0];
> +       struct device *dev = &client->dev;
> +       struct i2c_client *client2 = ps_bridge->page[2];
> +       struct i2c_client *client7 = ps_bridge->page[7];
> +       unsigned int pos = 0;
> +       u8 buf[257], rom_page_id_buf[3];
> +       int ret;
> +       u16 cpy_len;
> +
> +       ps8640_write_byte(client2, PAGE2_SPI_CFG3, I2C_TO_SPI_RESET);
> +       msleep(100);
> +       ps8640_write_byte(client2, PAGE2_SPI_CFG3, 0x00);
> +
> +       while (pos < fw->size) {

style nit:
This 'while' would work better as a for loop:

  for (pos = 0; pos < fw->size; pos += cpy_len)

> +               rom_page_id_buf[0] = PAGE2_ROMADD_BYTE1;
> +               rom_page_id_buf[1] = (pos >> 8) & 0xff;
> +               rom_page_id_buf[2] = (pos >> 16) & 0xff;

Remove "& 0xff" from the two lines above b/c rom_page_id_buf[] is a u8 array.

> +               ret = ps8640_write_bytes(client2, rom_page_id_buf, 3);
> +               if (ret)
> +                       goto error;
> +               cpy_len = fw->size >= 256 + pos ? 256 : fw->size - pos;
> +               buf[0] = 0;
> +               memcpy(buf + 1, fw->data + pos, cpy_len);
> +               ret = ps8640_write_bytes(client7, buf, cpy_len + 1);
> +               if (ret)
> +                       goto error;
> +
> +               pos += cpy_len;
> +
> +               dev_dbg(dev, "fw update completed %u / %zu bytes\n", pos,
> +                       fw->size);
> +       }
> +       return 0;
> +
> +error:
> +       dev_err(dev, "failed write extenal flash, %d\n", ret);
> +       return ret;
> +}
> +
> +static int ps8640_spi_normal_mode(struct ps8640 *ps_bridge)
> +{
> +       u8 cmd[2];
> +       struct i2c_client *client = ps_bridge->page[2];
> +
> +       /* Enable-Write-Status-Register */
> +       cmd[0] = WRITE_ENABLE_CMD;
> +       ps8640_spi_send_cmd(ps_bridge, cmd, 1);
> +
> +       /* protect BPL/BP0/BP1 */
> +       cmd[0] = WRITE_STATUS_REG_CMD;
> +       cmd[1] = BLK_PROTECT_BITS | STATUS_REG_PROTECT;
> +       ps8640_spi_send_cmd(ps_bridge, cmd, 2);
> +
> +       /* wait for SPI rom ready */
> +       ps8640_wait_rom_idle(ps_bridge);
> +
> +       /* disable PS8640 mapping function */
> +       ps8640_write_byte(client, PAGE2_ENCTLSPI_WR, 0x00);
> +
> +       gpiod_set_value(ps_bridge->gpio_mode_sel_n, 1);
> +       return 0;
> +}
> +
> +static int ps8640_enter_bl(struct ps8640 *ps_bridge)
> +{
> +       ps_bridge->in_fw_update = true;
> +       return ps8640_spi_dl_mode(ps_bridge);
> +}
> +
> +static void ps8640_exit_bl(struct ps8640 *ps_bridge, const struct firmware *fw)
> +{
> +       ps8640_spi_normal_mode(ps_bridge);
> +       ps_bridge->in_fw_update = false;
> +}
> +
> +static int ps8640_load_fw(struct ps8640 *ps_bridge, const struct firmware *fw)
> +{
> +       struct i2c_client *client = ps_bridge->page[0];
> +       struct device *dev = &client->dev;
> +       int ret;
> +       bool ps8640_status_backup = ps_bridge->enabled;
> +
> +       if (!ps_bridge->in_fw_update) {
> +               if (!ps8640_status_backup)
> +                       ps8640_pre_enable(&ps_bridge->bridge);
> +
> +               ret = ps8640_enter_bl(ps_bridge);
> +               if (ret)
> +                       goto exit;
> +       }
> +
> +       ret = ps8640_validate_firmware(ps_bridge, fw);

ps8640_validate_firmware() does not depend on the device at all; do this check
before switching to "bootloader" mode.

> +       if (ret)
> +               goto exit;
> +
> +       ret = ps8640_rom_prepare(ps_bridge);
> +       if (ret)
> +               goto exit;
> +
> +       ret = ps8640_write_rom(ps_bridge, fw);
> +
> +exit:
> +       if (ret)
> +               dev_err(dev, "Failed to load firmware, %d\n", ret);
> +
> +       ps8640_exit_bl(ps_bridge, fw);
> +       if (!ps8640_status_backup)
> +               ps8640_post_disable(&ps_bridge->bridge);
> +       return ret;
> +}
> +
> +static ssize_t ps8640_update_fw_store(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     const char *buf, size_t count)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct ps8640 *ps_bridge = i2c_get_clientdata(client);
> +       const struct firmware *fw;
> +       int error;
> +
> +       error = request_firmware(&fw, PS_FW_NAME, dev);
> +       if (error) {
> +               dev_err(dev, "Unable to open firmware %s: %d\n",
> +                       PS_FW_NAME, error);
> +               return error;
> +       }
> +
> +       error = ps8640_load_fw(ps_bridge, fw);
> +       if (error)
> +               dev_err(dev, "The firmware update failed(%d)\n", error);
> +       else
> +               dev_info(dev, "The firmware update succeeded\n");
> +
> +       release_firmware(fw);
> +       return error ? error : count;
> +}
> +
> +static DEVICE_ATTR(fw_version, S_IRUGO, ps8640_fw_version_show, NULL);
> +static DEVICE_ATTR(hw_version, S_IRUGO, ps8640_hw_version_show, NULL);
> +static DEVICE_ATTR(update_fw, S_IWUSR, NULL, ps8640_update_fw_store);
> +
> +static struct attribute *ps8640_attrs[] = {
> +       &dev_attr_fw_version.attr,
> +       &dev_attr_hw_version.attr,
> +       &dev_attr_update_fw.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group ps8640_attr_group = {
> +       .attrs = ps8640_attrs,
> +};
> +
> +static void ps8640_remove_sysfs_group(void *data)
> +{
> +       struct ps8640 *ps_bridge = data;
> +
> +       sysfs_remove_group(&ps_bridge->page[0]->dev.kobj, &ps8640_attr_group);
> +}
> +
> +static int ps8640_probe(struct i2c_client *client,
> +                       const struct i2c_device_id *id)
> +{
> +       struct device *dev = &client->dev;
> +       struct ps8640 *ps_bridge;
> +       struct device_node *np = dev->of_node;
> +       struct device_node *port, *out_ep;
> +       struct device_node *panel_node = NULL;
> +       int i, ret;
> +
> +       ps_bridge = devm_kzalloc(dev, sizeof(*ps_bridge), GFP_KERNEL);
> +       if (!ps_bridge)
> +               return -ENOMEM;
> +
> +       /* port at 1 is ps8640 output port */
> +       port = of_graph_get_port_by_id(np, 1);
> +       if (port) {
> +               out_ep = of_get_child_by_name(port, "endpoint");
> +               of_node_put(port);
> +               if (out_ep) {
> +                       panel_node = of_graph_get_remote_port_parent(out_ep);
> +                       of_node_put(out_ep);
> +               }
> +       }
> +       if (panel_node) {
> +               ps_bridge->panel = of_drm_find_panel(panel_node);
> +               of_node_put(panel_node);
> +               if (!ps_bridge->panel)
> +                       return -EPROBE_DEFER;
> +       }
> +
> +       ps_bridge->supplies[0].supply = "vdd33";
> +       ps_bridge->supplies[1].supply = "vdd12";
> +       ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ps_bridge->supplies),
> +                                     ps_bridge->supplies);
> +       if (ret) {
> +               dev_info(dev, "failed to get regulators: %d\n", ret);
> +               return -EPROBE_DEFER;

return ret

> +       }
> +
> +       ps_bridge->gpio_mode_sel_n = devm_gpiod_get(&client->dev, "mode-sel",
> +                                                   GPIOD_OUT_HIGH);
> +       if (IS_ERR(ps_bridge->gpio_mode_sel_n)) {
> +               ret = PTR_ERR(ps_bridge->gpio_mode_sel_n);
> +               dev_err(dev, "cannot get mode-sel %d\n", ret);
> +               return ret;
> +       }
> +
> +       ps_bridge->gpio_slp_n = devm_gpiod_get(&client->dev, "sleep",
> +                                              GPIOD_OUT_LOW);
> +       if (IS_ERR(ps_bridge->gpio_slp_n)) {
> +               ret = PTR_ERR(ps_bridge->gpio_slp_n);
> +               dev_err(dev, "cannot get sleep: %d\n", ret);
> +               return ret;
> +       }
> +
> +       /*
> +        * Request the reset pin low to avoid the bridge being
> +        * initialized prematurely
> +        */
> +       ps_bridge->gpio_rst_n = devm_gpiod_get(&client->dev, "reset",
> +                                              GPIOD_OUT_LOW);
> +       if (IS_ERR(ps_bridge->gpio_rst_n)) {
> +               ret = PTR_ERR(ps_bridge->gpio_rst_n);
> +               dev_err(dev, "cannot get reset: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ps_bridge->bridge.funcs = &ps8640_bridge_funcs;
> +       ps_bridge->bridge.of_node = dev->of_node;
> +       ret = drm_bridge_add(&ps_bridge->bridge);
> +       if (ret) {
> +               dev_err(dev, "Failed to add bridge: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ps_bridge->page[0] = client;
> +       ps_bridge->ddc_i2c = i2c_new_dummy(client->adapter, EDID_I2C_ADDR);
> +       if (!ps_bridge->ddc_i2c) {
> +               dev_err(dev, "failed ddc_i2c dummy device, address%02x\n",
> +                       EDID_I2C_ADDR);
> +               ret = -EBUSY;
> +               goto exit_ddc_i2c_dummy;
> +       }
> +       /*
> +        * ps8640 uses multiple addresses, use dummy devices for them
> +        * page[0]: for DP control
> +        * page[1]: for VIDEO Bridge
> +        * page[2]: for control top
> +        * page[3]: for DSI Link Control1
> +        * page[4]: for MIPI Phy
> +        * page[5]: for VPLL
> +        * page[6]: for DSI Link Control2
> +        * page[7]: for spi rom mapping
> +        */
> +       for (i = 1; i < 8; i++) {
> +               ps_bridge->page[i] = i2c_new_dummy(client->adapter,
> +                                                  client->addr + i);
> +               if (!ps_bridge->page[i]) {
> +                       dev_err(dev, "failed i2c dummy device, address%02x\n",
> +                               client->addr + i);
> +                       ret = -EBUSY;
> +                       goto exit_dummy;
> +               }
> +       }
> +       i2c_set_clientdata(client, ps_bridge);
> +
> +       ret = sysfs_create_group(&client->dev.kobj, &ps8640_attr_group);
> +       if (ret) {
> +               dev_err(dev, "failed to create sysfs entries: %d\n", ret);
> +               goto exit_dummy;
> +       }
> +
> +       ret = devm_add_action(dev, ps8640_remove_sysfs_group, ps_bridge);
> +       if (ret) {
> +               dev_err(dev, "failed to add sysfs cleanup action: %d\n", ret);
> +               goto exit_remove_sysfs;
> +       }
> +       return 0;
> +
> +exit_remove_sysfs:
> +       sysfs_remove_group(&ps_bridge->page[0]->dev.kobj, &ps8640_attr_group);
> +exit_dummy:
> +       for (i = 1; i < 8; i++)
> +               if (ps_bridge->page[i])
> +                       i2c_unregister_device(ps_bridge->page[i]);

i2c_unregister_device(ps_bridge->ddc_i2c);

> +exit_ddc_i2c_dummy:
> +       drm_bridge_remove(&ps_bridge->bridge);
> +       return ret;
> +}
> +
> +static int ps8640_remove(struct i2c_client *client)
> +{
> +       struct ps8640 *ps_bridge = i2c_get_clientdata(client);
> +       int i;
> +
> +       for (i = 1; i < 8; i++)
> +               i2c_unregister_device(ps_bridge->page[i]);

i2c_unregister_device(ps_bridge->ddc_i2c);

Ok, that's it for this round.
Thanks!

-Dan

> +
> +       drm_bridge_remove(&ps_bridge->bridge);
> +
> +       return 0;
> +}
