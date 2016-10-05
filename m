From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed, 05 Oct 2016 10:40:16 -0400
Subject: [PATCH] clk: lpc32xx: fix pwm clock divider computation
In-Reply-To: <78c1e683-ac17-437b-289f-113ea842f62b@mleia.com>
References: <1474915467-11101-1-git-send-email-slemieux.tyco@gmail.com>
 <78c1e683-ac17-437b-289f-113ea842f62b@mleia.com>
Message-ID: <1475678416.23405.32.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-10-05 at 05:38 +0300, Vladimir Zapolskiy wrote:
> Hi Sylvain,
> 
> On 26.09.2016 21:44, Sylvain Lemieux wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> > 
> > A zero value in the PWM clock divider register
> > (PWM1_FREQ/PWM2_FREQ) turn off the PWM clock.
> > 
> > The "CLK_DIVIDER_ALLOW_ZERO" option is used for hardware that handle
> > the zero divider by not modifying their clock input (i.e. bypass).
> > See "/include/linux/clk-provider.h" for details.
> 
> the problem is that the divider value is not set to some non-zero
> value when the clock is enabled, right?
> 
The "clk_divider_set_rate" function is working properly and 
setup the divider properly. There is no need to perform any
special process when enabling or initializing the PWM clock.

The problem occur when the PWM is enable in the project specific
device tree and the PWM output clock is not explicitly setup.

With the actual implementation, the function that compute the 
output rate, based on the actual divider, return the parent clock
rate, which is inaccurate, since the clock is off. The core driver
will than call the enable function, which should not take place.

This patch ensure that the compute output rate for the PWM clock
handle properly the special case for a 0 divider. By returning 0,
the core driver do not try to enable the clock, which is the
expected behavior.

I still think the current patch is the proper way to fix the
issue created by the "CLK_DIVIDER_ALLOW_ZERO" flag of the PWM clock.

> I think it does not matter if the clock rate value is set to parent
> clock rate or any other value when divider is 0 *and* clock is gated.
> Enabling or disabling a clock is a gate control, so I suggest two
> alternative options at your choice (my preference is option 2):
> 
> 1) add a custom clk_pwm_gate_enable(), clk_pwm_gate_disable() and
> clk_pwm_gate_is_enabled() functions combined under lpc32xx_clk_pwm_gate_ops.
> 
> Next instead of adding one more define for a single exception
> please reassign .ops for two PWM clocks in runtime in
> lpc32xx_clk_init() function before calling lpc32xx_clk_register()
> in a loop.
> 
> But this option is too invasive, a simpler solution is below.
> 
> 2) in lpc32xx_clk_init() before clock registrations check for zero
> dividers of PWM clocks, then if a divider is 0 and clock is gated
> set divider to 1, if the divider is 0 and clock is not gated then
> gate the clock and set divider to 1, in other cases do nothing.
> 
> > Remove the CLK_DIVIDER_ALLOW_ZERO option and add support to handle
> > the clock rate computation of the PWM clock divider 0 value.
> > 
> > Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> > ---
> > Note:
> > * Should we include a new CLK_DIVIDER option for this case
> >   (i.e. clock off when zero ) in "clk-provider.h"?
> > 
> >  drivers/clk/nxp/clk-lpc32xx.c | 52 +++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 48 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
> > index 34c9735..3ca3a14 100644
> > --- a/drivers/clk/nxp/clk-lpc32xx.c
> > +++ b/drivers/clk/nxp/clk-lpc32xx.c
> > @@ -959,6 +959,25 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
> >  				   divider->flags);
> >  }
> >  
> > +static unsigned long clk_divider_pwm_recalc_rate(struct clk_hw *hw,
> > +		unsigned long parent_rate)
> > +{
> > +	struct lpc32xx_clk_div *divider = to_lpc32xx_div(hw);
> > +	unsigned int val;
> > +
> > +	regmap_read(clk_regmap, divider->reg, &val);
> > +
> > +	val >>= divider->shift;
> > +	val &= div_mask(divider->width);
> > +
> > +	/* Handle 0 divider -> PWM clock is off. */
> > +	if(val == 0)
> 
> No space in front of the open parenthesis.
> 
> > +		return 0;
> > +
> > +	return divider_recalc_rate(hw, parent_rate, val, divider->table,
> > +				   divider->flags);
> > +}
> > +
> >  static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> >  				unsigned long *prate)
> >  {
> > @@ -999,6 +1018,12 @@ static const struct clk_ops lpc32xx_clk_divider_ops = {
> >  	.set_rate = clk_divider_set_rate,
> >  };
> >  
> > +static const struct clk_ops lpc32xx_clk_pwm_divider_ops = {
> > +	.recalc_rate = clk_divider_pwm_recalc_rate,
> > +	.round_rate = clk_divider_round_rate,
> > +	.set_rate = clk_divider_set_rate,
> > +};
> > +
> >  static u8 clk_mux_get_parent(struct clk_hw *hw)
> >  {
> >  	struct lpc32xx_clk_mux *mux = to_lpc32xx_mux(hw);
> > @@ -1151,6 +1176,25 @@ struct clk_hw_proto {
> >  	},								\
> >  }
> >  
> > +#define LPC32XX_DEFINE_PWM_DIV(_idx, _reg, _shift, _width, _tab, _fl)	\
> > +[CLK_PREFIX(_idx)] = {							\
> > +	.type = CLK_DIV,						\
> > +	{								\
> > +		.hw0 = {						\
> > +			.ops = &lpc32xx_clk_pwm_divider_ops,		\
> > +			{						\
> > +				.div = {				\
> > +					.reg = LPC32XX_CLKPWR_ ## _reg,	\
> > +					.shift = (_shift),		\
> > +					.width = (_width),		\
> > +					.table = (_tab),		\
> > +					.flags = (_fl),			\
> > +				 },					\
> > +			},						\
> > +		 },							\
> > +	},								\
> > +}
> > +
> >  #define LPC32XX_DEFINE_GATE(_idx, _reg, _bit, _flags)			\
> >  [CLK_PREFIX(_idx)] = {							\
> >  	.type = CLK_GATE,						\
> > @@ -1281,14 +1325,14 @@ static struct clk_hw_proto clk_hw_proto[LPC32XX_CLK_HW_MAX] = {
> >  	LPC32XX_DEFINE_GATE(MCPWM, TIMCLK_CTRL1, 6, 0),
> >  
> >  	LPC32XX_DEFINE_MUX(PWM1_MUX, PWMCLK_CTRL, 1, 0x1, NULL, 0),
> > -	LPC32XX_DEFINE_DIV(PWM1_DIV, PWMCLK_CTRL, 4, 4, NULL,
> > -			   CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO),
> > +	LPC32XX_DEFINE_PWM_DIV(PWM1_DIV, PWMCLK_CTRL, 4, 4, NULL,
> > +			       CLK_DIVIDER_ONE_BASED),
> >  	LPC32XX_DEFINE_GATE(PWM1_GATE, PWMCLK_CTRL, 0, 0),
> >  	LPC32XX_DEFINE_COMPOSITE(PWM1, PWM1_MUX, PWM1_DIV, PWM1_GATE),
> >  
> >  	LPC32XX_DEFINE_MUX(PWM2_MUX, PWMCLK_CTRL, 3, 0x1, NULL, 0),
> > -	LPC32XX_DEFINE_DIV(PWM2_DIV, PWMCLK_CTRL, 8, 4, NULL,
> > -			   CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO),
> > +	LPC32XX_DEFINE_PWM_DIV(PWM2_DIV, PWMCLK_CTRL, 8, 4, NULL,
> > +			       CLK_DIVIDER_ONE_BASED),
> >  	LPC32XX_DEFINE_GATE(PWM2_GATE, PWMCLK_CTRL, 2, 0),
> >  	LPC32XX_DEFINE_COMPOSITE(PWM2, PWM2_MUX, PWM2_DIV, PWM2_GATE),
> >  
> > 
> 
> --
> With best wishes,
> Vladimir

Regards,
Sylvain
