From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Nov 2013 23:37:19 +0100
Subject: [PATCHv6 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20131128212510.GC14689@mithrandir>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com>
 <20131128212510.GC14689@mithrandir>
Message-ID: <20131128223719.GG14689@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 10:25:11PM +0100, Thierry Reding wrote:
> On Tue, Nov 12, 2013 at 09:36:55AM +0800, Xiubo Li wrote:
[...]
> > +static int fsl_pwm_parse_clk_ps(struct fsl_pwm_chip *fpc)
> > +{
> > +	int ret;
> > +	struct of_phandle_args clkspec;
> > +	struct device_node *np = fpc->chip.dev->of_node;
> > +
> > +	fpc->sys_clk = devm_clk_get(fpc->chip.dev, "ftm0");
> > +	if (IS_ERR(fpc->sys_clk)) {
> > +		ret = PTR_ERR(fpc->sys_clk);
> > +		dev_err(fpc->chip.dev,
> > +				"failed to get \"ftm0\" clock %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	fpc->counter_clk = devm_clk_get(fpc->chip.dev, "ftm0_counter");
> > +	if (IS_ERR(fpc->counter_clk)) {
> > +		ret = PTR_ERR(fpc->counter_clk);
> > +		dev_err(fpc->chip.dev,
> > +				"failed to get \"ftm0_counter\" clock %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = of_parse_phandle_with_args(np, "clocks", "#clock-cells", 1,
> > +					&clkspec);
> > +	if (ret)
> > +		return ret;
> > +
> > +	fpc->counter_clk_select = clkspec.args[0];
> 
> This isn't at all pretty. But given that once you have access to a
> struct clk there's no way to identify it, I don't know of a better
> alternative.

Hi Mike,

I've seen this crop up a number of times now, to varying degrees of
gravity. In this particular case, the driver needs to know the type of a
clock because it needs to program this hardware differently depending on
which clock feeds the counter. Since there is no way to obtain any kind
of identifying information from a struct clk, drivers need to rely on
hacks like this and manually reach into the device tree to obtain that
information.

I'm aware of similar cases which have been solved by using a mux clock
that takes a set of parents and the .set_parent() operation is then used
to program registers appropriately. However in all those cases, the mux
clock (and the parents) have all been part of a single driver, so I am
not sure if the same would be applicable here.

Do you have any other suggestions on how this could possibly be solved?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/e25606d9/attachment.sig>
