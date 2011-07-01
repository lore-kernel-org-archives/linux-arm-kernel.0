From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 01 Jul 2011 10:03:48 +0900
Subject: [PATCH 4/7] ARM: EXYNOS4: Support early wakeup while entering
	sleep mode
In-Reply-To: <20110624102246.GF23234@n2100.arm.linux.org.uk>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
	<1308732405-16664-5-git-send-email-kgene.kim@samsung.com>
	<20110622145715.GS23234@n2100.arm.linux.org.uk>
	<007401cc3242$48947160$d9bd5420$%kim@samsung.com>
	<20110624093750.GD23234@n2100.arm.linux.org.uk>
	<20110624102246.GF23234@n2100.arm.linux.org.uk>
Message-ID: <017d01cc378a$c017edf0$4047c9d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Fri, Jun 24, 2011 at 10:37:50AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Jun 24, 2011 at 04:42:26PM +0900, Kukjin Kim wrote:
> > > Russell King - ARM Linux wrote:
> > >

(snip)

> 
> Here's an updated patch for it against the v3 set of patches.
> 
>  arch/arm/include/asm/suspend.h |    9 +++++----
>  arch/arm/kernel/sleep.S        |   11 +++++++++--
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/suspend.h
b/arch/arm/include/asm/suspend.h
> index f8db9d0..54821b5 100644
> --- a/arch/arm/include/asm/suspend.h
> +++ b/arch/arm/include/asm/suspend.h
> @@ -10,12 +10,13 @@ extern void cpu_resume(void);
>   * Hide the first two arguments to __cpu_suspend - these are an
implementation
>   * detail which platform code shouldn't have to know about.
>   */
> -static inline void cpu_suspend(unsigned long arg, void (*fn)(unsigned
long))
> +static inline int cpu_suspend(unsigned long arg, void (*fn)(unsigned
long))
>  {
> -	extern void __cpu_suspend(int, long, unsigned long,
> -				  void (*)(unsigned long));
> -	__cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, arg, fn);
> +	extern int __cpu_suspend(int, long, unsigned long,
> +				 void (*)(unsigned long));
> +	int ret = __cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, arg, fn);
>  	flush_tlb_all();
> +	return ret;
>  }
> 
>  #endif
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index c156d0e..dc902f2 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -12,7 +12,6 @@
>   *  r1 = v:p offset
>   *  r2 = suspend function arg0
>   *  r3 = suspend function
> - * Note: does not return until system resumes
>   */
>  ENTRY(__cpu_suspend)
>  	stmfd	sp!, {r4 - r11, lr}
> @@ -26,7 +25,7 @@ ENTRY(__cpu_suspend)
>  #endif
>  	mov	r6, sp			@ current virtual SP
>  	sub	sp, sp, r5		@ allocate CPU state on stack
> -	mov	r0, sp			@ save pointer
> +	mov	r0, sp			@ save pointer to CPU save block
>  	add	ip, ip, r1		@ convert resume fn to phys
>  	stmfd	sp!, {r1, r6, ip}	@ save v:p, virt SP, phys resume fn
>  	ldr	r5, =sleep_save_sp
> @@ -55,10 +54,17 @@ ENTRY(__cpu_suspend)
>  #else
>  	bl	__cpuc_flush_kern_all
>  #endif
> +	adr	lr, BSYM(cpu_suspend_abort)
>  	ldmfd	sp!, {r0, pc}		@ call suspend fn
>  ENDPROC(__cpu_suspend)
>  	.ltorg
> 
> +cpu_suspend_abort:
> +	ldmia	sp!, {r1 - r3}		@ pop v:p, virt SP, phys resume fn
> +	mov	sp, r2

Russell thanks.

How do you think to add following for handling failure of cpu_suspend?

+	mov	r0, #-1

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> +	ldmfd	sp!, {r4 - r11, pc}
> +ENDPROC(cpu_suspend_abort)
> +
>  /*
>   * r0 = control register value
>   * r1 = v:p offset (preserved by cpu_do_resume)
> @@ -89,6 +95,7 @@ cpu_resume_after_mmu:
>  	str	r5, [r2, r4, lsl #2]	@ restore old mapping
>  	mcr	p15, 0, r0, c1, c0, 0	@ turn on D-cache
>  	bl	cpu_init		@ restore the und/abt/irq banked
regs
> +	mov	r0, #0			@ return zero on success
>  	ldmfd	sp!, {r4 - r11, pc}
>  ENDPROC(cpu_resume_after_mmu)
> 
