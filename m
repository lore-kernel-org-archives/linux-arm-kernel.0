From: ospite@studenti.unina.it (Antonio Ospite)
Date: Fri, 4 Dec 2009 13:57:57 +0100
Subject: [PATCH] leds: Add LED class driver for regulator driven LEDs.
In-Reply-To: <20091202204121.GB18311@rakim.wolfsonmicro.main>
References: <1259775625-25973-1-git-send-email-ospite@studenti.unina.it>
	<1259778235.3588.141.camel@odin>
	<20091202213131.1393a956.ospite@studenti.unina.it>
	<20091202204121.GB18311@rakim.wolfsonmicro.main>
Message-ID: <20091204135757.d7533e20.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Dec 2009 20:41:22 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Dec 02, 2009 at 09:31:31PM +0100, Antonio Ospite wrote:
> > Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> 
> > > Some regulators may not support voltage change (via hw design or
> > > constraints) so set_voltage() will fail. We probably want to handle this
> > > regulator type so we don't call set_voltage().
> 
> > Ok, I'll read more about the regulator framework to find out how to
> > check regulator capabilities.
> 
> Checking for errors when counting and listing the voltages ought to
> cover this.

This is the incremental change I have in mind; if it's ok, then
a v2 is on its way.

diff --git a/drivers/leds/leds-regulator.c b/drivers/leds/leds-regulator.c
index f4c508b..8146d12 100644
--- a/drivers/leds/leds-regulator.c
+++ b/drivers/leds/leds-regulator.c
@@ -34,14 +34,23 @@ struct regulator_led {

 static inline int led_regulator_get_max_brightness(struct regulator *supply)
 {
-       return regulator_count_voltages(supply);
+       int ret = regulator_count_voltages(supply);
+
+       /* even if regulator can't change voltages,
+        * we still assume it can change status
+        * and the LED can be turned on and off.
+        */
+       if (ret == -EINVAL)
+               return 1;
+
+       return ret;
 }

 static int led_regulator_get_vdd(struct regulator *supply,
                enum led_brightness brightness)
 {
        if (brightness == 0)
-               return 0;
+               return -EINVAL;

        return regulator_list_voltage(supply, brightness - 1);
 }
@@ -95,13 +104,15 @@ static void led_work(struct work_struct *work)
        }

        voltage = led_regulator_get_vdd(led->vcc, led->value);
-       dev_dbg(led->cdev.dev, "brightness: %d voltage: %d",
-                       led->value, voltage);
-
-       ret = regulator_set_voltage(led->vcc, voltage, voltage);
-       if (ret != 0)
-               dev_err(led->cdev.dev, "Failed to set voltage %d: %d\n",
-                       voltage, ret);
+       if (voltage) {
+               dev_dbg(led->cdev.dev, "brightness: %d voltage: %d",
+                               led->value, voltage);
+
+               ret = regulator_set_voltage(led->vcc, voltage, voltage);
+               if (ret != 0)
+                       dev_err(led->cdev.dev, "Failed to set voltage %d: %d\n",
+                               voltage, ret);
+       }

        regulator_led_enable(led);


In the last hunk I could have checked (max_brightness > 1) in place
of (voltage) given the first hunk, any opinion?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091204/8e19f4b9/attachment.sig>
