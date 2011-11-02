From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 2 Nov 2011 10:39:04 +0000
Subject: [PATCH] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <1320228610-18129-1-git-send-email-Barry.Song@csr.com>
References: <1320228610-18129-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20111102103904.GB4937@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

I'm not too familiar with I2C, so just a couple of general comments 
inline, but otherwise looks good to me.

Jamie

On Wed, Nov 02, 2011 at 03:10:10AM -0700, Barry Song wrote:
> From: Zhiwu Song <Zhiwu.Song@csr.com>
> 
> SiRFprimaII is the latest generation application processor from CSR?s
> multi-function SoC product family.
> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> 3.0.
> There are two I2C controllers on primaII, features include:
> ? Two I2C controller modules are on chip
> ? RISC I/O bus read write register
> ? Up to 16 bytes data buffer for issuing commands and writing data at the same time
> ? Up to 16 commands, and receiving read data 16 bytes at a time
> ? Error INT report (ACK check)
> ? No-ACK bus protocols (SCCB bus protocols)
> 
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
[...]
> diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
> new file mode 100644
> index 0000000..d4ccba7
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-sirf.c
> @@ -0,0 +1,425 @@
> +/*
> + * I2C bus driver for CSR SiRFprimaII
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +
> +#include "i2c-sirf.h"
> +
> +#define SIRFSOC_I2C_DEFAULT_SPEED  100000
> +
> +struct sirfsoc_i2c {
> +	void *base;

This should be void __iomem *base;

> +	struct clk *clk;
> +	unsigned long speed;	/* I2C SCL frequency */
> +	int irq;
> +	u32 cmd_ptr;		/* Current position in CMD buffer */
> +	u8 *buf;		/* Buffer passed by user */
> +	u32 msg_len;		/* Message length */
> +	u32 finished_len;	/* number of bytes read/written */
> +	u32 read_cmd_len;	/* number of read cmd sent */
> +	int msg_read;		/* 1 indicates a read message */
> +	int err_status;		/* 1 indicates an error on bus */
> +
> +	u32 sda_delay;		/* For suspend/resume */
> +	u32 clk_div;
> +	int last;		/* Last message in transfer, STOP cmd can be sent */
> +
> +	struct completion done;	/* indicates completion of message transfer */
> +	struct i2c_adapter *adapter;
> +};
> +
> +static void i2c_sirfsoc_read_data(struct sirfsoc_i2c *siic)
> +{
> +	u32 data = 0;
> +	int i = 0;
> +
> +	for (i = 0; i < siic->read_cmd_len; i++) {
> +		if (!(i & 0x3))
> +			data = readl(siic->base + SIRFSOC_I2C_DATA_BUF + i);
> +		siic->buf[siic->finished_len++] =
> +			(unsigned char)((data & SIRFSOC_I2C_DATA_MASK(i)) >>
> +				SIRFSOC_I2C_DATA_SHIFT(i));
> +
> +		BUG_ON(siic->finished_len > siic->msg_len);
> +	}
> +}
> +
> +static void i2c_sirfsoc_queue_cmd(struct sirfsoc_i2c *siic)
> +{
> +	u32 regval;
> +	int i = 0;
> +
> +	if (siic->msg_read) {
> +		while (((siic->finished_len + i) < siic->msg_len)
> +			&& (siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)) {
> +			regval = SIRFSOC_I2C_READ | SIRFSOC_I2C_CMD_RP(0);
> +			if (((siic->finished_len + i) ==
> +					(siic->msg_len - 1)) && siic->last)
> +				regval |= SIRFSOC_I2C_STOP | SIRFSOC_I2C_NACK;
> +			writel(regval,
> +				siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
> +			i++;
> +		}
> +
> +		siic->read_cmd_len = i;
> +	} else {
> +		while ((siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX - 1)
> +			&& (siic->finished_len < siic->msg_len)) {
> +			regval = SIRFSOC_I2C_WRITE | SIRFSOC_I2C_CMD_RP(0);
> +			if ((siic->finished_len == (siic->msg_len - 1))
> +				&& siic->last)
> +				regval |= SIRFSOC_I2C_STOP;
> +			writel(regval,
> +				siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
> +			writel(siic->buf[siic->finished_len++],
> +				siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
> +		}
> +	}
> +	siic->cmd_ptr = 0;
> +
> +	/* Trigger the transfer */
> +	writel(SIRFSOC_I2C_START_CMD, siic->base + SIRFSOC_I2C_CMD_START);
> +}
> +
> +static irqreturn_t i2c_sirfsoc_irq(int irq, void *dev_id)
> +{
> +	struct sirfsoc_i2c *siic = (struct sirfsoc_i2c *)dev_id;
> +	u32 i2c_stat = readl(siic->base + SIRFSOC_I2C_STATUS);
> +
> +	if (i2c_stat & SIRFSOC_I2C_STAT_ERR) {
> +		/* Error conditions */
> +		siic->err_status = 1;
> +		writel(SIRFSOC_I2C_STAT_ERR, siic->base + SIRFSOC_I2C_STATUS);
> +
> +		if (i2c_stat & SIRFSOC_I2C_STAT_NACK)
> +			dev_err(&siic->adapter->dev, "ACK not received\n");
> +		else
> +			dev_err(&siic->adapter->dev, "I2C error\n");
> +
> +		complete(&siic->done);
> +	} else if (i2c_stat & SIRFSOC_I2C_STAT_CMD_DONE) {
> +		/* CMD buffer execution complete */
> +		if (siic->msg_read)
> +			i2c_sirfsoc_read_data(siic);
> +		if (siic->finished_len == siic->msg_len)
> +			complete(&siic->done);
> +		else /* Fill a new CMD buffer for left data */
> +			i2c_sirfsoc_queue_cmd(siic);
> +
> +		writel(SIRFSOC_I2C_STAT_CMD_DONE, siic->base + SIRFSOC_I2C_STATUS);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void i2c_sirfsoc_set_address(struct sirfsoc_i2c *siic,
> +	struct i2c_msg *msg)
> +{
> +	unsigned char addr;
> +	u32 regval = SIRFSOC_I2C_START | SIRFSOC_I2C_CMD_RP(0) | SIRFSOC_I2C_WRITE;
> +
> +	/* no data and last message -> add STOP */
> +	if (siic->last && (msg->len == 0))
> +		regval |= SIRFSOC_I2C_STOP;
> +
> +	writel(regval, siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
> +
> +	addr = msg->addr << 1;	/* Generate address */
> +	if (msg->flags & I2C_M_RD)
> +		addr |= 1;
> +	if (msg->flags & I2C_M_REV_DIR_ADDR)	/* Reverse direction bit */
> +		addr ^= 1;
> +
> +	writel(addr, siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
> +}
> +
> +static int i2c_sirfsoc_xfer_msg(struct sirfsoc_i2c *siic, struct i2c_msg *msg)
> +{
> +	u32 regval = readl(siic->base + SIRFSOC_I2C_CTRL);
> +	int timeout = (msg->len + 1) * 50;
> +	int ret = 0;
> +
> +	i2c_sirfsoc_set_address(siic, msg);
> +
> +	writel(regval | SIRFSOC_I2C_CMD_DONE_EN | SIRFSOC_I2C_ERR_INT_EN,
> +		siic->base + SIRFSOC_I2C_CTRL);
> +	i2c_sirfsoc_queue_cmd(siic);
> +
> +	if (wait_for_completion_timeout(&siic->done, timeout) == 0) {
> +		siic->err_status = 1;
> +		dev_err(&siic->adapter->dev, "Transfer timeout\n");
> +	}
> +
> +	writel(regval & ~(SIRFSOC_I2C_CMD_DONE_EN | SIRFSOC_I2C_ERR_INT_EN),
> +		siic->base + SIRFSOC_I2C_CTRL);
> +	writel(0, siic->base + SIRFSOC_I2C_CMD_START);
> +
> +	if (siic->err_status) {
> +		writel(readl(siic->base + SIRFSOC_I2C_CTRL) | SIRFSOC_I2C_RESET,
> +			siic->base + SIRFSOC_I2C_CTRL);
> +		while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
> +			cpu_relax();
> +
> +		ret = -EIO;
> +	}
> +
> +	return ret;
> +}
> +
> +static u32 i2c_sirfsoc_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static int i2c_sirfsoc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +	int num)
> +{
> +	struct sirfsoc_i2c *siic = adap->algo_data;
> +	int i, ret;
> +
> +	for (i = 0; i < num; i++) {
> +		siic->buf = msgs[i].buf;
> +		siic->msg_len = msgs[i].len;
> +
> +		if (msgs[i].flags & I2C_M_RD)
> +			siic->msg_read = 1;
> +		else
> +			siic->msg_read = 0;
> +
> +		siic->err_status = 0;
> +		siic->cmd_ptr = 0;
> +		siic->finished_len = 0;
> +		if (i == (num - 1))
> +			siic->last = 1;
> +		else
> +			siic->last = 0;
> +
> +		ret = i2c_sirfsoc_xfer_msg(siic, &msgs[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return num;
> +}
> +
> +/* I2C algorithms associated with this master controller driver */
> +static struct i2c_algorithm i2c_sirfsoc_algo = {
> +	.master_xfer = i2c_sirfsoc_xfer,
> +	.functionality = i2c_sirfsoc_func,
> +};

const?

> +
> +static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev)
> +{
> +	struct sirfsoc_i2c *siic;
> +	struct i2c_adapter *new_adapter;
> +	struct resource *mem_res;
> +	struct clk *clk;
> +	int ctrl_speed;
> +
> +	int err;
> +	u32 regval;
> +
> +	clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		err = PTR_ERR(clk);
> +		dev_err(&pdev->dev, "Clock get failed\n");
> +		goto out;
> +	}
> +
> +	clk_enable(clk);

The return value of clk_enable() should really be checked.

> +	ctrl_speed = clk_get_rate(clk);
> +
> +	new_adapter = kzalloc(sizeof(*new_adapter), GFP_KERNEL);

If you do:

	new_adapter = devm_kzalloc(&pdev->dev, sizeof(*new_adapter), 
				   GFP_KERNEL);

then devres will handle cleanup on failure for you and also device 
removal so you can get rid of a lot of the error handling and just 
return early.  The same applies for the ioremap, irq requesting and 
other allocations.

> +	if (!new_adapter) {
> +		dev_err(&pdev->dev,
> +			"Can't allocate new i2c adapter!\n");
> +		err = -ENOMEM;
> +		goto clk_out;
> +	}
> +
> +	siic = kzalloc(sizeof(*siic), GFP_KERNEL);
> +	if (!siic) {
> +		dev_err(&pdev->dev, "Can't allocate driver data\n");
> +		err = -ENOMEM;
> +		goto free_adapter;
> +	}
> +	new_adapter->class = I2C_CLASS_HWMON | I2C_CLASS_DDC | I2C_CLASS_SPD;
> +	siic->adapter = new_adapter;
> +
> +	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (mem_res == NULL) {
> +		dev_err(&pdev->dev, "Unable to get MEM resource\n");
> +		err = -EINVAL;
> +		goto free_data;
> +	}
> +
> +	siic->base =
> +		ioremap(mem_res->start, (mem_res->end - mem_res->start + 1));
> +	if (siic->base == NULL) {
> +		dev_err(&pdev->dev, "IO remap failed!\n");
> +		err = -ENOMEM;
> +		goto free_data;
> +	}
> +
> +	siic->irq = platform_get_irq(pdev, 0);
> +	if (!siic->irq) {
> +		err = -EINVAL;
> +		goto free_base;
> +	}
> +	err = request_irq(siic->irq, i2c_sirfsoc_irq, 0,
> +		dev_name(&pdev->dev), siic);
> +	if (err)
> +		goto free_base;
> +
> +	new_adapter->algo = &i2c_sirfsoc_algo;
> +	new_adapter->algo_data = siic;
> +
> +	new_adapter->dev.parent = &pdev->dev;
> +	new_adapter->nr = pdev->id;
> +
> +	strlcpy(new_adapter->name, "sirfsoc-i2c", sizeof(new_adapter->name));
> +
> +	platform_set_drvdata(pdev, new_adapter);
> +	init_completion(&siic->done);
> +
> +	/* Controller Initalisation */
> +
> +	writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
> +	while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
> +		cpu_relax();
> +	writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE,
> +		siic->base + SIRFSOC_I2C_CTRL);
> +
> +	siic->clk = clk;
> +	siic->speed = SIRFSOC_I2C_DEFAULT_SPEED;
> +	if (siic->speed < 100000)
> +		regval =
> +			(2 * ctrl_speed) / (2 * siic->speed * 11);
> +	else
> +		regval = ctrl_speed / (siic->speed * 5);
> +
> +	writel(regval, siic->base + SIRFSOC_I2C_CLK_CTRL);
> +	if (regval > 0xFF)
> +		writel(0xFF, siic->base + SIRFSOC_I2C_SDA_DELAY);
> +	else
> +		writel(regval, siic->base + SIRFSOC_I2C_SDA_DELAY);
> +
> +	err = i2c_add_numbered_adapter(new_adapter);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "Can't add new i2c adapter\n");
> +		goto free_irq;
> +	}
> +
> +	dev_info(&pdev->dev, "I2C adapter ready to operate\n");
> +
> +	return 0;
> +
> +free_irq:
> +	free_irq(siic->irq, siic);
> +free_base:
> +	iounmap(siic->base);
> +free_data:
> +	kfree(siic);
> +free_adapter:
> +	kfree(new_adapter);
> +clk_out:
> +	clk_disable(clk);
> +	clk_put(clk);
> +out:
> +	return err;
> +}
> +
> +static int __devexit i2c_sirfsoc_remove(struct platform_device *pdev)
> +{
> +	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
> +	struct sirfsoc_i2c *siic = adapter->algo_data;
> +
> +	writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
> +	i2c_del_adapter(adapter);
> +	free_irq(siic->irq, siic);
> +	iounmap(siic->base);
> +	kfree(siic);
> +	kfree(adapter);
> +	clk_disable(siic->clk);
> +	clk_put(siic->clk);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int i2c_sirfsoc_suspend(struct platform_device *pdev, pm_message_t msg)
> +{
> +	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
> +	struct sirfsoc_i2c *siic = adapter->algo_data;
> +
> +	siic->sda_delay = readl(siic->base + SIRFSOC_I2C_SDA_DELAY);
> +	siic->clk_div = readl(siic->base + SIRFSOC_I2C_CLK_CTRL);
> +	return 0;
> +}
> +
> +static int i2c_sirfsoc_resume(struct platform_device *pdev)
> +{
> +	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
> +	struct sirfsoc_i2c *siic = adapter->algo_data;
> +
> +	writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
> +	writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE,
> +		siic->base + SIRFSOC_I2C_CTRL);
> +	writel(siic->clk_div, siic->base + SIRFSOC_I2C_CLK_CTRL);
> +	writel(siic->sda_delay, siic->base + SIRFSOC_I2C_SDA_DELAY);
> +	return 0;
> +}
> +#else
> +#define i2c_sirfsoc_suspend	NULL
> +#define i2c_sirfsoc_resume	NULL
> +#endif
> +
> +static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst = {
> +	{ .compatible = "sirf,prima2-i2c", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sirfsoc_i2c_of_match);
> +
> +static struct platform_driver i2c_sirfsoc_driver = {
> +	.driver = {
> +		.name = "sirfsoc_i2c",
> +		.owner = THIS_MODULE,
> +		.of_match_table = sirfsoc_i2c_of_match,
> +	},
> +	.probe = i2c_sirfsoc_probe,
> +	.remove = __devexit_p(i2c_sirfsoc_remove),
> +	.suspend = i2c_sirfsoc_suspend,
> +	.resume = i2c_sirfsoc_resume,
> +};
> +
> +static int __init i2c_sirfsoc_init(void)
> +{
> +	return platform_driver_register(&i2c_sirfsoc_driver);
> +}
> +arch_initcall(i2c_sirfsoc_init);
> +
> +static void __exit i2c_sirfsoc_exit(void)
> +{
> +	platform_driver_unregister(&i2c_sirfsoc_driver);
> +}
> +module_exit(i2c_sirfsoc_exit);
> +
> +MODULE_DESCRIPTION("SiRF SoC I2C master controller driver");
> +MODULE_AUTHOR("Zhiwu Song <Zhiwu.Song@csr.com>, "
> +	"Xiangzhen Ye <Xiangzhen.Ye@csr.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/i2c/busses/i2c-sirf.h b/drivers/i2c/busses/i2c-sirf.h
> new file mode 100644
> index 0000000..28f4ada
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-sirf.h
> @@ -0,0 +1,61 @@
> +/*
> + * I2C bus drivers for CSR SiRFprimaII
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#ifndef _SIRFSOC_I2C_BUS_H_
> +#define _SIRFSOC_I2C_BUS_H_
> +
> +#include <linux/bitops.h>
> +
> +#define SIRFSOC_I2C_CLK_CTRL		0x00

It may be worth moving the contents of this file into the .c file as 
they don't get used anywhere else.
