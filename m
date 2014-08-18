From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 18 Aug 2014 23:25:22 +0100
Subject: [PATCH v7 6/8] drivers: cpuidle: CPU idle ARM64 driver
In-Reply-To: <20140818142153.GH20043@localhost>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-7-git-send-email-lorenzo.pieralisi@arm.com>
 <20140818142153.GH20043@localhost>
Message-ID: <20140818222521.GA5032@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 03:21:53PM +0100, Catalin Marinas wrote:
> On Wed, Aug 13, 2014 at 04:52:05PM +0100, Lorenzo Pieralisi wrote:
> > +static int __init arm64_idle_init(void)
> > +{
> > +	int i, ret;
> > +	struct cpuidle_driver *drv = &arm64_idle_driver;
> > +
> > +	drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
> > +	if (!drv->cpumask)
> > +		return -ENOMEM;
> > +
> > +	cpumask_copy(drv->cpumask, cpu_possible_mask);
> > +	/*
> > +	 * Initialize idle states data, starting at index 1.
> > +	 * This driver is DT only, if no DT idle states are detected (ret == 0)
> > +	 * let the driver initialization fail accordingly since there is no
> > +	 * reason to initialize the idle driver if only wfi is supported.
> > +	 */
> > +	ret = dt_init_idle_driver(drv, 1);
> > +	if (ret <= 0)
> > +		goto free_mem;
> > +	/*
> > +	 * Call arch CPU operations in order to initialize
> > +	 * idle states suspend back-end specific data
> > +	 */
> > +	for_each_cpu(i, drv->cpumask) {
> > +		ret = cpu_init_idle(i);
> > +		if (ret)
> > +			goto free_mem;
> > +	}
> > +
> > +	for (i = 1; i < drv->state_count; i++)
> > +		drv->states[i].enter = arm_enter_idle_state;
> 
> BTW, I've seen this pattern a few times already. Do you think it would
> be useful to change the dt_init_idle_driver() API to take a function
> pointer as argument and populate it there? The only drawback would be if
> we want different functions based on the states that have been
> populated (not sure whether we'll need the flexibility in the future).
> Either way, my ack on this patch stands.

Yes, you have a point I thought about that. My fear is legacy drivers
that might require different function pointers for different states
(but still want to get idle states data from DT when we convert them).

I wanted to tread carefully as a first step, it should not be a blocker,
but I will give it more thought. I do not think we need a function
pointer per-state, I will talk to Daniel to make a final decision.

Thank you !
Lorenzo
