From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 23 Dec 2014 08:45:52 +0000
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <54989F43.5070100@gmail.com>
References: <54345FA7.9030606@gmail.com> <54370A1E.6070707@gmail.com>
 <20141009223244.GJ5182@n2100.arm.linux.org.uk>
 <1879331.AWtSrdvUyc@wuerfel>
 <20141010100146.GM5182@n2100.arm.linux.org.uk>
 <54989F43.5070100@gmail.com>
Message-ID: <CAKv+Gu9jHjbLmA0mBXBm_TA3N1aDqUqTHcXz=27dC5WXS8rtmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 December 2014 at 22:46, Lanchon <lanchon@gmail.com> wrote:
>
> On 10/10/2014 07:01 AM, Russell King - ARM Linux wrote:
>>
>> On Fri, Oct 10, 2014 at 11:45:34AM +0200, Arnd Bergmann wrote:
>>>
>>> On Thursday 09 October 2014 23:32:44 Russell King - ARM Linux wrote:
>>>>>
>>>>> there is a new piece of information:
>>>>> the FP corruption seems to only happen in these android devices if the
>>>>> display is off. the charger may be connected or not, but if the display
>>>>> is on, the corruption won't happen.
>>>>>
>>>>> i wonder if the kernel could be turning off the FPU and then back on
>>>>> without saving the FPU state. i would think corruption would be seen
>>>>> more often then.
>>>>
>>>> No.  We don't "turn off" the VFP.  We disable and enable access to VFP
>>>> via the coprocessor access register.  If the VFP access is disabled and
>>>> then re-enabled, all state is preserved.
>>>>
>>>> The only time which state would be lost is if (eg) we hot-unplug the
>>>> entire CPU, but that first requires a context switch which implies that
>>>> the state will already be saved.
>>>
>>> Could the problem be caused by a bug in the exynos CPU suspend/resume
>>> path then? E.g. if we go to sleep with VFP access disabled but it
>>> comes back with VFP access enabled (or vice versa) that could lead
>>> to the wrong register state being seen by the user space application.
>>
>> Well, an interesting test would be to save out the entire VFP state
>> both before and after the pread64 call, and then inspect that to
>> determine whether it is a single register or multiple registers
>> which are being corrupted.
>>
>> However, looking at the mainline code, we do the right thing with the
>> CPU PM infrastructure, and that is called appropriately by the exynos
>> CPU idle driver.
>>
>> So, another possible test for Lanchon would be to see whether disabling
>> CPU idle support fixes the problem.
>>
>
> hi again! thank you all for your help. i sort of disappeared, i'm very sorry
> about that.
>
> i never mentioned it here, but the fact was that i didn't have a device to
> test on. so all i could do was post test code and ask users for their help.
> at some point no one was helping; i waited for test results but they never
> happened, so i got frustrated and abandoned the project.
>
> but recently interest built up again and we were able to progress and
> finally fix this, so i'm writing to let you know how it turned out.
>
> so remember there was random userland VFP register corruption. the VFP state
> was not being corrupted in the registers nor in the saved state in ram. what
> happened was: the kernel tracks the leftover state in the VFP once the eager
> state save is done. in the lazy restore trap, the kernel optimizes away the
> state load and instead only enables the VFP if it can prove that the
> leftover state in the VFP hardware matches the process state saved in ram.
>
> however under some circumstances the kernel did the wrong thing: it didn't
> reload the registers even though it was needed, probably because the
> hardware had been powered down and had lost state without the tracking code
> getting word of it. just disabling the optimization made the kernel solid.
>
> a couple of days later the root cause seems to have been identified and
> fixed. i describe the whole thing here:
> http://forum.xda-developers.com/galaxy-s2/development-derivatives/kernel-fpbug-stable-4-x-kernel-galaxy-t2978088
>
> once again, thank you for all your help.
>

Nice work! Seems like quite an adventure you guys had there.

-- 
Ard.
