From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2018 12:02:19 +0200
Subject: [PATCH] ARM: use choice for kernel unwinders
In-Reply-To: <20180821222416.7771-1-stefan@agner.ch>
References: <20180821222416.7771-1-stefan@agner.ch>
Message-ID: <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2018 at 12:24 AM Stefan Agner <stefan@agner.ch> wrote:
>
> While in theory multiple unwinders could be compiled in, it does
> not make sense in practise. Use a choice to make the unwinder
> selection mutually exclusive and mandatory.
>
> Already before this commit it has not been possible to deselect
> FRAME_POINTER. Remove the obsolete comment.
>
> Furthermore, to produce a meaningful backtrace with FRAME_POINTER
> enabled the kernel needs a specific function prologue:
>     mov    ip, sp
>     stmfd    sp!, {fp, ip, lr, pc}
>     sub    fp, ip, #4
>
> To get to the required prologue gcc uses apcs and no-sched-prolog.
> This compiler options are not available on clang, and clang is not
> able to generate the required prologue. Make the FRAME_POINTER
> config symbol depending on !clang.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Looks ok to me. I've added it to my randconfig test environment, you
will hear from me within a day if I run into build regressions.

We may still want to clean up these three lines:

lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC &&
!ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !X86
lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
!MICROBLAZE && !ARM_UNWIND && !ARC && !X86
lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
!MICROBLAZE && !ARM_UNWIND && !ARC && !X86

in which ARM is the odd case that currently depends on an architecture
specific rather than the architecture itself.
We could introduce a 'config ARCH_HAS_UNWINDER' symbol that gets
selected by mips, ppc, s390, microblaze, arm and x86 unconditionally,
and then simplify the 'select' statements here.

       Arnd
