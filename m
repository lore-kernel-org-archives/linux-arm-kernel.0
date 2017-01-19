From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Jan 2017 09:02:58 +0100
Subject: [PATCH v9 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <CAOAejn2LobTMfvsvmW8cCiToFHuM6n26s5QPLLXxLzb-WKkhQw@mail.gmail.com>
References: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
 <1484666821-20551-3-git-send-email-cedric.madianga@gmail.com>
 <20170117193752.e6hju25w74bb4i4z@pengutronix.de>
 <CAOAejn0ea2j_oUijOdHgiL3JU4TM0HZoL+-ggzjpPL2eA7tDCw@mail.gmail.com>
 <20170118184237.tvhlsksdcw2ckwan@pengutronix.de>
 <CAOAejn2LobTMfvsvmW8cCiToFHuM6n26s5QPLLXxLzb-WKkhQw@mail.gmail.com>
Message-ID: <20170119080258.fovhfy2v6rrtgwgp@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Cedric,

On Wed, Jan 18, 2017 at 09:55:39PM +0100, M'boumba Cedric Madianga wrote:
> 2017-01-18 19:42 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello Cedric,
> >
> > On Wed, Jan 18, 2017 at 04:21:17PM +0100, M'boumba Cedric Madianga wrote:
> >> >> +      * In standard mode, the maximum allowed SCL rise time is 1000 ns.
> >> >> +      * If, in the I2C_CR2 register, the value of FREQ[5:0] bits is equal to
> >> >> +      * 0x08 so period = 125 ns therefore the TRISE[5:0] bits must be
> >> >> +      * programmed with 09h.(1000 ns / 125 ns = 8 + 1)
> >> >
> >> >         * programmed with 0x9.
> >> > (1000 ns / 125 ns = 8)
> >> >
> >> >> +      * So, for I2C standard mode TRISE = FREQ[5:0] + 1
> >> >> +      *
> >> >> +      * In fast mode, the maximum allowed SCL rise time is 300 ns.
> >> >> +      * If, in the I2C_CR2 register, the value of FREQ[5:0] bits is equal to
> >> >> +      * 0x08 so period = 125 ns therefore the TRISE[5:0] bits must be
> >> >> +      * programmed with 03h.(300 ns / 125 ns = 2 + 1)
> >> >
> >> > as above s/03h/0x3/;
> >>
> >> ok
> >>
> >> > s/.(/. (/;
> >> ok
> >>
> >> > s/+ 1//;
> >> This formula is use to understand how we find the result 0x3
> >> So, 0x3 => 300 ns / 125ns = 2 + 1
> >
> > Yeah, I understood that, but writing 300 ns / 125ns = 2 + 1 is
> > irritating at best.
> 
> Ok. I will write 0x3 (300 ns / 125 ns + 1) and 0x9 (1000 ns / 125 ns + 1)
> 
> >> >         [...]
> >> >         If DUTY = 1: (to reach 400 kHz)
> >> >
> >> > Strange.
> >> >
> >> >> +             val = DIV_ROUND_UP(i2c_dev->parent_rate, 400000 * 3);
> >> >
> >> > the manual reads:
> >> >
> >> >         The minimum allowed value is 0x04, except in FAST DUTY mode
> >> >         where the minimum allowed value is 0x01
> >> >
> >> > You don't check for that, right?
> >>
> >> As the minimum freq value is 6 Mhz in fast mode the minimum CCR is 5
> >> as described in the comment.
> >> So I don't need to check that again as it is already done by checking
> >> parent frequency.
> >
> > That would then go into a comment.
> 
> Is it really needed ?
> Adding some comments to explain implementation choices or  hardware
> way of working is clearly useful.
> But for this kind of thing, I am really surprised...

TL;DR: It's not needed, but it probably helps.

Consider someone sees a breakage in your driver in five years. By then
you either have other interests or at least forgot 95 % of the thoughts
you had when implementing the driver.

So when I see:

	val = DIV_ROUND_UP(i2c_dev->parent_rate, 400000 * 3);
	ccr |= STM32F4_I2C_CCR_CCR(val);
	writel_relaxed(ccr, i2c_dev->base + STM32F4_I2C_CCR);                                                                                                       

after seeing that the bus freq is wrong the obvious thoughts are:

 - Does this use the right algorithm?
 - Does this calculation result in values that are usable by the
   hardware?

That you thought about this today doesn't mean it's still right in five
years. During that time a new hardware variant is available with a
higher parent freq. Or there is a new errata available for the SoC.

So to help answer the questions above it helps if you add today the
formulas from the manual and a quick reason for why val fits into the
respective bits in the CCR register. That comment might be wrong until
then, too, but that only means you should make it easy to verify.
Something like:

	/* 
	 * Function bla_blub made sure that parent_rate is not higher
	 * than 23 * pi MHz. As a result val is at most 13.2 bits wide
	 * and so fits into the CCR bits.
	 */

This gives you in five years time the opportunity to quickly check
bla_blub if this is still true, add a printk for parent_rate to check
this, or quickly identify the bug in the code or the mismatch to the
manual.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
