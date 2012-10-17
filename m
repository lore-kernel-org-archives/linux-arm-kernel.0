From: yanpai.chen@gmail.com (Andrew Yan-Pai Chen)
Date: Wed, 17 Oct 2012 16:42:19 +0800
Subject: [RFC PATCH v2] prevent top pte being overwritten before flushing
In-Reply-To: <1350236542-96465-1-git-send-email-yanpai.chen@gmail.com>
References: <1350236542-96465-1-git-send-email-yanpai.chen@gmail.com>
Message-ID: <CANj_sbCbdfvgkKXJjk4L_5Rk-4mQ-zqDqMErry-AzHddDb8WYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 1:42 AM, Andrew Yan-Pai Chen
<yanpai.chen@gmail.com> wrote:
> From: Yan-Pai Chen <ypchen@faraday-tech.com>
>
> Since flush_pfn_alias() is preemptible, it is possible to be
> preempted just after set_top_pte() is done. If the process
> which preempts the previous happened to invoke flush_pfn_alias()
> with the same colour vaddr as that of the previous, the same
> top pte will be overwritten. When switching back to the previous,
> it attempts to flush cache lines with incorrect mapping. Then
> no lines (or wrong lines) will be flushed because of the nature
> of vipt caches.
>
> flush_icache_alias() has the same problem as well. However, as it
> could be called in SMP setups, we prevent concurrent overwrites of
> top pte by having a lock on it.
>
> Signed-off-by: JasonLin <wwlin@faraday-tech.com>
> Signed-off-by: Yan-Pai Chen <ypchen@faraday-tech.com>
> ---
>  arch/arm/mm/flush.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 40ca11e..b6510f4 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -11,6 +11,7 @@
>  #include <linux/mm.h>
>  #include <linux/pagemap.h>
>  #include <linux/highmem.h>
> +#include <linux/spinlock.h>
>
>  #include <asm/cacheflush.h>
>  #include <asm/cachetype.h>
> @@ -22,11 +23,15 @@
>
>  #ifdef CONFIG_CPU_CACHE_VIPT
>
> +static DEFINE_RAW_SPINLOCK(flush_lock);
> +
> +/* Beware that this function is not to be called for SMP setups. */
>  static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
>  {
>         unsigned long to = FLUSH_ALIAS_START + (CACHE_COLOUR(vaddr) <<
> PAGE_SHIFT);
>         const int zero = 0;
>
> +       preempt_disable();
>         set_top_pte(to, pfn_pte(pfn, PAGE_KERNEL));
>
>         asm(    "mcrr   p15, 0, %1, %0, c14\n"
> @@ -34,6 +39,8 @@ static void flush_pfn_alias(unsigned long pfn, unsigned
> long vaddr)
>             :
>             : "r" (to), "r" (to + PAGE_SIZE - L1_CACHE_BYTES), "r" (zero)
>             : "cc");
> +
> +       preempt_enable();
>  }
>
>  static void flush_icache_alias(unsigned long pfn, unsigned long vaddr,
> unsigned long len)
> @@ -42,9 +49,13 @@ static void flush_icache_alias(unsigned long pfn,
> unsigned long vaddr, unsigned
>         unsigned long offset = vaddr & (PAGE_SIZE - 1);
>         unsigned long to;
>
> +       raw_spin_lock(&flush_lock);
> +
>         set_top_pte(va, pfn_pte(pfn, PAGE_KERNEL));
>         to = va + offset;
>         flush_icache_range(to, to + len);
> +
> +       raw_spin_unlock(&flush_lock);
>  }
>
>  void flush_cache_mm(struct mm_struct *mm)
> --
> 1.7.4.1
>

Hi all,

Any ideas?
