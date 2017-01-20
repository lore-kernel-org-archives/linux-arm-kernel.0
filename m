From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 20 Jan 2017 23:45:15 +0200
Subject: [PATCH v1 3/3] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <1484901827-16369-3-git-send-email-baoyou.xie@linaro.org>
References: <1484901827-16369-1-git-send-email-baoyou.xie@linaro.org>
 <1484901827-16369-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <CAHp75VfjS-Wdun65Tx8xEniTVfiMASu022K9ipVRwxJLE8SXkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 10:43 AM, Baoyou Xie <baoyou.xie@linaro.org> wrote:
> This patch adds i2c controller driver for ZTE's zx2967 family.
>

> +config I2C_ZX2967
> +       bool "ZTE zx2967 I2C support"

No module?

> +       depends on ARCH_ZX
> +       default y

Would architecture selects it instead?

> +       help
> +         Selecting this option will add ZX I2C driver.
> +         If unsure, say y.

Two sentences about the same in spite 'default y'.

> +#define BW1                            (u32)1

Do you really need casting?

> +#define I2C_STOP                       0
> +#define I2C_MASTER                     (1 << 0)

BIT(0) ?
And so further.

> +#define I2C_INT_MASK                   0x3f

GENMASK(6, 0) ?


> +#define I2C_ERROR_MASK                 (I2C_ERROR_DATA | I2C_ERROR_DEVICE)

Ditto.
GENMASK() with explicit numbers.

> +static int zx2967_i2c_flush_fifos(struct zx2967_i2c_info *zx_i2c)
> +{
> +       u32 val = 0;
> +       u32 offset = 0;

Useless assignments.

> +
> +       if (zx_i2c->msg_rd) {
> +               offset = REG_RDCONF;
> +               val = I2C_RFIFO_RESET;
> +       } else {
> +               offset = REG_WRCONF;
> +               val = I2C_WFIFO_RESET;
> +       }

> +static int zx2967_i2c_empty_rx_fifo(struct zx2967_i2c_info *zx_i2c, u32 size)
> +{

> +       u8  val[I2C_FIFO_MAX] = {0};
> +       int i = 0;

Ditto.

> +
> +       if (size == 0) {

Would it be the case?

> +               dev_err(zx_i2c->dev, "size is invalid\n");
> +               return -EINVAL;
> +       }

And what happens even in that case if you just remove this check?

> +
> +       zx2967_i2c_readsb(zx_i2c, val, REG_DATA, size);
> +       for (i = 0; i < size; i++) {
> +               *(zx_i2c->buf++) = val[i];
> +               zx_i2c->residue--;
> +               if (zx_i2c->residue <= 0)
> +                       break;

> +static int zx2967_i2c_fill_tx_fifo(struct zx2967_i2c_info *zx_i2c)
> +{
> +       u8 *buf = zx_i2c->buf;
> +       size_t residue = zx_i2c->residue;
> +
> +       if (residue == 0) {
> +               dev_err(zx_i2c->dev, "residue is %d\n", (int)residue);
> +               return -EINVAL;
> +       }

Ditto.


> +static void  zx2967_enable_tenbit(struct zx2967_i2c_info *zx_i2c, __u16 addr)
> +{
> +       u16 val = ((addr >> 7) & 0x7);

Redundant parens.

> +       if (val > 0) {

if (!val)
 return;

> +static int zx2967_i2c_xfer_msg(struct zx2967_i2c_info *zx_i2c,
> +                              struct i2c_msg *msg
> +{
> +       unsigned long time_left = 0;

> +       unsigned int i = 0;

Redundant assignment.

> +
> +       if (msg->len == 0)

if (!msg...)

> +               return -EINVAL;

> +static int zx2967_i2c_xfer(struct i2c_adapter *adap,
> +                          struct i2c_msg *msgs, int num)
> +{
> +       int i;

> +       int ret = 0;

Redundant. See below.

> +       struct zx2967_i2c_info *zx_i2c = i2c_get_adapdata(adap);

Reverse tree, please.

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

int ret;

> +               ret = zx2967_i2c_xfer_msg(zx_i2c, &msgs[i]);
> +               if (num > 1)
> +                       usleep_range(1000, 2000);
> +               if (ret)

> +                       break;

return ret;

> +       }
> +

> +       return ret ?: i;

return i;

And looking now, how i can't be num here?

> +}

> +{
> +       struct zx2967_i2c_info *zx_i2c = i2c_get_adapdata(adap);

> +       u32 val;
> +       u8 buf[2];
> +       unsigned long time_left;

Reverse tree.

> +       usleep_range(1000, 2000);
> +       switch (size) {
> +       case I2C_SMBUS_BYTE:
> +       case I2C_SMBUS_BYTE_DATA:
> +               val = zx2967_i2c_readl(zx_i2c, REG_DATA);
> +               data->byte = val;
> +               break;
> +       case I2C_SMBUS_WORD_DATA:
> +       case I2C_SMBUS_PROC_CALL:
> +               buf[0] = zx2967_i2c_readl(zx_i2c, REG_DATA);
> +               buf[1] = zx2967_i2c_readl(zx_i2c, REG_DATA);
> +               data->word = (buf[0] << 8) | buf[1];
> +               break;
> +       default:
> +               dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}

I would revisit those several loooong functions for splitting/refactoring.

> +
> +static u32 zx2967_i2c_func(struct i2c_adapter *adap)
> +{
> +       return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
> +              I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> +              I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_PROC_CALL |
> +              I2C_FUNC_I2C | I2C_FUNC_SMBUS_I2C_BLOCK;
> +}

It's just
#define XXX YY1 | YY2 | ...

> +#ifdef CONFIG_PM
> +static int zx2967_i2c_suspend(struct device *dev)

Switch to __maybe_unuse.

> +static int zx2967_i2c_probe(struct platform_device *pdev)
> +{

> +       struct resource *res;
> +       struct zx2967_i2c_info *zx_i2c = NULL;

Redundant assignment.

> +       struct clk *clk;
> +       void __iomem *reg_base;

Reverse tree for all above until top of this function.

> +       int ret = 0;

Redundant assignment.

> +
> +       zx_i2c = devm_kzalloc(&pdev->dev, sizeof(*zx_i2c), GFP_KERNEL);
> +       if (!zx_i2c)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

> +       if (!res) {
> +               dev_err(&pdev->dev, "missing io resource\n");
> +               return -EINVAL;
> +       }
> +

Completely redundant lines of code.

> +       reg_base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(reg_base))
> +               return PTR_ERR(reg_base);
> +
> +       clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(clk)) {
> +               dev_err(&pdev->dev, "missing controller clock");
> +               return PTR_ERR(clk);
> +       }
> +
> +       ret = clk_prepare_enable(clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable i2c_clk\n");
> +               return ret;
> +       }
> +

> +       of_property_read_u32(pdev->dev.of_node,
> +                       "clock-frequency", &zx_i2c->clk_freq);

devce_property_read_uXX();

> +       zx_i2c->reg_base = reg_base;
> +       zx_i2c->clk = clk;

> +       zx_i2c->irq = platform_get_irq(pdev, 0);

Is this optional?
Otherwise has to be checked.

> +       zx_i2c->id = pdev->id;
> +       zx_i2c->dev = &pdev->dev;
> +
> +       zx_i2c->pin_scl = devm_pinctrl_get_select(&pdev->dev, "scl");
> +       if (IS_ERR(zx_i2c->pin_scl))
> +               dev_info(&pdev->dev, "scl pin is not specified in dts\n");
> +
> +       zx_i2c->pin_sda = devm_pinctrl_get_select(&pdev->dev, "sda");
> +       if (IS_ERR(zx_i2c->pin_sda))
> +               dev_info(&pdev->dev, "sda pin is not specified in dts\n");
> +
> +       spin_lock_init(&zx_i2c->lock);
> +       init_completion(&zx_i2c->complete);
> +       platform_set_drvdata(pdev, zx_i2c);
> +
> +       ret = zx2967_i2c_reset_hardware(zx_i2c);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to initialize i2c controller\n");
> +               goto unprepare_clk;
> +       }
> +
> +       ret = devm_request_irq(&pdev->dev, zx_i2c->irq,
> +                       zx2967_i2c_isr, 0, dev_name(&pdev->dev), zx_i2c);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to request irq %i\n", zx_i2c->irq);
> +               goto unprepare_clk;
> +       }
> +
> +       i2c_set_adapdata(&zx_i2c->adap, zx_i2c);

> +       zx_i2c->adap.owner = THIS_MODULE;

Do you need this?

> +       zx_i2c->adap.class = I2C_CLASS_DEPRECATED;
> +       strlcpy(zx_i2c->adap.name, "zx2967 i2c adapter",
> +               sizeof(zx_i2c->adap.name));
> +       zx_i2c->adap.algo = &zx2967_i2c_algo;
> +       zx_i2c->adap.dev.parent = &pdev->dev;
> +       zx_i2c->adap.nr = pdev->id;
> +       zx_i2c->adap.dev.of_node = pdev->dev.of_node;
> +
> +       ret = i2c_add_numbered_adapter(&zx_i2c->adap);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to add zx2967 i2c adapter\n");
> +               goto unprepare_clk;
> +       }
> +
> +       return 0;
> +
> +unprepare_clk:

err_clk_unprepare:

> +       clk_unprepare(zx_i2c->clk);

Perhaps clk_disable_unprepare();

> +       return ret;
> +}
> +
> +static int zx2967_i2c_remove(struct platform_device *pdev)
> +{
> +       struct zx2967_i2c_info *zx_i2c = platform_get_drvdata(pdev);
> +
> +       i2c_del_adapter(&zx_i2c->adap);

> +       clk_unprepare(zx_i2c->clk);

Ditto.

> +
> +       return 0;
> +}

> +MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
> +MODULE_DESCRIPTION("ZTE zx2967 I2C Bus Controller driver");
> +MODULE_LICENSE("GPL v2");

When bool in Kconfig this all redundant.

-- 
With Best Regards,
Andy Shevchenko
