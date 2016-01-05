From: james.hogan@imgtec.com (James Hogan)
Date: Tue, 5 Jan 2016 00:09:30 +0000
Subject: [PATCH v2 20/32] metag: define __smp_xxx
In-Reply-To: <1451572003-2440-21-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-21-git-send-email-mst@redhat.com>
Message-ID: <20160105000929.GM17861@jhogan-linux.le.imgtec.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Thu, Dec 31, 2015 at 09:08:22PM +0200, Michael S. Tsirkin wrote:
> This defines __smp_xxx barriers for metag,
> for use by virtualization.
> 
> smp_xxx barriers are removed as they are
> defined correctly by asm-generic/barriers.h
> 
> Note: as __smp_XX macros should not depend on CONFIG_SMP, they can not
> use the existing fence() macro since that is defined differently between
> SMP and !SMP.  For this reason, this patch introduces a wrapper
> metag_fence() that doesn't depend on CONFIG_SMP.
> fence() is then defined using that, depending on CONFIG_SMP.

I'm not a fan of the inconsistent commit message wrapping. I wrap to 72
columns (although I now notice SubmittingPatches says to use 75...).

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/metag/include/asm/barrier.h | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/metag/include/asm/barrier.h b/arch/metag/include/asm/barrier.h
> index b5b778b..84880c9 100644
> --- a/arch/metag/include/asm/barrier.h
> +++ b/arch/metag/include/asm/barrier.h
> @@ -44,13 +44,6 @@ static inline void wr_fence(void)
>  #define rmb()		barrier()
>  #define wmb()		mb()
>  
> -#ifndef CONFIG_SMP
> -#define fence()		do { } while (0)
> -#define smp_mb()        barrier()
> -#define smp_rmb()       barrier()
> -#define smp_wmb()       barrier()
> -#else

!SMP kernel text differs, but only because of new presence of unused
metag_fence() inline function. If I #if 0 that out, then it matches, so
thats fine.

> -
>  #ifdef CONFIG_METAG_SMP_WRITE_REORDERING
>  /*
>   * Write to the atomic memory unlock system event register (command 0). This is
> @@ -60,26 +53,31 @@ static inline void wr_fence(void)
>   * incoherence). It is therefore ineffective if used after and on the same
>   * thread as a write.
>   */
> -static inline void fence(void)
> +static inline void metag_fence(void)
>  {
>  	volatile int *flushptr = (volatile int *) LINSYSEVENT_WR_ATOMIC_UNLOCK;
>  	barrier();
>  	*flushptr = 0;
>  	barrier();
>  }
> -#define smp_mb()        fence()
> -#define smp_rmb()       fence()
> -#define smp_wmb()       barrier()
> +#define __smp_mb()        metag_fence()
> +#define __smp_rmb()       metag_fence()
> +#define __smp_wmb()       barrier()
>  #else
> -#define fence()		do { } while (0)
> -#define smp_mb()        barrier()
> -#define smp_rmb()       barrier()
> -#define smp_wmb()       barrier()
> +#define metag_fence()		do { } while (0)
> +#define __smp_mb()        barrier()
> +#define __smp_rmb()       barrier()
> +#define __smp_wmb()       barrier()

Whitespace is now messed up. Admitedly its already inconsistent
tabs/spaces, but it'd be nice if the definitions at least still all
lined up. You're touching all the definitions which use spaces anyway,
so feel free to convert them to tabs while you're at it.

Other than those niggles, it looks sensible to me:
Acked-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>  #endif
> +
> +#ifdef CONFIG_SMP
> +#define fence() metag_fence()
> +#else
> +#define fence()		do { } while (0)
>  #endif
>  
> -#define smp_mb__before_atomic()	barrier()
> -#define smp_mb__after_atomic()	barrier()
> +#define __smp_mb__before_atomic()	barrier()
> +#define __smp_mb__after_atomic()	barrier()
>  
>  #include <asm-generic/barrier.h>
>  
> -- 
> MST
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160105/822d84d1/attachment-0001.sig>
