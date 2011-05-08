From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 May 2011 10:24:03 +0100
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Message-ID: <20110508092403.GB27807@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2011 at 11:30:35PM +0200, Sven Eckelmann wrote:
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
...
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index 7e79503..a005265 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -218,6 +218,7 @@ static inline int atomic_add_unless(atomic_t *v, int a, int u)
>  	return c != u;
>  }
>  #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
> +#define atomic_dec_not_zero(v) atomic_add_unless((v), -1, 0)
>  
>  #define atomic_inc(v)		atomic_add(1, v)
>  #define atomic_dec(v)		atomic_sub(1, v)
> @@ -459,6 +460,7 @@ static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
>  #define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
>  #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
>  #define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1LL, 0LL)
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
>  
>  #else /* !CONFIG_GENERIC_ATOMIC64 */
>  #include <asm-generic/atomic64.h>

Do we need atomic_dec_not_zero() et.al. in every arch header - is there no
generic header which it could be added to?
