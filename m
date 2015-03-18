From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Mar 2015 08:54:34 +0100
Subject: [PATCH v2 0/8] ARM kernel size fixes
In-Reply-To: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9Ah4A75xd3zQF=7gHD8VzfmYezpeiXpkd+SWWrgrD6+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2015 at 13:07, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This series is a suggested approach to preventing linker failures on large
> kernels. It is somewhat unpolished, and posted for comments/testing primarily.
>
> The issues were found and reported by Arnd Bergmann, and these patches are
> loosely based on his initial approach to work around them.
>
> Changes since v1:
> - Updated PROCINFO patch (#1) to refer to the base of the struct by name, and
>   simplify the calling code (rmk)
> - Updated b_far/bl_far patch (#3) to remove ARM/THUMB alternatives and use a
>   conditionally defined PC_BIAS instead. Also added b_abs/bl_abs versions,
>   which can only be used for absolute branches but can be implemented in fewer
>   instructions. Added conditional branch support as well.
> - introduce (#6) and use (#7) the .text.fixup input section which gets emitted
>   after each .text section for each .o
> - added patch #8 that allows the kallsyms data to be moved to .data
>

I put the following ones in the patch tracker:

>   ARM: replace PROCINFO embedded branch with relative offset
>   ARM: add macro to perform far branches (b/bl)
>   ARM: use bl_far to call __hyp_stub_install_secondary from the .data
>     section
>   ARM: move the .idmap.text section closer to .head.text

Arnd, may I have your ack on these if you think this approach is ok?

>   asm-generic: introduce .text.fixup input section
>   ARM: keep .text and .fixup regions together

This one can be dropped and/or deferred. I don't need it to build
Arnd's dotconfig-from-hell successfully, and there is a KVM patch
under review that touches the same part of the linker script.

>   ARM: move HYP text to end of .text section

This one has not been discussed at all, so let's defer for now

>   kallsyms: allow kallsyms data to reside in the .data section
>

Regards,
Ard.


>  arch/arm/Kconfig                      |  1 +
>  arch/arm/include/asm/assembler.h      | 83 +++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/futex.h          |  2 +-
>  arch/arm/include/asm/uaccess.h        | 10 ++---
>  arch/arm/include/asm/word-at-a-time.h |  2 +-
>  arch/arm/kernel/entry-armv.S          |  2 +-
>  arch/arm/kernel/head.S                | 14 +++---
>  arch/arm/kernel/sleep.S               |  2 +-
>  arch/arm/kernel/swp_emulate.c         |  2 +-
>  arch/arm/kernel/vmlinux.lds.S         | 15 ++++---
>  arch/arm/kvm/init.S                   |  5 +--
>  arch/arm/kvm/interrupts.S             |  4 +-
>  arch/arm/lib/clear_user.S             |  2 +-
>  arch/arm/lib/copy_to_user.S           |  2 +-
>  arch/arm/lib/csumpartialcopyuser.S    |  2 +-
>  arch/arm/mm/alignment.c               |  6 +--
>  arch/arm/mm/proc-arm1020.S            |  4 +-
>  arch/arm/mm/proc-arm1020e.S           |  4 +-
>  arch/arm/mm/proc-arm1022.S            |  4 +-
>  arch/arm/mm/proc-arm1026.S            |  4 +-
>  arch/arm/mm/proc-arm720.S             |  4 +-
>  arch/arm/mm/proc-arm740.S             |  4 +-
>  arch/arm/mm/proc-arm7tdmi.S           |  4 +-
>  arch/arm/mm/proc-arm920.S             |  4 +-
>  arch/arm/mm/proc-arm922.S             |  4 +-
>  arch/arm/mm/proc-arm925.S             |  4 +-
>  arch/arm/mm/proc-arm926.S             |  4 +-
>  arch/arm/mm/proc-arm940.S             |  4 +-
>  arch/arm/mm/proc-arm946.S             |  4 +-
>  arch/arm/mm/proc-arm9tdmi.S           |  4 +-
>  arch/arm/mm/proc-fa526.S              |  4 +-
>  arch/arm/mm/proc-feroceon.S           |  5 ++-
>  arch/arm/mm/proc-macros.S             |  4 ++
>  arch/arm/mm/proc-mohawk.S             |  4 +-
>  arch/arm/mm/proc-sa110.S              |  4 +-
>  arch/arm/mm/proc-sa1100.S             |  4 +-
>  arch/arm/mm/proc-v6.S                 |  4 +-
>  arch/arm/mm/proc-v7.S                 | 28 ++++++------
>  arch/arm/mm/proc-v7m.S                |  4 +-
>  arch/arm/mm/proc-xsc3.S               |  4 +-
>  arch/arm/mm/proc-xscale.S             |  4 +-
>  arch/arm/nwfpe/entry.S                |  2 +-
>  include/asm-generic/vmlinux.lds.h     | 14 +++++-
>  init/Kconfig                          |  4 ++
>  scripts/kallsyms.c                    |  2 +-
>  45 files changed, 200 insertions(+), 101 deletions(-)
>
> --
> 1.8.3.2
>
