From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 7 Feb 2017 12:47:20 +0200
Subject: [PATCH v4 3/3] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <1486351569-4814-3-git-send-email-baoyou.xie@linaro.org>
References: <1486351569-4814-1-git-send-email-baoyou.xie@linaro.org>
 <1486351569-4814-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <CAHp75Ve+J+ECRpsCCoV_87nHH+AALQpgrygiy0qSOFMK22yABw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2017 at 5:26 AM, Baoyou Xie <baoyou.xie@linaro.org> wrote:
> This patch adds i2c controller driver for ZTE's zx2967 family.

> +#define I2C_STOP                       0
> +#define I2C_MASTER                     BIT(0)
> +#define I2C_ADDR_MODE_TEN              BIT(1)
> +#define I2C_IRQ_MSK_ENABLE             BIT(3)
> +#define I2C_RW_READ                    BIT(4)
> +#define I2C_CMB_RW_EN                  BIT(5)
> +#define I2C_START                      BIT(6)

> +#define I2C_ADDR_MODE_TEN              BIT(1)

I'm not sure you have to repeat this.

> +#define I2C_WFIFO_RESET                        BIT(7)
> +#define I2C_RFIFO_RESET                        BIT(7)

Hmm... Are they applied to the same register?

> +struct zx2967_i2c_info {
> +       spinlock_t              lock;

> +       struct device           *dev;
> +       struct i2c_adapter      adap;

I'm pretty sure you may access *dev from adap. Or they are different devices?

> +       struct clk              *clk;
> +       struct completion       complete;
> +       u32                     clk_freq;
> +       void __iomem            *reg_base;
> +       size_t                  residue;
> +       int                     irq;
> +       int                     msg_rd;
> +       u8                      *buf;
> +       u8                      access_cnt;
> +       bool                    is_suspended;
> +};


> +static void zx2967_i2c_flush_fifos(struct zx2967_i2c_info *zx_i2c)
> +{

> +       u32 val;
> +       u32 offset;

Reversed tree?

> +
> +       if (zx_i2c->msg_rd) {
> +               offset = REG_RDCONF;
> +               val = I2C_RFIFO_RESET;
> +       } else {
> +               offset = REG_WRCONF;
> +               val = I2C_WFIFO_RESET;
> +       }
> +
> +       val |= zx2967_i2c_readl(zx_i2c, offset);
> +       zx2967_i2c_writel(zx_i2c, val, offset);
> +}

> +       zx2967_i2c_readsb(zx_i2c, val, REG_DATA, size);
> +       for (i = 0; i < size; i++) {

> +               *(zx_i2c->buf++) = val[i];

Do you need parens? I guess *p++ = x; is quite understandable pattern.

> +               zx_i2c->residue--;
> +               if (zx_i2c->residue <= 0)
> +                       break;
> +       }
> +
> +       barrier();
> +
> +       return 0;
> +}

> +static int zx2967_i2c_fill_tx_fifo(struct zx2967_i2c_info *zx_i2c)
> +{

> +       u8 *buf = zx_i2c->buf;
> +       size_t residue = zx_i2c->residue;

Reversed tree?

> +
> +       if (residue == 0) {
> +               dev_err(zx_i2c->dev, "residue is %d\n", (int)residue);
> +               return -EINVAL;
> +       }

> +static void zx2967_enable_tenbit(struct zx2967_i2c_info *zx_i2c, __u16 addr)
> +{
> +       u16 val = (addr >> 7) & 0x7;

Magic values.

> +       if (val > 0) {

It can't be negative ->

if (val) {

> +               zx2967_i2c_writel(zx_i2c, val, REG_DEVADDR_H);
> +               val = (zx2967_i2c_readl(zx_i2c, REG_CMD)) | I2C_ADDR_MODE_TEN;
> +               zx2967_i2c_writel(zx_i2c, val, REG_CMD);
> +       }
> +}

> +static int zx2967_i2c_xfer(struct i2c_adapter *adap,
> +                          struct i2c_msg *msgs, int num)
> +{
> +       struct zx2967_i2c_info *zx_i2c = i2c_get_adapdata(adap);
> +       int ret;
> +       int i;
> +
> +       if (zx_i2c->is_suspended)
> +               return -EBUSY;
> +
> +       zx2967_i2c_writel(zx_i2c, (msgs->addr & 0x7f), REG_DEVADDR_L);
> +       zx2967_i2c_writel(zx_i2c, (msgs->addr >> 7) & 0x7, REG_DEVADDR_H);
> +       if (zx2967_i2c_readl(zx_i2c, REG_DEVADDR_H) > 0)
> +               zx2967_enable_tenbit(zx_i2c, msgs->addr);
> +
> +       for (i = 0; i < num; i++) {
> +               ret = zx2967_i2c_xfer_msg(zx_i2c, &msgs[i]);
> +               if (ret)
> +                       return ret;

> +               if (num > 1)

Would it be drastic performance impact if you remove this condition
and do sleep unconditionally?

> +                       usleep_range(1000, 2000);

Why do you need this in any case? Comment, please. Do this for every
non-commented *sleep() call in this driver.
(You may define minimum sleep range, put comment there and use it in
those *sleep() calls)

> +       }
> +
> +       return num;
> +}

> +#ifdef CONFIG_PM
> +static const struct dev_pm_ops zx2967_i2c_dev_pm_ops = {
> +       .suspend        = zx2967_i2c_suspend,
> +       .resume         = zx2967_i2c_resume,
> +};
> +#define ZX2967_I2C_DEV_PM_OPS  (&zx2967_i2c_dev_pm_ops)
> +#else
> +#define        ZX2967_I2C_DEV_PM_OPS   NULL
> +#endif

Remove these ugly #ifdef:s There are suitable macros are available in
pm.h. Like SIMPLE_PM_OPS().

> +static int zx2967_i2c_probe(struct platform_device *pdev)
> +{
> +       struct zx2967_i2c_info *zx_i2c;
> +       void __iomem *reg_base;
> +       struct resource *res;
> +       struct clk *clk;
> +       int ret;

> +       ret = device_property_read_u32(&pdev->dev, "clock-frequency",
> +                                      &zx_i2c->clk_freq);
> +       if (ret) {
> +               dev_err(&pdev->dev, "missing clock-frequency");
> +               return ret;
> +       }

How is it used? You enabled clock before this and that clock
apparently has to have frequency > 0. Isn't the same frequency we are
considering here?

> +       zx_i2c->reg_base = reg_base;
> +       zx_i2c->clk = clk;
> +       zx_i2c->dev = &pdev->dev;

> +       i2c_set_adapdata(&zx_i2c->adap, zx_i2c);

> +       zx_i2c->adap.owner = THIS_MODULE;

Is it still needed?

-- 
With Best Regards,
Andy Shevchenko
