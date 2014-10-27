From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 27 Oct 2014 13:19:25 -0700
Subject: [PATCHv4 0/7] Better page protections for arm64
In-Reply-To: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <544EA8CD.1050106@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apologies for the spam for those on the direct mail, I had a typo in the mailing list name.

On 10/27/2014 1:12 PM, Laura Abbott wrote:
> Hi,
>
> This is v4 of the series to add stricter page protections for arm64.
> The goal is to have text be RO/X and everything else be RW/NX.
> More testing is still needed all around, especially with additional
> page table levels. Some of this work may conflict with ongoing work
> to support ARCH_DEBUG_PAGEALLOC on arm64[1] so depending on where
> that goes I may need to rebase or re-work the code.
>
>
> Thanks,
> Laura
>
> [1] http://www.spinics.net/lists/arm-kernel/msg372216.html
>
> Laura Abbott (7):
>    arm64: Treat handle_arch_irq as a function pointer
>    arm64: Switch to ldr for loading the stub vectors
>    arm64: Move cpu_resume into the text section
>    arm64: Move some head.text functions to executable section
>    arm64: Factor out fixmap initialiation from ioremap
>    arm64: use fixmap for text patching when text is RO
>    arm64: add better page protections to arm64
>
>   arch/arm64/Kconfig.debug            |  23 +++
>   arch/arm64/include/asm/cacheflush.h |   4 +
>   arch/arm64/include/asm/fixmap.h     |   8 +-
>   arch/arm64/include/asm/insn.h       |   2 +
>   arch/arm64/include/asm/irq.h        |   1 -
>   arch/arm64/kernel/entry.S           |   6 +-
>   arch/arm64/kernel/head.S            |   7 +-
>   arch/arm64/kernel/insn.c            |  72 ++++++-
>   arch/arm64/kernel/irq.c             |   2 +
>   arch/arm64/kernel/jump_label.c      |   2 +-
>   arch/arm64/kernel/setup.c           |   3 +-
>   arch/arm64/kernel/sleep.S           |  12 +-
>   arch/arm64/kernel/vmlinux.lds.S     |  17 ++
>   arch/arm64/mm/init.c                |   1 +
>   arch/arm64/mm/ioremap.c             |  93 +--------
>   arch/arm64/mm/mm.h                  |   2 +
>   arch/arm64/mm/mmu.c                 | 397 ++++++++++++++++++++++++++++++++----
>   17 files changed, 507 insertions(+), 145 deletions(-)
>


-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
