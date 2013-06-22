From: gsi@denx.de (Gerhard Sittig)
Date: Sat, 22 Jun 2013 11:36:49 +0200
Subject: [PATCH v1 04/12] input: matrix-keypad: push/pull, separate
 polarity
In-Reply-To: <51C4C6C9.6030000@wwwdotorg.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-5-git-send-email-gsi@denx.de>
 <51C4C6C9.6030000@wwwdotorg.org>
Message-ID: <20130622093649.GF24305@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 15:34 -0600, Stephen Warren wrote:
> 
> On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> > extend the device tree adjustable hardware configuration:
> > - allow for differing polarity of the row and column GPIO pins
> > - optionally fully drive column output pins instead of the former
> >   unconditional open collector emulation approach
> 
> > diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> 
> > +- row-gpios-activelow:	row GPIO pins are active low
> > +- col-gpios-activelow:	column GPIO pins are active low
> >  - gpio-activelow:	row pins as well as column pins are active low
> > +			(provided for backward compatibility, and useful
> > +			for matrix layouts of identical polarity for
> > +			rows and columns)
> 
> Those should all come from the existing GPIO flags, and may even differ
> for each GPIO.
> 
> > +- col-gpios-pushpull:	fully drive the column selection pins in either
> > +			direction (high and low signals), the default
> > +			behaviour is to actively drive low signals and
> > +			be passive otherwise (emulates an open collector
> > +			output driver)
> 
> We don't actually have GPIO flags defined for pushpull-vs-open-collector
> etc. Perhaps we should do so. Then, we wouldn't need to invent custom
> properties to represent that in this binding.

I see your concerns and understand, but chose the above way to
just extend the existing implementation in the least intrusive
way without changing its nature.  See the reply on the first
patch for more details on the motivation.

Of course I agree that pin properties belong to the GPIO layer
and that "application drivers" on top should not worry about
that.  Were I allowed to break backwards compatibility, then I
could have done more shuffling.  But lacking the capability to
test the affected setups puts more burdon on others, which I
wanted to avoid.

And then there's the question of whether the "active low" applies
to the GPIO pin or to the matrix line (the above property
suggests it's the pin, but I'm yet undecided), and whether the
subsystems agree on a policy "where to put" the "overall
polarity" of such a chain of driver logic and SoC pins and
optionally involved inverting drivers and external components
which the driver communicates to.

The push-pull vs open-drain should never have made it into the
keypad driver, but that fact wasn't introduced but did exist.
Even if the kernel had no way to setup OD mode of a pin, the
bootloader has, and the kernel just needs to setup "values" just
like for any other pin regardless of push-pull or open-drain.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
