From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 Jun 2014 15:04:04 +0100
Subject: [PATCH] arm64: do not force irq affinity setting
In-Reply-To: <1403790015.20406.16.camel@pgaikwad-dt2>
References: <1403765395-16978-1-git-send-email-pgaikwad@nvidia.com>	
 <20140626102055.GD376@arm.com> <1403784024.20406.4.camel@pgaikwad-dt2>	
 <20140626131105.GF376@arm.com> <1403790015.20406.16.camel@pgaikwad-dt2>
Message-ID: <53AC2854.10107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26/06/14 14:40, Prashant Gaikwad wrote:
> On Thu, 2014-06-26 at 18:41 +0530, Will Deacon wrote:
>> On Thu, Jun 26, 2014 at 01:00:24PM +0100, Prashant Gaikwad wrote:
>>> On Thu, 2014-06-26 at 15:50 +0530, Will Deacon wrote:
>>>> On Thu, Jun 26, 2014 at 07:49:55AM +0100, Prashant Gaikwad wrote:
>>>>> Unconditional copying cpu_online_mask to affinity
>>>>> may result in migrating affinity to wrong CPU.
>>>>
>>>> We have a bug, but I don't follow your reasoning.
>>>>
>>>>> For example, IRQ 5 affinity mask contains CPU 4-7,
>>>>
>>>> Ok, so d->affinity is 0xf0...
>>>>
>>>>> it was affined to CPU4 and CPU 0-7 are online.
>>>>
>>>> ...and cpu_online_mask is 0xff.
>>>>
>>>>> Now if we hot-unplug CPU4 then with current
>>>>> implementation affinity mask will contain
>>>>> CPU 0-3,5-7 and IRQ 5 will be affined to CPU0.
>>>>
>>>> cpumask_any_and(affinity, cpu_online_mask) will give return < nr_cpu_ids
>>>> since there is an intersection of 0xf0. That means ret is false.
>>>>
>>>> The bug is that we then do affinity = cpu_online_mask; unconditionally,
>>>> but we *won't* do the cpumask_copy, since ret is false.
>>>>
>>>
>>> We do not copy but the affinity mask passed to irq_set_affinity function
>>> is nothing but cpu_online_mask. So in GIC it will set affinity to CPU0.
>>
>> Exactly, but your proposed patch changed more than that.
>>
>
> I am changing the force flag to false. That is because after I fix this
> behavior we have another bug where the IRQ affinity is set to offline
> CPU.
>

That's correct, it's the original issue I saw and fixed incorrectly which
triggered the bug you have now.

The main reason to retain the force flag as true is that the implementation is
irqchip specific. GIC implements the way you explained but what if some other
irqchip implementation has something different.

I believe that's the reason why Russell wants to get feedback from tglx.

Regards,
Sudeep
