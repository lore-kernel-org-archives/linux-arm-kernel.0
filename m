From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 2 Mar 2018 12:10:40 +0100
Subject: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
In-Reply-To: <CACRpkda=deFSmk2iyrtde3Z-aj6rW9_jNfE3Ep4X=ejprGxRUw@mail.gmail.com>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
 <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
 <20180302091025.GC30267@amd>
 <CACRpkda=deFSmk2iyrtde3Z-aj6rW9_jNfE3Ep4X=ejprGxRUw@mail.gmail.com>
Message-ID: <20180302111040.GA6344@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > If this is taking longer to fix, should c85823390215 be reverted in
> > the meantime? It does not seem particulary important/urgent...
> 
> No patience between the v4.16 release candidates eh ;)
> 
> commit 6662ae6af82df10259a70c7569b4c12ea7f3ba93
> ("gpiolib: Keep returning EPROBE_DEFER when we should")
> 
> and
> 
> commit ce27fb2c56db6ccfe8099343bb4afdab15e77e7b
> ("gpio: Handle deferred probing in of_find_gpio() properly")
> 
> that are both in Torvalds' tree since yesterday should be fixing
> this, I think? Did you try just using the upstream HEAD?

Ok, so this code looks pretty crazy to me: I tried removing the
"of_find_spi_gpio" part, and audio started working.

What is going on with the ()s around == s? You made me look up C
operator precedence.

Hmm, and it is also wrong, right? It turns any error code into ENOENT,
as it tries to do the "special handling".

                 *                                                                      
                 * This means we don't need to look any further for                     
                 * alternate name conventions, and we should really                     
                 * preserve the return code for our user to be able to                  
                 * retry probing later.                                                 
                 */
                if (IS_ERR(desc) && PTR_ERR(desc) == -EPROBE_DEFER)
                        return desc;

                if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
                        break;
        }

        /* Special handling for SPI GPIOs if used */
        if (IS_ERR(desc))
                desc = of_find_spi_gpio(dev, con_id, &of_flags);

        /* Special handling for regulator GPIOs if used */
        if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
                desc = of_find_regulator_gpio(dev, con_id, &of_flags);

Something like this?

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 84e5a9d..f0fab26 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -241,29 +241,17 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 
 		desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
 						&of_flags);
-		/*
-		 * -EPROBE_DEFER in our case means that we found a
-		 * valid GPIO property, but no controller has been
-		 * registered so far.
-		 *
-		 * This means we don't need to look any further for
-		 * alternate name conventions, and we should really
-		 * preserve the return code for our user to be able to
-		 * retry probing later.
-		 */
-		if (IS_ERR(desc) && PTR_ERR(desc) == -EPROBE_DEFER)
-			return desc;
 
-		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
+		if (!IS_ERR(desc) || PTR_ERR(desc) != -ENOENT)
 			break;
 	}
 
 	/* Special handling for SPI GPIOs if used */
-	if (IS_ERR(desc))
+	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
 		desc = of_find_spi_gpio(dev, con_id, &of_flags);
 
 	/* Special handling for regulator GPIOs if used */
-	if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
+	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
 		desc = of_find_regulator_gpio(dev, con_id, &of_flags);
 
 	if (IS_ERR(desc))

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/47927776/attachment.sig>
