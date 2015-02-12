From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 12 Feb 2015 15:22:07 +0800
Subject: [PATCH 0/7] OPP: Introduce OPP bindings V2 and supporting code
In-Reply-To: <20150212005220.GG11190@codeaurora.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
 <20150212005220.GG11190@codeaurora.org>
Message-ID: <CAKohponaLt51hiHd=uTocK_fPPwRDgkse5wc_PGG5tFQNnvfAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2015 at 08:52, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Here's some feedback on how we can't use OPPs (and OPPs in DT) on
> qcom platforms.
>
> On these platforms the OPPs are not always frequency voltage
> pairs. Sometimes they're a frequency voltage voltage triplet, or

So, making opp-microvolt an array of <target/min/max>, values should fix this?
Do we also need a opp-microvolt-names array as well? or can we reused
similar ones from the CPU node where regulator are defined.

> frequency voltage current triplet. I know that the OPP framework

so we do need opp-milliamp here..

> in the kernel doesn't support more than frequency voltage pairs,
> but that doesn't mean it can't in the future, and if it needs to
> do so the DT bindings shouldn't need a v3 revision.

Sure.

> Furthermore, we have a large number of OPP sets that apply to
> different speed bins and silicon characteristics of the SoC. In
> our systems we read some efuses (an eeprom of sorts) that tell us
> to use a certain set of OPPs because the silicon is so fast or
> has these certain characteristics. The bootloader is *not*
> reading these fuses and populating OPPs in DT. So right now we
> just put all these custom OPPish tables in DT and then pick the
> right one based on a node name match constructed from the bits we
> read in the efuses. How can we express this in DT with these
> bindings?

What about keeping things as is in DT and disabling the OPPs which
you don't support at boot? And only keep enabled the set of OPPs
that you want to use based on these efuses ?

> For example, on msm8974 we have a frequency voltage current
> triplet and there are 18 different sets of these triplets, each
> with 23 triplets per set. We could encode all of these tables as
> a bunch of nodes with compatible = "operating-points-v2" but how
> do we pick the right one to assign and populate for the CPU
> devices? Do we need some sort of opp-fuse-map table that encodes
> the information we want somewhere?

Probably add all these groups in a single OPP descriptor and
enable/disable them at runtime..

>  qcom,opp-fuse-map = <speedX binY versionZ &oppN>,
>                      ...
>
> but where do we put it? In the cpus node? Or maybe we can keep
> doing the node name matching? That would required dropping the
> oppN convention.

Probably this might not be required then ?

> Or take msm8916 as another example. On this device the voltage
> for a few frequencies comes from the efuses and then we
> interpolate the rest of the frequency voltage pairs. The speed
> bins are picked from another set of efuses so we can do the
> interpolation. Unfortunately we don't encode the frequency in the
> fuses, so we rely on a handful of tables being defined somewhere
> so that we know speed bin 0 means this set of frequencies and
> speed bin 1 means this set of frequencies. How do we encode this
> in DT?  Should we have the frequencies as OPPs and leave the
> voltage part out, filling it in at runtime based on what we read

Maybe yes.

> out of the efuses? I assume it's desirable to have the frequency
> tables in DT but we could also have them in the driver and if we
> did that there wouldn't be any shared-opp property to set and
> have the cpufreq-dt driver use to figure out clock sharing.

Probably better keep them in DT. But for platforms with dynamic OPPs
only, we will surely provide some API to make OPPs shared at runtime
too..

> Also sometimes we need to correlate OPPs between each other. For
> example on msm8960/apq8064 if the CPU is running at a frequency
> and voltage, the L2 needs to be running at another frequency,
> voltage, and voltage (triplet). The L2 is in two power domains
> but it only has one clock. Can/should this be expressed in DT? It

Not sure.

> certainly seems that it's at least easier to add it on as a
> feature because OPPs are nodes instead of an array. But we need

It wouldn't be a great idea to make these nodes too large just to support
some corner cases, and we better try to find the best way out. But if
we need it this way, we need it this way :)

> to make sure we can support multiple regulators somehow, either
> through correlated OPPs and multiple OPPs for a single device or
> by being able to say opp-0-microvolt, opp-1-microvolt. I would

an array would be better.

> guess something similar could happen if there were two clocks and
> one regulator although I've never seen such a scenario in
> practice.

Isn't this common? A single regulator voltage supporting multiple clock
rates? Or did I misunderstood it :)

We can have separate OPP nodes in this case.
