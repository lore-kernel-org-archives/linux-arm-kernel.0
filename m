From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Thu, 16 Jun 2016 20:14:07 +0100
Subject: [PATCH 2/2 v16] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1464861445-11086-2-git-send-email-jitao.shi@mediatek.com>
References: <1464861445-11086-1-git-send-email-jitao.shi@mediatek.com>
 <1464861445-11086-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <CACvgo53002XCPLufbJHQLC1uL1nNS7_0gh=napedetmvT6FoSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao Shi,

A few comments/suggestions which I hope you'll find useful. Note that
I'm not an expert in the area so take them with a pinch of salt.

On 2 June 2016 at 10:57, Jitao Shi <jitao.shi@mediatek.com> wrote:

> +#define WRITE_STATUS_REG_CMD   0x01
> +#define READ_STATUS_REG_CMD    0x05
> +#define BUSY                   BIT(0)
> +#define CLEAR_ALL_PROTECT      0x00
> +#define BLK_PROTECT_BITS       0x0c
> +#define STATUS_REG_PROTECT     BIT(7)
> +#define WRITE_ENABLE_CMD       0x06
> +#define CHIP_ERASE_CMD         0xc7
> +#define MAX_DEVS               0x8
Some of the above are unused - SPI_MAX_RETRY_CNT and PAGE2_SWSPI_CTL
come to might. Please double-check and nuke any unused ones for now ?

Add blank line between the macro definitions and the struct.

> +struct ps8640_info {
> +       u8 family_id;
> +       u8 variant_id;
> +       u16 version;
> +};
> +
> +struct ps8640 {
> +       struct drm_connector connector;
> +       struct drm_bridge bridge;
> +       struct edid *edid;
> +       struct mipi_dsi_device dsi;
> +       struct i2c_client *page[MAX_DEVS];
Throw in an enum that provides symbolic names for the different i2c
clients and rename "page" to clients or anything else that makes it
clearer ? Seems like '1' and '6' are never used.

Using better names than client2/7 in the actual code will be great :-)

> +       struct i2c_client *ddc_i2c;
> +       struct regulator_bulk_data supplies[2];
> +       struct drm_panel *panel;
> +       struct gpio_desc *gpio_rst_n;
> +       struct gpio_desc *gpio_slp_n;
> +       struct gpio_desc *gpio_mode_sel_n;
What does the _n suffix mean in the above three ? Bikeshed:
reset_gpio, sleep_gpio and mode_sel(ect)_gpio could also be used ;-)

> +       bool enabled;
> +
> +       /* firmware file info */
> +       struct ps8640_info info;
> +       bool in_fw_update;
> +       /* for firmware update protect */
> +       struct mutex fw_mutex;
> +};
> +
> +static const u8 enc_ctrl_code[6] = { 0xaa, 0x55, 0x50, 0x41, 0x52, 0x44 };
These feel a bit magical. Any chance you can give them symbolic names ?

> +static const u8 hw_chip_id[4] = { 0x00, 0x0a, 0x00, 0x30 };
> +
> +static inline struct ps8640 *bridge_to_ps8640(struct drm_bridge *e)
> +{
> +       return container_of(e, struct ps8640, bridge);
> +}
> +
> +static inline struct ps8640 *connector_to_ps8640(struct drm_connector *e)
> +{
> +       return container_of(e, struct ps8640, connector);
> +}
> +
> +static int ps8640_read(struct i2c_client *client, u8 reg, u8 *data,
> +                      u16 data_len)
> +{
> +       int ret;
> +       struct i2c_msg msgs[] = {
> +               {
> +                .addr = client->addr,
> +                .flags = 0,
> +                .len = 1,
> +                .buf = &reg,
> +               },
> +               {
> +                .addr = client->addr,
> +                .flags = I2C_M_RD,
> +                .len = data_len,
> +                .buf = data,
> +               }
> +       };
> +
> +       ret = i2c_transfer(client->adapter, msgs, 2);
> +
> +       if (ret == 2)
> +               return 0;
> +       if (ret < 0)
> +               return ret;
> +       else
> +               return -EIO;
> +}
> +
> +static int ps8640_write_bytes(struct i2c_client *client, const u8 *data,
> +                             u16 data_len)
> +{
> +       int ret;
> +       struct i2c_msg msg;
> +
> +       msg.addr = client->addr;
> +       msg.flags = 0;
> +       msg.len = data_len;
> +       msg.buf = (u8 *)data;
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
> +{
> +       u8 buf[] = { reg, data };
> +
> +       return ps8640_write_bytes(client, buf, sizeof(buf));
> +}
> +
> +static void ps8640_get_mcu_fw_version(struct ps8640 *ps_bridge)
> +{
> +       struct i2c_client *client = ps_bridge->page[5];
> +       u8 fw_ver[2];
> +
> +       ps8640_read(client, 0x4, fw_ver, sizeof(fw_ver));
> +       ps_bridge->info.version = (fw_ver[0] << 8) | fw_ver[1];
> +
> +       DRM_INFO_ONCE("ps8640 rom fw version %d.%d\n", fw_ver[0], fw_ver[1]);
> +}
> +
> +static int ps8640_bridge_unmute(struct ps8640 *ps_bridge)
> +{
> +       struct i2c_client *client = ps_bridge->page[3];
> +       u8 vdo_ctrl_buf[3] = { PAGE3_SET_ADD, VDO_CTL_ADD, VDO_EN };
> +
> +       return ps8640_write_bytes(client, vdo_ctrl_buf, sizeof(vdo_ctrl_buf));
> +}
> +
> +static int ps8640_bridge_mute(struct ps8640 *ps_bridge)
> +{
> +       struct i2c_client *client = ps_bridge->page[3];
> +       u8 vdo_ctrl_buf[3] = { PAGE3_SET_ADD, VDO_CTL_ADD, VDO_DIS };
> +
> +       return ps8640_write_bytes(client, vdo_ctrl_buf, sizeof(vdo_ctrl_buf));
> +}
> +
> +static void ps8640_pre_enable(struct drm_bridge *bridge)
> +{
> +       struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +       struct i2c_client *client = ps_bridge->page[2];
> +       int err;
> +       u8 set_vdo_done;
> +       ktime_t timeout;
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
> +

> +       timeout = ktime_add_ms(ktime_get(), 200);
> +       for (;;) {
> +               err = ps8640_read(client, PAGE2_GPIO_H, &set_vdo_done, 1);
> +               if (err < 0) {
> +                       DRM_ERROR("failed read PAGE2_GPIO_H: %d\n", err);
> +                       goto err_regulators_disable;
> +               }
> +               if ((set_vdo_done & PS_GPIO9) == PS_GPIO9)
> +                       break;
> +               if (ktime_compare(ktime_get(), timeout) > 0)
> +                       break;
> +               msleep(20);
> +       }
> +
This is the first such construct in DRM. Is there anything wrong using
something like the following ? Same question applies for the rest of
the patch.


count = XX;

for (i = 0; i < count; i++) {
    err = ps8640_read(client, PAGE2_GPIO_H, &set_vdo_done, 1);
    if (err < 0) {
        DRM_ERROR("failed read PAGE2_GPIO_H: %d\n", err);
        goto err_regulators_disable;
    }
    if ((set_vdo_done & PS_GPIO9) == PS_GPIO9)
        break;

    msleep(20);
}

if (i == count) {
    print_some_warning()
    error_out()
}



> +static int ps8640_get_modes(struct drm_connector *connector)
> +{

> +
> +       edid = devm_kmalloc(dev, sizeof(edid), GFP_KERNEL);
> +       if (!edid) {
> +               DRM_ERROR("Failed to allocate EDID\n");
> +               return 0;
Remove this. drm_get_edid() already returns a kmalloc'd hunk of memory.

> +       }
> +
> +       edid = drm_get_edid(connector, ps_bridge->ddc_i2c->adapter);
> +       if (!edid)
> +               goto out;
> +


> +int ps8640_bridge_attach(struct drm_bridge *bridge)
> +{
> +       struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +       struct device *dev = &ps_bridge->page[0]->dev;
> +       struct device_node *np = dev->of_node;
Kill off the temporary variable. dev->of_node is not that long and
it's used only once.

> +       struct mipi_dsi_host *host = ps_bridge->dsi.host;
This looks a bit odd. Can you move it to the !dsi_node below and add a
small comment ?



> +       if (dsi_node) {
> +               host = of_find_mipi_dsi_host_by_node(dsi_node);
> +               of_node_put(dsi_node);
> +               if (!host) {
> +                       ret = -ENODEV;
> +                       goto err;
> +               }
> +       }
> +
} else {
    // Use XXX if there's no dsi host provided by DT
    host = ps_bridge->dsi.host;
}


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
> +               goto err_spi;
> +
> +       ret = ps8640_wait_spi_nobusy(ps_bridge);
> +       if (ret)
> +               goto err_spi;
> +
> +       ret = ps8640_write_byte(client, PAGE2_IROM_CTRL, IROM_DISABLE);
> +       if (ret)
> +               goto exit;
> +
> +       return 0;
> +
> +err_spi:
> +       ps8640_write_byte(client, PAGE2_IROM_CTRL, IROM_DISABLE);
> +exit:
> +       if (ret)
ret is always non zero here.

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
> +       if (ps_bridge->gpio_mode_sel_n)
> +               gpiod_set_value(ps_bridge->gpio_mode_sel_n, 0);
> +
> +       /* reset spi interface */
> +       ret = ps8640_write_byte(client, PAGE2_SW_RESET,
> +                               SPI_SW_RESET | MPU_SW_RESET);
> +       if (ret)
> +               goto exit;
> +
> +       ret = ps8640_write_byte(client, PAGE2_SW_RESET, MPU_SW_RESET);
> +       if (ret)
> +               goto exit;
> +
Add "return 0;" ...

> +exit:
> +       if (ret)
... drop this check.

> +               dev_err(&client->dev, "fail reset spi interface: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int ps8640_rom_prepare(struct ps8640 *ps_bridge)
> +{


> +       for (i = 0; i < 6; i++)
s/6/ARRAY_SIZE(enc_ctrl_code)/

> +               ps8640_write_byte(client, PAGE2_ENCTLSPI_WR, enc_ctrl_code[i]);


> +static int ps8640_write_rom(struct ps8640 *ps_bridge, const struct firmware *fw)
> +{
> +       struct i2c_client *client = ps_bridge->page[0];
> +       struct device *dev = &client->dev;
> +       struct i2c_client *client2 = ps_bridge->page[2];
> +       struct i2c_client *client7 = ps_bridge->page[7];
> +       size_t pos;
> +       u8 buf[257], rom_page_id_buf[3];
> +       int ret;
> +       u16 cpy_len;
> +
> +       ps8640_write_byte(client2, PAGE2_SPI_CFG3, I2C_TO_SPI_RESET);
> +       msleep(100);
> +       ps8640_write_byte(client2, PAGE2_SPI_CFG3, 0x00);
> +
> +       for (pos = 0; pos < fw->size; pos += cpy_len) {
> +               rom_page_id_buf[0] = PAGE2_ROMADD_BYTE1;
> +               rom_page_id_buf[1] = pos >> 8;
> +               rom_page_id_buf[2] = pos >> 16;
Reuse buf[], the stack is getting big enough already ?

> +               ret = ps8640_write_bytes(client2, rom_page_id_buf, 3);
> +               if (ret)
> +                       goto error;
> +               cpy_len = fw->size >= 256 + pos ? 256 : fw->size - pos;
cpy_len = min(256, fw->size - pos); perhaps ?

> +               buf[0] = 0;
> +               memcpy(buf + 1, fw->data + pos, cpy_len);
> +               ret = ps8640_write_bytes(client7, buf, cpy_len + 1);
> +               if (ret)
> +                       goto error;
> +
> +               dev_dbg(dev, "fw update completed %zu / %zu bytes\n", pos,
> +                       fw->size);
> +       }
> +       return 0;
> +
> +error:
> +       dev_err(dev, "failed write external flash, %d\n", ret);
> +       return ret;
> +}
> +
> +static int ps8640_spi_normal_mode(struct ps8640 *ps_bridge)
> +{
Is it that ps8640_spi_send_cmd()... 'cannot fail' in here, unlike in
ps8640_spi_dl_mode() and ps8640_rom_prepare() ? If so it might be
worth adding a line or two of comment and making
ps8640_spi_normal_mode() return void.


> +static int ps8640_load_fw(struct ps8640 *ps_bridge, const struct firmware *fw)
> +{
> +       struct i2c_client *client = ps_bridge->page[0];
> +       struct device *dev = &client->dev;
> +       int ret;
> +       bool ps8640_status_backup = ps_bridge->enabled;
> +
> +       ret = ps8640_validate_firmware(ps_bridge, fw);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&ps_bridge->fw_mutex);
> +       if (!ps_bridge->in_fw_update) {
> +               if (!ps8640_status_backup)
> +                       ps8640_pre_enable(&ps_bridge->bridge);
> +
> +               ret = ps8640_enter_bl(ps_bridge);
IMHO open-coding ps8640_enter_bl/ps8640_exit_bl and having the
in_fw_update manipulation visible will make things more obvious.

> +               if (ret)
> +                       goto exit;
> +       }
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
Why are we calling these even if we never executed
ps8640_pre_enable/ps8640_enter_bl above ?


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
Can the device operate without a firmware ? If not, why is the
firmware loaded so later/after user interaction (via sysfs) ? I don't
recall any other driver in DRM to use such an approach.


Regards,
Emil
