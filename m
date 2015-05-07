From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 6 May 2015 22:52:31 -0700
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
Message-ID: <20150507055231.GB32399@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06, Viresh Kumar wrote:
> On 5 May 2015 at 22:42, Mark Brown <broonie@kernel.org> wrote:
> > This still doesn't say what the value is supposed to mean which means
> > it's not possible for someone to write generic code which handles the
> > binding - saying that people can reference the value doesn't tell them
> > how to interpret it.  A limit?  A nominal constant draw value?  A value
> > to regulate to?  Those are all different things expressed as a current.
> 
> @Stephen: Can you please answer these queries please, so that we
> can get the bindings correctly ?

If you look at the cpufreq/clock/pmic code on our codeaurora.org
tree you'll see that it's used to pass a value with uA units
through the regulator_set_optimum_mode() API. The call to
regulator_set_optimum_mode() is here[1], and the place where we
parse the OPP table from DT is here[2]. My understanding is that
with recent changes to the regulator framework, we would do a
s/regulator_set_optimum_mode/regulator_set_load/ and things would
otherwise be the same on the consumer side. On the regulator
side, we would move the .get_optimum_mode op to .set_load instead
of the hack where we write to the hardware in
.get_optimum_mode[3].

So does that mean it corresponds to a limit, or a nominal
constant draw value, or a value to regulator to? From what I can
tell it's used to figure out how many phases to enable[4]. I
suspect that means it's being used to figure out what value it
should regulate to. In newer PMICs this is all done
automatically, but at least for some of the PMICs we need to do
it manually.

[1] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/drivers/clk/qcom/clock.c?h=msm-3.10#n96
[2] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/drivers/clk/qcom/clock-krait-8974.c?h=msm-3.10#n584
[3] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/arch/arm/mach-msm/krait-regulator.c?h=msm-3.10#n610
[4] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/arch/arm/mach-msm/krait-regulator.c?h=msm-3.10#n486

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
