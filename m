From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 19 Feb 2013 13:42:56 -0800
Subject: [patch 1/2] kcmp: Make it to depend on CONFIG_KCMP
In-Reply-To: <20130219182838.GL20312@moon>
References: <20130219064800.719149796@openvz.org>
 <20130219065210.030802820@openvz.org> <5123444D.6000806@suse.cz>
 <20130219093154.GF20312@moon> <5123BC2B.6000304@zytor.com>
 <20130219182838.GL20312@moon>
Message-ID: <20130219134256.f4cedf44.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Feb 2013 22:28:38 +0400
Cyrill Gorcunov <gorcunov@openvz.org> wrote:

> Since kcmp syscall has been implemented (initially on
> x86 architecture) a number of other archs wire it up
> as well: xtensa, sparc, sh, s390, mips, microblaze,
> m68k (not taking into account those who uses
> <asm-generic/unistd.h> for syscall numbers
> definitions).
> 
> But the Makefile, which turns kcmp.o generation on
> still depends on former config-x86. Thus get rid
> of this limitation and make kcmp.o depend on CONFIG_KCMP
> option.
> 
> ...
>
> --- linux-2.6.git.orig/init/Kconfig
> +++ linux-2.6.git/init/Kconfig
> @@ -279,6 +279,15 @@ config FHANDLE
>  	  get renamed. Enables open_by_handle_at(2) and name_to_handle_at(2)
>  	  syscalls.
>  
> +config KCMP
> +	bool "kcmp syscall"
> +	default CHECKPOINT_RESTORE
> +	help
> +	  If you say Y here, a user level program will be able to use
> +	  kcmp(2) syscall.
> +
> +	  If unsure, say Y.
> +
>  config AUDIT
>  	bool "Auditing support"
>  	depends on NET
> Index: linux-2.6.git/kernel/Makefile
> ===================================================================
> --- linux-2.6.git.orig/kernel/Makefile
> +++ linux-2.6.git/kernel/Makefile
> @@ -25,9 +25,7 @@ endif
>  obj-y += sched/
>  obj-y += power/
>  
> -ifeq ($(CONFIG_CHECKPOINT_RESTORE),y)
> -obj-$(CONFIG_X86) += kcmp.o
> -endif
> +obj-$(CONFIG_KCMP) += kcmp.o
>  obj-$(CONFIG_FREEZER) += freezer.o
>  obj-$(CONFIG_PROFILING) += profile.o
>  obj-$(CONFIG_STACKTRACE) += stacktrace.o

This permits people to select kcmp with CONFIG_CHECKPOINT_RESTORE=n. 
Is there any point in doing that?

What would be wrong with just doing

	obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o

?
