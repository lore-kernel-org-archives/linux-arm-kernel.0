From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 9 Feb 2017 00:04:05 +0200
Subject: [PATCH v5 3/3] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <1486545372-5184-2-git-send-email-baoyou.xie@linaro.org>
References: <1486545372-5184-1-git-send-email-baoyou.xie@linaro.org>
 <1486545372-5184-2-git-send-email-baoyou.xie@linaro.org>
Message-ID: <CAHp75VdXZPcUHKAekrSCVFC7kUh8Wx+q1WjThqdVYhusd_LmBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 11:16 AM, Baoyou Xie <baoyou.xie@linaro.org> wrote:
> This patch adds i2c controller driver for ZTE's zx2967 family.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> Reviewed-by: Shawn Guo <shawnguo@kernel.org>

> +static int zx2967_i2c_empty_rx_fifo(struct zx2967_i2c_info *zx_i2c, u32 size)
> +{
> +       u8 val[I2C_FIFO_MAX] = {0};
> +       int i;

> +       zx2967_i2c_readsb(zx_i2c, val, REG_DATA, size);
> +       for (i = 0; i < size; i++) {

> +               *zx_i2c->buf++ = val[i];

Sorry, I just realized that it might be completely wrong.
Here we advance the buf pointer. If it's allocated the question is
where the beginning pointer is kept?
Or what I missed?

> +               zx_i2c->residue--;
> +               if (zx_i2c->residue <= 0)

How it could be < 0 ?

> +static int zx2967_i2c_xfer_msg(struct zx2967_i2c_info *zx_i2c,
> +                              struct i2c_msg *msg)
> +{
> +       if (msg->len == 0)
> +               return -EINVAL;
> +
> +       zx2967_i2c_flush_fifos(zx_i2c);
> +
> +       zx_i2c->buf = msg->buf;
> +       zx_i2c->residue = msg->len;
> +       zx_i2c->access_cnt = msg->len / I2C_FIFO_MAX;

> +       zx_i2c->msg_rd = (msg->flags & I2C_M_RD);

Redundant parens.

> +
> +       if (zx_i2c->msg_rd)
> +               return zx2967_i2c_xfer_read(zx_i2c);
> +
> +       return zx2967_i2c_xfer_write(zx_i2c);
> +}

> +       zx2967_i2c_writel(zx_i2c, (msgs->addr & 0x7f), REG_DEVADDR_L);

Ditto

> +       zx2967_i2c_writel(zx_i2c, (msgs->addr >> 7) & 0x7, REG_DEVADDR_H);

Though it might be written like this (depends on what style Wolfram prefers)

      zx2967_i2c_writel(zx_i2c, (msgs->addr >> 0) & 0x7f, REG_DEVADDR_L);
      zx2967_i2c_writel(zx_i2c, (msgs->addr >> 7) & 0x07, REG_DEVADDR_H);

> +       return num;
> +}

> +static void
> +zx2967_smbus_xfer_prepare(struct zx2967_i2c_info *zx_i2c, u16 addr,
> +                         char read_write, u8 command, int size,
> +                         union i2c_smbus_data *data)
> +{
> +       u32 val;
> +
> +       val = zx2967_i2c_readl(zx_i2c, REG_RDCONF);
> +       val |= I2C_RFIFO_RESET;
> +       zx2967_i2c_writel(zx_i2c, val, REG_RDCONF);
> +       zx2967_i2c_writel(zx_i2c, (addr & 0x7f), REG_DEVADDR_L);

Redundant parens.

> +       case I2C_SMBUS_WORD_DATA:
> +               zx2967_i2c_writel(zx_i2c, command, REG_DATA);
> +               if (read_write == I2C_SMBUS_WRITE) {

> +                       zx2967_i2c_writel(zx_i2c, (data->word >> 8), REG_DATA);
> +                       zx2967_i2c_writel(zx_i2c, (data->word & 0xff),

Btw does hw support byte access?
If so, _writeb() / _readb() would help a lot in this driver.

> +                                         REG_DATA);
> +               }
> +               break;
> +       }
> +}

> +static int zx2967_i2c_probe(struct platform_device *pdev)
> +{
> +       struct zx2967_i2c_info *zx_i2c;
> +       void __iomem *reg_base;


> +       ret = clk_prepare_enable(clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable i2c_clk\n");
> +               return ret;
> +       }

If Dmitry's patch gets upstream earlier than yours I would consider to
switch to devm_clk_prepare_enable().

> +
> +       ret = platform_get_irq(pdev, 0);
> +       if (ret < 0)
> +               return ret;

> +       zx_i2c->irq = ret;

I would group this with below assignments...

> +
> +       ret = device_property_read_u32(&pdev->dev, "clock-frequency",
> +                                      &zx_i2c->clk_freq);
> +       if (ret) {
> +               dev_err(&pdev->dev, "missing clock-frequency");
> +               return ret;
> +       }
> +

> +       zx_i2c->reg_base = reg_base;
> +       zx_i2c->clk = clk;

...^^^

-- 
With Best Regards,
Andy Shevchenko
