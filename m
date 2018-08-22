From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2018 16:32:33 +0200
Subject: [PATCH] ARM: use choice for kernel unwinders
In-Reply-To: <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
References: <20180821222416.7771-1-stefan@agner.ch>
 <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
Message-ID: <CAK8P3a03TFBi+kNccTm4WE7u9QdKfbA-Van0WpHH6VzDLtLCtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2018 at 12:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Aug 22, 2018 at 12:24 AM Stefan Agner <stefan@agner.ch> wrote:
> >
> > While in theory multiple unwinders could be compiled in, it does
> > not make sense in practise. Use a choice to make the unwinder
> > selection mutually exclusive and mandatory.
> >
> > Already before this commit it has not been possible to deselect
> > FRAME_POINTER. Remove the obsolete comment.
> >
> > Furthermore, to produce a meaningful backtrace with FRAME_POINTER
> > enabled the kernel needs a specific function prologue:
> >     mov    ip, sp
> >     stmfd    sp!, {fp, ip, lr, pc}
> >     sub    fp, ip, #4
> >
> > To get to the required prologue gcc uses apcs and no-sched-prolog.
> > This compiler options are not available on clang, and clang is not
> > able to generate the required prologue. Make the FRAME_POINTER
> > config symbol depending on !clang.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>
> Looks ok to me. I've added it to my randconfig test environment, you
> will hear from me within a day if I run into build regressions.

I needed a small hunk to avoid a warning:

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) ||
ARCH_WANT_FRAME_POINTERS [=n]
  Selected by [y]:
  - LOCKDEP [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
&& !MIPS && !PPC && !ARM_UNWIND [=n] && !S390 && !MICROBLAZE && !ARC
&& !X86
  - UNWINDER_FRAME_POINTER [=y] && <choice> && !THUMB2_KERNEL [=n] &&
!CC_IS_CLANG [=n]

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6e27419b90c0..08f914be6248 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -57,6 +57,7 @@ choice
 config UNWINDER_FRAME_POINTER
        bool "Frame pointer unwinder"
        depends on !THUMB2_KERNEL && !CC_IS_CLANG
+       select ARCH_WANT_FRAME_POINTERS
        select FRAME_POINTER
        help
          This option enables the frame pointer unwinder for unwinding
