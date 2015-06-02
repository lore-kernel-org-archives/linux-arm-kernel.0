From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 02 Jun 2015 11:15:33 +0900
Subject: [RFC PATCH 0/5] livepatch: add support on arm64
In-Reply-To: <5568FDD2.2040005@hitachi.com>
References: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
 <5568FDD2.2040005@hitachi.com>
Message-ID: <556D11C5.1010705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2015 09:01 AM, Masami Hiramatsu wrote:
> On 2015/05/28 14:51, Li Bin wrote:
>> This patchset propose a method for gcc -mfentry feature(profile
>> before prologue) implementation for arm64, and propose the livepatch
>> implementation for arm64 based on this feature.
>> The gcc implementation about this feature will be post to the gcc
>> community soon.
>>
>> With this -mfentry feature, the entry of each function like:
>>
>> foo:
>>      mov x9, x30
>>      bl __fentry__
>>      mov x30, x9
>>      [prologue]
>>      ...
>>
>> The x9 is a callee corruptible register, and the __fentry__ function
>> is responsible to protect all registers, so it can be used to protect
>> the x30. And the added two instructions which is register mov operation
>> have ralatively small impact on performance.
> 
> Hm, this implementation looks good to me :)
> This also enables us to KPROBES_ON_FTRACE too.

Even if x9 is a callee-saved register, there is no way to restore its original
value in setting up a pt_regs in ftrace_reg_caller.
It's not the right thing for KPROBES_ON_FTRACE, is it?

Saving Link register in stack is not a big deal since the overhead of ftrace
is much bigger.

-Takahiro AKASHI


> Thanks,
> 
>>
>> This patchset has been tested on arm64 platform.
>>
>> Li Bin (4):
>>    livepatch: ftrace: arm64: Add support for DYNAMIC_FTRACE_WITH_REGS
>>    livepatch: ftrace: add ftrace_function_stub_ip function
>>    livepatch: ftrace: arm64: Add support for -mfentry on arm64
>>    livepatch: arm64: add support for livepatch on arm64
>>
>> Xie XiuQi (1):
>>    livepatch: arm64: support relocation in a module
>>
>>   arch/arm64/Kconfig                 |    5 +
>>   arch/arm64/include/asm/ftrace.h    |    9 +
>>   arch/arm64/include/asm/livepatch.h |   45 +++++
>>   arch/arm64/kernel/Makefile         |    1 +
>>   arch/arm64/kernel/arm64ksyms.c     |    4 +
>>   arch/arm64/kernel/entry-ftrace.S   |  154 +++++++++++++++-
>>   arch/arm64/kernel/ftrace.c         |   28 +++-
>>   arch/arm64/kernel/livepatch.c      |   41 ++++
>>   arch/arm64/kernel/module.c         |  355 ++++++++++++++++++------------------
>>   include/linux/ftrace.h             |    1 +
>>   kernel/livepatch/core.c            |   17 ++-
>>   kernel/trace/ftrace.c              |   32 ++++
>>   scripts/recordmcount.pl            |    2 +-
>>   13 files changed, 508 insertions(+), 186 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/livepatch.h
>>   create mode 100644 arch/arm64/kernel/livepatch.c
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 
