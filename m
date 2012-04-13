From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Apr 2012 11:30:15 +0100
Subject: [PATCH] clk: Allocate and add clock lookups from clk_register()
In-Reply-To: <4F87FBA4.7000700@st.com>
References: <9fa570d09d94cdc4892b4e413ef3a0edc6f9dcef.1334298848.git.viresh.kumar@st.com>
 <20120413100133.GI3852@pengutronix.de> <4F87FBA4.7000700@st.com>
Message-ID: <20120413103015.GK24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 03:40:44PM +0530, Viresh Kumar wrote:
> On 4/13/2012 3:31 PM, Sascha Hauer wrote:
> >> > Pointer to original discussion:
> >> > http://www.spinics.net/lists/arm-kernel/msg169133.html
> > For reasons mentioned in this thread (long argument list, line wraps in
> > clk_register calls, only leaf nodes need lookups) I don't think this is
> > a good idea.
> 
> For that we can pass struct as argument.
> 
> >> >   */
> >> >  struct clk *clk_register(struct device *dev, const char *name,
> >> >  		const struct clk_ops *ops, struct clk_hw *hw,
> >> > -		const char **parent_names, u8 num_parents, unsigned long flags)
> >> > +		const char **parent_names, u8 num_parents, unsigned long flags,
> >> > +		struct clk_lookup **cl, const char *dev_id, const char *con_id)
> >> >  {
> > Also this doesn't handle the case when multiple lookups are associated
> > with a single clock (which is quite a common case on some SoCs). Yes,
> > we could still use the returned clk to register the additional lookups,
> > but that would make the advantage of this patch even smaller.
> 
> If there is a better way of managing this within the clock framework,
> without platforms having to do clkdev management, we can choose that.
> My main idea was to make platform code lighter.
> 
> We can do one more thing here to support multiple lookups for same clocks:
> We can pass array of struct having these three args as its fields.

You can do something else too:

int clk_register_clkdev(struct clk *clk, struct clk_lookup *cl, size_t num)
{
	unsigned i;

	if (!clk)
		return -ENOMEM;

	for (i = 0; i < num; i++, cl++) {
		cl->clk = clk;
		clkdev_add(cl);
	}
	return 0;
}

and:

int clk_register_single_clkdev(struct clk *clk, const char *devname, const char *conname)
{
	struct clk_lookup *cl;

	if (!clk)
		return -ENOMEM;

	cl = clkdev_alloc(clk, conname, "%s", devname);
	if (!cl)
		return -ENOMEM;
	clkdev_add(cl);
	return 0;
}

and do:

static struct clk_lookup clk_foo_lookups[] = {
	{
		.dev_name = foo,
		.con_name = bar,
	}, {
		...
	},
};

	clk = clk_register(dev, NULL, &ops, &hw, NULL, 0, 0);
	ret = clk_register_clkdev(clk, clk_foo_lookups, ARRAY_SIZE(clk_foo_lookups));
	if (ret)
		...

and:

	clk = clk_register(dev, NULL, &ops, &hw, NULL, 0, 0);
	ret = clk_register_simple_clkdev(clk, "devname", "conname");
	if (ret)
		...

which are both much easier to use than a function taking some 11
arguments, and doesn't require each and every clk_register*() function
to be modified to take the clkdev stuff.
