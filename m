From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 19 Nov 2014 14:37:54 -0800
Subject: [PATCHv5 0/7] Better page protections for arm64
In-Reply-To: <CAGXu5jKBkuUde7DK2NdFTycJkB=9Dyou+b2oo0aC-y85XN_Kng@mail.gmail.com>
References: <1416272105-14787-1-git-send-email-lauraa@codeaurora.org>
 <CAGXu5jKBkuUde7DK2NdFTycJkB=9Dyou+b2oo0aC-y85XN_Kng@mail.gmail.com>
Message-ID: <546D1BC2.3050503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2014 2:33 PM, Kees Cook wrote:
> On Mon, Nov 17, 2014 at 4:54 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
>> Hi,
>>
>> This is v5 of the series to add stricter page protections for arm64.
>> The goal is to have text be RO/NX and everything else be RW/NX.
>> I finally got my hands on a Juno board so I was able to do more
>> testing with both 4K and 64K pages although I still haven't tested
>> with EFI. This is based off of 3.18-rc5.
>>
>> Thanks,
>> Laura
>>
>> Laura Abbott (7):
>>    arm64: Treat handle_arch_irq as a function pointer
>>    arm64: Switch to adrp for loading the stub vectors
>>    arm64: Move cpu_resume into the text section
>>    arm64: Move some head.text functions to executable section
>>    arm64: Factor out fixmap initialiation from ioremap
>>    arm64: use fixmap for text patching when text is RO
>>    arm64: add better page protections to arm64
>>
>>   arch/arm64/Kconfig.debug            |  23 ++
>>   arch/arm64/include/asm/cacheflush.h |   4 +
>>   arch/arm64/include/asm/fixmap.h     |   8 +-
>>   arch/arm64/include/asm/insn.h       |   2 +
>>   arch/arm64/include/asm/irq.h        |   1 -
>>   arch/arm64/kernel/entry.S           |   6 +-
>>   arch/arm64/kernel/head.S            | 409 +++++++++++++++++-----------------
>>   arch/arm64/kernel/insn.c            |  72 +++++-
>>   arch/arm64/kernel/irq.c             |   2 +
>>   arch/arm64/kernel/jump_label.c      |   2 +-
>>   arch/arm64/kernel/setup.c           |   1 +
>>   arch/arm64/kernel/sleep.S           |  29 +--
>>   arch/arm64/kernel/suspend.c         |   4 +-
>>   arch/arm64/kernel/vmlinux.lds.S     |  21 ++
>>   arch/arm64/mm/init.c                |   1 +
>>   arch/arm64/mm/ioremap.c             |  93 +-------
>>   arch/arm64/mm/mm.h                  |   2 +
>>   arch/arm64/mm/mmu.c                 | 429 ++++++++++++++++++++++++++++++++----
>>   18 files changed, 743 insertions(+), 366 deletions(-)
>
> Thanks for working on this series! I've tested this on my aarch64
> hardware, and it worked nicely. :) Consider the whole series as:
>
> Tested-by: Kees Cook <keescook@chromium.org>
>
> Has anyone looked at getting an arm64 version of CONFIG_ARM_PTDUMP
> built? It'd be really nice to be able to check page table layout at a
> glace.
>

Yep, I have a version of that

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303418.html

Testing appreciated as always :)

> In the meantime, with this patch series, the "WRITE_RO" and
> "WRITE_KERN" tests from lkdtm correctly Oops the kernel.
>
> Thanks!
>
> -Kees
>

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
