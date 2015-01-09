From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Jan 2015 02:42:15 +0100
Subject: [PATCH 2/2] leds: tlc59116: Driver for the TI 16 Channel i2c LED
 driver
In-Reply-To: <54AF2275.9050600@gmail.com>
References: <1420763178-10115-1-git-send-email-andrew@lunn.ch>
 <1420763178-10115-3-git-send-email-andrew@lunn.ch>
 <54AF2275.9050600@gmail.com>
Message-ID: <20150109014215.GC10191@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 06:06:05AM +0530, Varka Bhadram wrote:
> 
> On Friday 09 January 2015 05:56 AM, Andrew Lunn wrote:
> >The TLC59116 is an I2C bus controlled 16-channel LED driver.  Each LED
> >output has its own 8-bit fixed-frequency PWM controller to control the
> >brightness of the LED.
> >
> >This is based on a driver from Belkin, but has been extensively
> >rewritten.
> >
> >Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >Cc: Matthew.Fatheree at belkin.com
> >---
> >  drivers/leds/Kconfig         |   7 ++
> >  drivers/leds/Makefile        |   1 +
> >  drivers/leds/leds-tlc59116.c | 253 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 261 insertions(+)
> >  create mode 100644 drivers/leds/leds-tlc59116.c
> >
> (...)
> 
> >+static const struct of_device_id of_tlc59116_leds_match[] = {
> >+	{ .compatible = "ti,tlc59116", },
> >+	{},
> >+};
> >+
> 
> Missing MODULE_DEVICE_TABLE(of, ...)..?

Thanks. I will add it. I was using leds-tca6507.c as my reference. It
also does not have one, but i will leave that to somebody else to fix.

     Andrew
 
> >+static const struct i2c_device_id tlc59116_id[] = {
> >+	{ "tlc59116" },
> >+	{},
> >+};
> >+MODULE_DEVICE_TABLE(i2c, tlc59116_id);
> >+
> >+static struct i2c_driver tlc59116_driver = {
> >+	.driver = {
> >+		.name = "tlc59116",
> >+		.of_match_table = of_match_ptr(of_tlc59116_leds_match),
> >+
> 
> Remove this unnecessary line space...
> 
> >+	},
> >+	.probe = tlc59116_probe,
> >+	.remove = tlc59116_remove,
> >+	.id_table = tlc59116_id,
> >+};
> >+
> >+module_i2c_driver(tlc59116_driver);
> >+
> >+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
> >+MODULE_LICENSE("GPL");
> >+MODULE_DESCRIPTION("TLC59116 LED driver");
> 
> -- 
> Thanks and Regards,
> Varka Bhadram.
> 
