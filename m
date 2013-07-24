From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 15:41:19 +0100
Subject: [PATCH 04/14] ARM: set BE8 if LE in head code
In-Reply-To: <1374661682-9349-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-5-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130724144118.GM11072@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 11:27:52AM +0100, Ben Dooks wrote:
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
> ---
>  arch/arm/boot/compressed/head.S |    1 +
>  arch/arm/kernel/head.S          |    4 ++++
>  arch/arm/kernel/sleep.S         |    1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 4eb8364..4d83bfd 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -135,6 +135,7 @@ start:
>  		.word	_edata			@ zImage end address
>   THUMB(		.thumb			)
>  1:
> + ARM_BE8(	setend	be )			@ go BE8 if LE, no-op if BE8

I find the comment here slightly confusing as it makes it sound like the
macro expands to nothing if we're BE8 (which is clearly not the case).

>  		mrs	r9, cpsr
>  #ifdef CONFIG_ARM_VIRT_EXT
>  		bl	__hyp_stub_install	@ get into SVC mode, reversibly
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index e40c0b3b..706c441 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -77,6 +77,7 @@
>  
>  	__HEAD
>  ENTRY(stext)
> + ARM_BE8(setend	be )			@ ensure we are in BE8 mode

Alignment issue here -- please try to align the instruction with the
instructions below (it's awkward to read with all the brackets).

>  
>   THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
>   THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
> @@ -351,6 +352,9 @@ ENTRY(secondary_startup)
>  	 * the processor type - there is no need to check the machine type
>  	 * as it has already been validated by the primary processor.
>  	 */
> +
> + ARM_BE8(setend	be)				@ if system starts LE, go BE8
> +
>  #ifdef CONFIG_ARM_VIRT_EXT
>  	bl	__hyp_stub_install_secondary
>  #endif
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index 987dcf3..954c28a 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -81,6 +81,7 @@ ENDPROC(cpu_resume_after_mmu)
>  	.data
>  	.align
>  ENTRY(cpu_resume)
> +ARM_BE8(setend be)			@ ensure we are in BE mode

Any reason to have three different comments for the same thing? I think you
probably just need to comment the one in head.S.

Will
