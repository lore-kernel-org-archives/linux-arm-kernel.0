From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 25 Feb 2013 23:50:23 +0100
Subject: [PATCH 2/2][RFC] time : set broadcast irq affinity
In-Reply-To: <20130222095530.377fd218@chromoly>
References: <5123C299.3080005@linaro.org>
 <1361484083-5906-1-git-send-email-daniel.lezcano@linaro.org>
 <1361484083-5906-2-git-send-email-daniel.lezcano@linaro.org>
 <20130222095530.377fd218@chromoly>
Message-ID: <512BEAAF.1070500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2013 06:55 PM, Jacob Pan wrote:
> On Thu, 21 Feb 2013 23:01:23 +0100
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 
>> +/*
>> + * Set broadcast interrupt affinity
>> + */
>> +static void tick_broadcast_set_affinity(struct clock_event_device
>> *bc, int cpu) +{
>> +	struct cpumask cpumask;
>> +
>> +	if (!(bc->features & CLOCK_EVT_FEAT_DYNIRQ))
>> +		return;
>> +
>> +	cpumask_clear(&cpumask);
>> +	cpumask_set_cpu(cpu, &cpumask);
>> +	irq_set_affinity(bc->irq, &cpumask);
> would it be more efficient to keep track of the current bc->irq affinity
> via cpumask then set it only if it is different?

Do you mean a cpumask static variable ? and something like:

if (!cpumask_test_cpu(cpu, &affinitymask)) {
	cpumask_set_cpu(cpu, &affinitymask);
	irq_set_affinity(bc->irq, &affinitymask)
}




-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
