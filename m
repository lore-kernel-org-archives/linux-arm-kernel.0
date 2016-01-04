From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 4 Jan 2016 14:45:25 +0100
Subject: [PATCH v2 22/32] s390: define __smp_xxx
In-Reply-To: <1451572003-2440-23-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-23-git-send-email-mst@redhat.com>
Message-ID: <20160104134525.GA6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2015 at 09:08:38PM +0200, Michael S. Tsirkin wrote:
> This defines __smp_xxx barriers for s390,
> for use by virtualization.
> 
> Some smp_xxx barriers are removed as they are
> defined correctly by asm-generic/barriers.h
> 
> Note: smp_mb, smp_rmb and smp_wmb are defined as full barriers
> unconditionally on this architecture.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/include/asm/barrier.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
> index c358c31..fbd25b2 100644
> --- a/arch/s390/include/asm/barrier.h
> +++ b/arch/s390/include/asm/barrier.h
> @@ -26,18 +26,21 @@
>  #define wmb()				barrier()
>  #define dma_rmb()			mb()
>  #define dma_wmb()			mb()
> -#define smp_mb()			mb()
> -#define smp_rmb()			rmb()
> -#define smp_wmb()			wmb()
> -
> -#define smp_store_release(p, v)						\
> +#define __smp_mb()			mb()
> +#define __smp_rmb()			rmb()
> +#define __smp_wmb()			wmb()
> +#define smp_mb()			__smp_mb()
> +#define smp_rmb()			__smp_rmb()
> +#define smp_wmb()			__smp_wmb()

Why define the smp_*mb() primitives here? Would not the inclusion of
asm-generic/barrier.h do this?
