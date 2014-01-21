From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Jan 2014 11:05:55 +0000
Subject: [PATCH v2] arm64: mm: use ubfm for dcache_line_size
In-Reply-To: <002501cf159c$85a358b0$90ea0a10$%han@samsung.com>
References: <002501cf159c$85a358b0$90ea0a10$%han@samsung.com>
Message-ID: <20140121110555.GF30706@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 05:00:21AM +0000, Jingoo Han wrote:
> Use 'ubfm' for the bitfield move instruction; thus, single
> instruction can be used instead of two instructions, when
> getting the minimum D-cache line size from CTR_EL0 register.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

  Acked-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will

> ---
> Change since v1
> - Remove unnecessary prefix '0x' from immediates, per Will Deacon
> - Add '#' to immediates for consistency, per Ard Biesheuvel
> 
>  arch/arm64/mm/proc-macros.S |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
> index 8957b82..005d29e 100644
> --- a/arch/arm64/mm/proc-macros.S
> +++ b/arch/arm64/mm/proc-macros.S
> @@ -38,8 +38,7 @@
>   */
>  	.macro	dcache_line_size, reg, tmp
>  	mrs	\tmp, ctr_el0			// read CTR
> -	lsr	\tmp, \tmp, #16
> -	and	\tmp, \tmp, #0xf		// cache line size encoding
> +	ubfm	\tmp, \tmp, #16, #19		// cache line size encoding
>  	mov	\reg, #4			// bytes per word
>  	lsl	\reg, \reg, \tmp		// actual cache line size
>  	.endm
> -- 
> 1.7.10.4
> 
> 
> 
