From: keescook@chromium.org (Kees Cook)
Date: Wed, 24 Jan 2018 15:27:46 +1100
Subject: [RFC/RFT PATCH 0/2] arm64: per-task stack canaries
In-Reply-To: <20180123130302.29409-1-ard.biesheuvel@linaro.org>
References: <20180123130302.29409-1-ard.biesheuvel@linaro.org>
Message-ID: <CAGXu5j+LAi_wtFvzxgup6Q1-TRz1zZQT3ji6DXbkQZYp+8Bt7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 12:03 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This is a proof of concept implementation of per-task stack canaries for
> arm64. The purpose is to reach agreement between the arm64 kernel and GCC
> maintainers on how to implement support for this in the compiler.
>
> What these patches show is that we can support per-task stack canaries
> on arm64 using only very minor changes on the kernel side, i.e., all
> that is needed is exposing the offset of stack_canary in task_struct
> via an ELF symbol. With that in place, the compiler needs to emit the
> following sequence when -fstack-protector-guard=tls is enabled
>
>   movz    xN, :abs_g0:__stack_chk_guard_offset
>   msr     xM, sp_el0
>   ldr     xM, [xM, xN]
>
> Note that this does not involve per-CPU variables, and so there are no
> concurrency issues to be addressed. sp_el0 is the current task pointer,
> whose value never changes from the POV of the task, even when migrating
> to another CPU.
>
> Patch #1 implements a GCC plugin that patches the sequence
>
>   adrp    xN, __stack_chk_guard
>   add     xN, Xn, :lo12:__stack_chk_guard
>
> into
>
>   mrs     xN, sp_el0
>   add     xN, xN, :lo12:__stack_chk_guard_offset
>
> which is a poor man's version of the movz/msr/ldr sequence above (and only
> works for small model code), but is sufficient as a proof of concept.
>
> Patch #2 exposes the __stack_chk_guard_offset symbol and wires up the plugin
> (if enabled in Kconfig)
>
> Again, the point is not to use GCC plugin based hacks, but to reach agreement
> on how to proceed with this for GCC.
>
> Comments welcome.

This is great! I can confirm I'm seeing changing canaries on the
stack, they match current->stack_canary, and my system still panics
when I stomp on them in memory. :)

-Kees

>
> Ard Biesheuvel (2):
>   gcc-plugins: add support plugin for arm64 per-task stack canaries
>   arm64: kernel: use a unique stack canary value for each task
>
>  arch/Kconfig                                    |   4 +
>  arch/arm64/Kconfig                              |   7 ++
>  arch/arm64/include/asm/stackprotector.h         |   4 +-
>  arch/arm64/kernel/asm-offsets.c                 |   3 +
>  arch/arm64/kernel/process.c                     |   4 +
>  arch/arm64/kernel/vmlinux.lds.S                 |   8 ++
>  scripts/Makefile.gcc-plugins                    |   2 +
>  scripts/gcc-plugins/arm64_ssp_per_task_plugin.c | 121 ++++++++++++++++++++
>  8 files changed, 152 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/gcc-plugins/arm64_ssp_per_task_plugin.c
>
> --
> 2.11.0
>



-- 
Kees Cook
Pixel Security
