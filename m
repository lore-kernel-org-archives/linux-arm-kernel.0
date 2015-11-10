From: yalin.wang2010@gmail.com (yalin wang)
Date: Tue, 10 Nov 2015 19:24:22 +0800
Subject: [PATCH] arm64: add HAVE_LATENCYTOP_SUPPORT config
In-Reply-To: <20151110111829.GD31947@arm.com>
References: <1446825478-24824-1-git-send-email-yalin.wang2010@gmail.com>
 <20151106160501.GR6087@arm.com>
 <247F438B-3EEA-4550-970E-A649D0E604ED@gmail.com>
 <20151106162109.GT6087@arm.com> <20151110074124.GB6672@osiris>
 <20151110100547.GC31947@arm.com> <20151110110145.GE6672@osiris>
 <20151110111829.GD31947@arm.com>
Message-ID: <B5D509B6-E779-4329-9220-E956720D98EA@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Nov 10, 2015, at 19:18, Will Deacon <will.deacon@arm.com> wrote:
> 
> Ha, so it does! Patch below. The only non-trivial part was arch/arm/,
> which has a dependency on !SMP which I believe is no longer required
> as of d5996b2ff0e2 ("ARM: fix /proc/$PID/stack on SMP").
> 
> Will
> 
> --->8
> 
> From 8dfb40e92ac322cbd68bf9f16cbb11fc5e210269 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon@arm.com>
> Date: Tue, 10 Nov 2015 11:10:04 +0000
> Subject: [PATCH] Kconfig: remove HAVE_LATENCYTOP_SUPPORT
> 
> As illustrated by a3afe70b83fd ("[S390] latencytop s390 support."),
> HAVE_LATENCYTOP_SUPPORT is defined by an architecture to advertise an
> implementation of save_stack_trace_tsk.
> 
> However, as of 9212ddb5eada ("stacktrace: provide save_stack_trace_tsk()
> weak alias") a dummy implementation is provided if STACKTRACE=y.
> Given that LATENCYTOP already depends on STACKTRACE_SUPPORT and selects
> STACKTRACE, we can remove HAVE_LATENCYTOP_SUPPORT altogether.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> arch/arc/Kconfig        | 3 ---
> arch/arm/Kconfig        | 5 -----
> arch/metag/Kconfig      | 3 ---
> arch/microblaze/Kconfig | 3 ---
> arch/parisc/Kconfig     | 3 ---
> arch/powerpc/Kconfig    | 3 ---
> arch/s390/Kconfig       | 3 ---
> arch/sh/Kconfig         | 3 ---
> arch/sparc/Kconfig      | 4 ----
> arch/unicore32/Kconfig  | 3 ---
> arch/x86/Kconfig        | 3 ---
> lib/Kconfig.debug       | 1 -
> 12 files changed, 37 deletions(-)
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 2c2ac3f3ff80..6dc312fd6480 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -73,9 +73,6 @@ config STACKTRACE_SUPPORT
> 	def_bool y
> 	select STACKTRACE
> 
> -config HAVE_LATENCYTOP_SUPPORT
> -	def_bool y
> -
> config HAVE_ARCH_TRANSPARENT_HUGEPAGE
> 	def_bool y
> 	depends on ARC_MMU_V4
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 35854e8d97ff..94eff0c6b0f8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -162,11 +162,6 @@ config STACKTRACE_SUPPORT
> 	bool
> 	default y
> 
> -config HAVE_LATENCYTOP_SUPPORT
> -	bool
> -	depends on !SMP
> -	default y
> -
> config LOCKDEP_SUPPORT
> 	bool
> 	default y
> diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
> index 0b389a81c43a..a0fa88da3e31 100644
> --- a/arch/metag/Kconfig
> +++ b/arch/metag/Kconfig
> @@ -36,9 +36,6 @@ config STACKTRACE_SUPPORT
> config LOCKDEP_SUPPORT
> 	def_bool y
> 
> -config HAVE_LATENCYTOP_SUPPORT
> -	def_bool y
> -
> config RWSEM_GENERIC_SPINLOCK
> 	def_bool y
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 0bce820428fc..5ecd0287a874 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -67,9 +67,6 @@ config STACKTRACE_SUPPORT
> config LOCKDEP_SUPPORT
> 	def_bool y
> 
> -config HAVE_LATENCYTOP_SUPPORT
> -	def_bool y
> -
> source "init/Kconfig"
> 
> source "kernel/Kconfig.freezer"
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index c36546959e86..16276d505cd6 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -79,9 +79,6 @@ config TIME_LOW_RES
> 	depends on SMP
> 	default y
> 
> -config HAVE_LATENCYTOP_SUPPORT
> -        def_bool y
> -
> # unless you want to implement ACPI on PA-RISC ... ;-)
> config PM
> 	bool
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index db49e0d796b1..89210bfdfc7a 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -47,9 +47,6 @@ config STACKTRACE_SUPPORT
> 	bool
> 	default y
> 
> -config HAVE_LATENCYTOP_SUPPORT
> -	def_bool y
> -
> config TRACE_IRQFLAGS_SUPPORT
> 	bool
> 	default y
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 3a55f493c7da..69e22b502d09 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -10,9 +10,6 @@ config LOCKDEP_SUPPORT
> config STACKTRACE_SUPPORT
> 	def_bool y
> 
> -config HAVE_LATENCYTOP_SUPPORT
> -	def_bool y
> -
> config RWSEM_GENERIC_SPINLOCK
> 	bool
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index d514df7e04dd..6c391a5d3e5c 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -130,9 +130,6 @@ config STACKTRACE_SUPPORT
> config LOCKDEP_SUPPORT
> 	def_bool y
> 
> -config HAVE_LATENCYTOP_SUPPORT
> -	def_bool y
> -
> config ARCH_HAS_ILOG2_U32
> 	def_bool n
> 
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 56442d2d7bbc..3203e42190dd 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -101,10 +101,6 @@ config LOCKDEP_SUPPORT
> 	bool
> 	default y if SPARC64
> 
> -config HAVE_LATENCYTOP_SUPPORT
> -	bool
> -	default y if SPARC64
> -
> config ARCH_HIBERNATION_POSSIBLE
> 	def_bool y if SPARC64
> 
> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index c9faddc61100..910aaaaed969 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -33,9 +33,6 @@ config NO_IOPORT_MAP
> config STACKTRACE_SUPPORT
> 	def_bool y
> 
> -config HAVE_LATENCYTOP_SUPPORT
> -	def_bool y
> -
> config LOCKDEP_SUPPORT
> 	def_bool y
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index db3622f22b61..9574f7d1fe97 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -177,9 +177,6 @@ config LOCKDEP_SUPPORT
> config STACKTRACE_SUPPORT
> 	def_bool y
> 
> -config HAVE_LATENCYTOP_SUPPORT
> -	def_bool y
> -
> config MMU
> 	def_bool y
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 16bf3bc25e3e..6984710e75c9 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1547,7 +1547,6 @@ config FAULT_INJECTION_STACKTRACE_FILTER
> 
> config LATENCYTOP
> 	bool "Latency measuring infrastructure"
> -	depends on HAVE_LATENCYTOP_SUPPORT
> 	depends on DEBUG_KERNEL
> 	depends on STACKTRACE_SUPPORT
> 	depends on PROC_FS
> -- 
> 2.1.4

seems fine. :)
