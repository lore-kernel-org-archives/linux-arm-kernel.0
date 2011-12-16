From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Dec 2011 10:38:30 +0000
Subject: [RFC PATCH] ARM: Fix the bug in dcache flush all API.
In-Reply-To: <1324026157-32628-1-git-send-email-r.sricharan@ti.com>
References: <1324026157-32628-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20111216103830.GA30477@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Dec 16, 2011 at 09:02:37AM +0000, sricharan wrote:
> Currently the v7_flush_dcache_all api uses the loc bit field
> in clidr register to find out the last level of cache that has to be
> flushed to achieve the data coherency. The loc bit field is present in
> the register from bits[24:26], but the algorithm uses bits[23:25] as
> the loc bit field. Bit[23] which corresponds to the cache type bit of
> level 8 is zero in most of the architectures. As a example, for a
> level 3 coherency the loc bit field is actually 2, since the bits[23:25]
> are used, the loc becomes 4 (multipled by 2) and algorithm compares this
> with current cace level * 2, which makes it work. But this wont work starting
> from cases where the loc bit field becomes 4, since bits[23:25] will be zeroes.
> 
> So correcting this in the algorithm by using 24 as the right shift value
> and compare the loc bit field with the current cache level.
> 
> Signed-off-by: sricharan <r.sricharan@ti.com>
> Reviewed-by: Santosh Shilimkar  <santosh.shilimkar@ti.com>
> ---
> Boot tested this on omap4430sdp.
> 
>  arch/arm/mm/cache-v7.S |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 07c4bc8..868aa1f 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -45,7 +45,7 @@ ENTRY(v7_flush_dcache_all)
>  	dmb					@ ensure ordering with previous memory accesses
>  	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
>  	ands	r3, r0, #0x7000000		@ extract loc from clidr
> -	mov	r3, r3, lsr #23			@ left align loc bit field
> +	mov	r3, r3, lsr #24			@ left align loc bit field
>  	beq	finished			@ if loc is 0, then no need to clean
>  	mov	r10, #0				@ start clean at cache level 0
>  loop1:
> @@ -80,7 +80,7 @@ loop3:
>  	bge	loop2
>  skip:
>  	add	r10, r10, #2			@ increment cache number
> -	cmp	r3, r10
> +	cmp	r3, r10, lsr #1
>  	bgt	loop1
>  finished:
>  	mov	r10, #0				@ swith back to cache level 0

I don't think this is fixing the problem fully and actually, I've just
spotted another bug where the line size is calculated incorrectly.

When we work out the shift to extract the cache type bits it will go wrong
once we hit the 4th iteration (r10 == 6) because we'll calculate a shift of
10 instead of 9.

I'll try and come up with some patches to fix this function properly since
it seems to broken in a few different ways.

Will
