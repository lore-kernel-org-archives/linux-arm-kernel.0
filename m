From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 22 Oct 2015 19:14:28 +0900
Subject: arm64:, Re: [RFC] Kernel livepatching support in GCC
In-Reply-To: <5628A738.5000305@huawei.com>
References: <844CBBAF-DA0E-4164-9E35-34075A26F665@linaro.org>
 <5628A738.5000305@huawei.com>
Message-ID: <5628B704.8070608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Li,
(added linux-arm-kernel to Cc.)

On 10/22/2015 06:07 PM, libin wrote:
>
>
> ? 2015/5/28 16:39, Maxim Kuvyrkov ??:
>> Hi,
>>
>> Akashi-san and I have been discussing required GCC changes to make kernel's livepatching work for AArch64 and other
>> architectures.  At the moment livepatching is supported for x86[_64] using the following options: "-pg -mfentry
>> -mrecord-mcount -mnop-mcount" which is geek-speak for "please add several NOPs at the very beginning of each function,
>> and make a section with addresses of all those NOP pads".
>>
>> The above long-ish list of options is a historical artifact of how livepatching support evolved for x86.  The end
>> result is that for livepatching (or ftrace, or possible future kernel features) to work compiler needs to generate a
>> little bit of empty code space at the beginning of each function.  Kernel can later use that space to insert call
>> sequences for various hooks.
>>
>> Our proposal is that instead of adding -mfentry/-mnop-count/-mrecord-mcount options to other architectures, we should
>> implement a target-independent option -fprolog-pad=N, which will generate a pad of N nops at the beginning of each
>> function and add a section entry describing the pad similar to -mrecord-mcount [1].
>>
>> Since adding NOPs is much less architecture-specific then outputting call instruction sequences, this option can be
>> handled in a target-independent way at least for some/most architectures.
>>
>> Comments?
>>
>> As I found out today, the team from Huawei has implemented [2], which follows x86 example of -mfentry option
>> generating a hard-coded call sequence.  I hope that this proposal can be easily incorporated into their work since
>> most of the livepatching changes are in the kernel.
>>
>
> Thanks very much for your effort for this, and the arch-independed implementation
> is very good to me, but only have one question that how to enture the atomic
> replacement of multi instructions in kernel side?

I have one idea, but we'd better discuss this topic in, at least including, linux-arm-kernel.

> And before this arch-independed option, can we consider the arch-depended -mfentry
> implemention for arm64 like arch x86 firstly? I will post it soon.
>
> livepatch for arm64 based on this arm64 -mfentry feature on github:
> https://github.com/libin2015/livepatch-for-arm64.git  master


I also have my own version of livepatch support for arm64 using yet-coming "-fprolog-add=N" option :)
As we discussed before, the main difference will be how we should preserve LR register when invoking
a ftrace hook (ftrace_regs_caller).
But again, this is a topic to discuss mainly in linux-arm-kernel.
(I have no intention of excluding gcc ml from the discussions.)

Thanks,
-Takahiro AKASHI

> discussions on this topic:
> https://lkml.org/lkml/2015/5/28/54
>
> Thanks,
> Li Bin
>
>> [1] Technically, generating a NOP pad and adding a section entry in .__mcount_loc are two separate actions, so we may
>> want to have a -fprolog-pad-record option.  My instinct is to stick with a single option for now, since we can always
>> add more later.
>>
>> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/346905.html
>>
>> --
>> Maxim Kuvyrkov
>> www.linaro.org
>>
>>
>>
>>
>>
>
