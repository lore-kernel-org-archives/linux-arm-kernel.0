From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 1 Mar 2016 11:35:09 -0800
Subject: [RFC v2 07/12] PM / cpu_domains: Add PM Domain governor for CPUs
In-Reply-To: <20160301193220.GN1440@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-8-git-send-email-lina.iyer@linaro.org>
 <20160226193338.GY28849@codeaurora.org> <20160301193220.GN1440@linaro.org>
Message-ID: <56D5EEED.5060203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2016 11:32 AM, Lina Iyer wrote:
> On Fri, Feb 26 2016 at 12:33 -0700, Stephen Boyd wrote:
>> On 02/12, Lina Iyer wrote:
>>> @@ -52,6 +55,76 @@ struct cpu_pm_domain *to_cpu_pd(struct
>>> generic_pm_domain *d)
>>>      return res;
>>>  }
>>>
>>> +static bool cpu_pd_down_ok(struct dev_pm_domain *pd)
>>> +{
>>> +    struct generic_pm_domain *genpd = pd_to_genpd(pd);
>>> +    struct cpu_pm_domain *cpu_pd = to_cpu_pd(genpd);
>>> +    int qos = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
>>> +    u64 sleep_ns;
>>> +    ktime_t earliest, next_wakeup;
>>> +    int cpu;
>>> +    int i;
>>> +
>>> +    /* Reset the last set genpd state, default to index 0 */
>>> +    genpd->state_idx = 0;
>>> +
>>> +    /* We dont want to power down, if QoS is 0 */
>>> +    if (!qos)
>>> +        return false;
>>> +
>>> +    /*
>>> +     * Find the sleep time for the cluster.
>>> +     * The time between now and the first wake up of any CPU that
>>> +     * are in this domain hierarchy is the time available for the
>>> +     * domain to be idle.
>>> +     */
>>> +    earliest = ktime_set(KTIME_SEC_MAX, 0);
>>> +    for_each_cpu_and(cpu, cpu_pd->cpus, cpu_online_mask) {
>>
>> We're not worried about hotplug happening in parallel because
>> preemption is disabled here?
>>
> Nope. Hotplug on the same domain or in its hierarchy will be waiting on
> the domain lock to released before becoming online. Any other domain is
> not of concern for this domain governor.
>
> If a core was hotplugged out while this is happening, then we may risk
> making an premature wake up decision, which would happen either way if
> we lock hotplug here.

Ok please make this into a comment in the code.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
