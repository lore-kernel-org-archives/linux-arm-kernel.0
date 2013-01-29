From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 29 Jan 2013 15:13:36 -0500 (EST)
Subject: [RFC PATCH] arm: decompressor: initialize PIC offset base register
 for uClinux tools
In-Reply-To: <1359480546-7033-1-git-send-email-jonathan.austin@arm.com>
References: <1359480546-7033-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <alpine.LFD.2.02.1301291453530.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Jan 2013, Jonathan Austin wrote:

> Before jumping to (position independent) C-code from the decompressor's
> assembler world we set-up the C environment. This setup currently does not
> set r9, which for arm-none-uclinux-uclibceabi should be the PIC offset base
> register (IE should point to the beginning of the GOT).
> 
> Currently, therefore, in order to build working kernels that use the
> decompressor it is necessary to use an arm-linux-gnueabi toolchain, or
> similar. uClinux toolchains cause a Prefetch Abort to occur at the beginning
> of the decompress_kernel function.
> 
> This patch allows uClinux toolchains to build bootable zImages by setting r9
> to the beginning of the GOT when __uClinux__ is defined, allowing the
> decompressor's C functions to work correctly.
> 
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> ---
> 
> One other possibility would be to specify -mno-single-pic-base when building
> the decompressor. This works around the problem, but forces the compiler to
> generate less optimal code.

How "less optimal"?  How much bigger/slower is it?
If not significant enough then going with -mno-single-pic-base might be 
fine.

>  arch/arm/boot/compressed/head.S |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index fe4d9c3..4491e75 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -410,6 +410,10 @@ wont_overwrite:
>   *   sp  = stack pointer
>   */
>  		orrs	r1, r0, r5
> +#ifdef __uClinux__
> +		mov	r9, r11			@ PIC offset base register
> +		addne	r9, r9, r0		@ Also needs relocating
> +#endif
>  		beq	not_relocated

Please don't insert your code between the orrs and the beq as those two 
go logically together.

In fact, the best location for this would probably be between the 
wont_overwrite label and the comment that immediately follows it. And 
then, those comments that follow until the branch into C code should be 
updated accordingly.


Nicolas
