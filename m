From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 2 Dec 2009 21:31:31 +0100
Subject: [PATCH] leds: Add LED class driver for regulator driven LEDs.
In-Reply-To: <1259778235.3588.141.camel@odin>
References: <1259775625-25973-1-git-send-email-ospite@studenti.unina.it>
	<1259778235.3588.141.camel@odin>
Message-ID: <20091202213131.1393a956.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 02 Dec 2009 18:23:55 +0000
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> On Wed, 2009-12-02 at 18:40 +0100, Antonio Ospite wrote:
> > This driver provides an interface for controlling LEDs (or vibrators)
> > connected to PMICs for which there is a regulator framework driver.
> > 
> > This driver can be used, for instance, to control vibrator on all Motorola EZX
> > phones using the pcap-regulator driver services.
> > 
> > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> 
> Some very minor points below.
> 

Thanks for reviewing the code.

[...]
> > +
> > +static void led_work(struct work_struct *work)
> > +{
> > +	struct regulator_led *led;
> > +	int voltage;
> > +	int ret;
> > +
> > +	led = container_of(work, struct regulator_led, work);
> > +
> > +	mutex_lock(&led->mutex);
> > +
> > +	if (led->value == 0) {
> 
> LED_OFF instead of 0 here ?
>

Ok.

> > +		regulator_led_disable(led);
> > +		goto out;
> > +	}
> > +
> > +	voltage = led_regulator_get_vdd(led->vcc, led->value);
> > +	dev_dbg(led->cdev.dev, "brightness: %d voltage: %d",
> > +			led->value, voltage);
> > +
> > +	ret = regulator_set_voltage(led->vcc, voltage, voltage);
> > +	if (ret != 0)
> > +		dev_err(led->cdev.dev, "Failed to set voltage %d: %d\n",
> > +			voltage, ret);
> 
> Some regulators may not support voltage change (via hw design or
> constraints) so set_voltage() will fail. We probably want to handle this
> regulator type so we don't call set_voltage().
>

Ok, I'll read more about the regulator framework to find out how to
check regulator capabilities.

> > +
> > +	regulator_led_enable(led);
> > +
> > +out:
> > +	mutex_unlock(&led->mutex);
> > +}
> > +
[...]
> > +static int regulator_led_probe(struct platform_device *pdev)
> > +{
> > +	struct led_regulator_platform_data *pdata = pdev->dev.platform_data;
> > +	struct regulator_led *led;
> > +	struct regulator *vcc;
> > +	int ret;
> > +
> > +	if (pdata == NULL) {
> > +		dev_err(&pdev->dev, "no platform data\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	vcc = regulator_get(&pdev->dev, pdata->supply);
> > +	if (IS_ERR(vcc)) {
> > +		dev_err(&pdev->dev, "Cannot get vcc for %s\n", pdata->name);
> > +		return PTR_ERR(vcc);;
> 
> double ;; here
>

Thanks.

[...]

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091202/9a79008c/attachment.sig>
