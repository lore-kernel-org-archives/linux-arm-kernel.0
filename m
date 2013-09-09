From: B45784@freescale.com (Kumar Singla Pardeep-B45784)
Date: Mon, 9 Sep 2013 17:30:18 +0000
Subject: [RFC] ARM: kernel: io: Optimize memcpy_fromio function.
In-Reply-To: <522DFB81.20203@gmail.com>
References: <1378743604-7339-1-git-send-email-b45784@freescale.com>
 <522DFB81.20203@gmail.com>
Message-ID: <6BE02386AFA7A7449F0ECB96E787BB7F0B87CA8E@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

From: Dirk Behme [mailto:dirk.behme at gmail.com] 
Sent: Monday, September 09, 2013 11:47 AM
To: Kumar Singla Pardeep-B45784
Cc: linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org; Estevam Fabio-R49496; Dunham Ragan-B37558
Subject: Re: [RFC] ARM: kernel: io: Optimize memcpy_fromio function.

Am 09.09.2013 18:20, schrieb Pardeep Kumar Singla:
> Currently memcpy_fromio function is copying byte by byte data.
> By replacing this function with inline assembly code, it is copying now 32 bytes at one time.
> By running two test cases(Tested on mx6qsabresd board),results are 
> following :-
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

[] I was not aware about this thread. We were working on boot optimization. And we found this fault and tried to optimize it and it was working fine.
My test results are already present in the patch.

Best regards

Dirk

> ---
>   arch/arm/kernel/io.c |   37 ++++++++++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c index 
> dcd5b4d..3eb8961 100644
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
