From: gerg@snapgear.com (Greg Ungerer)
Date: Wed, 6 Oct 2010 15:09:29 +1000
Subject: [PATCH 01/10] ARM: no need for nommu to jump through the hoops
	that	mmu does
In-Reply-To: <E1P2oXR-00020E-FV@rmk-PC.arm.linux.org.uk>
References: <E1P2oXR-00020E-FV@rmk-PC.arm.linux.org.uk>
Message-ID: <4CAC0489.90201@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/10 03:09, Russell King - ARM Linux wrote:
> nommu can jump directly to __mmap_switched without the absolute
> address branching which the mmuful kernel does.
>
> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>

Acked-by: Greg Ungerer <gerg@uclinux.org>



>   arch/arm/kernel/head-nommu.S |    5 +----
>   1 files changed, 1 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index 573b803..814ce1a 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -48,8 +48,6 @@ ENTRY(stext)
>   	movs	r8, r5				@ invalid machine (r5=0)?
>   	beq	__error_a			@ yes, error 'a'
>
> -	ldr	r13, __switch_data		@ address to jump to after
> -						@ the initialization is done
>   	adr	lr, BSYM(__after_proc_init)	@ return (PIC) address
>    ARM(	add	pc, r10, #PROCINFO_INITFUNC	)
>    THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
> @@ -87,8 +85,7 @@ __after_proc_init:
>   	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
>   #endif /* CONFIG_CPU_CP15 */
>
> -	mov	r3, r13
> -	mov	pc, r3				@ clear the BSS and jump
> +	b	__mmap_switched			@ clear the BSS and jump
>   						@ to start_kernel
>   ENDPROC(__after_proc_init)
>   	.ltorg


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
