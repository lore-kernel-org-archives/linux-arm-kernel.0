From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 2 Dec 2009 21:25:21 +0100
Subject: [PATCH] leds: Add LED class driver for regulator driven LEDs.
In-Reply-To: <20091202180658.GA12292@rakim.wolfsonmicro.main>
References: <1259775625-25973-1-git-send-email-ospite@studenti.unina.it>
	<20091202180658.GA12292@rakim.wolfsonmicro.main>
Message-ID: <20091202212521.500f7a46.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Dec 2009 18:06:58 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Dec 02, 2009 at 06:40:25PM +0100, Antonio Ospite wrote:
> 
> > A doubt I had was about leaving the 'supply' variable configurable from
> > platform data, or relying on some fixed value like "vled", but leaving it
> > configurable covers the case when we have different regulators used for
> > different LEDs or vibrators.
> 
> There's no need to do this since the regulator API matches consumers
> based on struct device as well as name so you can have as many LEDs as
> you like all using the same supply name mapping to different regulators.
>

I need some more explanation here, I am currently using the driver with
this code:

+/* VVIB: Vibrator on A780, A1200, A910, E6, E2 */
+static struct regulator_consumer_supply pcap_regulator_VVIB_consumers
[] = {
+	{ .dev_name = "leds-regulator", .supply = "vibrator", },
                                                   ^^^^^^^^
+};
+
+static struct regulator_init_data pcap_regulator_VVIB_data = {
+	.constraints = {
+		.min_uV = 1300000,
+		.max_uV = 3000000,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS |
+					REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies = ARRAY_SIZE
(pcap_regulator_VVIB_consumers),
+	.consumer_supplies = pcap_regulator_VVIB_consumers,
+};

@@ -749,6 +766,10 @@ static struct pcap_subdev a780_pcap_subdevs[] = {
 		.name		= "pcap-regulator",
 		.id		= VAUX3,
 		.platform_data	= &pcap_regulator_VAUX3_data,
+	}, {
+		.name		= "pcap-regulator",
+		.id		= VVIB,
+		.platform_data	= &pcap_regulator_VVIB_data,
 	},
 };


and then:

 
@@ -872,8 +893,24 @@ static struct platform_device a780_camera = {
 	},
 };
 
+/* vibrator */
+static struct led_regulator_platform_data a780_vibrator_data = {
+	.name   = "a780::vibrator",
+	.supply = "vibrator"
                   ^^^^^^^^ I'll get the regulator with this.
+};
+
+static struct platform_device a780_vibrator = {
+	.name = "leds-regulator",
+	.id   = -1,
+	.dev  = {
+		.platform_data = &a780_vibrator_data,
+	},
+};
+
+
 static struct platform_device *a780_devices[] __initdata = {
 	&a780_gpio_keys,
+	&a780_vibrator
 };

If I set the .supply value fixed, how can I assign different
regulators to different leds? Should I use the address to the platform
device (a780_vibrator in this case) for .dev when defining the
regulator in the first place?

> > Should I add a note in Documentation/ about how to use it? Tell me if so.
> 
> If you wish to, it's not essential (only one existing LED driver appears
> to do this) and the comment in the header file is probably adequate.
>

Ok.

> > +static inline int led_regulator_get_max_brightness(struct regulator *supply)
> > +{
> > +	return regulator_count_voltages(supply);
> > +}
> 
> More graceful handling of regulators that don't implement list_voltage
> might be nice (for simple on/off control - not all regulators have
> configurable voltages).  If a regulator doesn't support list_voltage
> you'll get -EINVAL.
>

Ok, I need to study the regulator framework a bit more, but I think I
got the logic you are referring to, if we can actually list voltages
then max_brightness is the number of voltages as it is now, else if we
can only change status then max_brightness is 1 (one).

> > +	vcc = regulator_get(&pdev->dev, pdata->supply);
> > +	if (IS_ERR(vcc)) {
> > +		dev_err(&pdev->dev, "Cannot get vcc for %s\n", pdata->name);
> > +		return PTR_ERR(vcc);;
> > +	}
> 
> You almost certainly want regulator_get_exclusive() here; this driver
> can't function properly if something else is using the regulator and
> holding the LED on or off without it.  You'll also want to check the
> status of the LED on startup and update your internal status to match
> that.

Will do, thanks for reviewing the code.

Regards,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091202/beae4876/attachment.sig>
