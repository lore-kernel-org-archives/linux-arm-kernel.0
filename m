From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 30 Jun 2018 15:14:37 +0300
Subject: [PATCH v2 5/6] i2c: Add Actions Semi OWL family S900 I2C driver
In-Reply-To: <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
 <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
Message-ID: <CAHp75Vd__qOXVxZTdxREwD6p1sEw49R2Kqb+esAmr_EhtT=gFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 9:10 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add Actions Semi OWL family S900 I2C driver.

> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

> +#include <linux/io.h>

Perhaps keep in order?

> +#define OWL_I2C_DEFAULT_SPEED  100000
> +#define OWL_I2C_MAX_SPEED      400000

..._SPEED -> ..._SPEED_HZ ?

DEFAULT -> DEF ?

> +static int owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
> +{
> +       unsigned int val, timeout = 0;
> +
> +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +                               OWL_I2C_CTL_EN, false);

> +       mdelay(1);

1 ms keeping CPU busy for nothing. Perhaps usleep_range() / msleep()?
Is it called in atomic context?

> +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +                               OWL_I2C_CTL_EN, true);
> +
> +       /* Reset FIFO */
> +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +                               OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR,
> +                               true);
> +
> +       /* Wait 50ms for FIFO reset complete */
> +       do {
> +               val = readl(i2c_dev->base + OWL_I2C_REG_FIFOCTL);
> +               if (!(val & (OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR)))
> +                       break;

> +               mdelay(1);

Ditto.

> +       } while (timeout++ < OWL_I2C_MAX_RETRIES);

OK, I see you call it from IRQ context. 50ms for IRQ handler is
inappropriate. (1ms either, but@least not so drastically).

> +}

> +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> +{

> +       stat = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> +       if (stat & OWL_I2C_STAT_BEB) {
> +               dev_dbg(&i2c_dev->adap.dev, "bus error");

> +               owl_i2c_reset(i2c_dev);

This is questionable to be here (looking at so loong delays in it).

> +               goto stop;
> +       }

> +       return IRQ_HANDLED;
> +}

> +static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +                               int num)
> +{

> +       int ret = 0, idx;

Redundant assignment.

> +       ret = owl_i2c_hw_init(i2c_dev);
> +       if (ret)
> +               return ret;

> +}

> +static const struct i2c_algorithm owl_i2c_algorithm = {
> +       .master_xfer    = owl_i2c_master_xfer,

> +       .functionality  = owl_i2c_func

Slightly better to keep comma at the end

> +};
> +
> +static const struct i2c_adapter_quirks owl_i2c_quirks = {
> +       .flags          = I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
> +       .max_read_len   = 240,
> +       .max_write_len  = 240,
> +       .max_comb_1st_msg_len = 6,
> +       .max_comb_2nd_msg_len = 240

Ditto.

> +};

-- 
With Best Regards,
Andy Shevchenko
