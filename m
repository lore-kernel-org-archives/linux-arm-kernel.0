From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 May 2015 17:37:28 +0200
Subject: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <1432127020.20394.15.camel@mtksdaap41>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
 <20150520085715.GA17078@pengutronix.de>
 <1432127020.20394.15.camel@mtksdaap41>
Message-ID: <20150520153728.GT24769@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, May 20, 2015 at 09:03:40PM +0800, Yingjoe Chen wrote:
> On Wed, 2015-05-20 at 10:57 +0200, Uwe Kleine-K?nig wrote:
> > On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> > > +	if (i2c->speed_hz > MAX_HS_MODE_SPEED)
> > > +		return -EINVAL;
> > According to the plan to tune for the highest possible rate <=
> > i2c->speed_hz, you should handle the case (i2c->speed_hz >
> > MAX_HS_MODE_SPEED) like i2c->speed_hz == MAX_HS_MODE_SPEED.
> > Well, you might want to prevent an overflow in the calculation below
> > however.
> 
> The check here means we don't support speed > MAX_HS_MODE_SPEED. This is
> different then slightly slower bus speed due to rounding error.
Well from outside there no difference between asking for 100 with
getting 98 or asking for 405 with getting 400. IMHO the expectation is
that you set the maximal possible rate when something too big for you is
requested. Consider a communication with a i2c device that supports 600
kHz. You have the choice to communicate with 400 kHz with that or not at
all.

> > > +	best_mul = MAX_SAMPLE_CNT_DIV * max_step_cnt;
> > > +
> > > +	for (sample_cnt = 1; sample_cnt <= MAX_SAMPLE_CNT_DIV; sample_cnt++) {
> > > +		step_cnt = (min_div + sample_cnt - 1) / sample_cnt;
> > DIV_ROUND_UP
> > 
> > > +		cnt_mul = step_cnt * sample_cnt;
> > > +		if (step_cnt > max_step_cnt)
> > > +			continue;
> > I think it can happen that you have step_cnt > max_step_cnt here, but
> > that (sample_cnt, max_step_cnt) still is a good pair to consider. So:
> 
> If step_cnt > max_step_cnt, then sample_cnt * max_step_cnt < min_div.
> This means (sample_cnt, max_step_cnt) is not a valid.
You're right.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
