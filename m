From: huawei.libin@huawei.com (Li Bin)
Date: Wed, 16 Dec 2015 14:04:33 +0800
Subject: [RFC PATCH 0/3] livepatch: arm64: add support for livepatch on
 arm64
In-Reply-To: <20151215154356.GF3729@pathway.suse.cz>
References: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
 <20151215154356.GF3729@pathway.suse.cz>
Message-ID: <5670FEF1.1040104@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



on 2015/12/15 23:43, Petr Mladek wrote:
> On Mon 2015-12-14 20:49:35, Li Bin wrote:
>> This patchset depends on the on-going gcc feature "-fprolog-pad=N",
>> which will generate a pad of N nops at the beginning of each function.
>>
>> Livepatch on arm64 can using the feature (that always placing one nop
>> at the beginning of the function). And when enable/disable func patching,
>> just modify the pad code to nop or branch. And that NOP and B instruction
>> are both safe instructions on arm64 which called "concurrent modification
>> and execution of instructions", that can be executed by one thread of
>> execution as they are being modified by another thread of execution without
>> requiring explicit synchronization.
>>
>> And this method will improve performance significantly compared with the
>> method based on ftrace, especially for the critical function being frequently
>> called.
> It sounds like a great feature for ftrace. If the new prologue is usable
> for LivePatching, it should be usable to call the ftrace handler as
> well. If you teach ftrace to use the new prologue, you will not need
> all these crazy arch-specific hacks for LivePatching. Then both ftrace
> and livepatch will benefit from the feature.
>
> I suggest to read the ftrace documentation in Documentation/trace/,
> especially ftrace-design.txt. I have never ported ftrace to a new
> architecture. I guess that you need to teach scripts/recordmcount.c
>  to find the new location. Also you might need to update
> arch/arm/kernel/ftrace.c. Also please make sure that ftrace
> supports DYNAMIC_FTRACE_WITH_REGS on Arm.

Hi Petr,
I had posted one method for livepatch implementaion on arm64 based on ftrace with
DYNAMIC_FTRACE_WITH_REGS.
https://lwn.net/Articles/646317/

This requires GCC changes to support it, and I propose a method that implement -mfentry
feature which following some other arch such as x86/mips/s390 etc. This method is
architecture-specific, and Maxim Kuvyrkov propose a new method for gcc that implement
a target-independent option -fprolog-pad=N, which will generate a pad of N nops at the
beginning of each function.
https://gcc.gnu.org/ml/gcc/2015-05/msg00267.html

And based on this, DYNAMIC_FTRACE_WITH_REGS feature can be implemented as
mentioned in:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386815.html

And in this patchset, I only concern the performance for livepatch on arm64, and I
hope this also can be resolved by improving ftrace, and thanks to Steve that he pointed
that he is working on a way to make ftrace a bit better for livepatch.

Thanks,
Li Bin

> It is harder but the right way to go. Your current patch set
> looks like a hack.
>
> Best Regards,
> Petr
>
> .
>
