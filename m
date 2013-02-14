From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 13 Feb 2013 23:33:15 -0500 (EST)
Subject: [PATCH 4/9] ARM: set BE8 if LE in head code
In-Reply-To: <1360752927-29331-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360752927-29331-5-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <alpine.LFD.2.03.1302132327540.8736@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Feb 2013, Ben Dooks wrote:

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

Comment below.

> ---
>  arch/arm/boot/compressed/head.S |    1 +
>  arch/arm/kernel/head.S          |    4 ++++
>  arch/arm/mm/proc-v7.S           |    1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 15ebdd6..06b0f15 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -134,6 +134,7 @@ start:
>  		.word	_edata			@ zImage end address
>   THUMB(		.thumb			)
>  1:
> + ARM_BE8(	setend	be )			@ go BE8 if LE, no-op if BE8
>  		mrs	r9, cpsr
>  #ifdef CONFIG_ARM_VIRT_EXT
>  		bl	__hyp_stub_install	@ get into SVC mode, reversibly
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index cc15384..a112994 100644
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
> @@ -333,6 +334,9 @@ ENTRY(secondary_startup)
>  	 * the processor type - there is no need to check the machine type
>  	 * as it has already been validated by the primary processor.
>  	 */
> +
> + ARM_BE8(setend	be)				@ if system starts LE, go BE8
> +
>  #ifdef CONFIG_ARM_VIRT_EXT
>  	bl	__hyp_stub_install_secondary
>  #endif
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index d17996b..28bb018 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -109,6 +109,7 @@ ENTRY(cpu_v7_do_suspend)
>  ENDPROC(cpu_v7_do_suspend)
>  
>  ENTRY(cpu_v7_do_resume)
> + ARM_BE8(setend	be )			@ ensure we are BE8

This is wrong.  You want to insert this in 
arch/arm/kernel/sleep.S:cpu_resume which is the main entry point for 
resuming.


Nicolas
