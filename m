From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 05 Jul 2010 11:54:39 +0100
Subject: [patch 2/2] arm: Implement l2x0 cache disable functions
In-Reply-To: <20100705092105.208597501@linutronix.de>
References: <20100705091706.660272375@linutronix.de>
	<20100705092105.208597501@linutronix.de>
Message-ID: <1278327279.11315.23.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-07-05 at 10:25 +0100, Thomas Gleixner wrote:
> --- linux-2.6.orig/arch/arm/mm/cache-l2x0.c
> +++ linux-2.6/arch/arm/mm/cache-l2x0.c
> @@ -103,7 +103,19 @@ static void l2x0_cache_sync(void)
>         spin_unlock_irqrestore(&l2x0_lock, flags);
>  }
> 
> -static inline void l2x0_inv_all(void)
> +static void l2x0_flush_all(void)
> +{
> +       unsigned long flags;
> +
> +       /* clean all ways */
> +       spin_lock_irqsave(&l2x0_lock, flags);
> +       writel(l2x0_way_mask, l2x0_base + L2X0_CLEAN_WAY);
> +       cache_wait(l2x0_base + L2X0_CLEAN_WAY, l2x0_way_mask);
> +       cache_sync();
> +       spin_unlock_irqrestore(&l2x0_lock, flags);
> +}

Since it only does cleaning, we should probably call it l2x0_clean_all
(the same for the outer_cache_fns entry). I think on ARM we
traditionally referred to flush as clean+invalidate.

-- 
Catalin
