From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 27 Feb 2018 00:30:33 +0100
Subject: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
In-Reply-To: <20180226231336.GA18565@amd>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
Message-ID: <20180226233033.GA14094@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > >> JFYI: This issues is tracked in the regression reports for Linux 4.16
> > >> (http://bit.ly/lnxregrep416 ) with this id:
> > >>
> > >> Linux-Regression-ID: lr#4b650f
> > >
> > > Ok, so it seems that issue is bigger: whole sound subsystem does not
> > > work. /proc/asound/cards is empty.
> > >
> > > 7e6127c1240ed569cdda2a67c8f03836f9f28c05 seems to be bad already.
> > >
> > > I tried to revert sound/soc changes, and sound is broken, too. Nasty
> > 
> > 
> > dmesg log?
> 
> Partial dmesg is at:
> https://github.com/pavelmachek/missy/blob/master/db/phone/nokia/n900/pavel/2018.1291171648263/dmesg.out
> 
> I should be able to get full one...
> 
> I did git bisect, and the winner seems to be:
> 
> pavel at duo:/data/l/linux-n900$ git bisect bad
> c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
> commit c85823390215e52d68d3826df92a447ed31e5c80
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Wed Dec 27 16:37:44 2017 +0100

I reverted it on top of v4.16-rc2, and sound now works. Ideas?

(Aha, and I see I made small mistake reverting... but...)

								Pavel

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 564bb7a..50cc590 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -157,36 +157,6 @@ int of_get_named_gpio_flags(struct device_node *np, const char *list_name,
 EXPORT_SYMBOL(of_get_named_gpio_flags);
 
 /*
- * The SPI GPIO bindings happened before we managed to establish that GPIO
- * properties should be named "foo-gpios" so we have this special kludge for
- * them.
- */
-static struct gpio_desc *of_find_spi_gpio(struct device *dev, const char *con_id,
-					  enum of_gpio_flags *of_flags)
-{
-	char prop_name[32]; /* 32 is max size of property name */
-	struct device_node *np = dev->of_node;
-	struct gpio_desc *desc;
-
-	/*
-	 * Hopefully the compiler stubs the rest of the function if this
-	 * is false.
-	 */
-	if (!IS_ENABLED(CONFIG_SPI_MASTER))
-		return ERR_PTR(-ENOENT);
-
-	/* Allow this specifically for "spi-gpio" devices */
-	if (!of_device_is_compatible(np, "spi-gpio") || !con_id)
-		return ERR_PTR(-ENOENT);
-
-	/* Will be "gpio-sck", "gpio-mosi" or "gpio-miso" */
-	snprintf(prop_name, sizeof(prop_name), "%s-%s", "gpio", con_id);
-
-	desc = of_get_named_gpiod_flags(np, prop_name, 0, of_flags);
-	return desc;
-}
-
-/*
  * Some regulator bindings happened before we managed to establish that GPIO
  * properties should be named "foo-gpios" so we have this special kludge for
  * them.
@@ -230,7 +200,6 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 	struct gpio_desc *desc;
 	unsigned int i;
 
-	/* Try GPIO property "foo-gpios" and "foo-gpio" */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
 		if (con_id)
 			snprintf(prop_name, sizeof(prop_name), "%s-%s", con_id,
@@ -245,14 +214,6 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 			break;
 	}
 
-	/* Special handling for SPI GPIOs if used */
-	if (IS_ERR(desc))
-		desc = of_find_spi_gpio(dev, con_id, &of_flags);
-
-	/* Special handling for regulator GPIOs if used */
-	if (IS_ERR(desc))
-		desc = of_find_regulator_gpio(dev, con_id, &of_flags);
-
 	if (IS_ERR(desc))
 		return desc;


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180227/d6fdf318/attachment.sig>
