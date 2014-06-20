From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 21 Jun 2014 00:16:43 +0200
Subject: [PATCH 6/7] pwm: st: Add new driver for ST's PWM IP
In-Reply-To: <20140619084404.GA26560@lee--X1>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-6-git-send-email-lee.jones@linaro.org>
 <20140618231127.GF26514@mithrandir>
 <20140619084404.GA26560@lee--X1>
Message-ID: <20140620221642.GA29400@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 09:44:04AM +0100, Lee Jones wrote:
> I'll comment on some of the more fluffy topics, I'll let Ajit reply to
> the more technical details of the patch.
> 
> On Thu, 19 Jun 2014, Thierry Reding wrote:
> > On Wed, Jun 18, 2014 at 03:52:51PM +0100, Lee Jones wrote:
> > > This driver supports all current STi platforms' PWM IPs.
> > > 
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/pwm/Kconfig  |   9 ++
> > >  drivers/pwm/Makefile |   1 +
> > >  drivers/pwm/pwm-st.c | 378 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 388 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-st.c
> > > 
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index 4ad7b89..98a7bbc 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -292,4 +292,13 @@ config PWM_VT8500
> > >  	  To compile this driver as a module, choose M here: the module
> > >  	  will be called pwm-vt8500.
> > >  
> > > +config PWM_ST
> > 
> > PWM_ST is awfully generic, perhaps PWM_STI would be a better choice?
> > Even that's very generic. Maybe PWM_STI_H4XX? There's nothing wrong with
> > supporting STiH{5,6,7,...}xx SoCs with such a driver. I'm just trying to
> > think ahead what will happen if at some point a new SoC family is
> > released that requires a different driver.
> 
> I'm inclined to agree with you, but as it stands, this driver supports
> all ST h/w, so it's correct for it to be generic.  If some new IP
> comes into fuition, at worst we'll have to change the name of the
> driver.  I'm happy to put myself on the line for that if the time
> comes.

Renaming a driver isn't a trivial matter. People may be using the name
in blacklists or scripts and renaming will likely annoy them. Like I
said, there's nothing wrong with the driver name being less generic, we
have other ways to identify what hardware it will run on.

> > > diff --git a/drivers/pwm/pwm-st.c b/drivers/pwm/pwm-st.c
[...]
> > > +#define MAX_PWM_CNT_DEFAULT	255
> > > +#define MAX_PRESCALE_DEFAULT	0xff
> > > +#define NUM_CHAN_DEFAULT	1
> > 
> > These are only used in one place and their meaning is fairly obvious, so
> > I'd just drop them.
> 
> I _always_ prefer defines over magic numbers, but as you wish - will fix.

In general I agree, but there are cases where in my opinion the defines
obfuscate rather than help. This is one of those. These aren't really
magic numbers, since they are used in a context where their meaning is
crystal clear.

> > > +	PWM_EN,
> > > +	PWM_INT_EN,
> > > +	/* keep last */
> > > +	MAX_REGFIELDS
> > > +};
> > > +
> > > +struct st_pwm_chip {
> > > +	struct device *dev;
> > > +	struct clk *clk;
> > > +	unsigned long clk_rate;
> > > +	struct regmap *regmap;
> > > +	struct st_pwm_compat_data *cdata;
> > 
> > Doesn't this require a predeclaration of struct st_pwm_compat_data? Or
> > maybe just move struct st_pwm_compat_data before this.
> 
> You're right, will fix.
> 
> I think I would have expected at least a compiler warning about that?

Me too. Perhaps one of the includes has a forward declaration? I'd hope
not.

> > > +};
> > > +
> > > +struct st_pwm_compat_data {
> > > +	const struct reg_field *reg_fields;
> > > +	int num_chan;
> > > +	int max_pwm_cnt;
> > > +	int max_prescale;
> > 
> > Can't these three be unsigned?
> 
> I see no reason why not.  They can also be signed. :)

I prefer if variables use the strictest type possible.

> > > +static void st_pwm_calc_periods(struct st_pwm_chip *pc)
> > > +{
> > > +	struct st_pwm_compat_data *cdata = pc->cdata;
> > > +	struct device *dev = pc->dev;
> > > +	unsigned long val;
> > > +	int i;
> > 
> > unsigned?
> 
> Why?
> 
> It's much more common this way:
> 
> $ git grep $'\t'"int i;" | wc -l
> 17018
> $ git grep $'\t'"unsigned int i;" | wc -l
> 2033

That just means that not everybody is as pedantic as I am. The reason
why it should be unsigned int is that it's used in a loop and compared
to a value which should also be unsigned (cdata->max_prescale). There
just isn't a reasonable scenario where they would need to be negative.

> > > + * 16 possible period values are supported (for a particular clock rate).
> > > + * The requested period will be applied only if it matches one of these
> > > + * 16 values.
> > > + */
> > > +static int st_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +			 int duty_ns, int period_ns)
> > > +{
> > > +	struct st_pwm_chip *pc = to_st_pwmchip(chip);
> > > +	struct device *dev = pc->dev;
> > > +	struct st_pwm_compat_data *cdata = pc->cdata;
> > > +	unsigned int prescale, pwmvalx;
> > > +	unsigned long *found;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * Search for matching period value. The corresponding index is our
> > > +	 * prescale value
> > > +	 */
> > > +	found = bsearch(&period_ns, &pc->pwm_periods[0],
> > 
> > Technically doesn't period_ns need to be converted to an unsigned long
> > here? Otherwise this won't be compatible with 64-bit architectures.
> > Admittedly that's maybe not something relevant for this family of SoCs,
> > but you never know where this driver will be used eventually.
> 
> This driver depends on ARCH_STI which only supports 32bit.

That's true now. It may not be forever. Also there's always a chance
that somebody will look at your code for inspiration and will copy the
same non-portability.

> > > +	ret = regmap_write(pc->regmap, ST_PWMVAL(pwm->hwpwm), pwmvalx);
> > > +	if (ret)
> > > +		goto clk_dis;
> > > +
> > > +	ret = regmap_field_write(pc->pwm_int_en, 0);
> > 
> > This seems to be never set to any other value, so perhaps it should be
> > set at .probe() time?
> 
> Unfortunately not, as the clk needs to be enabled whilst setting IRQ
> state.  Moving it into .probe() would mean wrapping this command
> between clk_enable() and clk_disable(), which I think it a waste.

That's a one-time thing nevertheless. If you keep it here the register
will keep being written with the same value over and over again.

> > > +	.reg_bits   = 32,
> > > +	.val_bits   = 32,
> > > +	.reg_stride = 4,
> > > +};
> > 
> > Please drop the artificial padding. A single space on each side of '='
> > will do just fine.
> 
> /me likes straight lines!
> 
> ... but as you wish.

And at some point you need to add a field that exceeds the current
padding and then you'll have one line that stands out. Trust me, that's
a whole lot worse than making each of them use a single space around '='
consistently from the beginning.

Or you'd need to update the whole block at the same time, which is just
needless churn.

> > > +static int st_pwm_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct device_node *np = dev->of_node;
> > > +	struct st_pwm_compat_data *cdata;
> > > +	struct st_pwm_chip *pc;
> > > +	struct resource *res;
> > > +	int ret;
> > > +
> > > +	if (!np) {
> > > +		dev_err(dev, "failed to find device node\n");
> > > +		return -EINVAL;
> > > +	}
> > 
> > I have difficulty imagining how this condition would ever happen. Can
> > this check not simply be removed?
> 
> Although true, this check is very common.  I wonder if they can _all_
> be removed from OF only drivers?  Probably something worth bringing up
> with the DT guys.

Yes, it's completely unnecessary for OF-only drivers.

> > > +	 */
> > > +	cdata->reg_fields   = &st_pwm_regfields[0];
> > 
> > Why not simply "= st_pwm_regfields;"?
> 
> Although semantically the same, I think what we're trying to achieve
> is more obvious at first glance in the current format.
> 
> But will fix if you are insistent.

Yes, please.

> Look at those lovely straight lines.  Are you sure you want me to
> unalign the regmap_config above?

	cdata->max_pwm_cnt  = MAX_PWM_CNT_DEFAULT;
	cdata->max_prescale = MAX_PRESCALE_DEFAULT;
	cdata->num_chan     = NUM_CHAN_DEFAULT;
	cdata->some_other_param = SOME_OTHER_PARAM_DEFAULT;

Not very pretty, is it?

> > > +	if (IS_ERR(pc->clk)) {
> > > +		dev_err(dev, "failed to get pwm clock\n");
> > > +		return PTR_ERR(pc->clk);
> > > +	}
> > > +
> > > +	pc->clk_rate = clk_get_rate(pc->clk);
> > > +	if (!pc->clk_rate) {
> > > +		dev_err(dev, "failed to get clk rate\n");
> > 
> > "... clock rate\n"
> 
> clk is a well known synonym for clock in Linux and can be found
> throughout many bootlogs, but again, happy to change if it's causing
> issues.

Yes, please.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140621/5e77abb1/attachment-0001.sig>
