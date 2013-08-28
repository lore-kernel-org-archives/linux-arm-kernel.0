From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 28 Aug 2013 17:42:26 +0100
Subject: [PATCH 04/19] ARM: set BE8 if LE in head code
In-Reply-To: <1377639509-22778-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377639509-22778-5-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130828164226.GC3842@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 10:38:14PM +0100, Ben Dooks wrote:
> If we are booting in LE and compiled for BE8, then add code to
> set the state to bE8. Since the instruction stream is always LE,
> we do not need to do anything special to the instruction.
> 
> Also ensure that the secondary processors are started in the same mode.
> 
> Note, we do add about 20 bytes to the kernel image, but it seems easier
> to do this than adding another configuration to change.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

(Lose the merge conflicts lines, though)

> 
> Conflicts:
> 	arch/arm/kernel/sleep.S
> ---
>  arch/arm/boot/compressed/head.S |    1 +
>  arch/arm/kernel/head.S          |    4 ++++
>  arch/arm/kernel/sleep.S         |    1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index c912c2a..066b034 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -135,6 +135,7 @@ start:
>  		.word	_edata			@ zImage end address
>   THUMB(		.thumb			)
>  1:
> + ARM_BE8(	setend	be )			@ go BE8 if compiled for BE8
>  		mrs	r9, cpsr
>  #ifdef CONFIG_ARM_VIRT_EXT
>  		bl	__hyp_stub_install	@ get into SVC mode, reversibly
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 9e5906c..a047acf 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -77,6 +77,7 @@
>  
>  	__HEAD
>  ENTRY(stext)
> + ARM_BE8(setend	be )			@ ensure we are in BE8 mode
>  
>   THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
>   THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
> @@ -352,6 +353,9 @@ ENTRY(secondary_startup)
>  	 * the processor type - there is no need to check the machine type
>  	 * as it has already been validated by the primary processor.
>  	 */
> +
> + ARM_BE8(setend	be)				@ ensure we are in BE8 mode
> +
>  #ifdef CONFIG_ARM_VIRT_EXT
>  	bl	__hyp_stub_install_secondary
>  #endif
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index db1536b..716343c 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -130,6 +130,7 @@ ENDPROC(cpu_resume_after_mmu)
>  	.data
>  	.align
>  ENTRY(cpu_resume)
> +ARM_BE8(setend be)			@ ensure we are in BE mode
>  	mov	r1, #0
>  	ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
>  	ALT_UP_B(1f)
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
