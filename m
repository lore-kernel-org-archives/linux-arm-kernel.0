From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jan 2014 11:13:07 +0000
Subject: [PATCH] arm64: mm: use ubfm for dcache_line_size
In-Reply-To: <000301cf135a$c1390e40$43ab2ac0$%han@samsung.com>
References: <000301cf135a$c1390e40$43ab2ac0$%han@samsung.com>
Message-ID: <20140117111307.GE16003@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 08:04:32AM +0000, Jingoo Han wrote:
> Use 'ubfm' for the bitfield move instruction; thus, single
> instruction can be used instead of two instructions, when
> getting the minimum D-cache line size from CTR_EL0 register.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm64/mm/proc-macros.S |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
> index 8957b82..c31f41e 100644
> --- a/arch/arm64/mm/proc-macros.S
> +++ b/arch/arm64/mm/proc-macros.S
> @@ -38,8 +38,7 @@
>   */
>  	.macro	dcache_line_size, reg, tmp
>  	mrs	\tmp, ctr_el0			// read CTR
> -	lsr	\tmp, \tmp, #16
> -	and	\tmp, \tmp, #0xf		// cache line size encoding
> +	ubfm	\tmp, \tmp, #0x16, 0x19		// cache line size encoding

0x16 and 0x19. Are you sure?

You can also grep for other occurences of this pattern and change those too
(pgtable stuff in head.S, clidr in cache.S).

Will
