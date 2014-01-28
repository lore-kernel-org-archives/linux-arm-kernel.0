From: ta.omasab@gmail.com (Thomas Abraham)
Date: Tue, 28 Jan 2014 20:45:49 +0530
Subject: [PATCH v2 1/7] cpufreq: cpufreq-cpu0: allow optional safe voltage
 during frequency transitions
In-Reply-To: <20140128160633.470202ec@amdc2363>
References: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
 <1390047057-2239-2-git-send-email-thomas.ab@samsung.com>
 <20140127202543.4167.83362@quantum>
 <CAJuA9ah1vsgpD04QhM5RApkCe9xcvpPkLvdwzgadKGWvngAt+g@mail.gmail.com>
 <20140128091721.1d8128cd@amdc2363>
 <CAJuA9ag_izbSmQ_9-NH4NSGeCnzNBdwPUKzBTg5azuFKVqD28g@mail.gmail.com>
 <20140128160633.470202ec@amdc2363>
Message-ID: <CAJuA9agBDQPk4-J35Qo8yVysaStVPBEMqdwiMZVqzFL7-C+BzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Tue, Jan 28, 2014 at 8:36 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Thomas,
>
>> Hi Lukasz,
>>
>> On Tue, Jan 28, 2014 at 1:47 PM, Lukasz Majewski
>> <l.majewski@samsung.com> wrote:
>> > Hi Thomas, Mike
>> >
>> >> Hi Mike,
>> >>
>> >> On Tue, Jan 28, 2014 at 1:55 AM, Mike Turquette
>> >> <mturquette@linaro.org> wrote:
>> >> > Quoting Thomas Abraham (2014-01-18 04:10:51)
>> >> >> From: Thomas Abraham <thomas.ab@samsung.com>
>> >> >>
>> >> >> On some platforms such as the Samsung Exynos, changing the
>> >> >> frequency of the CPU clock requires changing the frequency of
>> >> >> the PLL that is supplying the CPU clock. To change the
>> >> >> frequency of the PLL, the CPU clock is temporarily reparented
>> >> >> to another parent clock.
>> >> >>
>> >> >> The clock frequency of this temporary parent clock could be much
>> >> >> higher than the clock frequency of the PLL at the time of
>> >> >> reparenting. Due to the temporary increase in the CPU clock
>> >> >> speed, the CPU (and any other components in the CPU clock
>> >> >> domain such as dividers, mux, etc.) have to to be operated at a
>> >> >> higher voltage level, called the safe voltage level. This patch
>> >> >> adds optional support to temporarily switch to a safe voltage
>> >> >> level during CPU frequency transitions.
>> >> >>
>> >> >> Cc: Shawn Guo <shawn.guo@linaro.org>
>> >> >> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> >> >
>> >> > I'm not a fan of this change. This corner case should be
>> >> > abstracted away somehow. I had talked to Chander Kayshap
>> >> > previously about handling voltage changes in clock notifier
>> >> > callbacks, which then renders any voltage change as a trivial
>> >> > part of the clock rate transition. That means that this "safe
>> >> > voltage" thing could be handled automagically without any
>> >> > additional code in the CPUfreq driver.
>> >> >
>> >> > There are two nice ways to do this with the clock framework.
>> >> > First is explicit re-parenting with voltage scaling done in the
>> >> > clock rate-change notifiers:
>> >> >
>> >> > clk_set_parent(cpu_clk, temp_parent);
>> >> > /* implicit voltage scaling to "safe voltage" happens above */
>> >> > clk_set_rate(pll, some_rate);
>> >> > clk_set_parent(cpu_clk, pll);
>> >> > /* implicit voltage scaling to nominal OPP voltage happens above
>> >> > */
>> >> >
>> >
>> > I must agree with Mike here. In my opinion the above approach is
>> > more compliant with CCF (as I've pointed it out in my other comment
>> > - the cpu_clk has more than one parent and we could switch between
>> > them when needed).
>>
>> The mux which is used to re-parent is part of the larger opaque cpu
>> clock type (more like the composite clock). So I am not sure how this
>> isn't compliant with ccf.
>
> My point here is to use the clk_set_parent() explicitly instead of
> changing the mux with writing values directly to registers.
>
> However, I'm also aware, that we must reparent quickly. so I'm OK
> with your approach.

Okay.

>
>>
>> >
>> >> > The above sequence would require a separate exnyos CPUfreq
>> >> > driver, due to the added clk_set_parent logic.
>> >> >
>> >> > The second way to do this is to abstract the clk re-muxing logic
>> >> > out into the clk driver, which would allow cpufreq-cpu0 to be
>> >> > used for the exynos chips.
>> >>
>> >> This is the approach this patch series takes (patch 2/7). The clock
>> >> re-muxing logic is handled by a clock driver code. The difference
>> >> from what you suggested is that the safe voltage (that may be
>> >> optionally) required before doing the re-muxing is handled here in
>> >> cpufreq-cpu0 driver.
>> >>
>> >> The safe voltage setup can be done in the notifier as you
>> >> suggested.
>> >
>> > If the clk_set_parent() approach is not suitable, then cannot we
>> > consider using the one from highbank-cpufreq.c?
>> >
>> > Here we have cpufreq-cpu0.c which sets voltage of the cpu_clk.
>> > In the highbank-cpufreq.c there are clock notifiers to change the
>> > voltage.
>> >
>> > Cannot Exynos reuse such approach? Why shall we pollute
>> > cpufreq-cpu0.c with another solution?
>>
>> The highbank-cpufreq.c file was introduced because platforms using
>> this driver did not have the usual regulator to control the voltage.
>> The first commit of this driver explains this (copied below).
>>
>> "Highbank processors depend on the external ECME to perform voltage
>> management based on a requested frequency. Communication between the
>> A9 cores and the ECME happens over the pl320 IPC channel."
>>
>> So those platforms had no choice but to use an alternative approach to
>> control the voltage (and reuse cpufreq-cpu0 as much as possible).
>> The
>> case with exynos is a different one.
>
> Highbank needs to set voltage via IPC, Exynos needs to adjust voltage
> when reparenting.
>
> Both can be recognized as unusual cases. That is why I asked if we
> could reuse the same approach for Exynos.

Okay.

>
>> cpufreq-cpu0 is fully re-usable
>> for exynos with the additional support for "safe voltage". If we agree
>> that there might be existing or future platforms with single
>> clock/voltage rail that require the "safe voltage" feature, then
>> adding "safe voltage" support in cpufreq-cpu0 driver seems to be the
>> right approach.
>
> I think that Shawn's opinion will be final here.
>
>>
>> >
>> >> But, doing that in cpufreq-cpu0 driver will help other platforms
>> >> reuse this feature if required. Also, if done here, the regulator
>> >> handling is localized in this driver which otherwise would need to
>> >> be handled in two places, cpufreq-cpu0 driver and the clock
>> >> notifier.
>> >
>> > I think that there is a logical distinction between setting voltage
>> > for cpufreq-cpu0 related clock and increasing voltage of reparented
>> > clock.
>> >
>> > The former fits naturally to cpufreq-cpu0, when the latter seems
>> > like some corner case (as Mike pointed out) for Exynos.
>>
>> Agreed, it is a corner case. But for this corner case, we are
>> performing some additional actions on the same regulator which is used
>> in the normal functioning of the driver.
>>
>> >
>> >>
>> >> So I tend to prefer the approach in this patch but I am willing to
>> >> consider any suggestions.
>> >
>> > Thomas, what do you think about highbank-cpufreq.c approach (with
>> > using clock notifiers)?
>>
>> I have made a related comment on this above.
>>
>> >
>> > Do you think, that it is feasible to reuse it with Exynos?
>>
>> highbank cpufreq driver is intended for a different purpose so I don't
>> think it can be reused for exynos. Yes, we can make exynos specific
>> hacks into highbank driver but how would that be better over the
>> approach in this patch?
>
> I think, that I was misunderstood here. I wanted to ask if we could
> reuse the clk notifier approach.

Okay, I misunderstood your comment. We could do something similar to
highbank cpufreq driver for exynos as well. Anyways, Shawn prefers not
to add "safe voltage" support into cpufreq-cpu0 driver. So we need to
look for other options.

Thanks,
Thomas.

>
>>
>> >
>> >> Shawn, it would be helpful if you could let
>> >> us know your thoughts on this. I am almost done with testing the
>> >> v3 of this series and want to post it so if there are any
>> >> objections to the changes in this patch, please let me know.
>> >>
>> >> Thanks,
>> >> Thomas.
>> >>
>> >> >
>> >> > I'm more a fan of explicitly listing the Exact Steps for the cpu
>> >> > opp transition in a separate exynos-specific CPUfreq driver, but
>> >> > that's probably an unpopular view.
>> >> >
>> >> > Regards,
>> >> > Mike
>> >> >
>> >> >> ---
>> >> >>  .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    7 ++++
>> >> >>  drivers/cpufreq/cpufreq-cpu0.c                     |   37
>> >> >> +++++++++++++++++-- 2 files changed, 40 insertions(+), 4
>> >> >> deletions(-)
>> >> >>
>> >> >> diff --git
>> >> >> a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
>> >> >> b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
>> >> >> index f055515..37453ab 100644 ---
>> >> >> a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt +++
>> >> >> b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt @@
>> >> >> -19,6 +19,12 @@ Optional properties:
>> >> >>  - cooling-min-level:
>> >> >>  - cooling-max-level:
>> >> >>       Please refer to
>> >> >> Documentation/devicetree/bindings/thermal/thermal.txt. +-
>> >> >> safe-opp: Certain platforms require that during a opp
>> >> >> transition,
>> >> >> +  a system should not go below a particular opp level. For such
>> >> >> systems,
>> >> >> +  this property specifies the minimum opp to be maintained
>> >> >> during the
>> >> >> +  opp transitions. The safe-opp value is a tuple with first
>> >> >> element
>> >> >> +  representing the safe frequency and the second element
>> >> >> representing the
>> >> >> +  safe voltage.
>> >> >>
>> >> >>  Examples:
>> >> >>
>> >> >> @@ -36,6 +42,7 @@ cpus {
>> >> >>                         396000  950000
>> >> >>                         198000  850000
>> >> >>                 >;
>> >> >> +               safe-opp = <396000 950000>
>> >> >>                 clock-latency = <61036>; /* two CLK32 periods */
>> >> >>                 #cooling-cells = <2>;
>> >> >>                 cooling-min-level = <0>;
>> >> >> diff --git a/drivers/cpufreq/cpufreq-cpu0.c
>> >> >> b/drivers/cpufreq/cpufreq-cpu0.c index 0c12ffc..075d3d1 100644
>> >> >> --- a/drivers/cpufreq/cpufreq-cpu0.c
>> >> >> +++ b/drivers/cpufreq/cpufreq-cpu0.c
>> >> >> @@ -27,6 +27,8 @@
>> >> >>
>> >> >>  static unsigned int transition_latency;
>> >> >>  static unsigned int voltage_tolerance; /* in percentage */
>> >> >> +static unsigned long safe_frequency;
>> >> >> +static unsigned long safe_voltage;
>> >> >>
>> >> >>  static struct device *cpu_dev;
>> >> >>  static struct clk *cpu_clk;
>> >> >> @@ -64,17 +66,30 @@ static int cpu0_set_target(struct
>> >> >> cpufreq_policy *policy, unsigned int index) volt_old =
>> >> >> regulator_get_voltage(cpu_reg); }
>> >> >>
>> >> >> -       pr_debug("%u MHz, %ld mV --> %u MHz, %ld mV\n",
>> >> >> +       pr_debug("\n\n%u MHz, %ld mV --> %u MHz, %ld mV\n",
>> >> >>                  old_freq / 1000, volt_old ? volt_old / 1000 :
>> >> >> -1, new_freq / 1000, volt ? volt / 1000 : -1);
>> >> >>
>> >> >>         /* scaling up?  scale voltage before frequency */
>> >> >> -       if (!IS_ERR(cpu_reg) && new_freq > old_freq) {
>> >> >> +       if (!IS_ERR(cpu_reg) && new_freq > old_freq &&
>> >> >> +                               new_freq >= safe_frequency) {
>> >> >>                 ret = regulator_set_voltage_tol(cpu_reg, volt,
>> >> >> tol); if (ret) {
>> >> >>                         pr_err("failed to scale voltage up:
>> >> >> %d\n", ret); return ret;
>> >> >>                 }
>> >> >> +       } else if (!IS_ERR(cpu_reg) && old_freq <
>> >> >> safe_frequency) {
>> >> >> +               /*
>> >> >> +                * the scaled up voltage level for the new_freq
>> >> >> is lower
>> >> >> +                * than the safe voltage level. so set
>> >> >> safe_voltage
>> >> >> +                * as the intermediate voltage level and revert
>> >> >> it
>> >> >> +                * back after the frequency has been changed.
>> >> >> +                */
>> >> >> +               ret = regulator_set_voltage_tol(cpu_reg,
>> >> >> safe_voltage, tol);
>> >> >> +               if (ret) {
>> >> >> +                       pr_err("failed to set safe voltage:
>> >> >> %d\n", ret);
>> >> >> +                       return ret;
>> >> >> +               }
>> >> >>         }
>> >> >>
>> >> >>         ret = clk_set_rate(cpu_clk, freq_exact);
>> >> >> @@ -86,7 +101,8 @@ static int cpu0_set_target(struct
>> >> >> cpufreq_policy *policy, unsigned int index) }
>> >> >>
>> >> >>         /* scaling down?  scale voltage after frequency */
>> >> >> -       if (!IS_ERR(cpu_reg) && new_freq < old_freq) {
>> >> >> +       if (!IS_ERR(cpu_reg) &&
>> >> >> +                       (new_freq < old_freq || new_freq <
>> >> >> safe_frequency)) { ret = regulator_set_voltage_tol(cpu_reg,
>> >> >> volt, tol); if (ret) {
>> >> >>                         pr_err("failed to scale voltage down:
>> >> >> %d\n", ret); @@ -116,6 +132,8 @@ static struct cpufreq_driver
>> >> >> cpu0_cpufreq_driver = {
>> >> >>
>> >> >>  static int cpu0_cpufreq_probe(struct platform_device *pdev)
>> >> >>  {
>> >> >> +       const struct property *prop;
>> >> >> +       struct dev_pm_opp *opp;
>> >> >>         struct device_node *np;
>> >> >>         int ret;
>> >> >>
>> >> >> @@ -165,13 +183,24 @@ static int cpu0_cpufreq_probe(struct
>> >> >> platform_device *pdev) goto out_put_node;
>> >> >>         }
>> >> >>
>> >> >> +       prop = of_find_property(np, "safe-opp", NULL);
>> >> >> +       if (prop) {
>> >> >> +               if (prop->value && (prop->length / sizeof(u32))
>> >> >> == 2) {
>> >> >> +                       const __be32 *val;
>> >> >> +                       val = prop->value;
>> >> >> +                       safe_frequency = be32_to_cpup(val++);
>> >> >> +                       safe_voltage = be32_to_cpup(val);
>> >> >> +               } else {
>> >> >> +                       pr_err("invalid safe-opp level
>> >> >> specified\n");
>> >> >> +               }
>> >> >> +       }
>> >> >> +
>> >> >>         of_property_read_u32(np, "voltage-tolerance",
>> >> >> &voltage_tolerance);
>> >> >>
>> >> >>         if (of_property_read_u32(np, "clock-latency",
>> >> >> &transition_latency)) transition_latency = CPUFREQ_ETERNAL;
>> >> >>
>> >> >>         if (!IS_ERR(cpu_reg)) {
>> >> >> -               struct dev_pm_opp *opp;
>> >> >>                 unsigned long min_uV, max_uV;
>> >> >>                 int i;
>> >> >>
>> >> >> --
>> >> >> 1.6.6.rc2
>> >> >>
>> >
>> >
>> >
>> > --
>> > Best regards,
>> >
>> > Lukasz Majewski
>> >
>> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
>>
>> Thanks for your comments Lukasz.
>>
>> Regards,
>> Thomas.
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
