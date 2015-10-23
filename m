From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 23 Oct 2015 18:11:03 +0900
Subject: arm64:, Re: [RFC] Kernel livepatching support in GCC
In-Reply-To: <5628B9D4.9020701@arm.com>
References: <844CBBAF-DA0E-4164-9E35-34075A26F665@linaro.org>
 <5628A738.5000305@huawei.com> <5628B704.8070608@linaro.org>
 <5628B9D4.9020701@arm.com>
Message-ID: <5629F9A7.3040808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2015 07:26 PM, Szabolcs Nagy wrote:
> On 22/10/15 11:14, AKASHI Takahiro wrote:
>> On 10/22/2015 06:07 PM, libin wrote:
>>> ? 2015/5/28 16:39, Maxim Kuvyrkov ??:
>>>> Our proposal is that instead of adding -mfentry/-mnop-count/-mrecord-mcount options to other architectures,
>>>> we should
>>>> implement a target-independent option -fprolog-pad=N, which will generate a pad of N nops at the beginning
>>>> of each
>>>> function and add a section entry describing the pad similar to -mrecord-mcount [1].
>>>>
>>>> Since adding NOPs is much less architecture-specific then outputting call instruction sequences, this option
>>>> can be
>>>> handled in a target-independent way at least for some/most architectures.
>>>>
>>>> Comments?
>>>>
>>>> As I found out today, the team from Huawei has implemented [2], which follows x86 example of -mfentry option
>>>> generating a hard-coded call sequence.  I hope that this proposal can be easily incorporated into their work
>>>> since
>>>> most of the livepatching changes are in the kernel.
>>>>
>>>
>>> Thanks very much for your effort for this, and the arch-independed implementation
>>> is very good to me, but only have one question that how to enture the atomic
>>> replacement of multi instructions in kernel side?
>>
>> I have one idea, but we'd better discuss this topic in, at least including, linux-arm-kernel.
>>
>>> And before this arch-independed option, can we consider the arch-depended -mfentry
>>> implemention for arm64 like arch x86 firstly? I will post it soon.
>>>
>>> livepatch for arm64 based on this arm64 -mfentry feature on github:
>>> https://github.com/libin2015/livepatch-for-arm64.git  master
>>
>>
>> I also have my own version of livepatch support for arm64 using yet-coming "-fprolog-add=N" option :)
>> As we discussed before, the main difference will be how we should preserve LR register when invoking
>> a ftrace hook (ftrace_regs_caller).
>> But again, this is a topic to discuss mainly in linux-arm-kernel.
>> (I have no intention of excluding gcc ml from the discussions.)
>
> is -fprolog-add=N enough from gcc?

Yes, as far as I correctly understand this option.

> i assume it solves the live patching, but i thought -mfentry
> might be still necessary when live patching is not used.

No.
- Livepatch depends on ftrace's DYNAMIC_FTRACE_WITH_REGS feature
- DYNAMIC_FTRACE_WITH_REGS can be implemented either with -fprolog-add=N or -mfentry
- x86 is the only architecture that supports -mfentry AFAIK
- and it is used in the kernel solely to implement this ftrace feature AFAIK
- So once a generic option, fprolog-add=N, is supported, we have no reason to add arch-specific -mfentry.

> or is the kernel fine with the current mcount abi for that?
> (note that changes the code generation in leaf functions

Can you please elaborate your comments in more details?
I didn't get your point here.

Thanks,
-Takahiro AKASHI

> and currently the kernel relies on frame pointers etc.)
>
