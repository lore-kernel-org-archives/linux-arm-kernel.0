From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Apr 2013 11:24:36 +0200
Subject: [PATCH v3] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <201304181101.13644.arnd@arndb.de>
References: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201304172223.43707.arnd@arndb.de>
 <20130418081555.GV30416@pengutronix.de>
 <201304181101.13644.arnd@arndb.de>
Message-ID: <20130418092436.GB21099@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 11:01:13AM +0200, Arnd Bergmann wrote:
> On Thursday 18 April 2013, Uwe Kleine-K?nig wrote:
> > > > + * Each bank handles 32 irqs. Only the 16th (= last) bank handles only
> > > > + * 16 irqs.
> > > > + */
> > > > +#define NVIC_MAX_IRQ               ((NVIC_MAX_BANKS - 1) * 32 + 16)
> > > 
> > > Is this actually inherent to the hardware design, or is the number of irqs
> > > actually customizable? Also, why do you care about the maximum? You only
> > > use it to check against the device tree provided value, but I suppose
> > > you could just as well trust that property to be correct.
> > I don't provide a value for the number of irqs in the device tree. There
> > is only the value INTLINESNUM in the V7M_SCS_ICTR register that is used
> > to determine the number of interrupt banks.
> 
> Ah, right. But do you have any reason to believe it could be wrong?
No it's just that the mapping isn't linear in the end.

	INTLINESNUM | number of irqs
	      0     |     32
	      1     |     64
	      2     |     96
	      3     |    128
	      4     |    160
	      5     |    192
	      6     |    224
	      7     |    256
	      8     |    288
	      9     |    320
	     10     |    352
	     11     |    384
	     12     |    416
	     13     |    448
	     14     |    480
	     15     |    496

That is, there are (INTLINESNUM + 1) * 32 irqs for INTLINESNUM < 15. For
INTLINESNUM == 15 there are only 496 and not 16 * 32 == 512. That's the
same on the gic (just with bigger numbers).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
