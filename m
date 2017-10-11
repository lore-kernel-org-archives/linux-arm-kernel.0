From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 11 Oct 2017 22:03:28 +0900
Subject: [PATCH] arm64: remove unneeded copy to init_utsname()->machine
In-Reply-To: <1505389204-17231-1-git-send-email-yamada.masahiro@socionext.com>
References: <1505389204-17231-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNASYmFf1NqVReq-mXhn8OsAkkxF0NXARDZ7L7oOC5zfpjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm64 maintainers,

Could you check this please?


2017-09-14 20:40 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> As you see in init/version.c, init_uts_ns.name.machine is initially
> set to UTS_MACHINE.  There is no point to copy the same string.
>
> I dug the git history to figure out why this line is here.  My best
> guess is like this:
>
>  - This line has been around here since the initial support of arm64
>    by commit 9703d9d7f77c ("arm64: Kernel booting and initialisation").
>    If ARCH (=arm64) and UTS_MACHINE (=aarch64) do not match,
>    arch/$(ARCH)/Makefile is supposed to override UTS_MACHINE, but the
>    initial version of arch/arm64/Makefile missed to do that.  Instead,
>    the boot code copied "aarch64" to init_utsname()->machine.
>
>  - Commit 94ed1f2cb5d4 ("arm64: setup: report ELF_PLATFORM as the
>    machine for utsname") replaced "aarch64" with ELF_PLATFORM to
>    make "uname" to reflect the endianness.
>
>  - ELF_PLATFORM does not help to provide the UTS machine name to rpm
>    target, so commit cfa88c79462d ("arm64: Set UTS_MACHINE in the
>    Makefile") fixed it.  The commit simply replaced ELF_PLATFORM with
>    UTS_MACHINE, but missed the fact the string copy itself is no longer
>    needed.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm64/kernel/Makefile | 2 --
>  arch/arm64/kernel/setup.c  | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index f2b4e81..29764d7 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -10,8 +10,6 @@ CFLAGS_REMOVE_ftrace.o = -pg
>  CFLAGS_REMOVE_insn.o = -pg
>  CFLAGS_REMOVE_return_address.o = -pg
>
> -CFLAGS_setup.o = -DUTS_MACHINE='"$(UTS_MACHINE)"'
> -
>  # Object file lists.
>  arm64-obj-y            := debug-monitors.o entry.o irq.o fpsimd.o              \
>                            entry-fpsimd.o process.o ptrace.o setup.o signal.o   \
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index d4b7405..b2fdb59 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -23,7 +23,6 @@
>  #include <linux/stddef.h>
>  #include <linux/ioport.h>
>  #include <linux/delay.h>
> -#include <linux/utsname.h>
>  #include <linux/initrd.h>
>  #include <linux/console.h>
>  #include <linux/cache.h>
> @@ -246,7 +245,6 @@ void __init setup_arch(char **cmdline_p)
>  {
>         pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
>
> -       sprintf(init_utsname()->machine, UTS_MACHINE);
>         init_mm.start_code = (unsigned long) _text;
>         init_mm.end_code   = (unsigned long) _etext;
>         init_mm.end_data   = (unsigned long) _edata;
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
