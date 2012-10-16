From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 16 Oct 2012 11:35:45 -0400
Subject: [PATCH 1/4] leds: leds-ns2: add device tree binding
In-Reply-To: <20121016093914.GD28384@kw.sim.vm.gnt>
References: <1350315295-14567-1-git-send-email-simon.guinot@sequanux.org>
 <1350315295-14567-2-git-send-email-simon.guinot@sequanux.org>
 <20121015174144.GH20922@titan.lakedaemon.net>
 <20121015191222.GB28384@kw.sim.vm.gnt>
 <20121015195809.GJ20922@titan.lakedaemon.net>
 <20121016093914.GD28384@kw.sim.vm.gnt>
Message-ID: <20121016153545.GK20922@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 11:39:14AM +0200, Simon Guinot wrote:
> On Mon, Oct 15, 2012 at 03:58:09PM -0400, Jason Cooper wrote:
> > On Mon, Oct 15, 2012 at 09:12:22PM +0200, Simon Guinot wrote:
> > > On Mon, Oct 15, 2012 at 01:41:44PM -0400, Jason Cooper wrote:
> > > > On Mon, Oct 15, 2012 at 05:34:52PM +0200, Simon Guinot wrote:
...
> > > > > @@ -312,8 +389,9 @@ static struct platform_driver ns2_led_driver = {
> > > > >  	.probe		= ns2_led_probe,
> > > > >  	.remove		= __devexit_p(ns2_led_remove),
> > > > >  	.driver		= {
> > > > > -		.name	= "leds-ns2",
> > > > > -		.owner	= THIS_MODULE,
> > > > > +		.name		= "leds-ns2",
> > > > > +		.owner		= THIS_MODULE,
> > > > 
> > > > nit.  whitespace before '=', above two lines.
> > > 
> > > Sorry I don't get it. For the two lines before, I used two tabs before
> > > '='. As a result, this lines are aligned with the next one. I got no
> > > warnings and no errors from checkpatch.pl.
> > 
> > It's not a checkpatch problem.  It's that before your patch, the equals
> > signs were lined up.  Afterwards, they aren't.  In either case, if you
> > would like to fix the whitespace (line up all struct elements and the
> > equals signs), that should be a separate patch.
> 
> The current patch inserts a new field (of_match_table) in the structure.
> This new field breaks the equals signs alignment. I think it is correct
> to restore the alignment broken by a patch in the same patch context.
> 
> Do you really want me to put this in a separate patch ?

Ok, I see what you were doing.  No need for a separate patch.

> > > > > +		.of_match_table	= of_match_ptr(of_ns2_leds_match),
> > > > 
> > > > Have you tried this with OF_GPIO=n?  of_match_ptr() handles CONFIG_OF
> > > > being enabled/disabled.  Which means the case of CONFIG_OF=y,
> > > > CONFIG_OF_GPIO=n appears to be unhandled.
> > > 
> > > Good caught. I guess I have just copied a bug from the driver gpio-fan.
> > 
> > On the next round, please add a separate patch fixing gpio-fan.c.
> 
> After a second look, I noticed that several drivers are also mixing up
> CONFIG_OF and CONFIG_OF_GPIO checks: gpio-fan, leds-gpio, gpio_keys.c,
> i2c-gpio.c, spi-s3c64xx.c, ...
> 
> I also noticed that CONFIG_OF_GPIO can't be selected separately from
> CONFIG_OF. From Kconfig, CONFIG_OF implies CONFIG_OF_GPIO.
> 
> So, I am no longer convinced we have a bug here. But if there is, we
> will need more than a single patch to fix it :)

Agreed.  I'd hate to see what happens if CONFIG_OF_GPIO was decoupled
from CONFIG_OF.  :-/  Once DT conversion has settled down, we'll have to
look at removing it.

thx,

Jason.
