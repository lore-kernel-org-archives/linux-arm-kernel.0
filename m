From: dianders@chromium.org (Doug Anderson)
Date: Wed, 16 Sep 2015 13:04:03 -0700
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <CAD=FV=XZ4cY4o-=vL79GDE4m57B+Rw_Yr_QwtB6T7DbQNzmU0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Aug 30, 2015 at 2:34 PM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
> The change adds support of internal HDMI I2C master controller, this
> subdevice is used by default, if "ddc-i2c-bus" DT property is omitted.
>
> The main purpose of this functionality is to support reading EDID from
> an HDMI monitor on boards, which don't have an I2C bus connected to
> DDC pins.
>
> The current implementation does not support "I2C Master Interface
> Extended Read Mode" to read data addressed by non-zero segment
> pointer, this means that if EDID has more than 1 extension blocks,
> EDID reading operation won't succeed, in my practice all tested HDMI
> monitors have at maximum one extension block.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
> The change is based on today's v4.2, please let me know, if it should be rebased.
>
> The change has compilation dependency on I2CM_ADDRESS register name fix,
> see http://lists.freedesktop.org/archives/dri-devel/2015-May/082980.html
>
> From http://lists.freedesktop.org/archives/dri-devel/2015-May/082981.html
> v1 of the change was
>
>   Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> but I hesitate to add the tag here due to multiple updates in v2.
>
> Changes from v2 to v3, thanks to Russell:
> - moved register field value definitions to dw_hdmi.h
> - made completions uninterruptible to avoid transfer retries if interrupted
> - use one completion for both read and write transfers as in v1, operation_reg is removed
> - redundant i2c->stat = 0 is removed from dw_hdmi_i2c_read/write()
> - struct i2c_algorithm dw_hdmi_algorithm is qualified as const
> - dw_hdmi_i2c_adapter() does not modify struct dw_hdmi on error path
> - dw_hdmi_i2c_irq() does not modify hdmi->i2c->stat, if interrupt is not for I2CM
> - spin lock is removed from dw_hdmi_i2c_irq()
> - removed spin lock from dw_hdmi_i2c_xfer() around write to HDMI_IH_MUTE_I2CM_STAT0 register
> - split loop over message array in dw_hdmi_i2c_xfer() to validation and transfer parts
> - added a mutex to serialize I2C transfer requests, i2c->lock is completely removed
> - removed if(len) check from dw_hdmi_i2c_write(), hardware supports only len>0 transfers
> - described extension blocks <= 1 limitation in the commit message
> - a number of minor clean ups
>
> Changes from v1 to v2:
> - fixed a devm_kfree() signature
> - split completions for read and write operations
>
>  drivers/gpu/drm/bridge/dw_hdmi.c | 262 ++++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/bridge/dw_hdmi.h |  19 +++
>  2 files changed, 275 insertions(+), 6 deletions(-)

Not sure what the status of this patch is, but I'll make a few more
suggestions in case they're helpful.


> +static void dw_hdmi_i2c_init(struct dw_hdmi *hdmi)
> +{
> +       /* Set Fast Mode speed */
> +       hdmi_writeb(hdmi, 0x0b, HDMI_I2CM_DIV);

If you're going to hardcode to something, it seems like hardcoding to
standard mode might be better?  It's likely that users will plug into
all kinds of broken / crappy HDMI devices out there.  I think you'll
get better compatibility by using the slower mode, and EDID transfers
really aren't too performance critical are they?


> +
> +       /* Software reset */
> +       hdmi_writeb(hdmi, 0x00, HDMI_I2CM_SOFTRSTZ);

Unless there's a reason not to, it seems like the reset ought to be
the first thing in this function (before setting the I2CM_DIV).  Even
if it doesn't actually reset the speed on current hardware, it just
seems cleaner.


> +static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
> +                           struct i2c_msg *msgs, int num)
> +{
> +       struct dw_hdmi *hdmi = i2c_get_adapdata(adap);
> +       struct dw_hdmi_i2c *i2c = hdmi->i2c;
> +       u8 addr = msgs[0].addr;
> +       int i, ret = 0;
> +
> +       dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
> +
> +       for (i = 0; i < num; i++) {
> +               if (msgs[i].addr != addr) {
> +                       dev_warn(hdmi->dev,
> +                                "unsupported transfer, changed slave address\n");
> +                       return -EOPNOTSUPP;
> +               }
> +
> +               if (msgs[i].len == 0) {
> +                       dev_dbg(hdmi->dev,
> +                               "unsupported transfer %d/%d, no data\n",
> +                               i + 1, num);
> +                       return -EOPNOTSUPP;
> +               }
> +       }
> +
> +       mutex_lock(&i2c->lock);
> +

If I may make a suggestion, it's worth considering putting
dw_hdmi_i2c_init() here and removing it from the dw_hdmi_bind()
function.  There isn't any state kept between i2c transfers (each one
is independent), so re-initting each time won't hurt.  ...and doing so
has the potential to fix some things.

On rk3288 there's at least one case where the i2c controller can get
wedged and just totally stops working.  Although this particular wedge
isn't fixed by calling dw_hdmi_i2c_init() (it needs a full controller
reset to fix), it's possible that there may be other cases where the
HDMI_I2CM_SOFTRSTZ fixes some bad state.

Note: if you do that, you can just init HDMI_IH_MUTE_I2CM_STAT0 to
0x00 at the end of dw_hdmi_i2c_init() and skip the next statement...

> +       hdmi_writeb(hdmi, 0x00, HDMI_IH_MUTE_I2CM_STAT0);


-Doug

On Sun, Aug 30, 2015 at 2:34 PM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
> The change adds support of internal HDMI I2C master controller, this
> subdevice is used by default, if "ddc-i2c-bus" DT property is omitted.
>
> The main purpose of this functionality is to support reading EDID from
> an HDMI monitor on boards, which don't have an I2C bus connected to
> DDC pins.
>
> The current implementation does not support "I2C Master Interface
> Extended Read Mode" to read data addressed by non-zero segment
> pointer, this means that if EDID has more than 1 extension blocks,
> EDID reading operation won't succeed, in my practice all tested HDMI
> monitors have at maximum one extension block.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
> The change is based on today's v4.2, please let me know, if it should be rebased.
>
> The change has compilation dependency on I2CM_ADDRESS register name fix,
> see http://lists.freedesktop.org/archives/dri-devel/2015-May/082980.html
>
> From http://lists.freedesktop.org/archives/dri-devel/2015-May/082981.html
> v1 of the change was
>
>   Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> but I hesitate to add the tag here due to multiple updates in v2.
>
> Changes from v2 to v3, thanks to Russell:
> - moved register field value definitions to dw_hdmi.h
> - made completions uninterruptible to avoid transfer retries if interrupted
> - use one completion for both read and write transfers as in v1, operation_reg is removed
> - redundant i2c->stat = 0 is removed from dw_hdmi_i2c_read/write()
> - struct i2c_algorithm dw_hdmi_algorithm is qualified as const
> - dw_hdmi_i2c_adapter() does not modify struct dw_hdmi on error path
> - dw_hdmi_i2c_irq() does not modify hdmi->i2c->stat, if interrupt is not for I2CM
> - spin lock is removed from dw_hdmi_i2c_irq()
> - removed spin lock from dw_hdmi_i2c_xfer() around write to HDMI_IH_MUTE_I2CM_STAT0 register
> - split loop over message array in dw_hdmi_i2c_xfer() to validation and transfer parts
> - added a mutex to serialize I2C transfer requests, i2c->lock is completely removed
> - removed if(len) check from dw_hdmi_i2c_write(), hardware supports only len>0 transfers
> - described extension blocks <= 1 limitation in the commit message
> - a number of minor clean ups
>
> Changes from v1 to v2:
> - fixed a devm_kfree() signature
> - split completions for read and write operations
>
>  drivers/gpu/drm/bridge/dw_hdmi.c | 262 ++++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/bridge/dw_hdmi.h |  19 +++
>  2 files changed, 275 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index 816d104..d329e04 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -1,14 +1,15 @@
>  /*
> + * DesignWare High-Definition Multimedia Interface (HDMI) driver
> + *
> + * Copyright (C) 2013-2015 Mentor Graphics Inc.
>   * Copyright (C) 2011-2013 Freescale Semiconductor, Inc.
> + * Copyright (C) 2010, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
>   * (at your option) any later version.
>   *
> - * Designware High-Definition Multimedia Interface (HDMI) driver
> - *
> - * Copyright (C) 2010, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>   */
>  #include <linux/module.h>
>  #include <linux/irq.h>
> @@ -102,6 +103,17 @@ struct hdmi_data_info {
>         struct hdmi_vmode video_mode;
>  };
>
> +struct dw_hdmi_i2c {
> +       struct i2c_adapter      adap;
> +
> +       struct mutex            lock;
> +       struct completion       cmp;
> +       u8                      stat;
> +
> +       u8                      slave_reg;
> +       bool                    is_regaddr;
> +};
> +
>  struct dw_hdmi {
>         struct drm_connector connector;
>         struct drm_encoder *encoder;
> @@ -111,6 +123,7 @@ struct dw_hdmi {
>         struct device *dev;
>         struct clk *isfr_clk;
>         struct clk *iahb_clk;
> +       struct dw_hdmi_i2c *i2c;
>
>         struct hdmi_data_info hdmi_data;
>         const struct dw_hdmi_plat_data *plat_data;
> @@ -179,6 +192,200 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
>         hdmi_modb(hdmi, data << shift, mask, reg);
>  }
>
> +static void dw_hdmi_i2c_init(struct dw_hdmi *hdmi)
> +{
> +       /* Set Fast Mode speed */
> +       hdmi_writeb(hdmi, 0x0b, HDMI_I2CM_DIV);
> +
> +       /* Software reset */
> +       hdmi_writeb(hdmi, 0x00, HDMI_I2CM_SOFTRSTZ);
> +
> +       /* Set done, not acknowledged and arbitration interrupt polarities */
> +       hdmi_writeb(hdmi, HDMI_I2CM_INT_DONE_POL, HDMI_I2CM_INT);
> +       hdmi_writeb(hdmi, HDMI_I2CM_CTLINT_NAC_POL | HDMI_I2CM_CTLINT_ARB_POL,
> +                   HDMI_I2CM_CTLINT);
> +
> +       /* Clear DONE and ERROR interrupts */
> +       hdmi_writeb(hdmi, HDMI_IH_I2CM_STAT0_ERROR | HDMI_IH_I2CM_STAT0_DONE,
> +                   HDMI_IH_I2CM_STAT0);
> +
> +       /* Mute DONE and ERROR interrupts */
> +       hdmi_writeb(hdmi, HDMI_IH_I2CM_STAT0_ERROR | HDMI_IH_I2CM_STAT0_DONE,
> +                   HDMI_IH_MUTE_I2CM_STAT0);
> +}
> +
> +static int dw_hdmi_i2c_read(struct dw_hdmi *hdmi,
> +                           unsigned char *buf, unsigned int length)
> +{
> +       struct dw_hdmi_i2c *i2c = hdmi->i2c;
> +       int stat;
> +
> +       if (!i2c->is_regaddr) {
> +               dev_dbg(hdmi->dev, "set read register address to 0\n");
> +               i2c->slave_reg = 0x00;
> +               i2c->is_regaddr = true;
> +       }
> +
> +       while (length--) {
> +               reinit_completion(&i2c->cmp);
> +
> +               hdmi_writeb(hdmi, i2c->slave_reg++, HDMI_I2CM_ADDRESS);
> +               hdmi_writeb(hdmi, HDMI_I2CM_OPERATION_READ,
> +                           HDMI_I2CM_OPERATION);
> +
> +               stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
> +               if (!stat)
> +                       return -EAGAIN;
> +
> +               /* Check for error condition on the bus */
> +               if (i2c->stat & HDMI_IH_I2CM_STAT0_ERROR)
> +                       return -EIO;
> +
> +               *buf++ = hdmi_readb(hdmi, HDMI_I2CM_DATAI);
> +       }
> +
> +       return 0;
> +}
> +
> +static int dw_hdmi_i2c_write(struct dw_hdmi *hdmi,
> +                            unsigned char *buf, unsigned int length)
> +{
> +       struct dw_hdmi_i2c *i2c = hdmi->i2c;
> +       int stat;
> +
> +       if (!i2c->is_regaddr) {
> +               /* Use the first write byte as register address */
> +               i2c->slave_reg = buf[0];
> +               length--;
> +               buf++;
> +               i2c->is_regaddr = true;
> +       }
> +
> +       while (length--) {
> +               reinit_completion(&i2c->cmp);
> +
> +               hdmi_writeb(hdmi, *buf++, HDMI_I2CM_DATAO);
> +               hdmi_writeb(hdmi, i2c->slave_reg++, HDMI_I2CM_ADDRESS);
> +               hdmi_writeb(hdmi, HDMI_I2CM_OPERATION_WRITE,
> +                           HDMI_I2CM_OPERATION);
> +
> +               stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
> +               if (!stat)
> +                       return -EAGAIN;
> +
> +               /* Check for error condition on the bus */
> +               if (i2c->stat & HDMI_IH_I2CM_STAT0_ERROR)
> +                       return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
> +                           struct i2c_msg *msgs, int num)
> +{
> +       struct dw_hdmi *hdmi = i2c_get_adapdata(adap);
> +       struct dw_hdmi_i2c *i2c = hdmi->i2c;
> +       u8 addr = msgs[0].addr;
> +       int i, ret = 0;
> +
> +       dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
> +
> +       for (i = 0; i < num; i++) {
> +               if (msgs[i].addr != addr) {
> +                       dev_warn(hdmi->dev,
> +                                "unsupported transfer, changed slave address\n");
> +                       return -EOPNOTSUPP;
> +               }
> +
> +               if (msgs[i].len == 0) {
> +                       dev_dbg(hdmi->dev,
> +                               "unsupported transfer %d/%d, no data\n",
> +                               i + 1, num);
> +                       return -EOPNOTSUPP;
> +               }
> +       }
> +
> +       mutex_lock(&i2c->lock);
> +
> +       hdmi_writeb(hdmi, 0x00, HDMI_IH_MUTE_I2CM_STAT0);
> +
> +       /* Set slave device address taken from the first I2C message */
> +       hdmi_writeb(hdmi, addr, HDMI_I2CM_SLAVE);
> +
> +       /* Set slave device register address on transfer */
> +       i2c->is_regaddr = false;
> +
> +       for (i = 0; i < num; i++) {
> +               dev_dbg(hdmi->dev, "xfer: num: %d/%d, len: %d, flags: %#x\n",
> +                       i + 1, num, msgs[i].len, msgs[i].flags);
> +
> +               if (msgs[i].flags & I2C_M_RD)
> +                       ret = dw_hdmi_i2c_read(hdmi, msgs[i].buf, msgs[i].len);
> +               else
> +                       ret = dw_hdmi_i2c_write(hdmi, msgs[i].buf, msgs[i].len);
> +
> +               if (ret < 0)
> +                       break;
> +       }
> +
> +       if (!ret)
> +               ret = num;
> +
> +       /* Mute DONE and ERROR interrupts */
> +       hdmi_writeb(hdmi, HDMI_IH_I2CM_STAT0_ERROR | HDMI_IH_I2CM_STAT0_DONE,
> +                   HDMI_IH_MUTE_I2CM_STAT0);
> +
> +       mutex_unlock(&i2c->lock);
> +
> +       return ret;
> +}
> +
> +static u32 dw_hdmi_i2c_func(struct i2c_adapter *adapter)
> +{
> +       return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static const struct i2c_algorithm dw_hdmi_algorithm = {
> +       .master_xfer    = dw_hdmi_i2c_xfer,
> +       .functionality  = dw_hdmi_i2c_func,
> +};
> +
> +static struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi)
> +{
> +       struct i2c_adapter *adap;
> +       struct dw_hdmi_i2c *i2c;
> +       int ret;
> +
> +       i2c = devm_kzalloc(hdmi->dev, sizeof(*i2c), GFP_KERNEL);
> +       if (!i2c)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mutex_init(&i2c->lock);
> +       init_completion(&i2c->cmp);
> +
> +       adap = &i2c->adap;
> +       adap->class = I2C_CLASS_DDC;
> +       adap->owner = THIS_MODULE;
> +       adap->dev.parent = hdmi->dev;
> +       adap->algo = &dw_hdmi_algorithm;
> +       strlcpy(adap->name, "DesignWare HDMI", sizeof(adap->name));
> +       i2c_set_adapdata(adap, hdmi);
> +
> +       ret = i2c_add_adapter(adap);
> +       if (ret) {
> +               dev_warn(hdmi->dev, "cannot add %s I2C adapter\n", adap->name);
> +               devm_kfree(hdmi->dev, i2c);
> +               return ERR_PTR(ret);
> +       }
> +
> +       hdmi->i2c = i2c;
> +
> +       dev_info(hdmi->dev, "registered %s I2C bus driver\n", adap->name);
> +
> +       return adap;
> +}
> +
>  static void hdmi_set_cts_n(struct dw_hdmi *hdmi, unsigned int cts,
>                            unsigned int n)
>  {
> @@ -1466,16 +1673,40 @@ static struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>         .mode_fixup = dw_hdmi_bridge_mode_fixup,
>  };
>
> +static irqreturn_t dw_hdmi_i2c_irq(struct dw_hdmi *hdmi)
> +{
> +       struct dw_hdmi_i2c *i2c = hdmi->i2c;
> +       unsigned int stat;
> +
> +       stat = hdmi_readb(hdmi, HDMI_IH_I2CM_STAT0);
> +       if (!stat)
> +               return IRQ_NONE;
> +
> +       hdmi_writeb(hdmi, stat, HDMI_IH_I2CM_STAT0);
> +
> +       i2c->stat = stat;
> +
> +       complete(&i2c->cmp);
> +
> +       return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
>  {
>         struct dw_hdmi *hdmi = dev_id;
>         u8 intr_stat;
> +       irqreturn_t ret = IRQ_NONE;
> +
> +       if (hdmi->i2c)
> +               ret = dw_hdmi_i2c_irq(hdmi);
>
>         intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
> -       if (intr_stat)
> +       if (intr_stat) {
>                 hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
> +               return IRQ_WAKE_THREAD;
> +       }
>
> -       return intr_stat ? IRQ_WAKE_THREAD : IRQ_NONE;
> +       return ret;
>  }
>
>  static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
> @@ -1654,6 +1885,13 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
>          */
>         hdmi_init_clk_regenerator(hdmi);
>
> +       /* If DDC bus is not specified, try to register HDMI I2C bus */
> +       if (!hdmi->ddc) {
> +               hdmi->ddc = dw_hdmi_i2c_adapter(hdmi);
> +               if (IS_ERR(hdmi->ddc))
> +                       hdmi->ddc = NULL;
> +       }
> +
>         /*
>          * Configure registers related to HDMI interrupt
>          * generation before registering IRQ.
> @@ -1674,11 +1912,18 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
>         /* Unmute interrupts */
>         hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
>
> +       /* Unmute I2CM interrupts and reset HDMI DDC I2C master controller */
> +       if (hdmi->i2c)
> +               dw_hdmi_i2c_init(hdmi);
> +
>         dev_set_drvdata(dev, hdmi);
>
>         return 0;
>
>  err_iahb:
> +       if (hdmi->i2c)
> +               i2c_del_adapter(&hdmi->i2c->adap);
> +
>         clk_disable_unprepare(hdmi->iahb_clk);
>  err_isfr:
>         clk_disable_unprepare(hdmi->isfr_clk);
> @@ -1699,13 +1944,18 @@ void dw_hdmi_unbind(struct device *dev, struct device *master, void *data)
>
>         clk_disable_unprepare(hdmi->iahb_clk);
>         clk_disable_unprepare(hdmi->isfr_clk);
> -       i2c_put_adapter(hdmi->ddc);
> +
> +       if (hdmi->i2c)
> +               i2c_del_adapter(&hdmi->i2c->adap);
> +       else
> +               i2c_put_adapter(hdmi->ddc);
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
>
>  MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
>  MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
>  MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
> +MODULE_AUTHOR("Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>");
>  MODULE_DESCRIPTION("DW HDMI transmitter driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:dw-hdmi");
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.h b/drivers/gpu/drm/bridge/dw_hdmi.h
> index ee7f7ed..9ed85eb 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.h
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.h
> @@ -563,6 +563,10 @@ enum {
>         HDMI_IH_PHY_STAT0_TX_PHY_LOCK = 0x2,
>         HDMI_IH_PHY_STAT0_HPD = 0x1,
>
> +/* IH_I2CM_STAT0 and IH_MUTE_I2CM_STAT0 field values */
> +       HDMI_IH_I2CM_STAT0_DONE = 0x2,
> +       HDMI_IH_I2CM_STAT0_ERROR = 0x1,
> +
>  /* IH_MUTE_I2CMPHY_STAT0 field values */
>         HDMI_IH_MUTE_I2CMPHY_STAT0_I2CMPHYDONE = 0x2,
>         HDMI_IH_MUTE_I2CMPHY_STAT0_I2CMPHYERROR = 0x1,
> @@ -1029,6 +1033,21 @@ enum {
>         HDMI_A_VIDPOLCFG_HSYNCPOL_MASK = 0x2,
>         HDMI_A_VIDPOLCFG_HSYNCPOL_ACTIVE_HIGH = 0x2,
>         HDMI_A_VIDPOLCFG_HSYNCPOL_ACTIVE_LOW = 0x0,
> +
> +/* I2CM_OPERATION field values */
> +       HDMI_I2CM_OPERATION_WRITE = 0x10,
> +       HDMI_I2CM_OPERATION_READ_EXT = 0x2,
> +       HDMI_I2CM_OPERATION_READ = 0x1,
> +
> +/* I2CM_INT field values */
> +       HDMI_I2CM_INT_DONE_POL = 0x8,
> +       HDMI_I2CM_INT_DONE_MASK = 0x4,
> +
> +/* I2CM_CTLINT field values */
> +       HDMI_I2CM_CTLINT_NAC_POL = 0x80,
> +       HDMI_I2CM_CTLINT_NAC_MASK = 0x40,
> +       HDMI_I2CM_CTLINT_ARB_POL = 0x8,
> +       HDMI_I2CM_CTLINT_ARB_MASK = 0x4,
>  };
>
>  #endif /* __DW_HDMI_H__ */
> --
> 2.5.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
