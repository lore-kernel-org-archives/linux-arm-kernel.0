From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 30 Jun 2017 12:22:13 +0800
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <20170630041211.GX29665@vireshk-i7>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <beab4875-8dd7-43d7-9ad2-6e38963d7d4c@gr13.net>
 <20170629144711.GO29665@vireshk-i7>
 <1522ae7b-fd5b-5403-62bf-b0140e116d65@gr13.net>
 <20170630031648.GR29665@vireshk-i7>
 <CAGb2v64UabHPN79-zFzgxhsJwPF=fe_dM8jwnbxj_XR4LzsnwQ@mail.gmail.com>
 <20170630035533.GV29665@vireshk-i7>
 <CAGb2v67hxVciKFLD=8pgfm+UJ1i2Zb0aByTEa556O5uGcX7Oug@mail.gmail.com>
 <20170630041211.GX29665@vireshk-i7>
Message-ID: <CAGb2v641UyXS5ccmo0j9Dvty8soB+DqwF2w8zKHsM78oK7b1aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 12:12 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 30-06-17, 12:05, Chen-Yu Tsai wrote:
>> On Fri, Jun 30, 2017 at 11:55 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 30-06-17, 11:33, Chen-Yu Tsai wrote:
>> >> AFAIK regulator constraints are supposed to satisfy all users of it.
>> >
>> > Right.
>> >
>> >> >> >Let me try with an example. A regulator is shared between LCD and DMA
>> >> >> >controller.
>> >> >> >
>> >> >> >Operable ranges of the regulator: 1.8 - 3.0 V
>> >> >> >Range required by LCD: 2.0 - 3.0 V
>> >> >> >Range required by DMA: 1.8 - 2.5 V
>> >>
>> >> So for the example here, the regulator constraint should be 2.5 - 3.0 V,
>> >> or the intersection of all voltage requirements.
>> >
>> > Had a look at regulator_check_consumers() and the range selected by it
>> > is the *highest* min_uV and *lowest* max_uV, to find that intersection
>> > point.
>> >
>> > For LCD: min_uV = 2.0 V, max_uV = 3.0 V
>> > For DMA: min_uV = 1.8 V, max_uV = 2.5 V
>> >
>> > Highest min_uV = 2.0 V
>> > Lowest max_uV = 2.5 V
>> >
>> > And so I mentioned the regulator's final range (that satisfies all
>> > consumers) is 2 - 2.5 V.
>> >
>> > Why do you say it should be 2.5 - 3.0 V ?
>>
>> You are right. It should be 2.0 - 2.5 V. Haven't had my coffee this
>> morning. :(
>
> And I was worrying if I had something else in my coffee :)
>
>> I also want to mention that for DT based platforms, this constraint
>> should already be set in the device tree for the regulator, so the
>> scenario where DMA comes up and sets a voltage level that LCD cannot
>> use should not even be possible.
>
> Yes, such constraints are already present. But the problem (this
> series is trying to solve) is that the kernel doesn't know if the LCD
> is already powered ON. And so when DMA gets probed first, the kernel
> thinks that DMA is the only user of the regulator and the voltage is
> set to 1.8-2.5 V. And so this series is somehow trying to make the
> kernel aware about the constraints of the LCD controller which was
> enabled in the bootloader.

What I'm saying is for the DT case, the constraints are already limited
to the intersection of all users, regardless of whether they are turned
on or not. At least this is what I believe makes sense. You really don't
want to set a regulator such that it over voltages for a subset of its
consumers. Consumers might not have proper power isolation for this.

I think what you mean is that the DT constraints are the union of all
consumer constraints (1.8 - 3.0 V in this case), then each consumer
comes in and adds its own constraints. And for such a design, the kernel
needs to know which and what constraints to apply.

Either way regulators already support constraints, so they are easier
to deal with. Clocks on the other hand, while the core does support
clock rate constraints, AFAIK no one really uses or supports them.

ChenYu
