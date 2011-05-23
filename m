From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 May 2011 16:41:26 +0200
Subject: [PATCH] mfd wm8350: allocate irq descs dynamically
In-Reply-To: <20110523104409.GA15635@opensource.wolfsonmicro.com>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
	<1305878365-827-3-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1105201451160.3078@ionos>
	<20110520130721.GD10403@pengutronix.de>
	<alpine.LFD.2.02.1105201518030.3078@ionos>
	<20110521112947.GB11887@sirena.org.uk>
	<20110523062501.GA20715@pengutronix.de>
	<20110523104409.GA15635@opensource.wolfsonmicro.com>
Message-ID: <20110523144126.GF20715@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> > -	if (!pdata || !pdata->irq_base) {
> > -		dev_warn(wm8350->dev, "No interrupt support, no IRQ base\n");
> > +	if (!pdata) {
> > +		dev_warn(wm8350->dev, "No interrupt support, no platform data\n");
> 
> This isn't terribly good, the only reason we're checking pdata here is
> because we can't dereference it to look up irq_base if it's not there.

I'm not sure what you mean here. Are you suggesting that we should
default to dynamically requested irqs without platform data?
I did it this way because without platform data pdata->irq_high is
unknown.

> 
> > +	if (!pdata->irq_base) {
> > +		wm8350->irq_base = irq_alloc_descs(-1, 0, ARRAY_SIZE(wm8350_irqs), 0);
> > +		if (wm8350->irq_base < 0) {
> 
> One other thing - it doesn't seem to be 100% desirable to making the
> allocation of the IRQ descriptors depend on not specifying a base - for
> many situations we're likely to want to know what the numbers we end up
> with are (eg, for passing to another device) but if we don't call
> irq_alloc_decs() the platform still has to arrange for the descriptors
> to be there in advance.  It feels like the code should always use
> irq_alloc_descs(), though obviously that's not going to work right now.

If that's the case the platform still can provide irq_base and then it
does know in advance. Also, shouldn't this other device be instantiated
from the wm8350 driver?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
