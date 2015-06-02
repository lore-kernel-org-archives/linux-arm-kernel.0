From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Wed, 03 Jun 2015 06:04:48 +0900
Subject: [RFC PATCH 0/5] livepatch: add support on arm64
In-Reply-To: <556D8CBD.8060105@huawei.com>
References: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
 <5568FDD2.2040005@hitachi.com> <556D11C5.1010705@linaro.org>
 <556D8CBD.8060105@huawei.com>
Message-ID: <556E1A70.5010500@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/06/02 20:00, Li Bin wrote:
> On 2015/6/2 10:15, AKASHI Takahiro wrote:
>> On 05/30/2015 09:01 AM, Masami Hiramatsu wrote:
>>> On 2015/05/28 14:51, Li Bin wrote:
>>>> This patchset propose a method for gcc -mfentry feature(profile
>>>> before prologue) implementation for arm64, and propose the livepatch
>>>> implementation for arm64 based on this feature.
>>>> The gcc implementation about this feature will be post to the gcc
>>>> community soon.
>>>>
>>>> With this -mfentry feature, the entry of each function like:
>>>>
>>>> foo:
>>>>      mov x9, x30
>>>>      bl __fentry__
>>>>      mov x30, x9
>>>>      [prologue]
>>>>      ...
>>>>
>>>> The x9 is a callee corruptible register, and the __fentry__ function
>>>> is responsible to protect all registers, so it can be used to protect
>>>> the x30. And the added two instructions which is register mov operation
>>>> have ralatively small impact on performance.
>>>
>>> Hm, this implementation looks good to me :)
>>> This also enables us to KPROBES_ON_FTRACE too.
>>
>> Even if x9 is a callee-saved register, there is no way to restore its original
>> value in setting up a pt_regs in ftrace_reg_caller.

Good point :)

> 
> Hi, Takahiro AKASHI
> 
> Firstly, x9 is not a callee-saved but a caller-saved register(or being called
> corruptible register).
> Secondly, I think x9 is already protected properly, please reference the patch:
> [PATCH 1/5] livepatch: ftrace: arm64: Add support for DYNAMIC_FTRACE_WITH_REGS
> [PATCH 3/5] livepatch: ftrace: arm64: Add support for -mfentry on arm64

I guess he concern about the x9 value at the function entrance is lost. For
example, regs->x9 at the handler of ftrace_regs_call is always same as flags
(if I correctly understand).
If it is right, it should be documented in the commit log and
Documentation/trace/ftrace.txt. However, that is practically no problem,
since;
- x9 is caller saved register, so functions MUST not depend on its value.
 (this means ftrace handlers also should not expect any meaningful value
  in regs->x9)
- Even if a function is wrongly coded and access x9, it is always same as
 caller address (link register). easy to debug :)

So, finally, I think it's OK to use x9 for this purpose.

Thank you,

> 
>> It's not the right thing for KPROBES_ON_FTRACE, is it?
>>
>> Saving Link register in stack is not a big deal since the overhead of ftrace
>> is much bigger.
> 
> Performance overhead is only one aspect of the problem, and more importantly,
> even worse is that it would break the arm64 ABI rules.
> 
> Thanks,
> 	Li Bin
>>
>> -Takahiro AKASHI
>>
>>
>>> Thanks,
>>>
>>>>
>>>> This patchset has been tested on arm64 platform.
>>>>
>>>> Li Bin (4):
>>>>    livepatch: ftrace: arm64: Add support for DYNAMIC_FTRACE_WITH_REGS
>>>>    livepatch: ftrace: add ftrace_function_stub_ip function
>>>>    livepatch: ftrace: arm64: Add support for -mfentry on arm64
>>>>    livepatch: arm64: add support for livepatch on arm64
>>>>
>>>> Xie XiuQi (1):
>>>>    livepatch: arm64: support relocation in a module
>>>>
>>>>   arch/arm64/Kconfig                 |    5 +
>>>>   arch/arm64/include/asm/ftrace.h    |    9 +
>>>>   arch/arm64/include/asm/livepatch.h |   45 +++++
>>>>   arch/arm64/kernel/Makefile         |    1 +
>>>>   arch/arm64/kernel/arm64ksyms.c     |    4 +
>>>>   arch/arm64/kernel/entry-ftrace.S   |  154 +++++++++++++++-
>>>>   arch/arm64/kernel/ftrace.c         |   28 +++-
>>>>   arch/arm64/kernel/livepatch.c      |   41 ++++
>>>>   arch/arm64/kernel/module.c         |  355 ++++++++++++++++++------------------
>>>>   include/linux/ftrace.h             |    1 +
>>>>   kernel/livepatch/core.c            |   17 ++-
>>>>   kernel/trace/ftrace.c              |   32 ++++
>>>>   scripts/recordmcount.pl            |    2 +-
>>>>   13 files changed, 508 insertions(+), 186 deletions(-)
>>>>   create mode 100644 arch/arm64/include/asm/livepatch.h
>>>>   create mode 100644 arch/arm64/kernel/livepatch.c
>>>>


-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt at hitachi.com
