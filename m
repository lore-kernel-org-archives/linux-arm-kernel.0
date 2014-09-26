From: zhangfei.gao@linaro.org (zhangfei)
Date: Fri, 26 Sep 2014 11:30:29 +0800
Subject: [PATCH resend 2/2] i2c: hix5hd2: add i2c controller driver
In-Reply-To: <20140919171829.GB2874@katana>
References: <1409030722-30709-1-git-send-email-zhangfei.gao@linaro.org>
 <1409030722-30709-3-git-send-email-zhangfei.gao@linaro.org>
 <20140919171829.GB2874@katana>
Message-ID: <5424DDD5.1020706@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thanks Wolfram for the careful review

On 09/20/2014 01:18 AM, Wolfram Sang wrote:
> Hi,
>
> thanks for the submission.
>
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-hix5hd2.c
>> @@ -0,0 +1,573 @@
>> +/*
>> + * Copyright (c) 2014 Linaro Ltd.
>> + * Copyright (c) 2014 Hisilicon Limited.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * publishhed by the Free Software Foundation.
>
> "publishhed"
OK.
>
>> + *
>> + * Now only support 7 bit address.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/io.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>
> I think there should be at least of.h, too.
The of.h is already in i2c.h
include/linux/i2c.h:33:#include <linux/of.h>
>
>> +struct hix5hd2_i2c {
>> +	struct i2c_adapter adap;
>> +	struct i2c_msg	*msg;
>> +	unsigned int msg_ptr;	/* msg index */
>
> Comment seems wrong. It looks to me as the msg buffer index. If so, the
> variable name is also confusing.
Change to msg_idx & msg_len.
>
>> +	unsigned int len;	/* msg length */
>> +	int stop;
>> +	struct completion msg_complete;
>> +
>> +	unsigned int irq;
>
> That can be a local variable.
Yes
>
>> +	void __iomem *regs;
>> +	struct clk *clk;
>> +	struct device *dev;
>> +	spinlock_t lock;	/* IRQ synchronization */
>> +
>> +	int err;
>> +	enum hix5hd2_i2c_state state;
>> +	enum hix5hd2_i2c_speed speed_mode;
>
> Where is this needed?
will remove
>
>> +
>> +	/* Controller frequency */
>> +	unsigned int s_clock;
>> +};
>> +
>> +static void hix5hd2_i2c_drv_setrate(struct hix5hd2_i2c *i2c)
>> +{
>> +	u32 rate, val;
>> +	u32 sclh, scll, sysclock;
>> +
>> +	/* close all i2c interrupt */
>> +	val = readl_relaxed(i2c->regs + HIX5I2C_CTRL);
>> +	writel_relaxed(val & (~I2C_UNMASK_TOTAL), i2c->regs + HIX5I2C_CTRL);
>> +
>> +	rate = i2c->s_clock;
>> +	sysclock = clk_get_rate(i2c->clk);
>> +	sclh = (sysclock / (rate * 2)) / 2 - 1;
>> +	writel_relaxed(sclh, i2c->regs + HIX5I2C_SCL_H);
>> +	scll = (sysclock / (rate * 2)) / 2 - 1;
>
> scll and sclh use the same formula? Have you measured the setup
> frequency with a scope?
Yes, it is confusing, will use the same vector scl instead.
The value is same means sclk high voltage and low voltage keep same time.
>
>> +	writel_relaxed(scll, i2c->regs + HIX5I2C_SCL_L);
>> +
>> +	/* restore original interrupt*/
>> +	writel_relaxed(val, i2c->regs + HIX5I2C_CTRL);
>> +
>> +	dev_dbg(i2c->dev, "%s: sysclock=%d, rate=%d, sclh=%d, scll=%d\n",
>> +		__func__, sysclock, rate, sclh, scll);
>> +}
>> +
>> +static void hix5hd2_rw_over(struct hix5hd2_i2c *i2c)
>> +{
>> +	if (HIX5I2C_STAT_SND_STOP == i2c->state)
>
> To be honest, I don't like having the constant on the left side. It
> is far easier to read if they are on the right side. Plus, we have gcc
> warnings to prevent the "=" and "==" mistake. Please switch them around
> in this driver.
Got it.
>
>> +		dev_dbg(i2c->dev, "%s: rw and send stop over\n", __func__);
>> +	else
>> +		dev_dbg(i2c->dev, "%s: have not data to send\n", __func__);
>> +
>> +	i2c->state = HIX5I2C_STAT_RW_SUCCESS;
>> +	i2c->err = 0;
>> +}
>> +
>
> ...
>
>> +	/* handle error */
>> +	if (int_status & I2C_ARBITRATE_INTR) {
>> +		/*Bus error */
>
> Space missing in front of "Bus". If this is an arbitration lost error,
> then please use -EAGAIN. Check Documentation/i2c/fault-codes for the
> convention.
OK.
>
>> +		dev_dbg(i2c->dev, "ARB bus loss\n");
>> +		i2c->err = -ENXIO;
>> +		i2c->state = HIX5I2C_STAT_RW_ERR;
>> +		goto stop;
>> +	} else if (int_status & I2C_ACK_INTR) {
>> +		/* ack error */
>> +		dev_dbg(i2c->dev, "No ACK from device\n");
>> +		i2c->err = -ENXIO;
>> +		i2c->state = HIX5I2C_STAT_RW_ERR;
>> +		goto stop;
>> +	}
>> +
>> +static void hix5hd2_i2c_message_start(struct hix5hd2_i2c *i2c, int stop)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&i2c->lock, flags);
>> +	hix5hd2_i2c_clr_all_irq(i2c);
>> +	hix5hd2_i2c_enable_irq(i2c);
>> +
>> +	if (i2c->msg->flags & I2C_M_RD)
>> +		writel_relaxed(i2c->msg->addr | HIX5I2C_READ_OPERATION,
>> +			       i2c->regs + HIX5I2C_TXR);
>> +	else
>> +		writel_relaxed(i2c->msg->addr & HIX5I2C_WRITE_OPERATION,
>> +			       i2c->regs + HIX5I2C_TXR);
>
> ??? Does this really work? i2c->msg->addr should be left shifted by 1?

Double checked, it is because the test applictaion do the left shift.
Yes, will do the left shift by 1.
>
>> +
>> +	writel_relaxed(I2C_WRITE | I2C_START, i2c->regs + HIX5I2C_COM);
>> +	spin_unlock_irqrestore(&i2c->lock, flags);
>> +}
>> +
>> +static int hix5hd2_i2c_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +	struct hix5hd2_i2c *i2c;
>> +	struct resource *mem;
>> +	unsigned int op_clock;
>> +	int ret;
>> +
>> +	i2c = devm_kzalloc(&pdev->dev, sizeof(struct hix5hd2_i2c), GFP_KERNEL);
>> +	if (!i2c)
>> +		return -ENOMEM;
>> +
>> +	if (of_property_read_u32(np, "clock-frequency", &op_clock)) {
>> +		/* use default value */
>> +		i2c->speed_mode = HIX5I2C_HIG_SPD;
>> +		i2c->s_clock = HIX5I2C_HS_TX_CLOCK;
>
> Please use 100kHz as the default. This is the speed devices should
> support. 400kHz is optional. And I think 100000 is easier to read than a
> define.
OK.
>
>> +	} else {
>> +		if (op_clock >= HIX5I2C_HS_TX_CLOCK) {
>> +			i2c->speed_mode = HIX5I2C_HIG_SPD;
>> +			i2c->s_clock = HIX5I2C_HS_TX_CLOCK;
>
> So, if the speed is bigger than 400kHz, it will be capped down to
> 400kHz? Is that true? Then, the user should be informed about that.
Will add dev_warn to notify.
>
>> +		} else {
>> +			i2c->speed_mode = HIX5I2C_NORMAL_SPD;
>> +			i2c->s_clock = op_clock;
>> +		}
>> +	}
>> +
>
> ...
>
>> +	i2c->adap.owner   = THIS_MODULE;
>> +	i2c->adap.algo	  = &hix5hd2_i2c_algorithm;
>
> Single space as indentation.
Got it.

Thanks
