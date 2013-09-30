From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Mon, 30 Sep 2013 19:27:52 +0200
Subject: [PATCH v2 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <20130927175048.GG3094@katana>
References: <1380189238-5755-1-git-send-email-maxime.coquelin@st.com>
 <20130927175048.GG3094@katana>
Message-ID: <5249B498.2070400@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On 09/27/2013 07:50 PM, Wolfram Sang wrote:
> Hi,
>
> Please make one mail thread out of a patch series. That helps reviewing.
Ok, sorry for the inconvenience.
> On Thu, Sep 26, 2013 at 11:53:58AM +0200, Maxime COQUELIN wrote:
>> This patch adds support to SSC (Synchronous Serial Controller)
>> I2C driver. This IP also supports SPI protocol, but this is not
>> the aim of this driver.
>>
>> This IP is embedded in all ST SoCs for Set-top box platorms, and
>> supports I2C Standard and Fast modes.
...
>> +
>> +Optional properties :
>> +- st,needs-antiglitch-filter : The board design needs glitch suppression
>> +  enabled to operate reliably.
>> +- st,min-scl-pulse-width : The minimum valid SCL pulse width that is allowed
>> +  through the deglitch circuit. In units of us.
>> +- st,min-sda-pulse-width : The minimum valid SDA pulse width that is allowed
>> +  through the deglitch circuit. In units of us.
> I could imagine generic properties here, like
> 	i2c-min-scl-pulse-width-us
> 	i2c-min-sda-pulse-width-us
>
> So, if those are used, you can deduce that the glitch filter is wanted.
You are right, the "st,needs-antiglitch-filter" isn't necessary.
But I'm not sure we should put this generic, as it looks we are the only 
ones having such a feature.

> @DT maintainers: Sounds OK?
>
>>
...
>>   comment "External I2C/SMBus adapter drivers"
>>   
>>   config I2C_DIOLAN_U2C
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index d00997f..9ea5d422 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -92,5 +92,6 @@ obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
>>   obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
>>   obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
>>   obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
>> +obj-$(CONFIG_I2C_ST)		+= i2c-st.o
> Please keep it sorted.
Done in next series, same for Kconfig.
>
>>   
>>   ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
>> diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
>> new file mode 100644
>> index 0000000..7eb3be4
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-st.c
>> @@ -0,0 +1,691 @@
>> +/*
>> + * Copyright (C) 2013 STMicroelectronics
>> + *
>> + * I2C master mode controller driver, used in STMicroelectronics devices.
>> + *
>> + * Author: Maxime Coquelin <maxime.coquelin@st.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2, as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/i2c.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/err.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include "i2c-st.h"
>> +
>> +#define DRIVER_NAME "st-i2c"
> Nit: use the string directly
Ok.
>
>> +
>> +/* From I2C Specifications v0.5 */
>> +static struct st_i2c_timings i2c_timings[] = {
>> +	[I2C_MODE_STANDARD] = {
>> +		.rate			= 100000,
>> +		.rep_start_hold		= 4000,
>> +		.rep_start_setup	= 4700,
>> +		.start_hold		= 4000,
>> +		.data_setup_time	= 250,
>> +		.stop_setup_time	= 4000,
>> +		.bus_free_time		= 4700,
>> +	},
>> +	[I2C_MODE_FAST] = {
>> +		.rate			= 400000,
>> +		.rep_start_hold		= 600,
>> +		.rep_start_setup	= 600,
>> +		.start_hold		= 600,
>> +		.data_setup_time	= 100,
>> +		.stop_setup_time	= 600,
>> +		.bus_free_time		= 1300,
>> +	},
>> +};
> I assume there is no formula to calc these values?
These values are provided as is in I2C specification v0.5 (see p.48, 
table 10).
You can get it here: http://www.nxp.com/documents/user_manual/UM10204.pdf

These are generic values. Maybe it should be defined in the i2c 
framework instead than in the ST driver.
But having looked at the other drivers, it seems we are the only ones 
not having these values hard-coded in the IP.

>
>> +
>> +static void st_i2c_flush_rx_fifo(struct st_i2c_dev *i2c_dev)
>> +{
...
>> +
>> +	/* Noise suppression witdh */
>> +	val = i2c_dev->deglitch.scl_min_width_us * rate / 100000000;
>> +	writel(val, i2c_dev->base + SSC_NOISE_SUPP_WIDTH);
>> +
>> +	/* Noise suppression max output data delay width */
>> +	val = i2c_dev->deglitch.sda_min_width_us * rate / 100000000;
>> +	writel(val, i2c_dev->base + SSC_NOISE_SUPP_WIDTH_DATAOUT);
>> +
>> +	return;
> return can be skipped.
OK. Done.
>
>> +}
>> +
>> +static int st_i2c_wait_free_bus(struct st_i2c_dev *i2c_dev)
>> +{
>> +	u32 sta;
>> +	int i;
>> +
...
>> 		st_i2c_rd_fill_tx_fifo(i2c_dev, c->count - 1);
>> +}
>> +
>> +/**
>> + * st_i2c_isr() - Interrupt routine
>> + * @irq: interrupt number
>> + * @data: Controller's private data
>> + */
>> +static irqreturn_t st_i2c_isr(int irq, void *data)
>> +{
>> +	struct st_i2c_dev *i2c_dev = data;
>> +	struct st_i2c_client *c = &i2c_dev->client;
>> +	u32 sta, ien;
>> +	int it;
>> +
>> +	ien = readl(i2c_dev->base + SSC_IEN);
>> +	sta = readl(i2c_dev->base + SSC_STA);
>> +
>> +	/* Use __fls() to check error bits first */
>> +	it = __fls(sta & ien);
>> +	if (it < 0) {
>> +		dev_dbg(i2c_dev->dev, "spurious it (sta=0x%04x, ien=0x%04x)\n",
>> +				sta, ien);
>> +		return IRQ_HANDLED;
> IRQ_HANDLED? IRQ_NONE I'd think.
Right.
>
>> +	}
...
>> +
>> +/**
>> + * st_i2c_xfer_msg() - Transfer a single I2C message
>> + * @i2c_dev: Controller's private data
>> + * @msg: I2C message to transfer
>> + * @is_first: first message of the sequence
>> + * @is_last: last message of the sequence
>> + */
>> +static int st_i2c_xfer_msg(struct st_i2c_dev *i2c_dev, struct i2c_msg *msg,
>> +			    bool is_first, bool is_last)
>> +{
>> +	struct st_i2c_client *c = &i2c_dev->client;
>> +	u32 ctl, i2c, it;
>> +	unsigned long timeout;
>> +	int ret;
>> +
>> +	c->addr		= (u8)(msg->addr << 1);
>> +	c->addr		|= (msg->flags & I2C_M_RD);
>> +	c->buf		= msg->buf;
>> +	c->count	= msg->len;
>> +	c->xfered	= 0;
>> +	c->result	= 0;
>> +	c->stop		= is_last;
>> +
>> +	init_completion(&i2c_dev->complete);
> INIT_COMPLETION here, and init_completion in probe.
Ok.
>
>> +
>> +	ctl = SSC_CTL_EN | SSC_CTL_MS |	SSC_CTL_EN_RX_FIFO | SSC_CTL_EN_TX_FIFO;
>> +	st_i2c_set_bits(i2c_dev->base + SSC_CTL, ctl);
>> +
...
>> +	first = true;
>> +
>> +	for (i = 0; i < num; i++) {
>> +		last = (i < num - 1) ? false : true;
>> +
>> +		ret = st_i2c_xfer_msg(i2c_dev, &msgs[i], first, last);
> Simplify to:
> ret = st_i2c_xfer_msg(i2c_dev, &msgs[i], i == 0, i == num - 1) ?
Sure.
>
>> +		if (ret)
>> +			break;
>> +
>> +		first = false;
>> +	}
>> +
>> +	pinctrl_pm_select_idle_state(i2c_dev->dev);
>> +
>> +	clk_disable_unprepare(i2c_dev->clk);
>> +
>> +	i2c_dev->busy = false;
>> +
>> +	return (ret < 0) ? ret : i;
>> +}
>> +
>> +#ifdef CONFIG_PM
> CONFIG_PM_SLEEP
Ok.
>> +static int st_i2c_suspend(struct device *dev)
>> +{
>> +	struct platform_device *pdev =
>> +		container_of(dev, struct platform_device, dev);
>> +	struct st_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
>> +
>> +	if (i2c_dev->busy)
>> +		return -EBUSY;
>> +
>> +	pinctrl_pm_select_sleep_state(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int st_i2c_resume(struct device *dev)
>> +{
>> +	pinctrl_pm_select_default_state(dev);
>> +	/* Go in idle state if available */
>> +	pinctrl_pm_select_idle_state(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(st_i2c_pm, st_i2c_suspend, st_i2c_resume);
>> +#define ST_I2C_PM	(&st_i2c_pm)
>> +#else
>> +#define ST_I2C_PM	NULL
>> +#endif
>> +
>> +static u32 st_i2c_func(struct i2c_adapter *adap)
>> +{
>> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>> +}
> Have you verified that SMBUS_QUICK works? You can use i2cdetect to check
> that in case you haven't already.

Yes I checked.

i2cdetect works for addresses out of 0x30-0x37 and 0x50-0x5f ranges.
So SMBUS_QUICK is supported.
Note that it also works for EEPROM, so SMBUS_BYTE is okay too.

>> +
>> +static struct i2c_algorithm st_i2c_algo = {
>> +	.master_xfer = st_i2c_xfer,
>> +	.functionality = st_i2c_func,
>> +};
...
>> +
>> +static struct platform_driver st_i2c_driver = {
>> +	.driver = {
>> +		.name = DRIVER_NAME,
>> +		.owner = THIS_MODULE,
>> +		.of_match_table = st_i2c_match,
>> +		.pm = &st_i2c_pm,
> You probably wanted ST_I2C_PM here?
Yes...
>> +	},
>> +	.probe = st_i2c_probe,
>> +	.remove = st_i2c_remove,
>> +};
>> +
>> +module_platform_driver(st_i2c_driver);
>> +
>> +MODULE_AUTHOR("STMicroelectronics");
> I'd prefer your name, but at least, we need an email address.
Ok, I will put my name and email in next series.

>
>> +MODULE_DESCRIPTION("STMicroelectronics I2C driver");
>> +MODULE_LICENSE("GPL");
> Header says GPL v2.
Right.
>> diff --git a/drivers/i2c/busses/i2c-st.h b/drivers/i2c/busses/i2c-st.h
>> new file mode 100644
>> index 0000000..e8ba3dc
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-st.h
>> @@ -0,0 +1,208 @@
> Since this is not shared, please include into the c-file.
Okay.
>> +/*
>> + * Copyright (C) 2013 STMicroelectronics
...
>> +}
>> +
>> +#endif /* __I2C_ST_H_ */
>> -- 
>> 1.7.9.5
>>
Thanks for the review.
Next series will be pushed tomorrow.

Regards,
Maxime
> Thanks,
>
>     Wolfram
>
