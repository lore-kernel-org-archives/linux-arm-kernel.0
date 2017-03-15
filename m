From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 15 Mar 2017 16:44:37 +0000
Subject: [v3 3/5] coresight: add support for debug module
In-Reply-To: <20170313165600.GB32431@linaro.org>
References: <1488520809-31670-4-git-send-email-leo.yan@linaro.org>
 <011fdac0-59bf-b539-2de3-0b59a41bc922@arm.com>
 <20170309175915.GA964@leoy-linaro>
 <3f27efee-3b63-81fd-eb96-73fd7e6f5e92@arm.com>
 <20170313165600.GB32431@linaro.org>
Message-ID: <516f8989-4dde-2686-d549-0761feb14d1b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/17 16:56, Mathieu Poirier wrote:
> On Fri, Mar 10, 2017 at 02:29:53PM +0000, Suzuki K Poulose wrote:
>>>>> +
>>>>> +	put_online_cpus();
>>>>> +
>>>>> +	if (!debug_count++)
>>>>> +		atomic_notifier_chain_register(&panic_notifier_list,
>>>>> +					       &debug_notifier);
>>>>> +
>>>>
>>>>> +	sprintf(buf, (char *)id->data, drvdata->cpu);
>>>>> +	dev_info(dev, "%s initialized\n", buf);
>>>>
>>>> This could simply be :
>>>> 	dev_info(dev, "Coresight debug-CPU%d initialized\n", drvdata->cpu);
>>>>
>>>> and get rid of the static string and the buffer, see below.
>>
>> Also we need pm_runtime_put() here to balance the pm_runtime_get_ from AMBA
>> device probe.
>
> Good point.
>
>> More on that below.
>>
>>>>
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static struct amba_id debug_ids[] = {
>>>>> +	{       /* Debug for Cortex-A53 */
>>>>> +		.id	= 0x000bbd03,
>>>>> +		.mask	= 0x000fffff,
>>>>
>>>> ...
>>>>
>>>>> +		.data   = "Coresight debug-CPU%d",
>>>>
>>>> I think this is pointless, as the debug area we are interested in is always associated
>>>> with a CPU, we could as well figure out what to print from the drvdata->cpu above.
>>>
>>> I prefer to follow your suggestion for upper two comments; but I'd like
>>> check with Mathieu, due I followed up Mathieu's suggestion to write
>>> current code.
>>
>> Btw, I don't see any PM calls to make sure the power domain (at least the debug domain)
>> is up, which could cause problems with accesses to some of these registers (leave alone the
>> ones in CPU power domain), especially the EDPRSR. We could also do pm_runtime_get on the
>> CPU's power domain, if the CPU is online, before we access the pcsr.
>
> I thought about PM runtime operations a little while back but wondered if it is
> really a good thing to have them around.  When this code is called the system
> has crashed and as such making PM runtimes call isn't a good idea.

You are right. It is not safe to make such calls when we have crashed.
The other side effect is, if we don't have the debug power domain up,
we could possibly hang the system and prevent other registered notifiers
from running, which doesn't sound good either.

>
> One thing we could do is _not_ call pm_runtime_put() at the end of the probe()
> operation.  That way we wouldn't have to mess around with PM runtime operations
> on an unstable system.  This, of course, is costly in terms of power consumption
> but the system is under test/debug anyway.

May be control the behavior via kernel command line ? Something like coresight_debug={on or 1} or
even use the "nohlt" ?

Suzuki
