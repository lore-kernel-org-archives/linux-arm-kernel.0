From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 10 Aug 2013 16:49:28 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzNdIEFSTTogSW50cm9kdWNlIGF0b21pYyBNTUlPIGNs?=
 =?UTF-8?B?ZWFyL3NldA==?=
In-Reply-To: <1376138582-7550-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376138582-7550-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1376138582-7550-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1376138968.556911297@f376.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Some SoC have MMIO regions that are shared across orthogonal
> subsystems. This commit implements a possible solution for the
> thread-safe access of such regions through a spinlock-protected API
> with clear-set semantics.
> 
> Concurrent access is protected with a single spinlock for the
> entire MMIO address space. While this protects shared-registers,
> it also serializes access to unrelated/unshared registers.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/include/asm/io.h |  5 +++++
>  arch/arm/kernel/io.c      | 24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index d070741..c84658d 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -36,6 +36,11 @@
>  #define isa_bus_to_virt phys_to_virt
>  
>  /*
> + * Atomic MMIO-wide IO clear/set
> + */
> +extern void atomic_io_clear_set(void __iomem *reg, u32 clear, u32 set);
> +
> +/*
>   * Generic IO read/write.  These perform native-endian accesses.  Note
>   * that some architectures will want to re-define __raw_{read,write}w.
>   */
> diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
> index dcd5b4d..3ab8201 100644
> --- a/arch/arm/kernel/io.c
> +++ b/arch/arm/kernel/io.c
> @@ -1,6 +1,30 @@
>  #include <linux/export.h>
>  #include <linux/types.h>
>  #include <linux/io.h>
> +#include <linux/spinlock.h>
> +
> +static DEFINE_SPINLOCK(__io_lock);
> +
> +/*
> + * Some platforms have MMIO regions that are shared across orthogonal
> + * subsystems. This API implements thread-safe access to such regions
> + * through a spinlock-protected API with clear-set semantics.
> + *
> + * Concurrent access is protected with a single spinlock for the entire MMIO
> + * address space. While this protects shared-registers, it also serializes
> + * access to unrelated/unshared registers.
> + *
> + * Using this API on frequently accessed registers in performance-critical
> + * paths is not recommended, as the spinlock used by this API would become
> + * highly contended.
> + */
> +void atomic_io_clear_set(void __iomem *reg, u32 clear, u32 set)
> +{
> +	spin_lock(&__io_lock);
> +	writel((readl(reg) & ~clear) | set, reg);
> +	spin_unlock(&__io_lock);
> +}
> +EXPORT_SYMBOL(atomic_io_clear_set);

So, one lock is used to all possible registers?
Seems a regmap-mmio can be used for such access.

---
