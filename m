From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 20 Dec 2016 21:44:51 +0100
Subject: [PATCH v6 4/5] fpga manager: Add cyclone-ps-spi driver for
 Altera FPGAs
In-Reply-To: <ba899a9f-3a31-85c5-9da4-dd64a2661e60@gmail.com>
References: <cover.1481918884.git.stillcompiling@gmail.com>
 <abaad69b5dd15c086826cc9b6e2d52aefb04f9ef.1481918884.git.stillcompiling@gmail.com>
 <20161219072326.fael3uughtghexl4@pengutronix.de>
 <ba899a9f-3a31-85c5-9da4-dd64a2661e60@gmail.com>
Message-ID: <20161220204451.knlh4zqz53gx4neq@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joshua,

On Tue, Dec 20, 2016 at 11:47:37AM -0800, Joshua Clayton wrote:
> >> + *  Copyright (c) 2017 United Western Technologies, Corporation
> > In which timezone it's already 2017? s/  / /
> >
> LOL. It will be 2017 long before 4.11 was my thinking.
> I guess I've never spent much time on time stamp etiquette for copyright.
> It said "2015" in v5, despite still being revised.

Well, you have to put the date when you worked on the driver.

> >> + *
> >> + *  Joshua Clayton <stillcompiling@gmail.com>
> >> + *
> >> + * Manage Altera FPGA firmware that is loaded over spi using the passive
> >> + * serial configuration method.
> >> + * Firmware must be in binary "rbf" format.
> >> + * Works on Cyclone V. Should work on cyclone series.
> >> + * May work on other Altera FPGAs.
> > I can test this later on an Arria 10. I'm not sure what the connection
> > between "Cyclone" and "Arria" is, but the protocol looks similar.
> My guess was it would be.
> Would be wonderful to have someone to test.

I didn't come around yet.

> >> + *
> >> + */
> >> +
> >> +#include <linux/bitrev.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/fpga/fpga-mgr.h>
> >> +#include <linux/gpio/consumer.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_gpio.h>
> >> +#include <linux/spi/spi.h>
> >> +#include <linux/sizes.h>
> >> +
> >> +#define FPGA_RESET_TIME		50   /* time in usecs to trigger FPGA config */
> >> +#define FPGA_MIN_DELAY		50   /* min usecs to wait for config status */
> >> +#define FPGA_MAX_DELAY		1000 /* max usecs to wait for config status */
> >> +
> >> +struct cyclonespi_conf {
> >> +	struct gpio_desc *config;
> >> +	struct gpio_desc *status;
> >> +	struct spi_device *spi;
> >> +};
> >> +
> >> +static const struct of_device_id of_ef_match[] = {
> >> +	{ .compatible = "altr,cyclone-ps-spi-fpga-mgr", },
> >> +	{}
> >> +};
> >> +MODULE_DEVICE_TABLE(of, of_ef_match);
> > barebox already has such a driver, the binding is available at
> >
> > 	https://git.pengutronix.de/cgit/barebox/tree/Documentation/devicetree/bindings/firmware/altr,passive-serial.txt
> >
> > (This isn't completely accurate because nstat is optional in the driver.)
> Interesting.
> The binding looks ... like we should synchronize those bindings.

ack.

> >> +	gpiod_set_value(conf->config, 1);
> >> +	usleep_range(FPGA_RESET_TIME, FPGA_RESET_TIME + 20);
> >> +	if (!gpiod_get_value(conf->status)) {
> >> +		dev_err(&mgr->dev, "Status pin should be low.\n");
> > You write this when get_value returns 0. There is something fishy.
> I'll take a look. These gpios are "active low", so a logical 1 is a
> physical low, IIRC. Maybe I should change the wording:
> Something like dev_err(&mgr->dev, "Status pin should be in reset.\n");

maybe "inactive"? Then then you should better use nconfig as dts name
(as done in the barebox binding) and put the active low information into
the flag.

> >> +		return -EIO;
> >> +	}
> >> +
> >> +	gpiod_set_value(conf->config, 0);
> >> +	for (i = 0; i < (FPGA_MAX_DELAY / FPGA_MIN_DELAY); i++) {
> >> +		usleep_range(FPGA_MIN_DELAY, FPGA_MIN_DELAY + 20);
> >> +		if (!gpiod_get_value(conf->status))
> >> +			return 0;
> >> +	}
> >> +
> >> +	dev_err(&mgr->dev, "Status pin not ready.\n");
> >> +	return -EIO;
> > For Arria 10 the documentation has:
> >
> > 	To ensure a successful configuration, send the entire
> > 	configuration data to the device. CONF_DONE is released high
> > 	when the device receives all the configuration data
> > 	successfully. After CONF_DONE goes high, send two additional
> > 	falling edges on DCLK to begin initialization and enter user
> > 	mode.
> >
> > ISTR this is necessary for Arria V, too.
> DCLK is the spi clock, yes?
> Would sending an extra byte after CONF_DONE is released suffice?

The barebox driver sends two bytes.

> >> +}
> >> +
> >> +static int cyclonespi_write(struct fpga_manager *mgr, const char *buf,
> >> +			    size_t count)
> >> +{
> >> +	struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
> >> +	const char *fw_data = buf;
> >> +	const char *fw_data_end = fw_data + count;
> >> +
> >> +	while (fw_data < fw_data_end) {
> >> +		int ret;
> >> +		size_t stride = min(fw_data_end - fw_data, SZ_4K);
> >> +
> >> +		rev_buf((void *)fw_data, stride);
> > This isn't necessary if the spi controller supports SPI_LSB_FIRST. At
> > least the mvebu spi core can do this for you. (The driver doesn't
> > support it yet, though.)
> This is true, but many of them do not.

And I think it's hard to detect if the adapter driver supports this or
simply ignores it.
 
> Moritz Fischer had  proposal to add things like this with a flag.
> It could then be part of the library, rather than part of the driver
> 
> Speaking of which,
> I made an unsuccessful attempt to hack generic lsb first SPI
> with an extra bounce buffer.
> Sending was fine, but I ran into trouble with LSB first rx
> (I think) because of dma.

Link?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
