From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 May 2015 10:57:16 +0200
Subject: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150520085715.GA17078@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

now that I understood the formula some more comments to the calculation.

On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> +#define I2C_DEFAUT_SPEED		100000	/* hz */
DEFAULT?

> +#define MAX_FS_MODE_SPEED		400000
> +#define MAX_HS_MODE_SPEED		3400000
> +#define MAX_SAMPLE_CNT_DIV		8
> +#define MAX_STEP_CNT_DIV		64
> +#define MAX_HS_STEP_CNT_DIV		8
> [...]
> +/* calculate i2c port speed */
> +static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int clk_src_in_hz)
> +{
add a comment here, that clk_src_in_hz is the parent clock already
divided by clock-div.

> +	unsigned int khz;
> +	unsigned int step_cnt;
> +	unsigned int sample_cnt;
> +	unsigned int sclk;
> +	unsigned int hclk;
> +	unsigned int max_step_cnt;
> +	unsigned int sample_div = MAX_SAMPLE_CNT_DIV;
> +	unsigned int step_div;
> +	unsigned int min_div;
> +	unsigned int best_mul;
> +	unsigned int cnt_mul;
> +
> +	if (i2c->speed_hz > MAX_HS_MODE_SPEED)
> +		return -EINVAL;
According to the plan to tune for the highest possible rate <=
i2c->speed_hz, you should handle the case (i2c->speed_hz >
MAX_HS_MODE_SPEED) like i2c->speed_hz == MAX_HS_MODE_SPEED.
Well, you might want to prevent an overflow in the calculation below
however.

> +	else if (i2c->speed_hz > MAX_FS_MODE_SPEED)
> +		max_step_cnt = MAX_HS_STEP_CNT_DIV;
> +	else
> +		max_step_cnt = MAX_STEP_CNT_DIV;
So I assume this is the hardware limit on the step_cnt value. For
FS_MODE and below you have 6 bits and writing X corresponds to
step_cnt = X + 1. For HS_MODE there are only 3 bits. right?

> +	step_div = max_step_cnt;
> +	/* Find the best combination */
> +	khz = i2c->speed_hz / 1000;
> +	hclk = clk_src_in_hz / 1000;
Why are you dividing here? There shouldn't be an overflow problem and
you're loosing precision.

> +	min_div = ((hclk >> 1) + khz - 1) / khz;
The shift accounts for the fixed divider 2 in

	i2c_bus_freq = parent_clk / (clock-div * 2 * sample_cnt * step_cnt

? Maybe better call this opt_div instead of min_div? So now we're
searching for the best pair (sample_cnt, step_cnt) with:

	* 0 < sample_cnt < MAX_SAMPLE_CNT_DIV
	* 0 < step_cnt < max_step_cnt
	* sample_cnt * step_cnt >= min_div
	* optimizing for sample_cnt * step_cnt being minimal

Right?

> +	best_mul = MAX_SAMPLE_CNT_DIV * max_step_cnt;
> +
> +	for (sample_cnt = 1; sample_cnt <= MAX_SAMPLE_CNT_DIV; sample_cnt++) {
> +		step_cnt = (min_div + sample_cnt - 1) / sample_cnt;
DIV_ROUND_UP

> +		cnt_mul = step_cnt * sample_cnt;
> +		if (step_cnt > max_step_cnt)
> +			continue;
I think it can happen that you have step_cnt > max_step_cnt here, but
that (sample_cnt, max_step_cnt) still is a good pair to consider. So:

	step_cnt = DIV_ROUND_UP(min_div, sample_cnt);
	if (step_cnt > max_step_cnt)
		step_cnt = max_step_cnt;

	cnt_mul = step_cnt * sample_cnt;

> +
> +		if (cnt_mul < best_mul) {
> +			best_mul = cnt_mul;
> +			sample_div = sample_cnt;
> +			step_div = step_cnt;
I'd call these best_sample_cnt and best_step_cnt instead of sample_div
and step_div.

> +			if (best_mul == min_div)
> +				break;
> +		}
> +	}
> +
> +	sample_cnt = sample_div;
> +	step_cnt = step_div;
> +	sclk = hclk / (2 * sample_cnt * step_cnt);
> +	if (sclk > khz) {
Can this happen? A better name for "sclk" would be "bus_freq"?

> +		dev_dbg(i2c->dev, "%s mode: unsupported speed (%ldkhz)\n",
> +			(i2c->speed_hz > MAX_HS_MODE_SPEED) ? "HS" : "ST/FT",
What is ST/FR? I would have expected FS here.

> +			(long int)khz);
> +		return -EINVAL;
> +	}
> +
> +	step_cnt--;
> +	sample_cnt--;
> +
> +	if (i2c->speed_hz > MAX_FS_MODE_SPEED) {
> +		/* Set the hign speed mode register */
> +		i2c->timing_reg = I2C_FS_TIME_INIT_VALUE;
> +		i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
> +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 12 |
> +			(step_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8;
> +	} else {
> +		i2c->timing_reg =
> +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8 |
> +			(step_cnt & I2C_TIMING_STEP_DIV_MASK) << 0;
> +		/* Disable the high speed transaction */
> +		i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
> +	}
Would it be sensible to write these values directly into hardware here?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
