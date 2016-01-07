From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 07 Jan 2016 14:35:46 +0000
Subject: [PATCH 4.4-rc5 v22 2/4] irqchip: gic: Make gic_raise_softirq
 FIQ-safe
In-Reply-To: <1450644757-18734-3-git-send-email-daniel.thompson@linaro.org>
References: <1450644757-18734-1-git-send-email-daniel.thompson@linaro.org>
 <1450644757-18734-3-git-send-email-daniel.thompson@linaro.org>
Message-ID: <568E77C2.9060002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/12/15 20:52, Daniel Thompson wrote:
> It is currently possible for FIQ handlers to re-enter gic_raise_softirq()
> and lock up.
> 
>     	gic_raise_softirq()
> 	   lock(x);
> -~-> FIQ
>         handle_fiq()
> 	   gic_raise_softirq()
> 	      lock(x);		<-- Lockup
> 
> arch/arm/ uses IPIs to implement arch_irq_work_raise(), thus this issue
> renders it difficult for FIQ handlers to safely defer work to less
> restrictive calling contexts.
> 
> This patch fixes the problem by converting the cpu_map_migration_lock
> into a rwlock making it safe to re-enter the function.
> 
> Note that having made it safe to re-enter gic_raise_softirq() we no
> longer need to mask interrupts during gic_raise_softirq() because the
> b.L migration is always performed from task context.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
