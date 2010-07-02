From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 02 Jul 2010 12:47:20 +0100
Subject: [patch 2/2] arm: Implement l2x0 cache disable function
In-Reply-To: <20100701160352.249208135@linutronix.de>
References: <20100701160206.539545857@linutronix.de>
	<20100701160352.249208135@linutronix.de>
Message-ID: <1278071240.10162.59.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-01 at 17:05 +0100, Thomas Gleixner wrote:
> This function is called from kexec code before the inner caches are
> disabled to prevent random crashes in the new kernel.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Index: linux-2.6/arch/arm/mm/cache-l2x0.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mm/cache-l2x0.c
> +++ linux-2.6/arch/arm/mm/cache-l2x0.c
> @@ -206,6 +206,12 @@ static void l2x0_flush_range(unsigned lo
>         spin_unlock_irqrestore(&l2x0_lock, flags);
>  }
> 
> +static void l2x0_cache_disable(void)
> +{
> +       l2x0_inv_all();
> +       writel(0, l2x0_base + L2X0_CTRL);
> +}

Even if we go this route, we need an l2x0_flush_all() rather than
invalidate here as the latter removes dirty cache lines without evicting
them first.

-- 
Catalin
