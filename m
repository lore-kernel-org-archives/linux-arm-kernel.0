From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Oct 2012 10:10:06 +0100
Subject: [RFC] arm/mm: add a protection when flushing anonymous pages
In-Reply-To: <CANj_sbADwtPR6cgk05QkmvrSUOOQRYXB9vPB6KATKEmwcN8UrA@mail.gmail.com>
References: <CAGCDX1mY4wbMq4qDJ9vCazShxdWQXVYyWkpLd5u8_xqbEC2BWQ@mail.gmail.com>
 <CAGCDX1mkPVre6h=9kNbRqCp_wtbOneuRLMXM+mkZWFXPwWkBfg@mail.gmail.com>
 <CANj_sbADwtPR6cgk05QkmvrSUOOQRYXB9vPB6KATKEmwcN8UrA@mail.gmail.com>
Message-ID: <20121005091006.GM4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 03:07:33PM +0800, Andrew Yan-Pai Chen wrote:
> [RFC PATCH] make flush_pfn_alias() nonpreemptible
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
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 40ca11e..bd07918 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -27,6 +27,8 @@ static void flush_pfn_alias(unsigned long pfn,
> unsigned long vaddr)
>         unsigned long to = FLUSH_ALIAS_START + (CACHE_COLOUR(vaddr) <<
> PAGE_SHIFT);
>         const int zero = 0;
> 
> +       preempt_disable();
> +
>         set_top_pte(to, pfn_pte(pfn, PAGE_KERNEL));
> 
>         asm(    "mcrr   p15, 0, %1, %0, c14\n"
> @@ -34,6 +36,8 @@ static void flush_pfn_alias(unsigned long pfn,
> unsigned long vaddr)
>             :
>             : "r" (to), "r" (to + PAGE_SIZE - L1_CACHE_BYTES), "r" (zero)
>             : "cc");
> +
> +       preempt_enable();
>  }

This looks like it's quite correct, but if you look at the file a little
deeper, you'll notice that flush_icache_alias() potentially suffers the
same issue.

They should probably both also have a comment indicating that they're not
to be called for SMP setups (because there's no locking for that.)
