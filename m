From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 30 Apr 2015 11:57:09 +0100
Subject: [PATCH V3] arm64: optimized copy_to_user and copy_from_user
 assembly code
In-Reply-To: <1430267932-17730-1-git-send-email-fkan@apm.com>
References: <1430267932-17730-1-git-send-email-fkan@apm.com>
Message-ID: <20150430105709.GL18867@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 05:38:52PM -0700, Feng Kan wrote:
> Using the glibc cortex string work work authored by Linaro as base to
> create new copy to/from user kernel routine.
> 
> Iperf performance increase:
> 		-l (size)		1 core result
> Optimized 	64B			44-51Mb/s
> 		1500B			4.9Gb/s
> 		30000B			16.2Gb/s
> Original	64B			34-50.7Mb/s
> 		1500B			4.7Gb/s
> 		30000B			14.5Gb/s

There is indeed some performance improvement, especially for large
buffers, so I'm fine in principle with changing these functions.
However, I have some comments below.

>  arch/arm64/lib/copy_from_user.S |  92 +++++++++++------
>  arch/arm64/lib/copy_template.S  | 213 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/lib/copy_to_user.S   |  56 ++++++-----

We should try to share copy_template.S with the memcpy routine as well.
They are basically the same, just the labels for user access differ.
More about this below.

We also have copy_in_user which is very similar.

> --- a/arch/arm64/lib/copy_from_user.S
> +++ b/arch/arm64/lib/copy_from_user.S
> @@ -15,7 +15,6 @@
>   */
>  
>  #include <linux/linkage.h>
> -#include <asm/assembler.h>
>  
>  /*
>   * Copy from user space to a kernel buffer (alignment handled by the hardware)
[...]
> +9:
> +	/*
> +	 * count is accurate
> +	 * dst is accurate
> +	 */
> +	mov	x0, count
> +	sub	dst, dst, tmp1
> +	b	.Lfinalize
> +
> +10:
> +	/*
> +	 * count is in the last 15 bytes
> +	 * dst is somewhere in there
> +	 */
> +	mov	x0, count
> +	sub	dst, limit, count
> +	b	.Lfinalize

I'm confused by these labels and what they try to do. In the copy
template, usually 'count' is decremented before a set of post-indexed
load/store instructions are issued. I don't think 'count' is relevant
here for how many bytes have been copied. For example, copy_from_user()
can only fault on a load instruction. When you handle such exception,
you want to zero from the current dst (the store wasn't issued since the
load failed) to the end of the buffer (your limit).

> --- /dev/null
> +++ b/arch/arm64/lib/copy_template.S
> @@ -0,0 +1,213 @@
[...]
> +#include <asm/assembler.h>
> +#include <asm/cache.h>
> +
> +dstin	.req x0
> +src	.req x1
> +count	.req x2
> +tmp1	.req x3
> +tmp1w	.req w3
> +tmp2	.req x4
> +tmp2w	.req w4
> +limit	.req x5
> +dst	.req x6
> +
> +A_l	.req x7
> +A_h	.req x8
> +B_l	.req x9
> +B_h	.req x10
> +C_l	.req x11
> +C_h	.req x12
> +D_l	.req x13
> +D_h	.req x14
> +
> +	mov	dst, dstin
> +	add	limit, dst, count
> +	cmp	count, #16
> +	b.lo	.Ltail15
> +
> +	/*
> +	 * We don't much care about the alignment of DST, but we want SRC
> +	 * to be 128-bit (16 byte) aligned so that we don't cross cache line
> +	 * boundaries on both loads and stores.
> +	 */
> +	ands	tmp2, src, #15
> +	b.eq	.LSrcAligned
> +	sub	count, count, tmp2
> +
> +	tbz	tmp2, #0, 1f
> +	USER(11f, ldrb	tmp1w, [src], #1)
> +	USER(11f, strb	tmp1w, [dst], #1)

That's wrong. Depending own whether you want copy_from_user,
copy_to_user or copy_in_user, you have the USER annotation for load,
store or both respectively. It may be easier if we use asm macros
similar to the arm32 copy_template.S. Or maybe some macros like TMPL_LD,
TMPL_ST which may be defined to USER or just expanding the argument
based on the function they are called from (and we can easily share the
template with memcpy and copy_in_user).

> --- a/arch/arm64/lib/copy_to_user.S
> +++ b/arch/arm64/lib/copy_to_user.S
[...]
> +	.align    2
> +9:
> +10:
> +	/*
> +	 * count is accurate
> +	 */
> +	mov	x0, count
> +	b	.Lfinalize
> +11:
> +	/*
> +	 * count is over accounted by tmp2
> +	 */
> +	add	x0, count, tmp2
> +	b	.Lfinalize
> +12:
> +14:
> +	/*
> +	 * (count + 64) bytes remain
> +	 * dst is accurate
> +	 */
> +	adds	x0, count, #64
> +	b	.Lfinalize
> +13:
> +	/*
> +	 * (count + 128) bytes remain
> +	 */
> +	add	x0, count, #128
> +.Lfinalize:
>  	ret
>  	.previous

Can we no just use something like (limit - dst) here and avoid checks
for whether 'count' was accurate or not?

-- 
Catalin
