From: dirk.behme@gmail.com (Dirk Behme)
Date: Mon, 09 Sep 2013 18:46:57 +0200
Subject: [RFC] ARM: kernel: io: Optimize memcpy_fromio function.
In-Reply-To: <1378743604-7339-1-git-send-email-b45784@freescale.com>
References: <1378743604-7339-1-git-send-email-b45784@freescale.com>
Message-ID: <522DFB81.20203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.09.2013 18:20, schrieb Pardeep Kumar Singla:
> Currently memcpy_fromio function is copying byte by byte data.
> By replacing this function with inline assembly code, it is copying now 32 bytes at one time.
> By running two test cases(Tested on mx6qsabresd board),results are following :-
>
> a)First test case  by calling the memcpy_fromio function only once:-
> 	1. With Optimization it is just taking 6 usec.
> 	2. Without optimization it is taking 114usec.
> b)Second test case by calling the memcpy_fromio function 100000 times.
> 	1.With Optimization it is just taking .8 sec
> 	2.Without optimization it is taking 11 sec.
>
> Signed-off-by: Pardeep Kumar Singla <b45784@freescale.com>

Is there any special reason trying to optimize memcpy_fromio() itself? 
Instead of using anything like

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173195.html

? I.e. using already existing optimized code?

Best regards

Dirk

> ---
>   arch/arm/kernel/io.c |   37 ++++++++++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
> index dcd5b4d..3eb8961 100644
> --- a/arch/arm/kernel/io.c
> +++ b/arch/arm/kernel/io.c
> @@ -4,16 +4,39 @@
>
>   /*
>    * Copy data from IO memory space to "real" memory space.
> - * This needs to be optimized.
>    */
> +void *asmcopy_8w(void *dst, void *src, int blocks);
> +asm("						\n\
> +	.align  2				\n\
> +	.text					\n\
> +	.global asmcopy_8w			\n\
> +	.type asmcopy_8w, %function		\n\
> +asmcopy_8w:					\n\
> +	stmfd sp!, {r3-r10, lr}			\n\
> +.loop:  ldmia r1!, {r3-r10}			\n\
> +	stmia r0!, {r3-r10}			\n\
> +	subs r2, r2, #1				\n\
> +	bne .loop				\n\
> +	ldmfd sp!, {r3-r10, pc}			\n\
> +");
> +
>   void _memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
>   {
> -	unsigned char *t = to;
> -	while (count) {
> -		count--;
> -		*t = readb(from);
> -		t++;
> -		from++;
> +	unsigned char *dst = (unsigned char *)to;
> +	unsigned char *src = (unsigned char *)from;
> +	if ((((int)src & 3) == 0) && (((int)dst & 3) == 0) && (count >= 32)) {
> +		/* copy big chunks */
> +		asmcopy_8w(dst, src, count >> 5);
> +		dst += count & (~0x1f);
> +		src += count & (~0x1f);
> +		count &= 0x1f;
> +	}
> +
> +	/* un-aligned or trailing accesses */
> +	while (count--) {
> +		*dst = readb(src);
> +		dst++;
> +		src++;
>   	}
>   }
>
>
