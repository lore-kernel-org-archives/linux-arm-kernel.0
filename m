From: james.morse@arm.com (James Morse)
Date: Wed, 01 Nov 2017 15:59:52 +0000
Subject: [PATCH v4 11/13] firmware: arm_sdei: add support for CPU private
 events
In-Reply-To: <59EF798A.9000609@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
 <20171017174432.1684-12-james.morse@arm.com> <20171018171959.GJ21820@arm.com>
 <59EF798A.9000609@arm.com>
Message-ID: <59F9EF78.8090107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 24/10/17 18:34, James Morse wrote:
> On 18/10/17 18:19, Will Deacon wrote:
>> On Tue, Oct 17, 2017 at 06:44:30PM +0100, James Morse wrote:
>>> Private SDE events are per-cpu, and need to be registered and enabled
>>> on each CPU.
>>>
>>> Hide this detail from the caller by adapting our {,un}register and
>>> {en,dis}able calls to send an IPI to each CPU if the event is private.
>>>
>>> CPU private events are unregistered when the CPU is powered-off, and
>>> re-registered when the CPU is brought back online. This saves bringing
>>> secondary cores back online to call private_reset() on shutdown, kexec
>>> and resume from hibernate.
> 
>>> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
>>> index 28e4c4cbb16d..5598d9ba8b5d 100644
>>> --- a/drivers/firmware/arm_sdei.c
>>> +++ b/drivers/firmware/arm_sdei.c
>>> @@ -610,6 +813,7 @@ static int sdei_device_freeze(struct device *dev)
>>>  {
>>>  	int err;
>>>  
>>> +	frozen = true;
>>>  	err = sdei_event_unregister_all();
> 
>> Are the release semantics from spin_unlock in sdei_event_unregister_all
>> sufficient for the ordering guarantees you need?
> 
> ... ordering ...
> 
> The hotplug notifiers don't touch that lock, so at the first level: no.
> 
> It looks like I was relying on the cpu-hotplug code using stop-machine for its
> work, and the spinlocks changing the pre-empt count for this to work. Which is
> not something I want to debug if it changes!
> 
> I'll post a patch changing this bool to a more sensible atomic type.

Here I show my ignorance: atomic_t didn't do what I thought. But I do take the
spinlock inside the hotplug callback, so I'll move the variable in there.


Thanks,

James
