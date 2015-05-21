From: eddie.huang@mediatek.com (Eddie Huang)
Date: Thu, 21 May 2015 15:01:29 +0800
Subject: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <20150520085715.GA17078@pengutronix.de>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
 <20150520085715.GA17078@pengutronix.de>
Message-ID: <1432191689.28646.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please see my reply below (I skip comments that already reply in another
mail).

On Wed, 2015-05-20 at 10:57 +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> now that I understood the formula some more comments to the calculation.
> 
> On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> > +#define I2C_DEFAUT_SPEED		100000	/* hz */
> DEFAULT?
> 
Yes, will fix.

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
We move parent_clk div clock-div in mtk_i2c_set_speed function, I think
this is more clear.

> > +	step_div = max_step_cnt;
> > +	/* Find the best combination */
> > +	khz = i2c->speed_hz / 1000;
> > +	hclk = clk_src_in_hz / 1000;
> Why are you dividing here? There shouldn't be an overflow problem and
> you're loosing precision.
OK, will remove div 1000.

> 
> > +	min_div = ((hclk >> 1) + khz - 1) / khz;
> The shift accounts for the fixed divider 2 in
> 
> 	i2c_bus_freq = parent_clk / (clock-div * 2 * sample_cnt * step_cnt
> 
> ? Maybe better call this opt_div instead of min_div? 
OK

> 
> > +	best_mul = MAX_SAMPLE_CNT_DIV * max_step_cnt;
> > +
> > +	for (sample_cnt = 1; sample_cnt <= MAX_SAMPLE_CNT_DIV; sample_cnt++) {
> > +		step_cnt = (min_div + sample_cnt - 1) / sample_cnt;
> DIV_ROUND_UP
OK

> > +
> > +		if (cnt_mul < best_mul) {
> > +			best_mul = cnt_mul;
> > +			sample_div = sample_cnt;
> > +			step_div = step_cnt;
> I'd call these best_sample_cnt and best_step_cnt instead of sample_div
> and step_div.
OK

> 
> > +			if (best_mul == min_div)
> > +				break;
> > +		}
> > +	}
> > +
> > +	sample_cnt = sample_div;
> > +	step_cnt = step_div;
> > +	sclk = hclk / (2 * sample_cnt * step_cnt);
> > +	if (sclk > khz) {
> Can this happen? A better name for "sclk" would be "bus_freq"?
Yes, if i2c->speed_hz is too small, not able to get target_speed using
hardware div. 

> 
> > +		dev_dbg(i2c->dev, "%s mode: unsupported speed (%ldkhz)\n",
> > +			(i2c->speed_hz > MAX_HS_MODE_SPEED) ? "HS" : "ST/FT",
> What is ST/FR? I would have expected FS here.
Please skip it.The debug message is too lousy.

> 
> > +			(long int)khz);
> > +		return -EINVAL;
> > +	}
> > +
> > +	step_cnt--;
> > +	sample_cnt--;
> > +
> > +	if (i2c->speed_hz > MAX_FS_MODE_SPEED) {
> > +		/* Set the hign speed mode register */
> > +		i2c->timing_reg = I2C_FS_TIME_INIT_VALUE;
> > +		i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
> > +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 12 |
> > +			(step_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8;
> > +	} else {
> > +		i2c->timing_reg =
> > +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8 |
> > +			(step_cnt & I2C_TIMING_STEP_DIV_MASK) << 0;
> > +		/* Disable the high speed transaction */
> > +		i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
> > +	}
> Would it be sensible to write these values directly into hardware here?
No.In some error cases, we want to reinitialize hardware, keep these
values to avoid calculate again.

Eddie
