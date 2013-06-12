From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Thu, 13 Jun 2013 00:22:29 +0200
Subject: [PATCH 1/2] pinctrl: add function to parse generic pinconfig
 properties from a dt node
In-Reply-To: <51B88BD0.805@imgtec.com>
References: <201306102139.32444.heiko@sntech.de>
 <201306102140.29918.heiko@sntech.de> <51B88BD0.805@imgtec.com>
Message-ID: <201306130022.29341.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Am Mittwoch, 12. Juni 2013, 16:55:12 schrieb James Hogan:
> Hi Heiko,
> 
> On 10/06/13 20:40, Heiko St?bner wrote:
> > pinconf_generic_parse_dt_config() takes a node as input and generates an
> > array of generic pinconfig values from the properties of this node.
> > 
> > As I couldn't find a mechanism to count the number of properties of a
> > node the function uses internally an array to accept one of parameter
> > and copies the real present options to a smaller variable at its end.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> <snip>
> 
> > @@ -139,3 +140,83 @@ void pinconf_generic_dump_config(struct pinctrl_dev
> > *pctldev,
> > 
> >  }
> >  EXPORT_SYMBOL_GPL(pinconf_generic_dump_config);
> >  #endif
> > 
> > +
> > +#ifdef CONFIG_OF
> > +struct pinconf_generic_dt_params {
> > +	const char * const property;
> > +	enum pin_config_param param;
> > +	u32 default_value;
> > +};
> > +
> > +static struct pinconf_generic_dt_params dt_params[] = {
> > +	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
> > +	{ "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
> > +	{ "bias-bus-hold", PIN_CONFIG_BIAS_BUS_HOLD, 0 },
> > +	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 0 },
> > +	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 0 },
> > +	{ "bias-pull-pin-default", PIN_CONFIG_BIAS_PULL_PIN_DEFAULT, 0 },
> > +	{ "drive-push-pull", PIN_CONFIG_DRIVE_PUSH_PULL, 0 },
> > +	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
> > +	{ "drive-open-source", PIN_CONFIG_DRIVE_OPEN_SOURCE, 0 },
> > +	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 0 },
> > +	{ "input-schmitt-enable", PIN_CONFIG_INPUT_SCHMITT_ENABLE, 1 },
> > +	{ "input-schmitt-disable", PIN_CONFIG_INPUT_SCHMITT_ENABLE, 0 },
> > +	{ "input-schmitt", PIN_CONFIG_INPUT_SCHMITT, 0 },
> > +	{ "input-debounce", PIN_CONFIG_INPUT_DEBOUNCE, 0 },
> > +	{ "power-source", PIN_CONFIG_POWER_SOURCE, 0 },
> > +	{ "slew-rate", PIN_CONFIG_SLEW_RATE, 0 },
> > +	{ "low-power-mode", PIN_CONFIG_LOW_POWER_MODE, 0 },
> > +	{ "output-low", PIN_CONFIG_OUTPUT, 0, },
> > +	{ "output-high", PIN_CONFIG_OUTPUT, 1, },
> 
> shouldn't half of these default to 1 instead of 0? i.e. it's much nicer
> for the lone flag "bias-pull-up" to enable pull up rather than disable
> it (you even do this in the DT example in the bindings doc).

on closer inspection it seems that you may be right. The documentation to the 
options in the pinconf-generic header even tells that for example the pull 
options do have a 0 or 1 argument.

I guess I got much inspiration from sh-pfc/pinctrl.c when learning about the 
generic pinconf, which ignores any argument for these options, which I then 
have mimiced in my rockchip driver and here.


But I'm not sure if I understand everything correctly :-) ... isn't the bias-
disable the opposite of turning on a pull (like the sh-pfc/pinctrl does) and 
same with switching from one pull type to another, i.e. activating a pull up 
would turn off a pull down and on the whole making the argument redundant?


The only other candidate I could find was low-power-mode which really could 
use a "1" as default. All the other pinconf options either use custom 
arguments or ignore teir argument.


> Otherwise the patch looks good to me (though I haven't tried it yet).

nice


Heiko
