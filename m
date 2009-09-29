From: ben@simtec.co.uk (Ben Dooks)
Date: Tue, 29 Sep 2009 11:00:04 +0100
Subject: [PATCH] Touchscreen driver for the DTS413
In-Reply-To: <a57e67db0909280023q7d352f22ge5b5343dc0c79c65@mail.gmail.com>
References: <a57e67db0909280023q7d352f22ge5b5343dc0c79c65@mail.gmail.com>
Message-ID: <4AC1DAA4.4090508@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jernej Turnsek wrote:
> Hi,
> 
> we have developed a support for a nice capacitive ITO touchscreen from
> Densitron (DTS413). It is connected to the I2C bus.

you've failed to send to the linux-input list, the first
port of call for any _input_ related drivers. A CC: to
the relevant i2c list would have been nice.

> Simple DTS413 Touchscreen driver.
> 
> Signed-off-by: Jernej Turnsek <jernej.turnsek@gmail.com>
> 
> diff --git a/drivers/input/touchscreen/Kconfig
> b/drivers/input/touchscreen/Kconfig
> index ab02d72..b2403f5 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -510,6 +510,17 @@ config TOUCHSCREEN_W90X900
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called w90p910_ts.
> 
> +config TOUCHSCREEN_DTS413
> +	tristate "DTS413 based touchscreens"
> +	depends on I2C
> +	help
> +	  Say Y here if you have a DTS413 based touchscreen.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called dts413.
> +
>  config TOUCHSCREEN_PCAP
>  	tristate "Motorola PCAP touchscreen"
>  	depends on EZX_PCAP
> diff --git a/drivers/input/touchscreen/Makefile
> b/drivers/input/touchscreen/Makefile
> index 4599bf7..be7315b 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -40,4 +40,6 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ATMEL)	+= atmel-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_DTS413)	+= dts413.o
>  obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
> +
> diff --git a/drivers/input/touchscreen/dts413.c
> b/drivers/input/touchscreen/dts413.c
> new file mode 100644
> index 0000000..b7a43af
> --- /dev/null
> +++ b/drivers/input/touchscreen/dts413.c
> @@ -0,0 +1,282 @@
> +/*
> + * drivers/input/touchscreen/dts413.c
> + *
> + * Copyright (c) 2009 Iskraemeco d.d.
> + *	Jernej Turnsek <jernej.turnsek@iskraemeco.si>
> + *
> + * Using code from:
> + *  - migor_ts.c
> + * Copyright (c) 2008 Magnus Damm
> + * Copyright (c) 2007 Ujjwal Pande <ujjwal@kenati.com>,
> + *  Kenati Technologies Pvt Ltd.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <asm/io.h>

<asm/io.h> not for use in drivers, <linux/io.h> here

> +#include <linux/i2c.h>
> +#include <linux/timer.h>
> +
> +#define	MAX_11BIT		((1 << 11) - 1)
> +
> +#define EVENT_PENDOWN 	1
> +#define EVENT_PENUP   	0
> +
> +struct ts_event {
> +	u8 byte0_stat: 1;
> +	u8 byte0_res : 7;
> +	u8 byte1_xpos_msb : 4;
> +	u8 byte1_res : 4;
> +	u8 byte2_xpos_lsb : 7;
> +	u8 byte2_res : 1;
> +	u8 byte3_ypos_msb : 4;
> +	u8 byte3_res : 4;
> +	u8 byte4_ypos_lsb : 7;
> +	u8 byte4_res : 1;
> +	u8 byte5_speed : 6;
> +	u8 byte5_res : 2;
> +};

Do not do this. You are relying on the compiler version
that you are using to get this right.

> +
> +struct dts413 {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	struct delayed_work work;
> +	int irq;
> +};

kerneldoc comments would be nice here.

> +
> +static void dts413_poscheck(struct work_struct *work)
> +{
> +	struct dts413 *priv = container_of(work,
> +						  struct dts413,
> +						  work.work);
> +	unsigned short xpos, ypos;
> +	unsigned char event;
> +	u_int8_t buf[6];
> +	struct ts_event *ts = (struct ts_event *)&buf[0];
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	/* Now do Page Read */
> +	if (i2c_master_recv(priv->client, buf, sizeof(buf)) != sizeof(buf)) {
> +		dev_err(&priv->client->dev, "Unable to read i2c page\n");
> +		goto out;
> +	}
> +
> +	xpos = (unsigned short)(ts->byte1_xpos_msb << 7) | (ts->byte2_xpos_lsb);
> +	ypos = (unsigned short)(ts->byte3_ypos_msb << 7) | (ts->byte4_ypos_lsb);
> +	event = (unsigned char)ts->byte0_stat;
	
> +static irqreturn_t dts413_isr(int irq, void *dev_id)
> +{
> +	struct dts413 *priv = (struct dts413*)dev_id;

no need for cast.

> +	/* the touch screen controller chip is hooked up to the cpu
> +	 * using i2c and a single interrupt line. the interrupt line
> +	 * is pulled low whenever someone taps the screen. to deassert
> +	 * the interrupt line we need to acknowledge the interrupt by
> +	 * communicating with the controller over the slow i2c bus.
> +	 *
> +	 * we can't acknowledge from interrupt context since the i2c
> +	 * bus controller may sleep, so we just disable the interrupt
> +	 * here and handle the acknowledge using delayed work.
> +	 */

would have been nice to put this in a proper kerneldoc comment
on the start of the function.

> +	disable_irq_nosync(irq);
> +	schedule_delayed_work(&priv->work, HZ / 100);

why not just schedule_work?

> +	return IRQ_HANDLED;
> +}
> +
> +static int dts413_open(struct input_dev *dev)
> +{
> +	//struct dts413 *priv = input_get_drvdata(dev);
> +	//struct i2c_client *client = priv->client;

// commenting a no-no.

> +	/* enable controller */
> +	//todo
> +
> +	return 0;
> +}
> +
> +static void dts413_close(struct input_dev *dev)
> +{
> +	struct dts413 *priv = input_get_drvdata(dev);
> +	//struct i2c_client *client = priv->client;
> +
> +	disable_irq(priv->irq);
> +
> +	/* cancel pending work and wait for dts413_poscheck() to finish */
> +	if (cancel_delayed_work_sync(&priv->work)) {
> +		/*
> +		 * if migor_ts_poscheck was canceled we need to enable IRQ
> +		 * here to balance disable done in migor_ts_isr.
> +		 */
> +		enable_irq(priv->irq);
> +	}
> +
> +	/* disable controller */
> +	//todo
> +
> +	enable_irq(priv->irq);
> +}
> +
> +
> +static int dts413_probe(struct i2c_client *client,
> +			const struct i2c_device_id *idp)
> +{
> +	struct dts413 *priv;
> +	struct input_dev *input;
> +	int error;
> +	
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(&client->dev, "failed to allocate driver data\n");
> +		error = -ENOMEM;
> +		goto err0;
> +	}
> +
> +	dev_set_drvdata(&client->dev, priv);
> +
> +	input = input_allocate_device();
> +	if (!input) {
> +		dev_err(&client->dev, "Failed to allocate input device.\n");
> +		error = -ENOMEM;
> +		goto err1;
> +	}
> +
> +	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +
> +	input_set_abs_params(input, ABS_X, 0, MAX_11BIT, 0, 0);
> +	input_set_abs_params(input, ABS_Y, 0, MAX_11BIT, 0, 0);
> +	input_set_abs_params(input, ABS_PRESSURE, 0, 0, 0, 0);
> +
> +	input->name = client->name;
> +	input->id.bustype = BUS_I2C;
> +	input->dev.parent = &client->dev;
> +
> +	input->open = dts413_open;
> +	input->close = dts413_close;
> +
> +	input_set_drvdata(input, priv);
> +
> +	priv->client = client;
> +	priv->input = input;
> +	INIT_DELAYED_WORK(&priv->work, dts413_poscheck);
> +	priv->irq = client->irq;
> +
> +	error = input_register_device(input);
> +	if (error)
> +		goto err1;
> +
> +	error = request_irq(priv->irq, dts413_isr,
> IRQF_TRIGGER_FALLING/*IRQF_TRIGGER_LOW*/,

lose the bits you don't want.


-- 
Ben Dooks, Software Engineer, Simtec Electronics

http://www.simtec.co.uk/
