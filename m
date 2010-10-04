From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon, 4 Oct 2010 10:43:56 +0300
Subject: [PATCH] cpufreq for freescale mx51
In-Reply-To: <AANLkTikoMjEcFR9VS-piQP3QK65p36-YDyzsK1p5nPFh@mail.gmail.com>
References: <1285738417-1638-1-git-send-email-yong.shen@linaro.org>
	<20100930104817.GC2526@matterhorn.lan>
	<AANLkTikoMjEcFR9VS-piQP3QK65p36-YDyzsK1p5nPFh@mail.gmail.com>
Message-ID: <AANLkTimpwE_DvWr8=8wWFc90mbx6ZNxh6vTUR3abHB7+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More comments.

On Fri, Oct 1, 2010 at 7:06 AM, Yong Shen <yong.shen@linaro.org> wrote:
> Hi Amit,
>
> Please see my feedback embedded.
>
> On Thu, Sep 30, 2010 at 6:48 PM, Amit Kucheria <amit.kucheria@linaro.org>
> wrote:

[snip]

>> > +static int mxc_set_target(struct cpufreq_policy *policy,
>> > + ? ? ? ? ? ? ? ? ? ? ? unsigned int target_freq, unsigned int relation)
>> > +{
>> > + ? ? struct cpufreq_freqs freqs;
>> > + ? ? int freq_Hz;
>> > + ? ? int ret = 0;
>> > +
>> > + ? ? if (cpufreq_suspended) {
>> > + ? ? ? ? ? ? target_freq = clk_get_rate(cpu_clk) / 1000;
>> > + ? ? ? ? ? ? freq_Hz = calc_frequency_khz(target_freq, relation) *
>> > 1000;
>> > + ? ? ? ? ? ? if (freq_Hz == arm_lpm_clk)
>> > + ? ? ? ? ? ? ? ? ? ? freqs.old = cpu_wp_tbl[cpu_wp_nr - 2].cpu_rate /
>> > 1000;
>> > + ? ? ? ? ? ? else
>> > + ? ? ? ? ? ? ? ? ? ? freqs.old = arm_lpm_clk / 1000;
>> > +
>> > + ? ? ? ? ? ? freqs.new = freq_Hz / 1000;
>> > + ? ? ? ? ? ? freqs.cpu = 0;
>> > + ? ? ? ? ? ? freqs.flags = 0;
>> > + ? ? ? ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>> > + ? ? ? ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>> > + ? ? ? ? ? ? return ret;
>> > + ? ? }
>> > + ? ? /*
>> > + ? ? ?* Some governors do not respects CPU and policy lower limits
>> > + ? ? ?* which leads to bad things (division by zero etc), ensure
>> > + ? ? ?* that such things do not happen.
>> > + ? ? ?*/
>>
>> Isn't that a bug in the governor? Can you explain a bit?
>
> Yong: the original driver writer might have concern that some governor
> implementations will not care about the low limit suggested by cpu policy,
> therefore it is a change to correct them.

Could you confirm if this is still the case, and if not, get rid of
this code/comment?

>> > + ? ? if (target_freq < policy->cpuinfo.min_freq)
>> > + ? ? ? ? ? ? target_freq = policy->cpuinfo.min_freq;
>> > +
>> > + ? ? if (target_freq < policy->min)
>> > + ? ? ? ? ? ? target_freq = policy->min;
>> > +
>> > + ? ? freq_Hz = calc_frequency_khz(target_freq, relation) * 1000;
>> > +

[snip]

>> > + ? ? /* Set the current working point. */
>> > + ? ? cpu_wp_tbl = get_cpu_wp(&cpu_wp_nr);
>> > +
>> > + ? ? cpu_freq_khz_min = cpu_wp_tbl[0].cpu_rate / 1000;
>> > + ? ? cpu_freq_khz_max = cpu_wp_tbl[0].cpu_rate / 1000;
>> > +
>> > + ? ? for (i = 0; i < cpu_wp_nr; i++) {
>> > + ? ? ? ? ? ? imx_freq_table[cpu_wp_nr - 1 - i].index = cpu_wp_nr - i;
>>
>> cpu_wp_nr = 2 here
>>
>> 1st iteration of for loop:
>> ? ?imx_freq_table[2 - 1 - 0].index = 2 - 0
>> so, imx_freq_table[1].index = 2
>>
>> 2nd iteration:
>> ? ?imx_freq_table[2 - 1 - 1].index = 2 - 1
>> ? ?imx_freq_table[0].index = 1
>>
>> So you're trying to reverse the table order? Why not just sort the table
>> date
>> in the way you want and add a comment on the top to keep it sorted.
>
> Yong: my understanding is that the freq table defined in another file is
> sorted in descending order, so the writer tends to make imx_freq_table in a
> descending order.

Just change the order of the wp_table instead of this confusing math
to re-sort it. Look at other cpufreq rate tables in the kernel.

>> > + ? ? ? ? ? ? imx_freq_table[cpu_wp_nr - 1 - i].frequency =
>> > + ? ? ? ? ? ? ? ? cpu_wp_tbl[i].cpu_rate / 1000;
>> > +
>> > + ? ? ? ? ? ? if ((cpu_wp_tbl[i].cpu_rate / 1000) < cpu_freq_khz_min)
>> > + ? ? ? ? ? ? ? ? ? ? cpu_freq_khz_min = cpu_wp_tbl[i].cpu_rate / 1000;
>> > +
