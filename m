From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Feb 2018 15:48:49 +0000
Subject: [RFC PATCH v2 08/12] arm64: cmpxchg: Include build_bug.h instead
 of bug.h for BUILD_BUG
In-Reply-To: <1519657500-15094-9-git-send-email-will.deacon@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
 <1519657500-15094-9-git-send-email-will.deacon@arm.com>
Message-ID: <20180226154848.ejqxw5lkbiqqxlsf@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 03:04:56PM +0000, Will Deacon wrote:
> Having asm/cmpxchg.h pull in linux/bug.h is problematic because this
> ends up pulling in the atomic bitops which themselves may be built on
> top of atomic.h and cmpxchg.h.
> 
> Instead, just include build_bug.h for the definition of BUILD_BUG.

We also use VM_BUG_ON(), defined in <linux/mmdebug.h>, which includes
<linux/bug.h>.

... so I think we still have some fragility here, albeit no worse than before.

We also miss includes for:

* <linux/percpu-defs.h> (raw_cpu_ptr)
* <linux/preempt.h> (preempt_disable, preempt_enable)
* <linux/compiler.h> (unreachable)

I'm not sure if those are made worse by this change.

Mark.

> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cmpxchg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index ae852add053d..bc9e07bc6428 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -18,7 +18,7 @@
>  #ifndef __ASM_CMPXCHG_H
>  #define __ASM_CMPXCHG_H
>  
> -#include <linux/bug.h>
> +#include <linux/build_bug.h>
>  
>  #include <asm/atomic.h>
>  #include <asm/barrier.h>
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
