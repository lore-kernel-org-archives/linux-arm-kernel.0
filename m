From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 24 Feb 2018 22:46:17 +0100
Subject: regression v4.16 on Nokia N900:/dev/input/event6 aka AV Jack support
 disappeared
Message-ID: <20180224214617.GA22619@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

In v4.16, AV jack support disappeared.

This one is suspect:

commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057
Author: Andrew F. Davis <afd@ti.com>
Date:   Wed Nov 29 11:13:59 2017 -0600

    ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

    The correct DT property for specifying a GPIO used for reset
        is "reset-gpios", fix this here.

    Fixes: 14e3e295b2b9 ("ARM: dts: omap3-n900: Add TLV320AIC3X
    support")

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

How was it tested? It reverts polarity of reset pin, but
sound/soc/codecs/tlv320aic3x.c treats those as aliases:

 ret = of_get_named_gpio(np, "reset-gpios", 0);
 if (ret >= 0) {
    aic3x->gpio_reset = ret;
 } else {
 ret = of_get_named_gpio(np, "gpio-reset", 0);
 if (ret > 0) {
    dev_warn(&i2c->dev, "Using deprecated property \"gpio-r\eset\", please update your DT");
    aic3x->gpio_reset = ret;


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180224/bcfa934f/attachment-0001.sig>
