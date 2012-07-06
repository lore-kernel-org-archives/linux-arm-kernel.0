From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 06 Jul 2012 14:04:30 -0700
Subject: [PATCH] ARM: smp: Fix suspicious RCU originating from cpu_die()
In-Reply-To: <20120706203005.GF31508@n2100.arm.linux.org.uk>
References: <1341531958-31721-1-git-send-email-sboyd@codeaurora.org>
 <20120706002404.GJ2522@linux.vnet.ibm.com> <4FF730CD.7050907@codeaurora.org>
 <20120706203005.GF31508@n2100.arm.linux.org.uk>
Message-ID: <4FF752DE.7000104@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/12 13:30, Russell King - ARM Linux wrote:
> On Fri, Jul 06, 2012 at 11:39:09AM -0700, Stephen Boyd wrote:
>> On 07/05/12 17:24, Paul E. McKenney wrote:
>>> On Thu, Jul 05, 2012 at 04:45:58PM -0700, Stephen Boyd wrote:
>>>> @@ -179,7 +184,7 @@ void __ref cpu_die(void)
>>>>  	mb();
>>>>
>>>>  	/* Tell __cpu_die() that this CPU is now safe to dispose of */
>>>> -	complete(&cpu_died);
>>>> +	__this_cpu_write(cpu_state, CPU_DEAD);
>>> Or you could do something like:
>>>
>>> 	RCU_NONIDLE(complete(&cpu_died));
>>>
>>> This would tell RCU that it needed to pay attention to this CPU for
>>> the duration of the "complete()" function call despite the CPU's being
>>> idle.  And might allow you to dispense with the rest of the patch.
>> Great! I like that more since we get to keep the completion mechanism
>> instead of a busy wait.
>>
>> Russell, which one would you prefer? Here's the other version
> I think I prefer the version below.
>

Ok. I put it in the patch tracker.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
