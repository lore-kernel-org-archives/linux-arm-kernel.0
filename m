From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 11 Oct 2016 11:42:33 -0400
Subject: [PATCH] clk: lpc32xx: fix pwm clock divider computation
In-Reply-To: <28a243a6-9c66-228b-f9b0-2f0e659b5cdd@mleia.com>
References: <1474915467-11101-1-git-send-email-slemieux.tyco@gmail.com>
 <78c1e683-ac17-437b-289f-113ea842f62b@mleia.com>
 <1475678416.23405.32.camel@localhost>
 <28a243a6-9c66-228b-f9b0-2f0e659b5cdd@mleia.com>
Message-ID: <1476200553.7075.11.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Fri, 2016-10-07 at 03:56 +0300, Vladimir Zapolskiy wrote:
> Hi Sylvain,
> 
> On 05.10.2016 17:40, Sylvain Lemieux wrote:
> > On Wed, 2016-10-05 at 05:38 +0300, Vladimir Zapolskiy wrote:
> >> Hi Sylvain,
> >>
> >> On 26.09.2016 21:44, Sylvain Lemieux wrote:
> >>> From: Sylvain Lemieux <slemieux@tycoint.com>
> >>>
> >>> A zero value in the PWM clock divider register
> >>> (PWM1_FREQ/PWM2_FREQ) turn off the PWM clock.
> >>>
> >>> The "CLK_DIVIDER_ALLOW_ZERO" option is used for hardware that handle
> >>> the zero divider by not modifying their clock input (i.e. bypass).
> >>> See "/include/linux/clk-provider.h" for details.
> >>
> >> the problem is that the divider value is not set to some non-zero
> >> value when the clock is enabled, right?
> >>
> > The "clk_divider_set_rate" function is working properly and 
> > setup the divider properly. There is no need to perform any
> > special process when enabling or initializing the PWM clock.
> > 
> > The problem occur when the PWM is enable in the project specific
> > device tree and the PWM output clock is not explicitly setup.
> > 
> > With the actual implementation, the function that compute the 
> > output rate, based on the actual divider, return the parent clock
> > rate, which is inaccurate, since the clock is off. The core driver
> > will than call the enable function, which should not take place.
> 
> this is a reword of my statement above, I'll repeat it for clarity
> removing double negation, when PWMx_FREQ bits in PWMCLK_CTRL register
> are all zeros gate on/off works incorrectly.
> 
> > This patch ensure that the compute output rate for the PWM clock
> > handle properly the special case for a 0 divider. By returning 0,
> > the core driver do not try to enable the clock, which is the
> > expected behavior.
> 
> While I admit the problem, the patch is incorrect, it fakes a gated
> off clock by assigning zero frequency rate to it. In terms of CCF
> the problem is not related to the divider and it shall not be fixed
> by introducing a new divider operation, because it is an issue with
> the clock on/off setting correctness.
> 
> > I still think the current patch is the proper way to fix the
> > issue created by the "CLK_DIVIDER_ALLOW_ZERO" flag of the PWM clock.
> 
> Dealing with a complex clock it makes sense to decompose it into
> a divider clock and a gate clock in terms of CCF. The PWM clock
> under discussion does not fit into the common model, it has two
> independent gate controls, and half of the controls is placed
> into the clock divider bitfield.
> 
> CLK_DIVIDER_ALLOW_ZERO is used incorrectly here, like you stated
> in the commit message divider's zero value means the same as
> non-divided clock, and here it should mean a gated clock.
> By the way you may notice that a divider from MS_CTRL is similar.
> 
> Theoretically it might be possible to introduce a CCF-wide flag
> to describe zero value as a gated off clock, but I hesitate to
> do it until I find a ground that the flag is going to be utilized
> by other clock drivers.
> 
> Below I proposed two options how to resolve the problem, one is
> to update clock gate ops, another one is to make zero value never
> happen.
> 
> I tend to the second option, because it is simpler and direct,
> I'll implement it and send a change for your testing.

Thanks for the clarification;

The proper approach is to remove the second independent gate
control from the divider.

This patch is not needed; the following patch resolve this issue:
http://www.spinics.net/lists/arm-kernel/msg535313.html

> 
> >> I think it does not matter if the clock rate value is set to parent
> >> clock rate or any other value when divider is 0 *and* clock is gated.
> >> Enabling or disabling a clock is a gate control, so I suggest two
> >> alternative options at your choice (my preference is option 2):
> >>
> >> 1) add a custom clk_pwm_gate_enable(), clk_pwm_gate_disable() and
> >> clk_pwm_gate_is_enabled() functions combined under lpc32xx_clk_pwm_gate_ops.
> >>
> >> Next instead of adding one more define for a single exception
> >> please reassign .ops for two PWM clocks in runtime in
> >> lpc32xx_clk_init() function before calling lpc32xx_clk_register()
> >> in a loop.
> >>
> >> But this option is too invasive, a simpler solution is below.
> >>
> >> 2) in lpc32xx_clk_init() before clock registrations check for zero
> >> dividers of PWM clocks, then if a divider is 0 and clock is gated
> >> set divider to 1, if the divider is 0 and clock is not gated then
> >> gate the clock and set divider to 1, in other cases do nothing.
> >>
> >>> Remove the CLK_DIVIDER_ALLOW_ZERO option and add support to handle
> >>> the clock rate computation of the PWM clock divider 0 value.
> >>>
> >>> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> >>> ---
[...]
> 
> --
> With best wishes,
> Vladimir

Sylvain
