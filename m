From: ccross@google.com (Colin Cross)
Date: Thu, 21 Mar 2013 17:06:25 -0700
Subject: [PATCH 1/1] clk: Add notifier support in clk_prepare/clk_unprepare
In-Reply-To: <20130321223619.834.31998@quantum>
References: <1363699712-8124-1-git-send-email-bilhuang@nvidia.com>
 <20130319170140.8663.93388@quantum>
 <1363748149.8815.16.camel@bilhuang-vm1>
 <20130320033142.11073.30097@quantum>
 <1363754384.8815.42.camel@bilhuang-vm1>
 <20130320144752.11073.653@quantum>
 <CAPDyKFr+Hqi8Dge3Hn55JXbqEP358F3Eq1OHdYy=2JxucJHtJg@mail.gmail.com>
 <20130321223619.834.31998@quantum>
Message-ID: <CAMbhsRSSknsEX_gwAzPtV8b8kGdZyTpLEoT2uXaDKoCbpr3cJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 3:36 PM, Mike Turquette <mturquette@linaro.org> wrote:
> To my knowledge, devfreq performs one task: implements an algorithm
> (typically one that loops/polls) and applies this heuristic towards a
> dvfs transition.
>
> It is a policy layer, a high level layer.  It should not be used as a
> lower-level mechanism.  Please correct me if my understanding is wrong.
>
> I think the very idea of the clk framework calling into devfreq is
> backwards.  Ideally a devfreq driver would call clk_set_rate as part of
> it's target callback.  This is analogous to a cpufreq .target callback
> which calls clk_set_rate and regulator_set_voltage.  Can you imagine the
> clock framework cross-calling into cpufreq when clk_set_rate is called?
> I think that would be strange.
>
> I think that all of this discussion highlights the fact that there is a
> missing piece of infrastructure.  It isn't devfreq or clock rate-change
> notifiers.  It is that there is not a dvfs mechanism which neatly builds
> on top of these lower-level frameworks (clocks & regulators).  Clearly
> some higher-level abstraction layer is needed.

I went through all of this on Tegra2.  For a while I had a
dvfs_set_rate api for drivers that needed to modify the voltage when
they updated a clock, but I ended up dropping it.  Drivers rarely care
about the voltage, all they want to do is set their clock rate.  The
voltage necessary to support that clock is an implementation detail of
the silicon that is irrelevant to the driver (I know TI liked to
specify voltage/frequency combos for the blocks, but their chips still
had to support running at a lower clock speed for the voltage than
specified in the OPP because that case always occurs during a dvfs
change).

For Tegra2, before clk_prepare/clk_unprepare existed, I hacked dvfs
into the clk framework by using a mixture of mutex locked clocks and
spinlock locked clocks.  The main issue is accidentally recursive
locking the main clock locks when the call path is
clk->dvfs->regulator set->i2c->clk.  I think if you could guarantee
that clocks required for dvfs were always in the "prepared" state
(maybe a flag on the clock, kind of like WQ_MEM_RECLAIM marks
"special" workqueues, or just have the machine call clk_prepare), and
that clk_prepare on an already-prepared clock avoided taking the mutex
(atomic op fastpath plus mutex slow path?), then the existing
notifiers would be perfect for dvfs.
