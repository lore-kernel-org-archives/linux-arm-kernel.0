From: peda@axentia.se (Peter Rosin)
Date: Thu, 19 Jul 2018 08:01:46 +0200
Subject: [PATCH v4 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C
 driver
In-Reply-To: <20180701172305.15663-6-manivannan.sadhasivam@linaro.org>
References: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
 <20180701172305.15663-6-manivannan.sadhasivam@linaro.org>
Message-ID: <d1a1d687-dfa4-e9cb-7216-67d458000234@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-01 19:23, Manivannan Sadhasivam wrote:
> Add Actions Semiconductor Owl family S900 I2C driver.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/i2c/busses/Kconfig   |   7 +
>  drivers/i2c/busses/Makefile  |   1 +
>  drivers/i2c/busses/i2c-owl.c | 504 +++++++++++++++++++++++++++++++++++
>  3 files changed, 512 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-owl.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 4f8df2ec87b1..8c8025f87ce4 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -762,6 +762,13 @@ config I2C_OMAP
>  	  Like OMAP1510/1610/1710/5912 and OMAP242x.
>  	  For details see http://www.ti.com/omap.
>  
> +config I2C_OWL
> +	tristate "Actions Semiconductor Owl I2C Controller"
> +	depends on ARCH_ACTIONS || COMPILE_TEST
> +	help
> +	  Say Y here if you want to use the I2C bus controller on
> +	  the Actions Semiconductor Owl SoC's.
> +
>  config I2C_PASEMI
>  	tristate "PA Semi SMBus interface"
>  	depends on PPC_PASEMI && PCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 5a869144a0c5..b71618f77880 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_I2C_MXS)		+= i2c-mxs.o
>  obj-$(CONFIG_I2C_NOMADIK)	+= i2c-nomadik.o
>  obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
>  obj-$(CONFIG_I2C_OMAP)		+= i2c-omap.o
> +obj-$(CONFIG_I2C_OWL)		+= i2c-owl.o
>  obj-$(CONFIG_I2C_PASEMI)	+= i2c-pasemi.o
>  obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
>  obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> new file mode 100644
> index 000000000000..580f8d092302
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -0,0 +1,504 @@
> +// SPDX-License-Identifier: GPL-2.0+

The preferred spelling is GPL-2.0-or-later

> +/*
> + * Actions Semiconductor Owl SoC's I2C driver
> + *
> + * Copyright (c) 2014 Actions Semi Inc.
> + * Author: David Liu <liuwei@actions-semi.com>
> + *
> + * Copyright (c) 2018 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +/* I2C registers */
> +#define OWL_I2C_REG_CTL		0x0000
> +#define OWL_I2C_REG_CLKDIV	0x0004
> +#define OWL_I2C_REG_STAT	0x0008
> +#define OWL_I2C_REG_ADDR	0x000C
> +#define OWL_I2C_REG_TXDAT	0x0010
> +#define OWL_I2C_REG_RXDAT	0x0014
> +#define OWL_I2C_REG_CMD		0x0018
> +#define OWL_I2C_REG_FIFOCTL	0x001C
> +#define OWL_I2C_REG_FIFOSTAT	0x0020
> +#define OWL_I2C_REG_DATCNT	0x0024
> +#define OWL_I2C_REG_RCNT	0x0028
> +
> +/* I2Cx_CTL Bit Mask */
> +#define OWL_I2C_CTL_RB		BIT(1)
> +#define OWL_I2C_CTL_GBCC(x)	(((x) & 0x3) << 2)
> +#define	OWL_I2C_CTL_GBCC_NONE	OWL_I2C_CTL_GBCC(0)
> +#define	OWL_I2C_CTL_GBCC_START	OWL_I2C_CTL_GBCC(1)
> +#define	OWL_I2C_CTL_GBCC_STOP	OWL_I2C_CTL_GBCC(2)
> +#define	OWL_I2C_CTL_GBCC_RSTART	OWL_I2C_CTL_GBCC(3)
> +#define OWL_I2C_CTL_IRQE	BIT(5)
> +#define OWL_I2C_CTL_EN		BIT(7)
> +#define OWL_I2C_CTL_AE		BIT(8)
> +#define OWL_I2C_CTL_SHSM	BIT(10)
> +
> +#define OWL_I2C_DIV_FACTOR(x)	((x) & 0xff)
> +
> +/* I2Cx_STAT Bit Mask */
> +#define OWL_I2C_STAT_RACK	BIT(0)
> +#define OWL_I2C_STAT_BEB	BIT(1)
> +#define OWL_I2C_STAT_IRQP	BIT(2)
> +#define OWL_I2C_STAT_LAB	BIT(3)
> +#define OWL_I2C_STAT_STPD	BIT(4)
> +#define OWL_I2C_STAT_STAD	BIT(5)
> +#define OWL_I2C_STAT_BBB	BIT(6)
> +#define OWL_I2C_STAT_TCB	BIT(7)
> +#define OWL_I2C_STAT_LBST	BIT(8)
> +#define OWL_I2C_STAT_SAMB	BIT(9)
> +#define OWL_I2C_STAT_SRGC	BIT(10)
> +
> +/* I2Cx_CMD Bit Mask */
> +#define OWL_I2C_CMD_SBE		BIT(0)
> +#define OWL_I2C_CMD_RBE		BIT(4)
> +#define OWL_I2C_CMD_DE		BIT(8)
> +#define OWL_I2C_CMD_NS		BIT(9)
> +#define OWL_I2C_CMD_SE		BIT(10)
> +#define OWL_I2C_CMD_MSS		BIT(11)
> +#define OWL_I2C_CMD_WRS		BIT(12)
> +#define OWL_I2C_CMD_SECL	BIT(15)
> +
> +#define OWL_I2C_CMD_AS(x)	(((x) & 0x7) << 1)
> +#define OWL_I2C_CMD_SAS(x)	(((x) & 0x7) << 5)
> +
> +/* I2Cx_FIFOCTL Bit Mask */
> +#define OWL_I2C_FIFOCTL_NIB	BIT(0)
> +#define OWL_I2C_FIFOCTL_RFR	BIT(1)
> +#define OWL_I2C_FIFOCTL_TFR	BIT(2)
> +
> +/* I2Cc_FIFOSTAT Bit Mask */
> +#define OWL_I2C_FIFOSTAT_RNB	BIT(1)
> +#define OWL_I2C_FIFOSTAT_RFE	BIT(2)
> +#define OWL_I2C_FIFOSTAT_TFF	BIT(5)
> +#define OWL_I2C_FIFOSTAT_TFD	GENMASK(23, 16)
> +#define OWL_I2C_FIFOSTAT_RFD	GENMASK(15, 8)
> +
> +/* I2C bus timeout */
> +#define OWL_I2C_TIMEOUT		msecs_to_jiffies(4 * 1000)
> +
> +#define OWL_I2C_MAX_RETRIES	50
> +
> +#define OWL_I2C_DEF_SPEED_HZ	100000
> +#define OWL_I2C_MAX_SPEED_HZ	400000
> +
> +struct owl_i2c_dev {
> +	struct i2c_adapter	adap;
> +	struct i2c_msg		*msg;
> +	struct completion	msg_complete;
> +	struct clk		*clk;
> +	spinlock_t		lock;
> +	void __iomem		*base;
> +	unsigned long		clk_rate;
> +	u32			bus_freq;
> +	u32			msg_ptr;
> +};
> +
> +static void owl_i2c_update_reg(void __iomem *reg, unsigned int val, bool state)
> +{
> +	unsigned int regval;
> +
> +	regval = readl(reg);
> +
> +	if (state)
> +		regval |= val;
> +	else
> +		regval &= ~val;
> +
> +	writel(regval, reg);
> +}
> +
> +static void owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
> +{
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +				OWL_I2C_CTL_EN, false);
> +	mdelay(1);
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +				OWL_I2C_CTL_EN, true);
> +
> +	/* Clear status registers */
> +	writel(0, i2c_dev->base + OWL_I2C_REG_STAT);
> +}
> +
> +static int owl_i2c_reset_fifo(struct owl_i2c_dev *i2c_dev)
> +{
> +	unsigned int val, timeout = 0;
> +
> +	/* Reset FIFO */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +				OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR,
> +				true);
> +
> +	/* Wait 50ms for FIFO reset complete */
> +	do {
> +		val = readl(i2c_dev->base + OWL_I2C_REG_FIFOCTL);
> +		if (!(val & (OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR)))
> +			break;
> +		usleep_range(500, 1000);
> +	} while (timeout++ < OWL_I2C_MAX_RETRIES);
> +
> +	if (timeout > OWL_I2C_MAX_RETRIES) {
> +		dev_err(&i2c_dev->adap.dev, "FIFO reset timeout");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static void owl_i2c_set_freq(struct owl_i2c_dev *i2c_dev)
> +{
> +	unsigned int val;
> +
> +	val = DIV_ROUND_UP(i2c_dev->clk_rate, i2c_dev->bus_freq * 16);
> +
> +	/* Set clock divider factor */
> +	writel(OWL_I2C_DIV_FACTOR(val), i2c_dev->base + OWL_I2C_REG_CLKDIV);
> +}
> +
> +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> +{
> +	struct owl_i2c_dev *i2c_dev = _dev;
> +	struct i2c_msg *msg = i2c_dev->msg;
> +	unsigned long flags;
> +	unsigned int stat, fifostat;
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	fifostat = readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT);
> +	if (fifostat & OWL_I2C_FIFOSTAT_RNB) {
> +		dev_dbg(&i2c_dev->adap.dev, "received NACK from device");
> +		goto stop;
> +	}
> +
> +	stat = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> +	if (stat & OWL_I2C_STAT_BEB) {
> +		dev_dbg(&i2c_dev->adap.dev, "bus error");
> +		goto stop;
> +	}
> +
> +	/* Handle FIFO read */
> +	if (msg->flags & I2C_M_RD) {
> +		while ((readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> +				OWL_I2C_FIFOSTAT_RFE) &&
> +				(i2c_dev->msg_ptr < msg->len)) {

This is poorly aligned and has some () that at least I do not need.
I would write

		while ((readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
			OWL_I2C_FIFOSTAT_RFE) &&
		       i2c_dev->msg_ptr < msg->len) {

so that the two sides of the binary operators align.

> +			msg->buf[i2c_dev->msg_ptr++] = readl(i2c_dev->base +
> +							OWL_I2C_REG_RXDAT);
> +		}
> +	} else {
> +		/* Handle the remaining bytes which were not sent */
> +		while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> +				OWL_I2C_FIFOSTAT_TFF) &&
> +				i2c_dev->msg_ptr < msg->len) {
> +			writel(msg->buf[i2c_dev->msg_ptr++], i2c_dev->base +
> +							OWL_I2C_REG_TXDAT);

Here is another example of poor white-space. I would write:

			writel(msg->buf[i2c_dev->msg_ptr++],
			       i2c_dev->base + OWL_I2C_REG_TXDAT);

In general, I think you should have a look at most if not all your
multi-line statements, and make use of spaces so that things align
better vertically.

> +		}
> +	}
> +
> +stop:
> +	/* Clear pending interrupts */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_STAT,
> +				OWL_I2C_STAT_IRQP, true);

E.g. here. Make the OWL... argument align with i2c_dev->...

	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_STAT,
			   OWL_I2C_STAT_IRQP, true);

It really does look neater.

> +
> +	complete_all(&i2c_dev->msg_complete);
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u32 owl_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static int owl_i2c_check_bus_busy(struct i2c_adapter *adap)
> +{
> +	struct owl_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
> +	unsigned long timeout;
> +
> +	/* Check for Bus busy */
> +	timeout = jiffies + OWL_I2C_TIMEOUT;
> +	while (readl(i2c_dev->base + OWL_I2C_REG_STAT) & OWL_I2C_STAT_BBB) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(&adap->dev, "Bus busy timeout");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +				int num)
> +{
> +	struct owl_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
> +	struct i2c_msg *msg;
> +	unsigned long time_left, flags;
> +	unsigned int i2c_cmd, val;
> +	unsigned int addr;
> +	int ret, idx;
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	/* Reset I2C controller */
> +	owl_i2c_reset(i2c_dev);
> +
> +	/* Set bus frequency */
> +	owl_i2c_set_freq(i2c_dev);
> +
> +	/*
> +	 * Spinlock should be released before calling reset FIFO and
> +	 * bus busy check since those functions may sleep
> +	 */
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);
> +
> +	/* Reset FIFO */
> +	ret = owl_i2c_reset_fifo(i2c_dev);
> +	if (ret) {
> +		/* Disable I2C controller */
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +					OWL_I2C_CTL_EN, false);
> +		return ret;
> +	}
> +
> +	/* Check for bus busy */
> +	ret = owl_i2c_check_bus_busy(adap);
> +	if (ret) {
> +		/* Disable I2C controller */
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +					OWL_I2C_CTL_EN, false);
> +		return ret;
> +	}
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	/* Check for Arbitration lost */
> +	val = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> +	if (val & OWL_I2C_STAT_LAB) {
> +		val &= ~OWL_I2C_STAT_LAB;
> +		writel(val, i2c_dev->base + OWL_I2C_REG_STAT);
> +		ret = -EAGAIN;
> +		goto err_exit;
> +	}
> +
> +	reinit_completion(&i2c_dev->msg_complete);
> +
> +	/* Enable I2C controller interrupt */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +				OWL_I2C_CTL_IRQE, true);
> +
> +	/*
> +	 * Select: FIFO enable, Master mode, Stop enable, Data count enable,
> +	 * Send start bit
> +	 */
> +	i2c_cmd = (OWL_I2C_CMD_SECL | OWL_I2C_CMD_MSS | OWL_I2C_CMD_SE
> +			| OWL_I2C_CMD_NS | OWL_I2C_CMD_DE | OWL_I2C_CMD_SBE);

The operator is customarily on the first line, and the () are not needed.
And I would throw in a couple of extra spaces for readability. Like so:

	i2c_cmd = OWL_I2C_CMD_SECL | OWL_I2C_CMD_MSS | OWL_I2C_CMD_SE |
		  OWL_I2C_CMD_NS   | OWL_I2C_CMD_DE  | OWL_I2C_CMD_SBE;

> +
> +	/* Handle repeated start condition */
> +	if (num > 1) {
> +		/* Set internal address length and enable repeated start */
> +		i2c_cmd |= (OWL_I2C_CMD_AS(msgs[0].len + 1)
> +				| OWL_I2C_CMD_SAS(1) | OWL_I2C_CMD_RBE);

Spurious ()

> +
> +		/* Write slave address */
> +		addr = i2c_8bit_addr_from_msg(&msgs[0]);
> +		writel(addr, i2c_dev->base + OWL_I2C_REG_TXDAT);
> +
> +		/* Write internal register address */
> +		for (idx = 0; idx < msgs[0].len; idx++)
> +			writel(msgs[0].buf[idx], i2c_dev->base +
> +						OWL_I2C_REG_TXDAT);
> +
> +		msg = &msgs[1];
> +	} else {
> +		/* Set address length */
> +		i2c_cmd |= OWL_I2C_CMD_AS(1);
> +		msg = &msgs[0];
> +	}
> +
> +	i2c_dev->msg = msg;
> +	i2c_dev->msg_ptr = 0;
> +
> +	/* Set data count for the message */
> +	writel(msg->len, i2c_dev->base + OWL_I2C_REG_DATCNT);
> +
> +	addr = i2c_8bit_addr_from_msg(msg);
> +	writel(addr, i2c_dev->base + OWL_I2C_REG_TXDAT);
> +
> +	if (!(msg->flags & I2C_M_RD)) {
> +		/* Write data to FIFO */
> +		for (idx = 0; idx < msg->len; idx++) {
> +			/* Check for FIFO full */
> +			if (readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT)
> +					& OWL_I2C_FIFOSTAT_TFF)

Operator should be on the first line (and align, but as I said that goes
for virtually every multi-line statement in the whole file).

> +				break;
> +
> +			writel(msg->buf[idx],
> +					i2c_dev->base + OWL_I2C_REG_TXDAT);
> +		}
> +
> +		i2c_dev->msg_ptr = idx;
> +	}
> +
> +	/* Ignore the NACK if needed */
> +	if (msg->flags & I2C_M_IGNORE_NAK)
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +				OWL_I2C_FIFOCTL_NIB, true);
> +	else
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +				OWL_I2C_FIFOCTL_NIB, false);
> +
> +	/* Start the transfer */
> +	writel(i2c_cmd, i2c_dev->base + OWL_I2C_REG_CMD);
> +
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);
> +
> +	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
> +						adap->timeout);
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +	if (time_left == 0) {
> +		dev_err(&adap->dev, "Transaction timed out");
> +		/* Send stop condition and release the bus */
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +			OWL_I2C_CTL_GBCC_STOP | OWL_I2C_CTL_RB, true);
> +		ret = -ETIMEDOUT;
> +		goto err_exit;
> +	}
> +
> +	/*
> +	 * Here, -ENXIO will be returned if interrupt occurred but no
> +	 * read or write happened. Else if msg_ptr equals to message length,
> +	 * message count will be returned.
> +	 */
> +	ret = (i2c_dev->msg_ptr == msg->len) ? num : -ENXIO;

Consider killing the ().

> +
> +err_exit:
> +
> +	/* Disable I2C controller */
> +	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +				OWL_I2C_CTL_EN, false);
> +
> +	spin_unlock_irqrestore(&i2c_dev->lock, flags);

AFAICT, the ordering of these two statements do not matter. So you could
unlock first and then disable the controller. Then you could have an
unlocked_err_exit label (or something) that you could jump to when things
go south in unlocked regions above, and thus have common error handling.

I.e.

err_exit:
	spin_unlock_irqrestore(&i2c_dev->lock, flags);

unlocked_err_exit:
	/* Disable I2C controller */
	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
			   OWL_I2C_CTL_EN, false);

If the ordering actually matters, then I think you have a problem if either
of the unlocked owl_i2c_reset_fifo() or owl_i2c_check_bus_busy() fails above.
But as I said, I don't think the ordering matters...

But all this is stylistic nits. It's not my code and I don't care deeply.

Acked-by: Peter Rosin <peda@axentia.se>

> +
> +	return ret;
> +}
> +
> +static const struct i2c_algorithm owl_i2c_algorithm = {
> +	.master_xfer    = owl_i2c_master_xfer,
> +	.functionality  = owl_i2c_func,
> +};
> +
> +static const struct i2c_adapter_quirks owl_i2c_quirks = {
> +	.flags		= I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
> +	.max_read_len   = 240,
> +	.max_write_len  = 240,
> +	.max_comb_1st_msg_len = 6,
> +	.max_comb_2nd_msg_len = 240,
> +};
> +
> +static int owl_i2c_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct owl_i2c_dev *i2c_dev;
> +	struct resource *res;
> +	int ret, irq;
> +
> +	i2c_dev = devm_kzalloc(dev, sizeof(*i2c_dev), GFP_KERNEL);
> +	if (!i2c_dev)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	i2c_dev->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(i2c_dev->base))
> +		return PTR_ERR(i2c_dev->base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "failed to get IRQ number\n");
> +		return irq;
> +	}
> +
> +	if (of_property_read_u32(dev->of_node, "clock-frequency",
> +					&i2c_dev->bus_freq))
> +		i2c_dev->bus_freq = OWL_I2C_DEF_SPEED_HZ;
> +
> +	/* We support only frequencies of 100k and 400k for now */
> +	if (i2c_dev->bus_freq != OWL_I2C_DEF_SPEED_HZ &&
> +			i2c_dev->bus_freq != OWL_I2C_MAX_SPEED_HZ) {
> +		dev_err(dev, "invalid clock-frequency %d\n", i2c_dev->bus_freq);
> +		return -EINVAL;
> +	}
> +
> +	i2c_dev->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(i2c_dev->clk)) {
> +		dev_err(dev, "failed to get clock\n");
> +		return PTR_ERR(i2c_dev->clk);
> +	}
> +
> +	ret = clk_prepare_enable(i2c_dev->clk);
> +	if (ret)
> +		return ret;
> +
> +	i2c_dev->clk_rate = clk_get_rate(i2c_dev->clk);
> +	if (!i2c_dev->clk_rate) {
> +		dev_err(dev, "input clock rate should not be zero\n");
> +		ret = -EINVAL;
> +		goto disable_clk;
> +	}
> +
> +	init_completion(&i2c_dev->msg_complete);
> +	spin_lock_init(&i2c_dev->lock);
> +	i2c_dev->adap.owner = THIS_MODULE;
> +	i2c_dev->adap.algo = &owl_i2c_algorithm;
> +	i2c_dev->adap.timeout = OWL_I2C_TIMEOUT;
> +	i2c_dev->adap.quirks = &owl_i2c_quirks;
> +	i2c_dev->adap.dev.parent = dev;
> +	i2c_dev->adap.dev.of_node = dev->of_node;
> +	snprintf(i2c_dev->adap.name, sizeof(i2c_dev->adap.name),
> +			"%s", "OWL I2C adapter");
> +	i2c_set_adapdata(&i2c_dev->adap, i2c_dev);
> +
> +	platform_set_drvdata(pdev, i2c_dev);
> +
> +	ret = devm_request_irq(dev, irq, owl_i2c_interrupt, 0, pdev->name,
> +				i2c_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq %d\n", irq);
> +		goto disable_clk;
> +	}
> +
> +	return i2c_add_adapter(&i2c_dev->adap);
> +
> +disable_clk:
> +	clk_disable_unprepare(i2c_dev->clk);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id owl_i2c_of_match[] = {
> +	{.compatible = "actions,s900-i2c"},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, owl_i2c_of_match);
> +
> +static struct platform_driver owl_i2c_driver = {
> +	.probe		= owl_i2c_probe,
> +	.driver		= {
> +		.name	= "owl-i2c",
> +		.of_match_table = of_match_ptr(owl_i2c_of_match),
> +	},
> +};
> +module_platform_driver(owl_i2c_driver);
> +
> +MODULE_AUTHOR("David Liu <liuwei@actions-semi.com>");
> +MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
> +MODULE_DESCRIPTION("Actions Semiconductor Owl SoC's I2C driver");
> +MODULE_LICENSE("GPL");
> 
