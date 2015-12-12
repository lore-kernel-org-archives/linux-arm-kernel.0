From: dave.long@linaro.org (David Long)
Date: Sat, 12 Dec 2015 15:13:21 -0500
Subject: [RFC] kprobe'ing conditionally executed instructions
In-Reply-To: <566C6C11.1030600@redhat.com>
References: <566A5997.9020908@linaro.org> <566AF556.6050704@redhat.com>
 <566BB6FE.2050005@linaro.org> <566C6C11.1030600@redhat.com>
Message-ID: <566C7FE1.9050407@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2015 01:48 PM, William Cohen wrote:
> On 12/12/2015 12:56 AM, David Long wrote:
>> On 12/11/2015 11:09 AM, William Cohen wrote:
>>> On 12/11/2015 12:05 AM, David Long wrote:
>>>> There is a moderate amount of code already in kprobes on ARM and the current ARMv8 patch to deal with conditional execution of instructions. One aspect of how this is handled is that instructions that fail their predicate and are not (technically) executed are also not treated as a hit kprobe. Steve Capper has suggested that the probe handling should still take place because we stepped through the instruction even if it was effectively a nop.  This would be a significant change in how it currently works on 32-bit ARM, and a change in the patch for ARMv8 (although it's not likely to be much of a change in the kernel code).
>>>>
>>>> I need input on this.  Do people have opinions?
>>>>
>>>> -dl
>>>>
>>>
>>> Hi Dave,
>>>
>>> Conditionally executing the kprobes would violate the assumptions made for perf and systemtap collecting data. Even if the instruction is predicated and treated as a NOP it should still reliably trigger the kprobe.  However, for efficiency the simulation/emulation/single-step of the instruction could be skipped if the instruction is known to have no change on the machine state other than changing the program counter.
>>>
>>> -Will Cohen
>>>
>>
>> I wonder if this might explain some systemtap failures.
>>
>> -dl
>>
>
> Hi Dave,
>
> It is possible that some of the kprobes not triggering would cause testsuite failures, but I don't have a specific test to point to this is happening.
>
> How much of change would it be to fix the kprobes to get the correct behavior.  It might be easiest to fix it and compare the test results to find possible candidates where this problem occurs.
>
> -Will
>

I think it's a very simple change.  I will come up with something for 
you to test shortly. It sounds like we may need the change permanently 
anyway, although clearly there is not a solid consensus yet.

I would think this would impact 32-bit behavior much more than 64-bit. 
I can see about producing something for testing that too.

-dl
