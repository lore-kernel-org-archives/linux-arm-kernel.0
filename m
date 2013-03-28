From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 28 Mar 2013 15:01:09 -0700
Subject: [PATCH 1/1] clk: Add notifier support in clk_prepare/clk_unprepare
In-Reply-To: <CAMbhsRSSknsEX_gwAzPtV8b8kGdZyTpLEoT2uXaDKoCbpr3cJg@mail.gmail.com>
References: <1363699712-8124-1-git-send-email-bilhuang@nvidia.com>
 <20130319170140.8663.93388@quantum> <1363748149.8815.16.camel@bilhuang-vm1>
 <20130320033142.11073.30097@quantum>
 <1363754384.8815.42.camel@bilhuang-vm1> <20130320144752.11073.653@quantum>
 <CAPDyKFr+Hqi8Dge3Hn55JXbqEP358F3Eq1OHdYy=2JxucJHtJg@mail.gmail.com>
 <20130321223619.834.31998@quantum>
 <CAMbhsRSSknsEX_gwAzPtV8b8kGdZyTpLEoT2uXaDKoCbpr3cJg@mail.gmail.com>
Message-ID: <20130328220109.13785.58488@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Colin Cross (2013-03-21 17:06:25)
> On Thu, Mar 21, 2013 at 3:36 PM, Mike Turquette <mturquette@linaro.org> wrote:
> > To my knowledge, devfreq performs one task: implements an algorithm
> > (typically one that loops/polls) and applies this heuristic towards a
> > dvfs transition.
> >
> > It is a policy layer, a high level layer.  It should not be used as a
> > lower-level mechanism.  Please correct me if my understanding is wrong.
> >
> > I think the very idea of the clk framework calling into devfreq is
> > backwards.  Ideally a devfreq driver would call clk_set_rate as part of
> > it's target callback.  This is analogous to a cpufreq .target callback
> > which calls clk_set_rate and regulator_set_voltage.  Can you imagine the
> > clock framework cross-calling into cpufreq when clk_set_rate is called?
> > I think that would be strange.
> >
> > I think that all of this discussion highlights the fact that there is a
> > missing piece of infrastructure.  It isn't devfreq or clock rate-change
> > notifiers.  It is that there is not a dvfs mechanism which neatly builds
> > on top of these lower-level frameworks (clocks & regulators).  Clearly
> > some higher-level abstraction layer is needed.
> 
> I went through all of this on Tegra2.  For a while I had a
> dvfs_set_rate api for drivers that needed to modify the voltage when
> they updated a clock, but I ended up dropping it.  Drivers rarely care
> about the voltage, all they want to do is set their clock rate.  The
> voltage necessary to support that clock is an implementation detail of
> the silicon that is irrelevant to the driver

Hi Colin,

I agree about voltage scaling being an implementation detail,  but I
think that drivers similarly do not care about enabling clocks, clock
domains, power domains, voltage domains, etc.  The just want to say
"give me what I need to turn on and run", and "I'm done with that stuff
now, lazily turn off if you want to".  Runtime pm gives drivers that
abstraction layer today.

There is a need for a similar abstraction layer for dvfs or, more
generically, an abstraction layer for performance.  It is true that a
driver doesn't care about scaling it's voltage, but it also might not
care that its functional clock is changing rate, or that memory needs to
run faster, or that an async bridge or interface clock needs to change
it's rate.

These are also implementation details that are common in dvfs
transitions, but the driver surely doesn't care about.  (note that
obviously some driver care specifically about clocks, such as multimedia
codecs)

> (I know TI liked to specify voltage/frequency combos for the blocks,
> but their chips still had to support running at a lower clock speed
> for the voltage than specified in the OPP because that case always
> occurs during a dvfs change).
> 

I don't see the relevance to this discussion.

> For Tegra2, before clk_prepare/clk_unprepare existed, I hacked dvfs
> into the clk framework by using a mixture of mutex locked clocks and
> spinlock locked clocks.  The main issue is accidentally recursive
> locking the main clock locks when the call path is
> clk->dvfs->regulator set->i2c->clk.  I think if you could guarantee
> that clocks required for dvfs were always in the "prepared" state
> (maybe a flag on the clock, kind of like WQ_MEM_RECLAIM marks
> "special" workqueues, or just have the machine call clk_prepare), and
> that clk_prepare on an already-prepared clock avoided taking the mutex
> (atomic op fastpath plus mutex slow path?), then the existing
> notifiers would be perfect for dvfs.

The clk reentrancy patchset[1] solves the particular locking problem
you're referring to.

The bigger issue that worries me about using clock rate-change notifiers
to implement a dvfs transition is that the mechanism may not be powerful
enough, or may be very messy.

For instance consider OMAP's voltage domain dependencies.  A straight
forward example is running the MPU fast, which requires DDR to run fast.
So a call to clk_set_rate(cpu_clk) will shoot off PRE_RATE_CHANGE
notifiers that call clk_set_rate(ddr_clk).  Both of those calls to
clk_set_rate will also result in notifiers that each call
regulator_scale_voltage on their respective regulators.

Since there is no user tracking going on in the clock framework, all it
takes is any other actor in the system to call clk_set_rate(ddr_clk) and
overwrite what the mpu_clk did.  For instance a bluetooth file transfer
needs CORE to run fast for some 3Mbps transfer, and then ramps clock
rates back down (including the ddr_clk rate) after it completes, even
while the MPU is still running fast.  So now user requests have to be
tracked and compared to prevent that sort of thing from happening.
Should all of that user-tracking stuff end up in the clock framework?
I'm not so sure.

Anyways I'm still looking at the voltage scaling via notifiers thing and
trying to understand the limits of that design choice before everyone
converts over to it and there is no turning back.

Regards,
Mike

[1] http://article.gmane.org/gmane.linux.kernel/1466092
