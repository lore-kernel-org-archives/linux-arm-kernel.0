From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Sep 2013 10:30:41 +0100
Subject: [PATCH] ARM: include: asm: atomic.h: use type cast 's64' for the
 return value of atomic64_add_return().
In-Reply-To: <523D7DC7.8030603@asianux.com>
References: <523D7DC7.8030603@asianux.com>
Message-ID: <20130924093041.GB15119@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Sep 21, 2013 at 12:06:47PM +0100, Chen Gang wrote:
> The return value of atomic64_add_return() is u64 which never less than
> zero, so need type cast 's64' for comparing in atomic64_add_negative().
> 
> The related error: (allmodconfig for S5PV210, with "EXTRA_CFLAGS=-W"):
> 
>   kernel/events/core.c:5404:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/include/asm/atomic.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index da1c77d..8cf005d 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -475,7 +475,7 @@ static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
>  	return ret;
>  }
>  
> -#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
> +#define atomic64_add_negative(a, v)	((s64)atomic64_add_return((a), (v)) < 0)
>  #define atomic64_inc(v)			atomic64_add(1LL, (v))
>  #define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
>  #define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)

Is this the right fix? It looks more like atomic[64]_t should be signed, but
some 32-bit architectures (ARM, x86, tile) are actually implementing
atomic64_t as u64. Furthermore, there are discrepencies in the operands to
the various atomic64_* function (long long vs u64) which probably need
sorting out.

Since the 32-bit interface is well defined (Documentation/atomic_ops.txt),
I think we should just follow the same signedness rules for the 64-bit
versions.

Will
