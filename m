From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 14:00:49 +0100
Subject: [RFC] add pwmlib support
In-Reply-To: <4D46AFAB.3070805@metafoo.de>
References: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
	<4D447E5E.6060007@metafoo.de>
	<F45880696056844FA6A73F415B568C6953739F1986@EXDCVYMBSTM006.EQ1STM.local>
	<20110131075408.GH9041@pengutronix.de>
	<4D46AFAB.3070805@metafoo.de>
Message-ID: <20110131130049.GM9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 01:48:43PM +0100, Lars-Peter Clausen wrote:
> On 01/31/2011 08:54 AM, Sascha Hauer wrote:
> > On Mon, Jan 31, 2011 at 04:35:33AM +0100, Arun MURTHY wrote:
> >> Hi Sascha,
> >>
> >>>> I Cced the people working with PWMs in the kernel in the hope that
> >>> they can
> >>>> give input on what's missing / wrong in this implementation
> >>>>
> >>>> Sascha
> >>>>
> >>>
> >>> Hi
> >>>
> >>> There have been two other proposals for a generic PWM api during the
> >>> last year.
> >>> You might want to take a look at them.
> >>>
> >>> https://lkml.org/lkml/2010/2/9/275
> >>> https://lkml.org/lkml/2010/9/28/107
> >>>
> >>> I've added Bill Gatliff and Arun Murthy to Cc.
> >>>
> >>
> >> As said by Lars, we already have developed the pwm core driver and
> >> progressing towards aligning the existing pwm drivers to the pwm core
> >> driver.
> >> These set of patches are expected to be out in LKML by this week.
> > 
> > Nice, problem solved without me having to work on it ;).
> 
> I wouldn't call it problem solved yet.
> I liked your approach better so far, but lets see how the next iteration of Aruns
> patches turn out.

What I don't like about Bills patches is the way PWMs are configured.

Bill, since you are on Cc, maybe you can comment on this:

> +enum {
> +	PWM_CONFIG_DUTY_TICKS = BIT(0),
> +	PWM_CONFIG_PERIOD_TICKS = BIT(1),
> +	PWM_CONFIG_POLARITY = BIT(2),
> +	PWM_CONFIG_START = BIT(3),
> +	PWM_CONFIG_STOP = BIT(4),
> +
> +	PWM_CONFIG_HANDLER = BIT(5),
> +
> +	PWM_CONFIG_DUTY_NS = BIT(6),
> +	PWM_CONFIG_DUTY_PERCENT = BIT(7),
> +	PWM_CONFIG_PERIOD_NS = BIT(8),
> +};
> +
>
> ...
>
> +
> +struct pwm_channel_config {
> +	int config_mask;
> +	unsigned long duty_ticks;
> +	unsigned long period_ticks;
> +	int polarity;
> +
> +	pwm_handler_t handler;
> +
> +	unsigned long duty_ns;
> +	unsigned long period_ns;
> +	int duty_percent;
> +};
> 
> ...
> 
> +int pwm_config(struct pwm_channel *pwm,
> +	       struct pwm_channel_config *c);

I think we should have a single internal interpretation of how a pwm is
configured, either ticks or ns (or whatever else), but not ticks, ns and
percent. Instead we could provide helpers to convert between them.
Also, I don't like ioctl like function calls. Instead of dispatching
PWM_CONFIG_* we should use discrete functions for each functionality.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
