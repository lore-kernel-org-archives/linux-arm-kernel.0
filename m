From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 30 Jun 2017 14:13:30 +0530
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <CAGb2v64CE2cUKgFuXd0f+FEdzQqmpOgMWqk76RndjeOz98=H0A@mail.gmail.com>
References: <20170629144711.GO29665@vireshk-i7>
 <1522ae7b-fd5b-5403-62bf-b0140e116d65@gr13.net>
 <20170630031648.GR29665@vireshk-i7>
 <CAGb2v64UabHPN79-zFzgxhsJwPF=fe_dM8jwnbxj_XR4LzsnwQ@mail.gmail.com>
 <20170630035533.GV29665@vireshk-i7>
 <CAGb2v67hxVciKFLD=8pgfm+UJ1i2Zb0aByTEa556O5uGcX7Oug@mail.gmail.com>
 <20170630041211.GX29665@vireshk-i7>
 <CAGb2v641UyXS5ccmo0j9Dvty8soB+DqwF2w8zKHsM78oK7b1aw@mail.gmail.com>
 <20170630051203.GY29665@vireshk-i7>
 <CAGb2v64CE2cUKgFuXd0f+FEdzQqmpOgMWqk76RndjeOz98=H0A@mail.gmail.com>
Message-ID: <20170630084330.GB29665@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-06-17, 14:36, Chen-Yu Tsai wrote:
>  = On Fri, Jun 30, 2017 at 1:12 PM, Viresh Kumar
> <viresh.kumar@linaro.org> wrote:

> > Right, but someone needs to get the regulator first to have that
> > considered by the regulator core while deciding the final range.
> 
> AFAIK the regulator core automatically corrects any voltages outside
> its constraints when the regulator is first registered. This is
> independent of any consumer constraints.

Right, so the kernel checks if the current voltage value set for the
supply is within valid range as per the constraints present in
regulator node.

> > Both DMA and LCD driver do regulator_get() for their devices but if
> > only DMA driver is probed until now, then the regulator core wouldn't
> > consider LCD as regulator_get() is never called for LCD.
> >
> >> I think what you mean is that the DT constraints are the union of all
> >> consumer constraints (1.8 - 3.0 V in this case), then each consumer
> >> comes in and adds its own constraints. And for such a design, the kernel
> >> needs to know which and what constraints to apply.
> >
> > Sorry, I am confused with what you just said and not sure if I
> > understand it completely.
> >
> > Each consumer DT node will have its own set of constraints for the
> > regulator device. The kernel will do regulator_get() for them one by
> > one, based on when their drivers get probed. And an intersection of
> > those constraints (which already did regulator_get()) will be used by
> > the regulator core.
> 
> No. In the device tree, the only constraints (per the current state
> of the bindings) is for the regulator supply. Any consumer constraints
> are programmed purely by the driver, by using regulator_set_voltage().
> All of them are considered by the core before setting the real voltage.

That's right. I had a bit of misunderstanding here. By default min/max
for the consumers is set to zero and they are ignored in
regulator_check_consumers().

> > Now this series is saying that even if the driver didn't come up (for
> > LCD) and haven't done its regulator_get() yet, consider that device's
> > constraint while calculating the target voltage for the regulator.
> 
> What I'm saying is that, for the constraints in the regulator supply node,
> you would have already considered all consumer constraints.

Yes, so whatever voltage the bootloader has programmed for LCD should
fit within constraints present in supply's node.

> If one of its
> consumers can't take power above 2.5 V, surely you don't want the regulator
> sending power above that, so you would have
> 
>     regulator-max-microvolt = <2500000>;
>
> for that regulator node. You would do something similar for the lower
> limit of the voltage range.
> 

I am no regulators expert, but AFAIU that's not true. What's wrong
with the following scenario:

Operable ranges of the regulator: 1.8 - 3.0 V
Range required by LCD: 2.0 - 3.0 V
Range required by DMA: 1.8 - 2.5 V

Here DMA can't work with regulator voltages > 2.5 V, but regulator can
go max to 3.0 V. Of course if the DMA driver has done
regulator_set_voltage(), then we will be within 2.5 V range. But that
doesn't force us to have regulator-max-microvolt set to 2.5 V.

And so the DT node shall have this:

        regulator-min-microvolt = <1800000>;
        regulator-max-microvolt = <3000000>;

Isn't it ?

> This might be unrelated, but I think it is a similar problem. When a
> clk rate change is propagated up the clk tree, any affected sibling
> clks aren't automatically readjusted, i.e. try to keep roughly the
> same output clk rate by adjusting its own dividers. This might be
> one side of the problem you are trying to solve.

I am not sure how this problem can be solved with what this set is
proposing. :(

-- 
viresh
