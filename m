From: james.morse@arm.com (James Morse)
Date: Mon, 04 Apr 2016 16:33:21 +0100
Subject: [PATCH 3/8] arm64/kernel: use a proper stack frame in
 __mmap_switched()
In-Reply-To: <1459781544-14310-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
 <1459781544-14310-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <57028941.6050805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 04/04/16 15:52, Ard Biesheuvel wrote:
> Considering that we can expect stack accesses from the moment we assign
> VBAR_EL1, let's initialize the stack pointer first in __mmap_switched(),
> and set up a proper stack frame while we're at it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/head.S | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 9d8f928c355c..f441fc73a7a2 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -421,9 +421,14 @@ kernel_img_size:
>  /*
>   * The following fragment of code is executed with the MMU enabled.
>   */
> -	.set	initial_sp, init_thread_union + THREAD_START_SP
>  __mmap_switched:
> -	mov	x28, lr				// preserve LR
> +	adrp	x4, init_thread_union
> +	add	sp, x4, #THREAD_SIZE
> +	msr	sp_el0, x4			// Save thread_info

(Terms describing the stack are confusing, here goes!)

The address you have in x4 is the 'highest' address on the stack, (the first
that gets used), thread_info is at the other end, the 'lowest' address.

You used THREAD_SIZE instead of THREAD_START_SP, so the x4 value points to the
'bottom' of the page after the stack, this isn't a problem because the pre-index
addressing decrements sp before it writes, but it does break the 'and	x4, x4,
#~(THREAD_SIZE - 1)' trick to find thread_info, which I think is what the '-16'
in THREAD_START_SP is for...

6cdf9c7ca687 ("arm64: Store struct thread_info in sp_el0") got rid of most of
the users of this masking trick, maybe we can get rid of THREAD_START_SP too?
(unless it is there for some other clever reason!)


Thanks,

James


> +
> +	stp	xzr, x30, [sp, #-16]!
> +	mov	x29, sp
> +
>  	adr_l	x8, vectors			// load VBAR_EL1 with virtual
>  	msr	vbar_el1, x8			// vector table address
>  	isb
> @@ -475,16 +480,9 @@ __mmap_switched:
>  	dsb	sy				// with MMU off
>  #endif
>  
> -	adr_l	sp, initial_sp, x4
> -	mov	x4, sp
> -	and	x4, x4, #~(THREAD_SIZE - 1)
> -	msr	sp_el0, x4			// Save thread_info
> -
>  	ldr_l	x4, kimage_vaddr		// Save the offset between
>  	sub	x4, x4, x24			// the kernel virtual and
>  	str_l	x4, kimage_voffset, x5		// physical mappings
> -
> -	mov	x29, #0
>  #ifdef CONFIG_KASAN
>  	bl	kasan_early_init
>  #endif
> @@ -494,8 +492,8 @@ __mmap_switched:
>  	bl	kaslr_early_init		// parse FDT for KASLR options
>  	cbz	x0, 0f				// KASLR disabled? just proceed
>  	mov	x23, x0				// record KASLR offset
> -	ret	x28				// we must enable KASLR, return
> -						// to __enable_mmu()
> +	ldp	x29, x30, [sp], #16		// we must enable KASLR, return
> +	ret					// to __enable_mmu()
>  0:
>  #endif
>  	b	start_kernel
> 
