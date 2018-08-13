From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Aug 2018 23:12:55 +0200
Subject: [PATCH] ARM: require GCC for FRAME_POINTER
In-Reply-To: <20180811095235.1938-1-stefan@agner.ch>
References: <20180811095235.1938-1-stefan@agner.ch>
Message-ID: <CAK8P3a1SOAYkbMV-YvQ9pVhAk7J6jt9Sc23gc1idj8u5ftyp=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2018 at 11:52 AM Stefan Agner <stefan@agner.ch> wrote:
>

> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 693f84392f1b..cb65cf67dfa2 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -54,7 +54,7 @@ config DEBUG_WX
>  # n, but then RMK will have to kill you ;).
>  config FRAME_POINTER
>         bool
> -       depends on !THUMB2_KERNEL
> +       depends on !THUMB2_KERNEL && CC_IS_GCC
>         default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
>         help
>           If you say N here, the resulting kernel will be slightly smaller and

I suspect we actually need a bit more complexity here, as we have a couple
of options that do something like:

       select FRAME_POINTER if !MIPS && !PPC && !ARM_UNWIND && !S390
&& !MICROBLAZE && !ARC && !X86

This means that in configurations without ARM_UNWIND, we still
fail to build with clang. Maybe something like x86 would work, this currently
has

choice
        prompt "Choose kernel unwinder"
        default UNWINDER_ORC if X86_64
        default UNWINDER_FRAME_POINTER if X86_32

config UNWINDER_ORC
        bool "ORC unwinder"
        depends on X86_64
        select STACK_VALIDATION

config UNWINDER_FRAME_POINTER
        bool "Frame pointer unwinder"
        select FRAME_POINTER

config UNWINDER_GUESS
        bool "Guess unwinder"
        depends on EXPERT
        depends on !STACKDEPOT

endchoice

so we always get some form of unwinding, but have different levels of
functionality in them. Implementing ORC on ARM might be nice, but
that's a lot of work, so I'm not expecting you to do that.

The simplest approach would be to always force ARM_UNWIND=y
when not building with gcc:

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 43d598c9b1f9..b390ac99ba20 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -60,7 +60,7 @@ config FRAME_POINTER
          reported is severely limited.

 config ARM_UNWIND
-       bool "Enable stack unwinding support (EXPERIMENTAL)"
+       bool "Enable stack unwinding support (EXPERIMENTAL)" if CC_IS_GCC
        depends on AEABI
        default y
        help

      Arnd
