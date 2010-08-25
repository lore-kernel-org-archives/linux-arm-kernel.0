From: gadiyar@ti.com (Gadiyar, Anand)
Date: Wed, 25 Aug 2010 20:38:06 +0530
Subject: [PATCH] wire up fanotify and prlimit64 syscalls on ARM
In-Reply-To: <19573.12044.918202.642643@pilspetsen.it.uu.se>
References: <19573.12044.918202.642643@pilspetsen.it.uu.se>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03243069FE@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson wrote:
> 
> The 2.6.36-rc kernel added three new system calls:
> fanotify_init, fanotify_mark, and prlimit64.  This patch
> wires them up on ARM.
> 
> The only non-trivial issue here is the u64 argument to
> sys_fanotify_mark(), but it is the 3rd argument and thus
> passed in r2/r3 in both kernel and user space, so it causes
> no problems.
> 
> Tested with a 2.6.36-rc2 EABI kernel on an ixp4xx machine.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

For what it's worth,

Tested-by: Anand Gadiyar <gadiyar@ti.com>

on an OMAP4

> ---
>  arch/arm/include/asm/unistd.h |    3 +++
>  arch/arm/kernel/calls.S       |    3 +++
>  2 files changed, 6 insertions(+)
> 
> diff -rupN linux-2.6.36-rc2/arch/arm/include/asm/unistd.h 
> linux-2.6.36-rc2.arm-fanotify+prlimit64-syscalls/arch/arm/include/asm/unistd.h
> --- linux-2.6.36-rc2/arch/arm/include/asm/unistd.h	2010-08-24 12:03:48.000000000 +0200
> +++ linux-2.6.36-rc2.arm-fanotify+prlimit64-syscalls/arch/arm/include/asm/unistd.h	2010-08-25 16:27:22.000000000 +0200
> @@ -393,6 +393,9 @@
>  #define __NR_perf_event_open		(__NR_SYSCALL_BASE+364)
>  #define __NR_recvmmsg			(__NR_SYSCALL_BASE+365)
>  #define __NR_accept4			(__NR_SYSCALL_BASE+366)
> +#define __NR_fanotify_init		(__NR_SYSCALL_BASE+367)
> +#define __NR_fanotify_mark		(__NR_SYSCALL_BASE+368)
> +#define __NR_prlimit64			(__NR_SYSCALL_BASE+369)
>  
>  /*
>   * The following SWIs are ARM private.
> diff -rupN linux-2.6.36-rc2/arch/arm/kernel/calls.S linux-2.6.36-rc2.arm-fanotify+prlimit64-syscalls/arch/arm/kernel/calls.S
> --- linux-2.6.36-rc2/arch/arm/kernel/calls.S	2010-08-24 12:03:48.000000000 +0200
> +++ linux-2.6.36-rc2.arm-fanotify+prlimit64-syscalls/arch/arm/kernel/calls.S	2010-08-25 16:27:22.000000000 +0200
> @@ -376,6 +376,9 @@
>  		CALL(sys_perf_event_open)
>  /* 365 */	CALL(sys_recvmmsg)
>  		CALL(sys_accept4)
> +		CALL(sys_fanotify_init)
> +		CALL(sys_fanotify_mark)
> +		CALL(sys_prlimit64)
>  #ifndef syscalls_counted
>  .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
>  #define syscalls_counted
