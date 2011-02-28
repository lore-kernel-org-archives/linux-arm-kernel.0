From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 28 Feb 2011 14:58:11 -0500 (EST)
Subject: [PATCH] ARM: Thumb-2: Work around buggy Thumb-2 short branch
	relocations in gas
In-Reply-To: <1298914692-19897-1-git-send-email-dave.martin@linaro.org>
References: <1298914692-19897-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1102281456390.7544@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Feb 2011, Dave Martin wrote:

> Various binutils versions can resolve Thumb-2 branches to
> locally-defined, preemptible global symbols as short-range "b.n"
> branch instructions.
> 
> This is a problem, because there's no guarantee the final
> destination of the symbol, or any candidate locations for a
> trampoline, are within range of the branch.  For this reason, the
> kernel does not support fixing up the R_ARM_THM_JUMP11 (102)
> relocation in modules at all, and it makes little sense to add
> support.
> 
> The symptom is that the kernel fails with an "unsupported
> relocation" error when loading some modules.
> 
> Until fixed tools are available, passing
> -fno-optimize-sibling-calls to gcc should prevent gcc generating
> code which hits this problem, at the cost of a bit of extra runtime
> stack usage in some cases.
> 
> The problem is described in more detail at:
>     https://bugs.launchpad.net/binutils-linaro/+bug/725126
> 
> Only Thumb-2 kernels are affected.
> 
> This patch adds a new CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11 config
> option which adds -fno-optimize-sibling-calls to CFLAGS_MODULE
> when building a Thumb-2 kernel.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
>  arch/arm/Kconfig  |   31 +++++++++++++++++++++++++++++++
>  arch/arm/Makefile |    4 ++++
>  2 files changed, 35 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5cff165..196f6d2 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1371,6 +1371,37 @@ config THUMB2_KERNEL
>  
>  	  If unsure, say N.
>  
> +config THUMB2_AVOID_R_ARM_THM_JUMP11
> +	bool "Work around buggy Thumb-2 short branch relocations in gas"
> +	depends on THUMB2_KERNEL && MODULES
> +	default y
> +	help
> +	  Various binutils versions can resolve Thumb-2 branches to
> +	  locally-defined, preemptible global symbols as short-range "b.n"
> +	  branch instructions.
> +
> +	  This is a problem, because there's no guarantee the final
> +	  destination of the symbol, or any candidate locations for a
> +	  trampoline, are within range of the branch.  For this reason, the
> +	  kernel does not support fixing up the R_ARM_THM_JUMP11 (102)
> +	  relocation in modules at all, and it makes little sense to add
> +	  support.
> +
> +	  The symptom is that the kernel fails with an "unsupported
> +	  relocation" error when loading some modules.
> +
> +	  Until fixed tools are available, passing
> +	  -fno-optimize-sibling-calls to gcc should prevent gcc generating
> +	  code which hits this problem, at the cost of a bit of extra runtime
> +	  stack usage in some cases.
> +
> +	  The problem is described in more detail at:
> +	      https://bugs.launchpad.net/binutils-linaro/+bug/725126
> +
> +	  Only Thumb-2 kernels are affected.
> +
> +	  Unless you are sure your tools don't have this problem, say Y.
> +
>  config ARM_ASM_UNIFIED
>  	bool
>  
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c22c1ad..ef5105a 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -105,6 +105,10 @@ AFLAGS_AUTOIT	:=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mau
>  AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
>  CFLAGS_THUMB2	:=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
>  AFLAGS_THUMB2	:=$(CFLAGS_THUMB2) -Wa$(comma)-mthumb
> +# Work around buggy relocation from gas if requested:
> +ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
> +CFLAGS_MODULE	+=-fno-optimize-sibling-calls
> +endif
>  endif
>  
>  # Need -Uarm for gcc < 3.x
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
