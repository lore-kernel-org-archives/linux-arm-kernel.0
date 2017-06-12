From: net147@gmail.com (Jonathan Liu)
Date: Mon, 12 Jun 2017 15:47:30 +1000
Subject: [PATCH] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
In-Reply-To: <CAGb2v66gdEe4jagsvVe7AeE5FwHfHo-9EvYkmnreK6A9cOc5UA@mail.gmail.com>
References: <20170612021217.27064-1-net147@gmail.com>
 <CAGb2v66gdEe4jagsvVe7AeE5FwHfHo-9EvYkmnreK6A9cOc5UA@mail.gmail.com>
Message-ID: <CANwerB0-9CeXn7=5RxD8Yxc6rMXktEhtqbhhyXg1tRipM0LPig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On 12 June 2017 at 13:28, Chen-Yu Tsai <wens@csie.org> wrote:
> On Mon, Jun 12, 2017 at 10:12 AM, Jonathan Liu <net147@gmail.com> wrote:
>> The drm_get_edid function should be used instead of drm_do_get_edid by
>> exposing the DDC bus as an I2C adapter. Implement this for A10s.
>
> Nice!

It is my first Linux kernel driver so there may be other things I have
overlooked. I am not sure about the behaviour of I2C writes larger
than 16 bytes but the EEPROMs I have tested only have a write buffer
of 8 bytes so writes are limited to a maximum of 8 bytes at a time
anyway.

>
>>
>> Signed-off-by: Jonathan Liu <net147@gmail.com>
>> ---
>>  drivers/gpu/drm/sun4i/Makefile         |   1 +
>>  drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  11 ++-
>>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c |  96 +++----------------
>>  drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c | 166 +++++++++++++++++++++++++++++++++
>>  4 files changed, 190 insertions(+), 84 deletions(-)
>>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
>>
>> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
>> index e29fd3a2ba9c..43c753cafc88 100644
>> --- a/drivers/gpu/drm/sun4i/Makefile
>> +++ b/drivers/gpu/drm/sun4i/Makefile
>> @@ -2,6 +2,7 @@ sun4i-drm-y += sun4i_drv.o
>>  sun4i-drm-y += sun4i_framebuffer.o
>>
>>  sun4i-drm-hdmi-y += sun4i_hdmi_enc.o
>> +sun4i-drm-hdmi-y += sun4i_hdmi_i2c.o
>>  sun4i-drm-hdmi-y += sun4i_hdmi_ddc_clk.o
>>  sun4i-drm-hdmi-y += sun4i_hdmi_tmds_clk.o
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> index 2589bc92be59..8e7a70f67f04 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> @@ -100,6 +100,7 @@
>>  #define SUN4I_HDMI_DDC_CTRL_START_CMD          BIT(30)
>>  #define SUN4I_HDMI_DDC_CTRL_FIFO_DIR_MASK      BIT(8)
>>  #define SUN4I_HDMI_DDC_CTRL_FIFO_DIR_READ      (0 << 8)
>> +#define SUN4I_HDMI_DDC_CTRL_FIFO_DIR_WRITE     (1 << 8)
>>  #define SUN4I_HDMI_DDC_CTRL_RESET              BIT(0)
>>
>>  #define SUN4I_HDMI_DDC_ADDR_REG                0x504
>> @@ -108,6 +109,10 @@
>>  #define SUN4I_HDMI_DDC_ADDR_OFFSET(off)                (((off) & 0xff) << 8)
>>  #define SUN4I_HDMI_DDC_ADDR_SLAVE(addr)                ((addr) & 0xff)
>>
>> +#define SUN4I_HDMI_DDC_INTERRUPT_STATUS_REG    0x50c
>> +#define SUN4I_HDMI_DDC_INTERRUPT_STATUS_FIFO_REQUEST   BIT(4)
>> +#define SUN4I_HDMI_DDC_INTERRUPT_STATUS_TRANSFER_COMPLETE      BIT(0)
>> +
>>  #define SUN4I_HDMI_DDC_FIFO_CTRL_REG   0x510
>>  #define SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR         BIT(31)
>>
>> @@ -115,7 +120,8 @@
>>  #define SUN4I_HDMI_DDC_BYTE_COUNT_REG  0x51c
>>
>>  #define SUN4I_HDMI_DDC_CMD_REG         0x520
>> -#define SUN4I_HDMI_DDC_CMD_EXPLICIT_EDDC_READ  6
>> +#define SUN4I_HDMI_DDC_CMD_IMPLICIT_WRITE      3
>> +#define SUN4I_HDMI_DDC_CMD_IMPLICIT_READ       5
>>
>>  #define SUN4I_HDMI_DDC_CLK_REG         0x528
>>  #define SUN4I_HDMI_DDC_CLK_M(m)                        (((m) & 0x7) << 3)
>> @@ -181,6 +187,8 @@ struct sun4i_hdmi {
>>         struct clk              *ddc_clk;
>>         struct clk              *tmds_clk;
>>
>> +       struct i2c_adapter      *i2c;
>> +
>>         struct sun4i_drv        *drv;
>>
>>         bool                    hdmi_monitor;
>> @@ -192,5 +200,6 @@ int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *clk);
>>  int sun6i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *clk);
>>  int sun4i_tmds_create(struct sun4i_hdmi *hdmi);
>>  int sun6i_tmds_create(struct sun4i_hdmi *hdmi);
>> +int sun4i_hdmi_i2c_create(struct sun4i_hdmi *hdmi);
>
> However you seem to have based it on the wrong branch/patches.
> You based them on my A31 HDMI patches, instead of what Maxime has
> in his sunxi-drm/for-next branch.
>
> I could add this to my A31 patches, though it probably won't make
> 4.13. Alternatively you could rebase them on top of Maxime's branch.

Yes, I forgot about that. I will rebase against sunxi-drm/for-next for V2.

>
>>
>>  #endif /* _SUN4I_HDMI_H_ */
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> index e9abf93eb41c..6c9b11c4cf68 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> @@ -186,93 +186,13 @@ static const struct drm_encoder_funcs sun4i_hdmi_funcs = {
>>         .destroy        = drm_encoder_cleanup,
>>  };
>>
>> -static int sun4i_hdmi_read_sub_block(struct sun4i_hdmi *hdmi,
>> -                                    unsigned int blk, unsigned int offset,
>> -                                    u8 *buf, unsigned int count)
>> -{
>> -       unsigned long reg;
>> -       int i;
>> -
>> -       reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> -       reg &= ~SUN4I_HDMI_DDC_CTRL_FIFO_DIR_MASK;
>> -       writel(reg | SUN4I_HDMI_DDC_CTRL_FIFO_DIR_READ,
>> -              hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> -
>> -       writel(SUN4I_HDMI_DDC_ADDR_SEGMENT(offset >> 8) |
>> -              SUN4I_HDMI_DDC_ADDR_EDDC(DDC_SEGMENT_ADDR << 1) |
>> -              SUN4I_HDMI_DDC_ADDR_OFFSET(offset) |
>> -              SUN4I_HDMI_DDC_ADDR_SLAVE(DDC_ADDR),
>> -              hdmi->base + SUN4I_HDMI_DDC_ADDR_REG);
>> -
>> -       reg = readl(hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
>> -       writel(reg | SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR,
>> -              hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
>> -
>> -       writel(count, hdmi->base + SUN4I_HDMI_DDC_BYTE_COUNT_REG);
>> -       writel(SUN4I_HDMI_DDC_CMD_EXPLICIT_EDDC_READ,
>> -              hdmi->base + SUN4I_HDMI_DDC_CMD_REG);
>> -
>> -       reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> -       writel(reg | SUN4I_HDMI_DDC_CTRL_START_CMD,
>> -              hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> -
>> -       if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG, reg,
>> -                              !(reg & SUN4I_HDMI_DDC_CTRL_START_CMD),
>> -                              100, 100000))
>> -               return -EIO;
>> -
>> -       for (i = 0; i < count; i++)
>> -               buf[i] = readb(hdmi->base + SUN4I_HDMI_DDC_FIFO_DATA_REG);
>> -
>> -       return 0;
>> -}
>> -
>> -static int sun4i_hdmi_read_edid_block(void *data, u8 *buf, unsigned int blk,
>> -                                     size_t length)
>> -{
>> -       struct sun4i_hdmi *hdmi = data;
>> -       int retry = 2, i;
>> -
>> -       do {
>> -               for (i = 0; i < length; i += SUN4I_HDMI_DDC_FIFO_SIZE) {
>> -                       unsigned char offset = blk * EDID_LENGTH + i;
>> -                       unsigned int count = min((unsigned int)SUN4I_HDMI_DDC_FIFO_SIZE,
>> -                                                length - i);
>> -                       int ret;
>> -
>> -                       ret = sun4i_hdmi_read_sub_block(hdmi, blk, offset,
>> -                                                       buf + i, count);
>> -                       if (ret)
>> -                               return ret;
>> -               }
>> -       } while (!drm_edid_block_valid(buf, blk, true, NULL) && (retry--));
>> -
>> -       return 0;
>> -}
>> -
>>  static int sun4i_hdmi_get_modes(struct drm_connector *connector)
>>  {
>>         struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
>> -       unsigned long reg;
>>         struct edid *edid;
>>         int ret;
>>
>> -       /* Reset i2c controller */
>> -       writel(SUN4I_HDMI_DDC_CTRL_ENABLE | SUN4I_HDMI_DDC_CTRL_RESET,
>> -              hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> -       if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG, reg,
>> -                              !(reg & SUN4I_HDMI_DDC_CTRL_RESET),
>> -                              100, 2000))
>> -               return -EIO;
>> -
>> -       writel(SUN4I_HDMI_DDC_LINE_CTRL_SDA_ENABLE |
>> -              SUN4I_HDMI_DDC_LINE_CTRL_SCL_ENABLE,
>> -              hdmi->base + SUN4I_HDMI_DDC_LINE_CTRL_REG);
>> -
>> -       clk_prepare_enable(hdmi->ddc_clk);
>> -       clk_set_rate(hdmi->ddc_clk, 100000);
>> -
>> -       edid = drm_do_get_edid(connector, sun4i_hdmi_read_edid_block, hdmi);
>> +       edid = drm_get_edid(connector, hdmi->i2c);
>>         if (!edid)
>>                 return 0;
>>
>> @@ -284,8 +204,6 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
>>         ret = drm_add_edid_modes(connector, edid);
>>         kfree(edid);
>>
>> -       clk_disable_unprepare(hdmi->ddc_clk);
>> -
>>         return ret;
>>  }
>>
>> @@ -424,6 +342,7 @@ struct sun4i_hdmi_variant {
>>         const struct drm_connector_helper_funcs *connector_helpers;
>>         int (*ddc_create)(struct sun4i_hdmi *hdmi, struct clk *clk);
>>         int (*tmds_create)(struct sun4i_hdmi *hdmi);
>> +       int (*hdmi_i2c_create)(struct sun4i_hdmi *hdmi);
>>         bool has_ddc_parent_clk;
>>         bool has_reset_control;
>>
>> @@ -439,6 +358,7 @@ static const struct sun4i_hdmi_variant sun5i_variant = {
>>         .connector_helpers      = &sun4i_hdmi_connector_helper_funcs,
>>         .ddc_create             = sun4i_ddc_create,
>>         .tmds_create            = sun4i_tmds_create,
>> +       .hdmi_i2c_create        = sun4i_hdmi_i2c_create,
>>         .has_ddc_parent_clk     = false,
>>         .has_reset_control      = false,
>>         .pad_ctrl0_init_val     = SUN4I_HDMI_PAD_CTRL0_TXEN |
>> @@ -622,6 +542,14 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
>>                 goto err_disable_mod_clk;
>>         }
>>
>> +       if (hdmi->variant->hdmi_i2c_create) {
>
> I don't think this would be optional.

This will be addressed in V2 when the patch is rebased.

>
>> +               ret = hdmi->variant->hdmi_i2c_create(hdmi);
>> +               if (ret) {
>> +                       dev_err(dev, "Couldn't create the HDMI I2C adapter\n");
>> +                       goto err_disable_mod_clk;
>> +               }
>> +       }
>> +
>
> You should also fix up the error path so that the I2C adapter
> gets remove if any of the subsequent calls fail.
>
>>         drm_encoder_helper_add(&hdmi->encoder,
>>                                &sun4i_hdmi_helper_funcs);
>>         ret = drm_encoder_init(drm,
>> @@ -676,6 +604,8 @@ static void sun4i_hdmi_unbind(struct device *dev, struct device *master,
>>
>>         drm_connector_cleanup(&hdmi->connector);
>>         drm_encoder_cleanup(&hdmi->encoder);
>> +       if (hdmi->i2c)
>> +               i2c_del_adapter(hdmi->i2c);
>
> So neither should this be optional.

Ditto. This will be addressed in V2 when the patch is rebased.

>
>>         clk_disable_unprepare(hdmi->mod_clk);
>>         clk_disable_unprepare(hdmi->bus_clk);
>>  }
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
>> new file mode 100644
>> index 000000000000..c33fa13cc668
>> --- /dev/null
>> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
>> @@ -0,0 +1,166 @@
>> +/*
>> + * Copyright (C) 2017 Jonathan Liu
>> + *
>> + * Jonathan Liu <net147@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of
>> + * the License, or (at your option) any later version.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/errno.h>
>> +#include <linux/clk.h>
>> +#include <linux/i2c.h>
>> +#include <linux/iopoll.h>
>> +
>> +#include "sun4i_hdmi.h"
>> +
>> +static int xfer_msg_chunk(struct sun4i_hdmi *hdmi, struct i2c_msg *msg)
>> +{
>> +       u32 count = min_t(u32, msg->len, SUN4I_HDMI_DDC_FIFO_SIZE);
>> +       u32 reg;
>> +       int i;
>> +
>> +       reg = readl(hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
>> +       writel(reg | SUN4I_HDMI_DDC_FIFO_CTRL_CLEAR,
>> +              hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
>> +
>> +       writel(count, hdmi->base
>> +              + SUN4I_HDMI_DDC_BYTE_COUNT_REG);
>> +       writel(msg->flags & I2C_M_RD
>> +              ? SUN4I_HDMI_DDC_CMD_IMPLICIT_READ
>> +              : SUN4I_HDMI_DDC_CMD_IMPLICIT_WRITE,
>> +              hdmi->base + SUN4I_HDMI_DDC_CMD_REG);
>> +
>> +       reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> +       writel(reg | SUN4I_HDMI_DDC_CTRL_START_CMD,
>> +              hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> +
>> +       if (!(msg->flags & I2C_M_RD)) {
>> +               for (i = 0; i < count; i++) {
>> +                       writeb(*msg->buf++, hdmi->base
>> +                              + SUN4I_HDMI_DDC_FIFO_DATA_REG);
>> +                       --msg->len;
>> +               }
>> +       }
>> +
>> +       if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG,
>> +                              reg,
>> +                              !(reg & SUN4I_HDMI_DDC_CTRL_START_CMD),
>> +                              100, 100000))
>> +               return -EIO;
>> +
>> +       reg = readl(hdmi->base + SUN4I_HDMI_DDC_INTERRUPT_STATUS_REG);
>> +       reg &= ~SUN4I_HDMI_DDC_INTERRUPT_STATUS_FIFO_REQUEST;
>> +
>> +       if (reg != SUN4I_HDMI_DDC_INTERRUPT_STATUS_TRANSFER_COMPLETE)
>> +               return -EIO;
>> +
>> +       if (msg->flags & I2C_M_RD) {
>> +               for (i = 0; i < count; i++) {
>> +                       *msg->buf++ = readb(hdmi->base
>> +                                           + SUN4I_HDMI_DDC_FIFO_DATA_REG);
>> +                       --msg->len;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int xfer_msg(struct sun4i_hdmi *hdmi, struct i2c_msg *msg)
>> +{
>> +       u32 reg;
>> +       int ret;
>> +
>> +       if (!msg->len)
>> +               return -EIO;
>> +
>> +       while (msg->len) {
>> +               reg = readl(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> +               reg &= ~SUN4I_HDMI_DDC_CTRL_FIFO_DIR_MASK;
>> +
>> +               writel(reg | (msg->flags & I2C_M_RD
>> +                             ? SUN4I_HDMI_DDC_CTRL_FIFO_DIR_READ
>> +                             : SUN4I_HDMI_DDC_CTRL_FIFO_DIR_WRITE),
>> +                      hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> +
>> +               writel(SUN4I_HDMI_DDC_ADDR_SLAVE(msg->addr),
>> +                      hdmi->base + SUN4I_HDMI_DDC_ADDR_REG);
>> +
>> +               ret = xfer_msg_chunk(hdmi, msg);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int sun4i_hdmi_i2c_xfer(struct i2c_adapter *adap,
>> +                              struct i2c_msg *msgs, int num)
>> +{
>> +       struct sun4i_hdmi *hdmi = i2c_get_adapdata(adap);
>> +       u32 reg;
>> +       int err, ret = num;
>> +       int i;
>> +
>> +       /* Reset i2c controller */
>> +       writel(SUN4I_HDMI_DDC_CTRL_ENABLE | SUN4I_HDMI_DDC_CTRL_RESET,
>> +              hdmi->base + SUN4I_HDMI_DDC_CTRL_REG);
>> +       if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_CTRL_REG, reg,
>> +                              !(reg & SUN4I_HDMI_DDC_CTRL_RESET),
>> +                              100, 2000))
>> +               return -EIO;
>> +
>> +       writel(SUN4I_HDMI_DDC_LINE_CTRL_SDA_ENABLE |
>> +              SUN4I_HDMI_DDC_LINE_CTRL_SCL_ENABLE,
>> +              hdmi->base + SUN4I_HDMI_DDC_LINE_CTRL_REG);
>> +
>> +       clk_prepare_enable(hdmi->ddc_clk);
>> +       clk_set_rate(hdmi->ddc_clk, 100000);
>> +
>> +       for (i = 0; i < num; i++) {
>> +               err = xfer_msg(hdmi, &msgs[i]);
>> +               if (err) {
>> +                       ret = err;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       clk_disable_unprepare(hdmi->ddc_clk);
>> +       return ret;
>> +}
>> +
>> +static u32 sun4i_hdmi_i2c_func(struct i2c_adapter *adap)
>> +{
>> +       return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>> +}
>> +
>> +static const struct i2c_algorithm sun4i_hdmi_i2c_algorithm = {
>> +       .master_xfer    = sun4i_hdmi_i2c_xfer,
>> +       .functionality  = sun4i_hdmi_i2c_func,
>> +};
>> +
>> +static struct i2c_adapter sun4i_hdmi_i2c_adapter = {
>> +       .owner  = THIS_MODULE,
>> +       .class  = I2C_CLASS_DDC,
>> +       .algo   = &sun4i_hdmi_i2c_algorithm,
>> +       .name   = "sun4i_hdmi_i2c adapter",
>> +};
>> +
>> +int sun4i_hdmi_i2c_create(struct sun4i_hdmi *hdmi)
>> +{
>> +       int ret = 0;
>> +
>> +       i2c_set_adapdata(&sun4i_hdmi_i2c_adapter, hdmi);
>> +
>> +       ret = i2c_add_adapter(&sun4i_hdmi_i2c_adapter);
>> +       if (ret)
>> +               return ret;
>> +
>> +       hdmi->i2c = &sun4i_hdmi_i2c_adapter;
>> +
>> +       return ret;
>> +}
>> --
>> 2.12.2
>>
>
> The rest looks good to me.
>
> Regards
> ChenYu

Will follow up with V2 shortly.

Regards,
Jonathan
