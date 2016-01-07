From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 07 Jan 2016 14:31:26 +0000
Subject: [PATCH 4.4-rc5 v22 1/4] irqchip: gic: Optimize locking in
 gic_raise_softirq
In-Reply-To: <1450644757-18734-2-git-send-email-daniel.thompson@linaro.org>
References: <1450644757-18734-1-git-send-email-daniel.thompson@linaro.org>
 <1450644757-18734-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <568E76BE.3010702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/12/15 20:52, Daniel Thompson wrote:
> Currently gic_raise_softirq() is locked using irq_controller_lock.
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

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
