From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 26 Nov 2013 10:18:07 -0500
Subject: [RFC] ARM Generic Timer + Interaction with WFI on Cortex-A15
In-Reply-To: <20131126122801.GB12304@e102568-lin.cambridge.arm.com>
References: <528DBD0C.6040203@gmail.com>
 <20131121120025.GC31695@e102568-lin.cambridge.arm.com>
 <529442BB.1000006@gmail.com>
 <20131126101041.GA12304@e102568-lin.cambridge.arm.com>
 <52947FFA.90504@gmail.com>
 <20131126122801.GB12304@e102568-lin.cambridge.arm.com>
Message-ID: <5294BBAF.9020103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 November 2013 07:28 AM, Lorenzo Pieralisi wrote:
> [adding Mark in CC to make him aware of this thread]
> 
> On Tue, Nov 26, 2013 at 11:03:22AM +0000, Marc C wrote:
>> Hi Lorenzo,
>>
>>> So what's the problem then ? Just avoid adding CPUIDLE_FLAG_TIMER_STOP
>>> to the C-state flags and you are all set, or I am missing something
>>> here ?
>>
>> The C3STOP flag prevents the kernel from using the timer as a
>> high-resolution clock source. There are some patches that remove the
>> C3STOP flag [1] in order for the timer to function for use with hrtimer.
>> I think something similar could be manageable as a DT property on the
>> armv7-timer binding.
>>
>>> Yes I do object. Timer binding is global in the DT and do not want to
>>> override the flag for all local timers when, as I mentioned, A15
>>> behaviour is just an exception. If you really need that, please write
>>> an idle driver that does not enter broadcast mode on C-state entry
>>> (see above).
>>
>> So what you're saying is that you'll outright disapprove of any patch
>> that would otherwise help ensure the kernel would run on any/all
>> variations of armv7-timer? I would imagine that we'd want things to be
>> more inclusive, and since there are quite a few SoCs with the timer that
>> behave in this manner.
>>
>> I'm not trying to be a thorn in your side. I just want to make sure
>> everyone that has an implementation similar to ours is covered, too.
> 
> Ok, I think I got it now. The platform in question has just local timers
> (no global timer), and they are not shut down on idle entry, actually
> the platform has no PM capability at all (apart from wfi).
> 
> Given that arch timers are C3STOP, kernel does not enter hr mode.
> 
> Problem is more complex than I thought and deserves some time to sort it
> out properly, I am also working on C-states binding for ARM, I will take
> this into account.
> 
Indeed its worth looking at considering power domain partitioning and PM
support on SOCs dictate the C3-STOP presence.

Regards,
Santosh
