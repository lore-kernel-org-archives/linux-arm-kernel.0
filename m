From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 7 Aug 2017 13:56:20 +0100
Subject: [PATCH v3] irqchip/tango: Don't use incorrect irq_mask_ack
 callback
In-Reply-To: <fb868111-bcff-9a12-70db-a820d3bbffd0@sigmadesigns.com>
References: <20170719190734.18566-1-opendmb@gmail.com>
 <20170719190734.18566-3-opendmb@gmail.com>
 <7a51555f-8191-9ebd-1f30-7c20f6db9d3f@sigmadesigns.com>
 <8d29fec9-35b8-c33b-3091-3e9a51c99ed7@gmail.com>
 <dddc01e3-b4f0-1f94-db6a-e3d4b31e6f4d@sigmadesigns.com>
 <yw1xfudkodvv.fsf@mansr.com>
 <6f0092f7-692f-4a15-1d95-40f4e59c8585@sigmadesigns.com>
 <yw1xbmo8odan.fsf@mansr.com> <3b858e14-0da1-d4aa-eb84-f136ece8c2a6@gmail.com>
 <yw1x4ltzm2ok.fsf@mansr.com> <48734beb-0e6b-3a8f-ebf4-b1cec63322e5@gmail.com>
 <fb868111-bcff-9a12-70db-a820d3bbffd0@sigmadesigns.com>
Message-ID: <ee3119ec-75e9-376d-f1f1-630a9a17c660@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/07/17 15:06, Marc Gonzalez wrote:
> On 27/07/2017 20:17, Florian Fainelli wrote:
> 
>> On 07/26/2017 12:13 PM, M?ns Rullg?rd wrote:
>>
>>> Florian Fainelli writes:
>>>
>>>> On 07/25/2017 06:29 AM, M?ns Rullg?rd wrote:
>>>>
>>>>> Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:
>>>>>
>>>>>> On 25/07/2017 15:16, M?ns Rullg?rd wrote:
>>>>>>
>>>>>>> What happened to the patch adding the proper combined function?
>>>>>>
>>>>>> It appears you're not CCed on v2.
>>>>>>
>>>>>> https://patchwork.kernel.org/patch/9859799/
>>>>>>
>>>>>> Doug wrote:
>>>>>>> Yes, you understand correctly.  The irq_mask_ack method is entirely
>>>>>>> optional and I assume that is why this issue went undetected for so
>>>>>>> long; however, it is slightly more efficient to combine the functions
>>>>>>> (even if the ack is unnecessary) which is why I chose to do so for my
>>>>>>> changes to the irqchip-brcmstb-l2 driver where I first discovered this
>>>>>>> issue.  How much value the improved efficiency has is certainly
>>>>>>> debatable, but interrupt handling is one area where people might care
>>>>>>> about such a small difference.  As the irqchip-tango driver maintainer
>>>>>>> you are welcome to decide whether or not the irq_mask_ack method makes
>>>>>>> sense to you.
>>>>>>
>>>>>> My preference goes to leaving the irq_mask_ack callback undefined,
>>>>>> and let the irqchip framework use irq_mask and irq_ack instead.
>>>>>
>>>>> Why would you prefer the less efficient way?
>>>>>
>>>>
>>>> Same question here, that does not really make sense to me.
>>>>
>>>> The whole point of this patch series is to have a set of efficient and
>>>> bugfree (or nearly) helper functions that drivers can rely on, are you
>>>> saying that somehow using irq_mask_and_ack is exposing a bug in the
>>>> tango irqchip driver and using the separate functions does not expose
>>>> this bug?
>>>
>>> There is currently a bug in that the function used doesn't do what its
>>> name implies which can't be good.  Using the separate mask and ack
>>> functions obviously works, but combining them saves a lock/unlock
>>> sequence.  The correct combined function has already been written, so I
>>> see no reason not to use it.
>>
>> Marc/Mason, are you intending to get this patch accepted in order to
>> provide a quick bugfix targeting earlier kernels with the tango irqchip
>> driver or is this how you think the correct fix for the tango irqchip
>> driver is as opposed to using Doug's fix?
> 
> Hello Florian,
> 
> I am extremely grateful for you and Doug bringing the defect to
> my attention, as it was indeed causing an issue which I had not
> found the time to investigate.
> 
> The reason I proposed an alternate patch is that
> 1) Doug didn't seem to mind, 2) simpler code leads to fewer bugs
> and less maintenance IME, and 3) I didn't see many drivers using
> the irq_mask_ack() callback (9 out of 86) with a few misusing it,
> by defining irq_mask = irq_mask_ack.
> 
> As you point out, my patch might be slightly easier to backport
> than Doug's (TBH, I hadn't considered that aspect until you
> mentioned it).
> 
> Has anyone ever quantified the performance improvement of
> mask_ack over mask + ack?

Aren't you the one who is in position of measuring this effect on the
actual HW that uses this?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
