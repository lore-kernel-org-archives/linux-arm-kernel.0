From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 24 Nov 2014 09:57:41 -0500 (EST)
Subject: [PATCH] ARM: PJ4: allow building in Thumb-2 mode
In-Reply-To: <1416830200-11114-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1416830200-11114-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.11.1411240957220.11690@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Nov 2014, Ard Biesheuvel wrote:

> Two files that get included when building the multi_v7_defconfig target
> fail to build when selecting THUMB2_KERNEL for this configuration.
> 
> In both cases, we can just build the file as ARM code, as none of its
> symbols are exported to modules, so there are no interworking concerns.
> In the iwmmxt.S case, add ENDPROC() declarations so the symbols are
> annotated as functions, resulting in the linker to emit the appropriate
> mode switches.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/kernel/Makefile |  1 +
>  arch/arm/kernel/iwmmxt.S | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 4c5d1a5982dd..575a5e424b0a 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_CPU_PJ4B)		+= pj4-cp0.o
>  obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o
>  obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o
> +CFLAGS_pj4-cp0.o		:= -marm
>  AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
>  obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
>  
> diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
> index ad58e565fe98..49fadbda8c63 100644
> --- a/arch/arm/kernel/iwmmxt.S
> +++ b/arch/arm/kernel/iwmmxt.S
> @@ -58,6 +58,7 @@
>  #define MMX_SIZE		(0x98)
>  
>  	.text
> +	.arm
>  
>  /*
>   * Lazy switching of Concan coprocessor context
> @@ -182,6 +183,8 @@ concan_load:
>  	tmcr	wCon, r2
>  	ret	lr
>  
> +ENDPROC(iwmmxt_task_enable)
> +
>  /*
>   * Back up Concan regs to save area and disable access to them
>   * (mainly for gdb or sleep mode usage)
> @@ -232,6 +235,8 @@ ENTRY(iwmmxt_task_disable)
>  1:	msr	cpsr_c, ip			@ restore interrupt mode
>  	ldmfd	sp!, {r4, pc}
>  
> +ENDPROC(iwmmxt_task_disable)
> +
>  /*
>   * Copy Concan state to given memory address
>   *
> @@ -268,6 +273,8 @@ ENTRY(iwmmxt_task_copy)
>  	msr	cpsr_c, ip			@ restore interrupt mode
>  	ret	r3
>  
> +ENDPROC(iwmmxt_task_copy)
> +
>  /*
>   * Restore Concan state from given memory address
>   *
> @@ -304,6 +311,8 @@ ENTRY(iwmmxt_task_restore)
>  	msr	cpsr_c, ip			@ restore interrupt mode
>  	ret	r3
>  
> +ENDPROC(iwmmxt_task_restore)
> +
>  /*
>   * Concan handling on task switch
>   *
> @@ -335,6 +344,8 @@ ENTRY(iwmmxt_task_switch)
>  	mrc	p15, 0, r1, c2, c0, 0
>  	sub	pc, lr, r1, lsr #32		@ cpwait and return
>  
> +ENDPROC(iwmmxt_task_switch)
> +
>  /*
>   * Remove Concan ownership of given task
>   *
> @@ -353,6 +364,8 @@ ENTRY(iwmmxt_task_release)
>  	msr	cpsr_c, r2			@ restore interrupts
>  	ret	lr
>  
> +ENDPROC(iwmmxt_task_release)
> +
>  	.data
>  concan_owner:
>  	.word	0
> -- 
> 1.8.3.2
> 
> 
