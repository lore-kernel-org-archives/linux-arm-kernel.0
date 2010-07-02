From: srinidhi.kasagar@stericsson.com (srinidhi)
Date: Fri, 2 Jul 2010 16:53:21 +0530
Subject: [patch 2/2] arm: Implement l2x0 cache disable function
In-Reply-To: <AANLkTillHUsJF8brOtHh8tl9Us493GsWfpjhXXsFExY7@mail.gmail.com>
References: <20100701160206.539545857@linutronix.de>
	<20100701160352.249208135@linutronix.de>
	<AANLkTillHUsJF8brOtHh8tl9Us493GsWfpjhXXsFExY7@mail.gmail.com>
Message-ID: <1278069801.4705.298.camel@bnru03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> ---------- Forwarded message ----------
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Thu, Jul 1, 2010 at 9:35 PM
> Subject: [patch 2/2] arm: Implement l2x0 cache disable function
> To: LAK <linux-arm-kernel@lists.infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> 
> 
> This function is called from kexec code before the inner caches are
> disabled to prevent random crashes in the new kernel.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Index: linux-2.6/arch/arm/mm/cache-l2x0.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mm/cache-l2x0.c
> +++ linux-2.6/arch/arm/mm/cache-l2x0.c
> @@ -206,6 +206,12 @@ static void l2x0_flush_range(unsigned lo
>        spin_unlock_irqrestore(&l2x0_lock, flags);
>  }
> 
> +static void l2x0_cache_disable(void)
> +{
> +       l2x0_inv_all();
> +       writel(0, l2x0_base + L2X0_CTRL);
> +}

I think it's a problem for PL310 controller where the access to
L2X0_CTRL is secure, accessing this in non-secure mode will fault.

Srinidhi
