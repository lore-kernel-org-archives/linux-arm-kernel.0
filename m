From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 25 Sep 2015 11:15:24 +0200
Subject: [PATCH v6 1/5] pwm: add the Berlin pwm controller driver
In-Reply-To: <20150921084008.GE19865@ulmo.nvidia.com>
References: <1442484788-15482-1-git-send-email-antoine.tenart@free-electrons.com>
 <1442484788-15482-2-git-send-email-antoine.tenart@free-electrons.com>
 <20150921084008.GE19865@ulmo.nvidia.com>
Message-ID: <20150925091524.GB19573@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 10:40:08AM +0200, Thierry Reding wrote:
> On Thu, Sep 17, 2015 at 12:13:04PM +0200, Antoine Tenart wrote:
> > +
> > +#define BERLIN_PWM_EN			0x0
> > +#define BERLIN_PWM_CONTROL		0x4
> > +#define BERLIN_PWM_DUTY			0x8
> > +#define BERLIN_PWM_TCNT			0xc
> > +
> > +#define BERLIN_PWM_ENABLE		BIT(0)
> > +#define BERLIN_PWM_INVERT_POLARITY	BIT(3)
> > +#define BERLIN_PWM_PRESCALE_MASK	0x7
> > +#define BERLIN_PWM_PRESCALE_MAX		4096
> > +#define BERLIN_PWM_MAX_TCNT		65535
> 
> It'd be nice to see some sort of connection between the register
> definitions and which fields belong to them.

Something like:

#define BERLIN_PWM_EN		0x0
#define  BERLIN_PWM_ENABLE	BIT(0)
#define BERLIN_PWM_CONTROL	0x4
...

> > +struct berlin_pwm_chip {
> > +	struct pwm_chip chip;
> > +	struct clk *clk;
> > +	void __iomem *base;
> > +	spinlock_t lock;
> 
> I don't think that lock is necessary here. You have per-channel
> registers and each channel can only be used by one consumer at a time
> anyway.

Sure. I'll make some tests and remove the lock if possible.

> > +#define to_berlin_pwm_chip(chip)	\
> > +	container_of((chip), struct berlin_pwm_chip, chip)
> > +
> > +#define berlin_pwm_readl(chip, channel, offset)		\
> > +	readl_relaxed((chip)->base + (channel) * 0x10 + offset)
> > +#define berlin_pwm_writel(val, chip, channel, offset)	\
> > +	writel_relaxed(val, (chip)->base + (channel) * 0x10 + offset)
> 
> These should be static inline functions. Also I think for
> berlin_pwm_writel() val should come after chip and channel to preserve a
> more natural ordering of parameters.

What's the benefit of using static inline functions here?

I'm not convinced having val after chip and channel is more natural, but
this is not a big matter. I'll update.

> > +
> > +/* prescaler table: {1, 4, 8, 16, 64, 256, 1024, 4096} */
> > +static const u32 prescaler_diff_table[] = {
> > +	1, 4, 2, 2, 4, 4, 4, 4,
> > +};
> 
> I don't see any relationship between these values and the prescaler
> table given in the comment. Please expand the comment to explain the
> connection.
> 
> After reading the remainder of the code, I see that the values in this
> table are the multiplication factors for each of the prescalers. It
> shouldn't be necessary to read the code to find out, so please clarify
> in the comment (and perhaps rename the table to something more related
> to its purpose, such as prescale_factors).

Will do.

> Perhaps an even more easily digestible alternative would be to make this
> a list of prescaler values and then use the values directly to compute
> the number of cycles rather than iteratively dividing and needing this
> unintuitive mapping.

Would something like the following be better?

"""
static const prescaler_table = {1, 4, 8, 16, 64, 256, 1024, 4096};
unsigned int prescale;
u64 tmp;

for (prescale = 0; prescale < ARRAY_SIZE(prescaler_table); prescale++) {
	tmp = cycles;
	do_div(tmp, prescaler_table[prescale]);

	if (tmp <= BERLIN_PWM_MAX_TCNT)
		break;
}

if (tmp > BERLIN_PWM_MAX_TCNT)
	return -ERANGE;

cycles = tmp;
"""

I personally prefer the prescale factors implementation, but I admit
this is maybe more readable.

> > +
> > +	while (cycles > BERLIN_PWM_MAX_TCNT)
> > +		do_div(cycles, prescaler_diff_table[++prescale]);
> 
> Don't you need to make sure that prescale doesn't exceed the table size?

Sure.

> > +
> > +	ret = pwmchip_add(&pwm->chip);
> > +	if (ret < 0) {
> > +		clk_disable_unprepare(pwm->clk);
> 
> Why not enable the clock until after successful registration? It doesn't
> seem like you need access before that. Doing so would introduce a subtle
> race condition between adding the chip (and hence exposing it via sysfs)
> and enabling the clock, so perhaps an even better approach would be to
> add more fine-grained clock management by enabling or disabling it only
> when necessary (clock enables are reference counted, so ->request() and
> ->free() would probably work fine in this case).
> 
> This isn't a real objection, though. If you prefer to keep things simple
> the current code is fine with me.

That was the idea. We may update this latter.

> > +static int berlin_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct berlin_pwm_chip *pwm = platform_get_drvdata(pdev);
> > +	int ret;
> > +
> > +	ret = pwmchip_remove(&pwm->chip);
> > +	if (ret)
> > +		return ret;
> > +
> > +	clk_disable_unprepare(pwm->clk);
> 
> You might want to disable the clock regardless. The driver will be
> unloaded regardless of whether pwmchip_remove() returns failure or
> not. The above would leak a clock enable, which may not be what you
> want.

Yes, I'll call clk_disable_unprepare() regardless of what pwmchip_remove()
returns.

Thanks for the review!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
