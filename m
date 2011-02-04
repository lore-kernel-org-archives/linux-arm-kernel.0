From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Feb 2011 11:18:41 +0000
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <AANLkTi=sfBTHLXejWxAWGa=Tcw+LoQfw6sUtcn6L+JeM@mail.gmail.com>
References: <20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<4D48741F.8060006@codeaurora.org>
	<20110201212409.GU31216@n2100.arm.linux.org.uk>
	<20110204095424.GB2347@richard-laptop>
	<20110204104832.GE14627@n2100.arm.linux.org.uk>
	<AANLkTi=sfBTHLXejWxAWGa=Tcw+LoQfw6sUtcn6L+JeM@mail.gmail.com>
Message-ID: <20110204111841.GG14627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 04, 2011 at 08:04:03PM +0900, Jassi Brar wrote:
> On Fri, Feb 4, 2011 at 7:48 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > int clk_enable(struct clk *clk)
> > {
> > ? ? ? ?unsigned long flags;
> > ? ? ? ?int ret = 0;
> >
> > ? ? ? ?if (clk) {
> > ? ? ? ? ? ? ? ?if (WARN_ON(!clk->prepare_count))
> > ? ? ? ? ? ? ? ? ? ? ? ?return -EINVAL;
> >
> > ? ? ? ? ? ? ? ?spin_lock_irqsave(&clk->lock, flags);
> > ? ? ? ? ? ? ? ?if (clk->enable_count++ == 0)
> > ? ? ? ? ? ? ? ? ? ? ? ?ret = clk->ops->enable(clk);
> > ? ? ? ? ? ? ? ?spin_unlock_irqrestore(&clk->lock, flags);
> > ? ? ? ?}
> > ? ? ? ?return ret;
> > }
> >
> > is entirely sufficient to catch the case of a single-use clock not being
> > prepared before clk_enable() is called.
> >
> > We're after detecting drivers missing calls to clk_prepare(), we're not
> > after detecting concurrent calls to clk_prepare()/clk_unprepare().
> 
> I hope you mean 'making sure the clock is prepared before it's enabled
> ' rather than
> 'catching a driver that doesn't do clk_prepare before clk_enable'.
> Because, the above implementation still doesn't catch a driver that
> doesn't call clk_prepare
> but simply uses a clock that happens to have been already prepare'd by
> some other
> driver or the platform.

No, I mean what I said.

The only way to do what you're asking is to attach a list of identifiers
which have prepared a clock to the struct clk, where each identifier is
unique to each driver instance.

So what that becomes is:

struct prepared_instance {
	struct list_head node;
	void *driver_id;
};

int clk_prepare(struct clk *clk, void *driver_id)
{
	struct prepared_instance *inst;
	int ret = 0;

	if (clk) {
		inst = kmalloc(sizeof(*inst), GFP_KERNEL);
		if (!inst)
			return -ENOMEM;

		inst->driver_id = driver_id;

		mutex_lock(&clk->mutex);
		if (clk->prepare_count++ == 0)
			ret = clk->ops->prepare(clk);

		if (ret == 0) {
			spin_lock_irqsave(&clk->lock, flags);
			list_add(&inst->node, &clk->prepare_list);
			spin_unlock_irqrestore(&clk->lock, flags);
		} else
			clk->prepare_count--;
		mutex_unlock(&clk->mutex);
	}
	return ret;
}

int clk_enable(struct clk *clk, void *driver_id)
{
	unsigned long flags;
	int ret = 0;

	if (clk) {
		struct prepare_instance *inst;

		spin_lock_irqsave(&clk->lock, flags);
		list_for_each_entry(inst, &clk->prepare_list, node)
			if (inst == driver_id)
				ret = -EINVAL;

		if (ret == 0 && clk->enable_count++ == 0) {
			ret = clk->ops->enable(clk);
			if (ret)
				clk->enable_count--;
		}
		spin_unlock_irqrestore(&clk->lock, flags);
	}
	return ret;
}

I think that's going completely over the top, and adds needless complexity
to drivers, which now have to pass an instance specific cookie into every
clk API call.
