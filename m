From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Apr 2015 13:51:07 +0100
Subject: [RESEND PATCH 4.0-rc7 v20 1/6] irqchip: gic: Optimize locking
 in gic_raise_softirq
In-Reply-To: <1428659511-9590-2-git-send-email-daniel.thompson@linaro.org>
References: <1427216014-5324-1-git-send-email-daniel.thompson@linaro.org>
 <1428659511-9590-1-git-send-email-daniel.thompson@linaro.org>
 <1428659511-9590-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <553647BB.6030408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/15 10:51, Daniel Thompson wrote:
> Currently gic_raise_softirq() is locked using upon irq_controller_lock.
> This lock is primarily used to make register read-modify-write sequences
> atomic but gic_raise_softirq() uses it instead to ensure that the
> big.LITTLE migration logic can figure out when it is safe to migrate
> interrupts between physical cores.
> 
> This is sub-optimal in closely related ways:
> 
> 1. No locking at all is required on systems where the b.L switcher is
>    not configured.
> 
> 2. Finer grain locking can be used on systems where the b.L switcher is
>    present.
> 
> This patch resolves both of the above by introducing a separate finer
> grain lock and providing conditionally compiled inlines to lock/unlock
> it.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Looks good to me.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
