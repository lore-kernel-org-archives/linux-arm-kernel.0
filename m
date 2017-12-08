From: alex.shi@linaro.org (Alex Shi)
Date: Fri, 8 Dec 2017 09:02:04 +0800
Subject: [PATCH 1/2] ARM: BUG if jumping to usermode address in kernel mode
In-Reply-To: <E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
 <E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
Message-ID: <e795ff2c-4419-c585-6064-f761efc16448@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC GregKH, since this patch would better to get to stable kernel.
This patch also expose a qemu issue which fixed by upstream commit:
3aaf33bebda8d4ffcc0f ARM: avoid faulting on qemu

Both of patches are tested in linaro's kernelci and LKFT on stable
kernel 4.4/4.9/4.14, no regressions. The lts 3.18 isn't applicable for
this patches.

Regards
Alex

On 11/25/2017 07:33 PM, Russell King wrote:
> Detect if we are returning to usermode via the normal kernel exit paths
> but the saved PSR value indicates that we are in kernel mode.  This
> could occur due to corrupted stack state, which has been observed with
> "ftracetest".
> 
> This ensures that we catch the problem case before we get to user code.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/include/asm/assembler.h | 18 ++++++++++++++++++
>  arch/arm/kernel/entry-header.S   |  6 ++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index ad301f107dd2..bc8d4bbd82e2 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -518,4 +518,22 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  #endif
>  	.endm
>  
> +	.macro	bug, msg, line
> +#ifdef CONFIG_THUMB2_KERNEL
> +1:	.inst	0xde02
> +#else
> +1:	.inst	0xe7f001f2
> +#endif
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
> +	.pushsection .rodata.str, "aMS", %progbits, 1
> +2:	.asciz	"\msg"
> +	.popsection
> +	.pushsection __bug_table, "aw"
> +	.align	2
> +	.word	1b, 2b
> +	.hword	\line
> +	.popsection
> +#endif
> +	.endm
> +
>  #endif /* __ASM_ASSEMBLER_H__ */
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index d523cd8439a3..7f4d80c2db6b 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -300,6 +300,8 @@
>  	mov	r2, sp
>  	ldr	r1, [r2, #\offset + S_PSR]	@ get calling cpsr
>  	ldr	lr, [r2, #\offset + S_PC]!	@ get pc
> +	tst	r1, #0xcf
> +	bne	1f
>  	msr	spsr_cxsf, r1			@ save in spsr_svc
>  #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_32v6K)
>  	@ We must avoid clrex due to Cortex-A15 erratum #830321
> @@ -314,6 +316,7 @@
>  						@ after ldm {}^
>  	add	sp, sp, #\offset + PT_REGS_SIZE
>  	movs	pc, lr				@ return & move spsr_svc into cpsr
> +1:	bug	"Returning to usermode but unexpected PSR bits set?", \@
>  #elif defined(CONFIG_CPU_V7M)
>  	@ V7M restore.
>  	@ Note that we don't need to do clrex here as clearing the local
> @@ -329,6 +332,8 @@
>  	ldr	r1, [sp, #\offset + S_PSR]	@ get calling cpsr
>  	ldr	lr, [sp, #\offset + S_PC]	@ get pc
>  	add	sp, sp, #\offset + S_SP
> +	tst	r1, #0xcf
> +	bne	1f
>  	msr	spsr_cxsf, r1			@ save in spsr_svc
>  
>  	@ We must avoid clrex due to Cortex-A15 erratum #830321
> @@ -341,6 +346,7 @@
>  	.endif
>  	add	sp, sp, #PT_REGS_SIZE - S_SP
>  	movs	pc, lr				@ return & move spsr_svc into cpsr
> +1:	bug	"Returning to usermode but unexpected PSR bits set?", \@
>  #endif	/* !CONFIG_THUMB2_KERNEL */
>  	.endm
>  
> 
