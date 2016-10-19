From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Oct 2016 12:16:29 +0100
Subject: [PATCH] arm64: Cortex-A53 errata workaround: check for kernel
 addresses
In-Reply-To: <20161018111627.17366-1-andre.przywara@arm.com>
References: <20161018111627.17366-1-andre.przywara@arm.com>
Message-ID: <20161019111628.GK9193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 12:16:27PM +0100, Andre Przywara wrote:
> Commit 7dd01aef0557 ("arm64: trap userspace "dc cvau" cache operation on
> errata-affected core") adds code to execute cache maintenance instructions
> in the kernel on behalf of userland on CPUs with certain ARM CPU errata.
> It turns out that the address hasn't been checked to be a valid user
> space address, allowing userland to clean cache lines in kernel space.
> Fix this by introducing an access_ok() check before executing the
> instructions on behalf of userland, taking care of tagged pointers on
> the way.
> 
> Reported-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Cc: <stable@vger.kernel.org> # 4.8.x
> ---
>  arch/arm64/include/asm/uaccess.h |  4 ++++
>  arch/arm64/kernel/traps.c        | 32 ++++++++++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index bcaf6fb..f842b47 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -21,6 +21,7 @@
>  /*
>   * User space memory access functions
>   */
> +#include <linux/bitops.h>
>  #include <linux/kasan-checks.h>
>  #include <linux/string.h>
>  #include <linux/thread_info.h>
> @@ -103,6 +104,9 @@ static inline void set_fs(mm_segment_t fs)
>  })
>  
>  #define access_ok(type, addr, size)	__range_ok(addr, size)
> +#define access_ok_tagged(type, addr, size)  access_ok(type,		       \
> +						      sign_extend64(addr, 55), \
> +						      size)

Sorry for not being clear, but I was actually thinking of a much simpler
macro, say detag_addr, that we could also expose as an asm variant for
the exception entry code.

If you want to modify access_ok, we could call detag_addr by default in
there.

Will
