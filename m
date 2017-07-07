From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 7 Jul 2017 19:25:50 +0300
Subject: [PATCHv4 3/3] i2c: altera: Add Altera I2C Controller driver
In-Reply-To: <1497904618-27010-4-git-send-email-thor.thayer@linux.intel.com>
References: <1497904618-27010-1-git-send-email-thor.thayer@linux.intel.com>
 <1497904618-27010-4-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <CAHp75VcpdeGW0KXSqZwyMDkGbjT+6Ky5nBXTs7d-dN0gpYHV_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 11:36 PM,  <thor.thayer@linux.intel.com> wrote:

Either...
> +#include <linux/init.h>

...or...
> +#include <linux/module.h>

...choose one.

> +#define ALTR_I2C_THRESHOLD     0       /*IRQ Threshold at 1 element */

Space missed.

> +/**
> + * altr_i2c_empty_rx_fifo - Fetch data from RX FIFO until end of
> + * transfer. Send a Stop bit on the last byte.
> + */
> +static void altr_i2c_empty_rx_fifo(struct altr_i2c_dev *idev)
> +{
> +       size_t rx_fifo_avail = readl(idev->base + ALTR_I2C_RX_FIFO_LVL);
> +       int bytes_to_transfer = min(rx_fifo_avail, idev->msg_len);
> +

> +       while (bytes_to_transfer-- > 0) {
> +               *idev->buf++ = readl(idev->base + ALTR_I2C_RX_DATA);
> +               if (idev->msg_len == 1)
> +                       altr_i2c_stop(idev);
> +               else
> +                       writel(0, idev->base + ALTR_I2C_TFR_CMD);
> +
> +               idev->msg_len--;
> +       }

Move out invariant from the loop (and I see a bug, you might go over
boundaries).

       while (bytes_to_transfer-- > 0) {
               *idev->buf++ = readl(idev->base + ALTR_I2C_RX_DATA);
               if (idev->msg_len-- == 1)
                   break;
               writel(0, idev->base + ALTR_I2C_TFR_CMD);
       }

       altr_i2c_stop(idev);

> +}
> +
> +/**
> + * altr_i2c_fill_tx_fifo - Fill TX FIFO from current message buffer.
> + * @return: Number of bytes left to transfer.
> + */
> +static int altr_i2c_fill_tx_fifo(struct altr_i2c_dev *idev)
> +{
> +       size_t tx_fifo_avail = idev->fifo_size - readl(idev->base +
> +                                                      ALTR_I2C_TC_FIFO_LVL);
> +       int bytes_to_transfer = min(tx_fifo_avail, idev->msg_len);
> +       int ret = idev->msg_len - bytes_to_transfer;
> +
> +       while (bytes_to_transfer-- > 0) {
> +               if (idev->msg_len == 1)
> +                       writel(ALTR_I2C_TFR_CMD_STO | *idev->buf++,
> +                              idev->base + ALTR_I2C_TFR_CMD);
> +               else
> +                       writel(*idev->buf++, idev->base + ALTR_I2C_TFR_CMD);
> +               idev->msg_len--;
> +       }

Ditto.

> +
> +       return ret;
> +}

> +/**
> + * altr_i2c_wait_for_core_idle - After TX, check core idle for all bytes TX.
> + * @return: 0 on success or -ETIMEDOUT on timeout.
> + */
> +static int altr_i2c_wait_for_core_idle(struct altr_i2c_dev *idev)
> +{
> +       unsigned long timeout = jiffies + msecs_to_jiffies(ALTR_I2C_TIMEOUT);
> +
> +       do {
> +               if (time_after(jiffies, timeout)) {
> +                       dev_err(idev->dev, "Core Idle timeout\n");
> +                       return -ETIMEDOUT;
> +               }
> +       } while (readl(idev->base + ALTR_I2C_STATUS) & ALTR_I2C_STAT_CORE);
> +
> +       return 0;
> +}

readl_poll_timeout[_atomic]() please.

> +static irqreturn_t altr_i2c_isr(int irq, void *_dev)
> +{
> +       struct altr_i2c_dev *idev = _dev;

> +       /* Read IRQ status but only interested in Enabled IRQs. */
> +       u32 status = readl(idev->base + ALTR_I2C_ISR) &
> +                    readl(idev->base + ALTR_I2C_ISER);

Don't you have cached value for mask?

> +}

> +
> +static int altr_i2c_xfer_msg(struct altr_i2c_dev *idev, struct i2c_msg *msg)
> +{
> +       u32 int_mask = ALTR_I2C_ISR_RXOF | ALTR_I2C_ISR_ARB | ALTR_I2C_ISR_NACK;

> +       u32 addr = (msg->addr << 1) & 0xFF;

i2c_8bit_addr_from_msg() ?

> +       unsigned long time_left;
> +

> +       if (i2c_m_rd(msg)) {
> +               /* Dummy read to ensure RX FIFO is empty */
> +               readl(idev->base + ALTR_I2C_RX_DATA);
> +               addr |= ALTR_I2C_TFR_CMD_RW_D;
> +       }
> +
> +       writel(ALTR_I2C_TFR_CMD_STA | addr, idev->base + ALTR_I2C_TFR_CMD);
> +
> +       if (i2c_m_rd(msg)) {
> +               /* write the first byte to start the RX */
> +               writel(0, idev->base + ALTR_I2C_TFR_CMD);
> +               int_mask |= ALTR_I2C_ISER_RXOF_EN | ALTR_I2C_ISER_RXRDY_EN;
> +       } else {
> +               altr_i2c_fill_tx_fifo(idev);
> +               int_mask |= ALTR_I2C_ISR_TXRDY;
> +       }

It's hard to follow. Perhaps

if (read) {
 ...do for read...
} else {
 ...do for write...
}

> +       if (readl(idev->base + ALTR_I2C_STATUS) & ALTR_I2C_STAT_CORE)
> +               dev_err(idev->dev, "%s: Core Status not IDLE...\n", __func__);

Better to

val = readl();
if (val)
 ...

> +static int
> +altr_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> +{

Why [] ?!

> +       struct altr_i2c_dev *idev = i2c_get_adapdata(adap);

> +       int i;
> +       int ret = 0;
> +
> +       for (i = 0; ret == 0 && i < num; ++i)
> +               ret = altr_i2c_xfer_msg(idev, &msgs[i]);
> +
> +       return ret ? : i;

Oy vey...
Perhaps

static int altr_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg
*msgs, int num)
{
    struct altr_i2c_dev *idev = i2c_get_adapdata(adap);
    int ret;

    while (num--) {
        ret = altr_i2c_xfer_msg(idev, msgs++);
        if (ret)
            return ret;
    }
    return 0;
}

> +static u32 altr_i2c_func(struct i2c_adapter *adap)
> +{
> +       return I2C_FUNC_I2C;
> +}

Useless. Use value in place.

> +static int altr_i2c_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct altr_i2c_dev *idev = NULL;
> +       struct resource *res;
> +       int irq;

> +       int ret = 0;

Redundant assignment.

> +       if (of_property_read_u32(np, "fifo-size", &idev->fifo_size))
> +               idev->fifo_size = ALTR_I2C_DFLT_FIFO_SZ;

Shouldn't be possible to auto detect?

> +       if (of_property_read_u32(np, "clock-frequency", &idev->bus_clk_rate)) {

device_property_*() ?

> +               dev_err(&pdev->dev, "Default to 100kHz\n");
> +               idev->bus_clk_rate = 100000;    /* default clock rate */
> +       }

-- 
With Best Regards,
Andy Shevchenko
