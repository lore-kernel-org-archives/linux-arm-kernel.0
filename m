From: james.hogan@imgtec.com (James Hogan)
Date: Mon, 4 Jan 2016 23:24:04 +0000
Subject: [PATCH v2 10/32] metag: reuse asm-generic/barrier.h
In-Reply-To: <1451572003-2440-11-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-11-git-send-email-mst@redhat.com>
Message-ID: <20160104232404.GL17861@jhogan-linux.le.imgtec.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2015 at 09:07:02PM +0200, Michael S. Tsirkin wrote:
> On metag dma_rmb, dma_wmb, smp_store_mb, read_barrier_depends,
> smp_read_barrier_depends, smp_store_release and smp_load_acquire  match
> the asm-generic variants exactly. Drop the local definitions and pull in
> asm-generic/barrier.h instead.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks good, and confirmed no text change (once patch 1 is applied that
is).

Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> ---
>  arch/metag/include/asm/barrier.h | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/metag/include/asm/barrier.h b/arch/metag/include/asm/barrier.h
> index 172b7e5..b5b778b 100644
> --- a/arch/metag/include/asm/barrier.h
> +++ b/arch/metag/include/asm/barrier.h
> @@ -44,9 +44,6 @@ static inline void wr_fence(void)
>  #define rmb()		barrier()
>  #define wmb()		mb()
>  
> -#define dma_rmb()	rmb()
> -#define dma_wmb()	wmb()
> -
>  #ifndef CONFIG_SMP
>  #define fence()		do { } while (0)
>  #define smp_mb()        barrier()
> @@ -81,27 +78,9 @@ static inline void fence(void)
>  #endif
>  #endif
>  
> -#define read_barrier_depends()		do { } while (0)
> -#define smp_read_barrier_depends()	do { } while (0)
> -
> -#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); smp_mb(); } while (0)
> -
> -#define smp_store_release(p, v)						\
> -do {									\
> -	compiletime_assert_atomic_type(*p);				\
> -	smp_mb();							\
> -	WRITE_ONCE(*p, v);						\
> -} while (0)
> -
> -#define smp_load_acquire(p)						\
> -({									\
> -	typeof(*p) ___p1 = READ_ONCE(*p);				\
> -	compiletime_assert_atomic_type(*p);				\
> -	smp_mb();							\
> -	___p1;								\
> -})
> -
>  #define smp_mb__before_atomic()	barrier()
>  #define smp_mb__after_atomic()	barrier()
>  
> +#include <asm-generic/barrier.h>
> +
>  #endif /* _ASM_METAG_BARRIER_H */
> -- 
> MST
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/fd33fa53/attachment.sig>
