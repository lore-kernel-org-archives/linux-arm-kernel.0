From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 12 Jan 2016 08:31:02 -0800
Subject: [PATCH v3 05/41] powerpc: reuse asm-generic/barrier.h
In-Reply-To: <1452426622-4471-6-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
 <1452426622-4471-6-git-send-email-mst@redhat.com>
Message-ID: <20160112163102.GE3818@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 10, 2016 at 04:17:09PM +0200, Michael S. Tsirkin wrote:
> On powerpc read_barrier_depends, smp_read_barrier_depends
> smp_store_mb(), smp_mb__before_atomic and smp_mb__after_atomic match the
> asm-generic variants exactly. Drop the local definitions and pull in
> asm-generic/barrier.h instead.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks sane to me.

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/barrier.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index a7af5fb..980ad0c 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -34,8 +34,6 @@
>  #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
>  #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
> 
> -#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); smp_mb(); } while (0)
> -
>  #ifdef __SUBARCH_HAS_LWSYNC
>  #    define SMPWMB      LWSYNC
>  #else
> @@ -60,9 +58,6 @@
>  #define smp_wmb()	barrier()
>  #endif /* CONFIG_SMP */
> 
> -#define read_barrier_depends()		do { } while (0)
> -#define smp_read_barrier_depends()	do { } while (0)
> -
>  /*
>   * This is a barrier which prevents following instructions from being
>   * started until the value of the argument x is known.  For example, if
> @@ -87,8 +82,8 @@ do {									\
>  	___p1;								\
>  })
> 
> -#define smp_mb__before_atomic()     smp_mb()
> -#define smp_mb__after_atomic()      smp_mb()
>  #define smp_mb__before_spinlock()   smp_mb()
> 
> +#include <asm-generic/barrier.h>
> +
>  #endif /* _ASM_POWERPC_BARRIER_H */
> -- 
> MST
> 
