From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 03 Dec 2015 10:45:05 -0800
Subject: arm64 sched_clock cpu accounting
In-Reply-To: <565F81D2.3060401@samsung.com>
References: <564CD5A7.8000007@samsung.com> <564D31D3.5040207@samsung.com>
 <20151202180741.GR18376@cbox> <565F81D2.3060401@samsung.com>
Message-ID: <56608DB1.6010401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 12/2/2015 3:42 PM, Mario Smarduch wrote:
> 
> 
> On 12/2/2015 10:07 AM, Christoffer Dall wrote:
>> Hi Mario,
>>
>> On Wed, Nov 18, 2015 at 06:20:03PM -0800, Mario Smarduch wrote:
>>> Also with tick accounting enabled, and periodic timer HZ set to 1000 no irq time
>>> is reported. That's with running a ping flood - 1200 int/s, not sure why
>>> wouldn't any irq time be reported? The other two modes report irq time as expected.
>>>
>>> On 11/18/2015 11:46 AM, Mario Smarduch wrote:
>>>> Hello,
>>>>   I noticed sched clock accounting can be enabled when arch-timer is
>>>> initialized. But arm64 doesn't appear to have 'HAVE_IRQ_TIME_ACCOUNTING'
>>>> selected (as of mainline 4.4-rc1) and IRQ_TIME_ACCOUNTING can't be selected.
>>>> After adding it to arch/arm64/Kconfig, option appears to work fine. Depending on
>>>> need all accounting options are fine, but irq time accounting appears to be most
>>>> preferable.
>>>>
>>>> Any thoughts? Is it fine to enable it?
>>>>
>> Is any of this related to KVM?
> 
> Indirectly, given the guest should yield same results. To be on the safe side I
> ran the guest in all combinations (7) to confirm that's the case.
> 
> Also verified that guest time on host appears fine in all these configurations.
> It takes extra effort to get the guest time as opposed to other modes.
> 
> - Mario
>>
>> -Christoffer
>>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 

While on this topic, one use case for RT like apps is run the host in full sched
clock accounting mode/NO_HZ_FULL and guest in IRQ time accounting mode/NO_HZ_IDLE.

This should make sense for a control plane, gateway guest (using normal IP
stack, timers, ..) there you have a lot of transitions between run modes. ANd
irq, softirq accounting matters.

The host on the other side should be fine running a vCPU in full sched clock
mode, you don't expect to many transitions from the vCPU, and less need for
irq/softirq accounting if any.

I recall you raised the point of run modes when you fixed guest time accounting,
but I didn't have a good use case back then for your question.

- Mario.
