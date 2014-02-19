From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Feb 2014 13:21:04 +0000
Subject: [PATCH v3 2/5] irqchip: gic: use dmb ishst instead of dsb when
 raising a softirq
In-Reply-To: <1392812917-29302-2-git-send-email-will.deacon@arm.com>
References: <1392812917-29302-1-git-send-email-will.deacon@arm.com>
 <1392812917-29302-2-git-send-email-will.deacon@arm.com>
Message-ID: <5304AFC0.6020202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/14 12:28, Will Deacon wrote:
> When sending an SGI to another CPU, we require a barrier to ensure that
> any pending stores to normal memory are made visible to the recipient
> before the interrupt arrives.
> 
> Rather than use a vanilla dsb() (which will soon cause an assembly error
> on arm64) before the writel_relaxed, we can instead use dsb(ishst),
> since we just need to ensure that any pending normal writes are visible
> within the inner-shareable domain before we poke the GIC.
> 
> With this observation, we can then further weaken the barrier to a
> dmb(ishst), since other CPUs in the inner-shareable domain must observe
> the write to the distributor before the SGI is generated.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

I'll queue a similar fix for the GICv3 code.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
