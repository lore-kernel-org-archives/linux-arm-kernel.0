From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 08:28:54 -0300
Subject: [PATCH v3 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <1377253445-2842-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377253445-2842-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377253445-2842-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130823112853.GE2389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 07:24:03AM -0300, Ezequiel Garcia wrote:
> Some SoC have MMIO regions that are shared across orthogonal
> subsystems. This commit implements a possible solution for the
> thread-safe access of such regions through a spinlock-protected API.
> 
> Concurrent access is protected with a single spinlock for the
> entire MMIO address space. While this protects shared-registers,
> it also serializes access to unrelated/unshared registers.
> 
> We add relaxed and non-relaxed variants, by using writel_relaxed and writel,
> respectively. The rationale for this is that some users may not require
> register write completion but only thread-safe access to a register.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Based on a similar approach suggested by Russell King:
> http://archive.arm.linux.org.uk/lurker/message/20130618.113606.d7d4fe4b.en.html
> 
> Changes from v2:
> * As suggested by Will Deacon, dropped the iowmb() barrier
>   and use relaxed variants instead. See Will's explanation for
>   details:
>   http://www.spinics.net/lists/arm-kernel/msg268775.html
> 
> * Use spin_{}_irqsave/restore to allow irq-context usage
>   also suggested by Will Deacon.
> 
> * Re-work the API semantics as proposed by Russell King.
> 
> Changes from v1:
> * Added an io barrier iowmb() as suggested by Will Deacon,
>   to ensure the writel gets completed before the spin_unlock().
> 
>  arch/arm/include/asm/io.h |  6 ++++++
>  arch/arm/kernel/io.c      | 29 +++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index d070741..27521e1 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -36,6 +36,12 @@
>  #define isa_bus_to_virt phys_to_virt
>  
>  /*
> + * Atomic MMIO-wide IO modify
> + */
> +extern void atomic_io_modify(void __iomem *reg, u32 mask, u32 set);
> +extern void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set);
> +
> +/*
>   * Generic IO read/write.  These perform native-endian accesses.  Note
>   * that some architectures will want to re-define __raw_{read,write}w.
>   */
> diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
> index dcd5b4d..651f1ad 100644
> --- a/arch/arm/kernel/io.c
> +++ b/arch/arm/kernel/io.c
> @@ -1,6 +1,35 @@
>  #include <linux/export.h>
>  #include <linux/types.h>
>  #include <linux/io.h>
> +#include <linux/spinlock.h>
> +
> +static DEFINE_SPINLOCK(__io_lock);
> +
> +void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set)
> +{
> +	unsigned long flags;
> +	u32 value;
> +
> +	spin_lock_irqsave(&__io_lock, flags);
> +	value = readl_relaxed(reg) & ~mask;
> +	value |= (set & mask);
> +	writel_relaxed(value, reg);
> +	spin_unlock_irqrestore(&__io_lock, flags);
> +}

And before anyone else screams at me, here's another typo:

> +EXPORT_SYMBOL(atomic_io_modify);
> +


-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
