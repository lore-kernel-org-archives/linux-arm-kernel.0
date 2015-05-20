From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 20 May 2015 21:03:40 +0800
Subject: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <20150520085715.GA17078@pengutronix.de>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
 <20150520085715.GA17078@pengutronix.de>
Message-ID: <1432127020.20394.15.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Uwe,

On Wed, 2015-05-20 at 10:57 +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> now that I understood the formula some more comments to the calculation.
> 
> On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> > +#define I2C_DEFAUT_SPEED		100000	/* hz */
> DEFAULT?
> 
> > +#define MAX_FS_MODE_SPEED		400000
> > +#define MAX_HS_MODE_SPEED		3400000
> > +#define MAX_SAMPLE_CNT_DIV		8
> > +#define MAX_STEP_CNT_DIV		64
> > +#define MAX_HS_STEP_CNT_DIV		8
> > [...]
> > +/* calculate i2c port speed */
> > +static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int clk_src_in_hz)
> > +{
> add a comment here, that clk_src_in_hz is the parent clock already
> divided by clock-div.
> 
> > +	unsigned int khz;
> > +	unsigned int step_cnt;
> > +	unsigned int sample_cnt;
> > +	unsigned int sclk;
> > +	unsigned int hclk;
> > +	unsigned int max_step_cnt;
> > +	unsigned int sample_div = MAX_SAMPLE_CNT_DIV;
> > +	unsigned int step_div;
> > +	unsigned int min_div;
> > +	unsigned int best_mul;
> > +	unsigned int cnt_mul;
> > +
> > +	if (i2c->speed_hz > MAX_HS_MODE_SPEED)
> > +		return -EINVAL;
> According to the plan to tune for the highest possible rate <=
> i2c->speed_hz, you should handle the case (i2c->speed_hz >
> MAX_HS_MODE_SPEED) like i2c->speed_hz == MAX_HS_MODE_SPEED.
> Well, you might want to prevent an overflow in the calculation below
> however.

The check here means we don't support speed > MAX_HS_MODE_SPEED. This is
different then slightly slower bus speed due to rounding error.

> > +	else if (i2c->speed_hz > MAX_FS_MODE_SPEED)
> > +		max_step_cnt = MAX_HS_STEP_CNT_DIV;
> > +	else
> > +		max_step_cnt = MAX_STEP_CNT_DIV;
> So I assume this is the hardware limit on the step_cnt value. For
> FS_MODE and below you have 6 bits and writing X corresponds to
> step_cnt = X + 1. For HS_MODE there are only 3 bits. right?

Yes, correct.

> > +	step_div = max_step_cnt;
> > +	/* Find the best combination */
> > +	khz = i2c->speed_hz / 1000;
> > +	hclk = clk_src_in_hz / 1000;
> Why are you dividing here? There shouldn't be an overflow problem and
> you're loosing precision.

Agreed, they should be removed.

> > +	min_div = ((hclk >> 1) + khz - 1) / khz;
> The shift accounts for the fixed divider 2 in
> 
> 	i2c_bus_freq = parent_clk / (clock-div * 2 * sample_cnt * step_cnt
> 
> ? Maybe better call this opt_div instead of min_div? So now we're
> searching for the best pair (sample_cnt, step_cnt) with:
> 
> 	* 0 < sample_cnt < MAX_SAMPLE_CNT_DIV
> 	* 0 < step_cnt < max_step_cnt
> 	* sample_cnt * step_cnt >= min_div
> 	* optimizing for sample_cnt * step_cnt being minimal
> 
> Right?

Yes.

> > +	best_mul = MAX_SAMPLE_CNT_DIV * max_step_cnt;
> > +
> > +	for (sample_cnt = 1; sample_cnt <= MAX_SAMPLE_CNT_DIV; sample_cnt++) {
> > +		step_cnt = (min_div + sample_cnt - 1) / sample_cnt;
> DIV_ROUND_UP
> 
> > +		cnt_mul = step_cnt * sample_cnt;
> > +		if (step_cnt > max_step_cnt)
> > +			continue;
> I think it can happen that you have step_cnt > max_step_cnt here, but
> that (sample_cnt, max_step_cnt) still is a good pair to consider. So:


If step_cnt > max_step_cnt, then sample_cnt * max_step_cnt < min_div.
This means (sample_cnt, max_step_cnt) is not a valid.

Joe.C
