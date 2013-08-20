From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 20 Aug 2013 13:55:13 -0300
Subject: [PATCH v2 1/3] ARM: Introduce atomic MMIO clear/set
In-Reply-To: <1377017307-23201-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377017307-23201-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377017307-23201-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130820165510.GA23311@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 01:48:25PM -0300, Ezequiel Garcia wrote:
> Some SoC have MMIO regions that are shared across orthogonal
> subsystems. This commit implements a possible solution for the
> thread-safe access of such regions through a spinlock-protected API
> with clear-set semantics.
> 
> Concurrent access is protected with a single spinlock for the
> entire MMIO address space. While this protects shared-registers,
> it also serializes access to unrelated/unshared registers.
> 
> ---
> Based on a similar approach suggested by Russel King:
> http://archive.arm.linux.org.uk/lurker/message/20130618.113606.d7d4fe4b.en.html
> 
> Changes from v1:
> 
> * Added an io barrier iowmb() as suggested by Will Deacon,
>   to ensure the writel gets completed before the spin_unlock().

Argh! of course the above goes below the SOB.

> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/include/asm/io.h |  5 +++++
>  arch/arm/kernel/io.c      | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index d070741..3cea1f0 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -36,6 +36,11 @@
>  #define isa_bus_to_virt phys_to_virt
>  
>  /*
> + * Atomic MMIO-wide IO clear/set
> + */
> +extern void atomic_io_clear_set(u32 clear, u32 set, void __iomem *reg);
> +
> +/*
>   * Generic IO read/write.  These perform native-endian accesses.  Note
>   * that some architectures will want to re-define __raw_{read,write}w.
>   */
> diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
> index dcd5b4d..b2a53a3 100644
> --- a/arch/arm/kernel/io.c
> +++ b/arch/arm/kernel/io.c
> @@ -1,6 +1,19 @@
>  #include <linux/export.h>
>  #include <linux/types.h>
>  #include <linux/io.h>
> +#include <linux/spinlock.h>
> +
> +static DEFINE_SPINLOCK(__io_lock);
> +
> +void atomic_io_clear_set(u32 clear, u32 set, void __iomem *reg)
> +{
> +	spin_lock(&__io_lock);
> +	writel((readl(reg) & ~clear) | set, reg);
> +	/* ensure the write get done before unlocking */
> +	__iowmb();
> +	spin_unlock(&__io_lock);
> +}
> +EXPORT_SYMBOL(atomic_io_clear_set);
>  
>  /*
>   * Copy data from IO memory space to "real" memory space.
> -- 
> 1.8.1.5
> 

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
