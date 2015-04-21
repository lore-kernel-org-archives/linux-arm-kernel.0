From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Apr 2015 13:54:31 +0100
Subject: [RESEND PATCH 4.0-rc7 v20 2/6] irqchip: gic: Make
 gic_raise_softirq FIQ-safe
In-Reply-To: <1428659511-9590-3-git-send-email-daniel.thompson@linaro.org>
References: <1427216014-5324-1-git-send-email-daniel.thompson@linaro.org>
 <1428659511-9590-1-git-send-email-daniel.thompson@linaro.org>
 <1428659511-9590-3-git-send-email-daniel.thompson@linaro.org>
Message-ID: <55364887.2000404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/15 10:51, Daniel Thompson wrote:
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
