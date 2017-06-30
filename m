From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 30 Jun 2017 14:36:15 +0800
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <20170630051203.GY29665@vireshk-i7>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <beab4875-8dd7-43d7-9ad2-6e38963d7d4c@gr13.net>
 <20170629144711.GO29665@vireshk-i7>
 <1522ae7b-fd5b-5403-62bf-b0140e116d65@gr13.net>
 <20170630031648.GR29665@vireshk-i7>
 <CAGb2v64UabHPN79-zFzgxhsJwPF=fe_dM8jwnbxj_XR4LzsnwQ@mail.gmail.com>
 <20170630035533.GV29665@vireshk-i7>
 <CAGb2v67hxVciKFLD=8pgfm+UJ1i2Zb0aByTEa556O5uGcX7Oug@mail.gmail.com>
 <20170630041211.GX29665@vireshk-i7>
 <CAGb2v641UyXS5ccmo0j9Dvty8soB+DqwF2w8zKHsM78oK7b1aw@mail.gmail.com>
 <20170630051203.GY29665@vireshk-i7>
Message-ID: <CAGb2v64CE2cUKgFuXd0f+FEdzQqmpOgMWqk76RndjeOz98=H0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 = On Fri, Jun 30, 2017 at 1:12 PM, Viresh Kumar
<viresh.kumar@linaro.org> wrote:
> On 30-06-17, 12:22, Chen-Yu Tsai wrote:
>> On Fri, Jun 30, 2017 at 12:12 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 30-06-17, 12:05, Chen-Yu Tsai wrote:
>
>> >> I also want to mention that for DT based platforms, this constraint
>> >> should already be set in the device tree for the regulator, so the
>> >> scenario where DMA comes up and sets a voltage level that LCD cannot
>> >> use should not even be possible.
>>
>> What I'm saying is for the DT case, the constraints are already limited
>> to the intersection of all users, regardless of whether they are turned
>> on or not.
>
> Right, but someone needs to get the regulator first to have that
> considered by the regulator core while deciding the final range.

AFAIK the regulator core automatically corrects any voltages outside
its constraints when the regulator is first registered. This is
independent of any consumer constraints.

> Both DMA and LCD driver do regulator_get() for their devices but if
> only DMA driver is probed until now, then the regulator core wouldn't
> consider LCD as regulator_get() is never called for LCD.
>
>> I think what you mean is that the DT constraints are the union of all
>> consumer constraints (1.8 - 3.0 V in this case), then each consumer
>> comes in and adds its own constraints. And for such a design, the kernel
>> needs to know which and what constraints to apply.
>
> Sorry, I am confused with what you just said and not sure if I
> understand it completely.
>
> Each consumer DT node will have its own set of constraints for the
> regulator device. The kernel will do regulator_get() for them one by
> one, based on when their drivers get probed. And an intersection of
> those constraints (which already did regulator_get()) will be used by
> the regulator core.

No. In the device tree, the only constraints (per the current state
of the bindings) is for the regulator supply. Any consumer constraints
are programmed purely by the driver, by using regulator_set_voltage().
All of them are considered by the core before setting the real voltage.

> Now this series is saying that even if the driver didn't come up (for
> LCD) and haven't done its regulator_get() yet, consider that device's
> constraint while calculating the target voltage for the regulator.

What I'm saying is that, for the constraints in the regulator supply node,
you would have already considered all consumer constraints. If one of its
consumers can't take power above 2.5 V, surely you don't want the regulator
sending power above that, so you would have

    regulator-max-microvolt = <2500000>;

for that regulator node. You would do something similar for the lower
limit of the voltage range.

You don't even need any actual consumers. Using regulator-min-microvolt,
regulator-max-microvolt, and regulator-always-on, you can have a regulator
provide power at a suitable voltage. We do this for various power rails
on Allwinner SoCs that don't really have proper consumers, like power
for internal logic, PLL, and others. I'm not saying this is a good solution,
because you lose runtime control of the regulator. It's just something
we came up with in lieu of any proper consumers.

>> Either way regulators already support constraints, so they are easier
>> to deal with. Clocks on the other hand, while the core does support
>> clock rate constraints, AFAIK no one really uses or supports them.
>
> Yeah, so I started with just regulators and that's when Mark suggested
> to do something generic which can be reused by other resource types.
> We may end up covering clk for sure I believe. Not sure yet about
> other resource types though.

This might be unrelated, but I think it is a similar problem. When a
clk rate change is propagated up the clk tree, any affected sibling
clks aren't automatically readjusted, i.e. try to keep roughly the
same output clk rate by adjusting its own dividers. This might be
one side of the problem you are trying to solve.

ChenYu
