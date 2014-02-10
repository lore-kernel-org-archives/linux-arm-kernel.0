From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Feb 2014 16:17:24 +0000
Subject: [PATCH v2 2/5] irqchip: gic: use writel instead of dsb +
 writel_relaxed
In-Reply-To: <1392042159-11603-2-git-send-email-will.deacon@arm.com>
References: <1392042159-11603-1-git-send-email-will.deacon@arm.com>
 <1392042159-11603-2-git-send-email-will.deacon@arm.com>
Message-ID: <20140210161724.GI25305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 02:22:36PM +0000, Will Deacon wrote:
> When sending an SGI to another CPU, we require a DSB to ensure that
> any pending stores to normal memory are made visible to the recipient
> before the interrupt arrives.
> 
> Rather than use a vanilla dsb() (which will soon cause an assembly error
> on arm64) before the writel_relaxed, we can instead use dsb(ishst),
> since we just need to ensure that any pending normal writes are visible
> within the inner-shareable domain before we poke the GIC.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> v1 => v2: Use dsb ishst instead of writel (which requires an L2 sync)
>           since the sync should already have been executed by the caller
> 	  if required. We *might* be able to relax this further to a dmb
> 	  but Catalin and I haven't got to the bottom of that yet.

In the meantime,

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
