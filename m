From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Dec 2013 19:29:38 +0000
Subject: [PATCH] arm64: cmpxchg: update macros to prevent warnings
In-Reply-To: <1386098127-29070-1-git-send-email-broonie@kernel.org>
References: <1386098127-29070-1-git-send-email-broonie@kernel.org>
Message-ID: <20131204192938.GF14145@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 07:15:27PM +0000, Mark Brown wrote:
> From: Mark Hambleton <mahamble@broadcom.com>
> 
> Make sure the value we are going to return is referenced in order to
> avoid warnings from newer GCCs such as:
> 
> arch/arm64/include/asm/cmpxchg.h:162:3: warning: value computed is not used [-Wunused-value]
>   ((__typeof__(*(ptr)))__cmpxchg_mb((ptr),   \
>    ^
> net/netfilter/nf_conntrack_core.c:674:2: note: in expansion of macro ?cmpxchg?
>   cmpxchg(&nf_conntrack_hash_rnd, 0, rand);
> 
> [Modified to use the current underlying implementation as current
> mainline for both cmpxchg() and cmpxchg_local() does -- broonie]
> 
> Signed-off-by: Mark Hambleton <mahamble@broadcom.com>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/include/asm/cmpxchg.h | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index 3914c0dcd09c..3f75fdb59447 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -158,17 +158,23 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
>  	return ret;
>  }
>  
> -#define cmpxchg(ptr,o,n)						\
> -	((__typeof__(*(ptr)))__cmpxchg_mb((ptr),			\
> -					  (unsigned long)(o),		\
> -					  (unsigned long)(n),		\
> -					  sizeof(*(ptr))))
> -
> -#define cmpxchg_local(ptr,o,n)						\
> -	((__typeof__(*(ptr)))__cmpxchg((ptr),				\
> -				       (unsigned long)(o),		\
> -				       (unsigned long)(n),		\
> -				       sizeof(*(ptr))))
> +#define cmpxchg(ptr, o, n) \
> +({ \
> +	__typeof__(*(ptr)) __ret; \
> +	__ret = (__typeof__(*(ptr))) \
> +	__cmpxchg((ptr), (unsigned long)(o), (unsigned long)(n), \
> +		sizeof(*(ptr))); \
> +	__ret; \
> +})
> +
> +#define cmpxchg_local(ptr, o, n) \
> +({ \
> +	__typeof__(*(ptr)) __ret; \
> +	__ret = (__typeof__(*(ptr))) \
> +	__cmpxchg_local((ptr), (unsigned long)(o), \
> +		(unsigned long)(n), sizeof(*(ptr))); \
> +	__ret; \
> +})

NAK.

This removes barrier semantics from cmpxchg and makes cmpxchg_local refer to
something which isn't defined anywhere, so the kernel doesn't even build.

Will
