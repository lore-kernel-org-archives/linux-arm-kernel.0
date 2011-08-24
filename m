From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 24 Aug 2011 11:26:07 +0200
Subject: [PATCH] ARM: ux500: send cpufreq notification for all cpus
In-Reply-To: <4E54B5AC.60608@ti.com>
References: <1314168245-2373-1-git-send-email-vincent.guittot@linaro.org>
	<4E54B5AC.60608@ti.com>
Message-ID: <CAKfTPtDf61SpfaD8vuZePF1Z2=DrSxOSr3_89VVwUMGykBAXNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2011 10:26, Santosh <santosh.shilimkar@ti.com> wrote:
> On Wednesday 24 August 2011 12:14 PM, Vincent Guittot wrote:
>>
>> The same clock is used for all cpus so we must notify the frequency change
>> for each one in order to update the configuration of all twd clockevents.
>>
>> Signed-off-by: Vincent Guittot<vincent.guittot@linaro.org>
>> ---
>> ?drivers/cpufreq/db8500-cpufreq.c | ? ?7 ++++---
>> ?1 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/db8500-cpufreq.c
>> b/drivers/cpufreq/db8500-cpufreq.c
>> index 0d8dd1c..4cb5785 100644
>> --- a/drivers/cpufreq/db8500-cpufreq.c
>> +++ b/drivers/cpufreq/db8500-cpufreq.c
>> @@ -76,13 +76,13 @@ static int db8500_cpufreq_target(struct cpufreq_policy
>> *policy,
>>
>> ? ? ? ?freqs.old = policy->cur;
>> ? ? ? ?freqs.new = freq_table[idx].frequency;
>> - ? ? ? freqs.cpu = policy->cpu;
>>
>> ? ? ? ?if (freqs.old == freqs.new)
>> ? ? ? ? ? ? ? ?return 0;
>>
>> ? ? ? ?/* pre-change notification */
>> - ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>> + ? ? ? for_each_online_cpu(freqs.cpu)
>> + ? ? ? ? ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>
> Blind notfier on all online CPU's will race. Take a example whete CPU
> is marked online but not yet registered to CPUFREQ. I have seen such a
> race in OMAP and fixed that using the policy->cpus field.
>

You're right, I'm going to use policy->cpus instead

> Regards
> Santosh
>
>
