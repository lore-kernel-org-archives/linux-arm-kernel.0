From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 27 Nov 2012 09:28:01 +0530
Subject: [PATCH] cpufreq: SPEAr: Add CPUFreq driver
In-Reply-To: <20121127040135.GB27305@S2100-06.ap.freescale.net>
References: <7ec0e3f4b81b70f3def4257e6b9781efd4c7a3d2.1353785862.git.viresh.kumar@linaro.org>
 <20121127040135.GB27305@S2100-06.ap.freescale.net>
Message-ID: <CAKohpomSAogQVeBQ8HaWwwoTVCsMha5d_1Wid6N3t5SnVZTc=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Thanks for feedback.

On 27 November 2012 09:31, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Sun, Nov 25, 2012 at 01:09:28AM +0530, Viresh Kumar wrote:
>> +cpufreq {
>> +     compatible = "st,cpufreq-spear";
>
> I do not think we need a "cpufreq" node, as we already have node for
> cpu to contain these.

Hmm.. Yes, can be done.

>> +     cpufreq_tbl = < 166000
>> +                     200000
>> +                     250000
>> +                     300000
>> +                     400000
>> +                     500000
>> +                     600000 >;
>
> It's a little bit unusual that cpu runs such a freq range
> (166 ~ 600 MHz) at a fixed voltage.  You really have no way
> to scale voltage?

AFAIK, there is no voltage scaling.

@Shiraz/Deepak: Can you confirm?

>> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
>> +static int spear_cpufreq_target(struct cpufreq_policy *policy,
>> +             unsigned int target_freq, unsigned int relation)
>> +{
>> +     struct cpufreq_freqs freqs;
>> +     unsigned long newfreq;
>> +     struct clk *srcclk;
>> +     int index, ret, mult = 1;
>> +
>> +     if (cpufreq_frequency_table_target(policy, spear_cpufreq.freq_tbl,
>> +                             target_freq, relation, &index))
>> +             return -EINVAL;
>> +
>> +     freqs.cpu = policy->cpu;
>> +     freqs.old = spear_cpufreq_get(0);
>> +
>> +     newfreq = spear_cpufreq.freq_tbl[index].frequency * 1000;
>> +     if (of_machine_is_compatible("st,spear1340")) {
>> +             /*
>> +              * SPEAr1340 is special in the sense that due to the possibility
>> +              * of multiple clock sources for cpu clk's parent we can have
>> +              * different clock source for different frequency of cpu clk.
>> +              * Hence we need to choose one from amongst these possible clock
>> +              * sources.
>> +              */
>> +             srcclk = spear1340_cpu_get_possible_parent(newfreq);
>
> From what I can see, if spear1340 clock driver can handle such special
> setup of clk, the driver will be nothing SPEAr specific and can probably
> be saved by just using cpufreq-cpu0.

There are few more patches we have for this driver, which are depending
on some mach stuff to be pushed first. We need to program system controller
too for make cpu clock transitions more stable. They should come after some
time.

--
viresh
