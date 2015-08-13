From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 13 Aug 2015 10:30:56 +0100
Subject: [PATCH v2 6/6] irqchip: crossbar: fix irq masking at suspend
In-Reply-To: <1439401562-28874-7-git-send-email-grygorii.strashko@ti.com>
References: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com>
 <1439401562-28874-7-git-send-email-grygorii.strashko@ti.com>
Message-ID: <55CC63D0.8030707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/08/15 18:46, Grygorii Strashko wrote:
> All ARM GIC IRQs have to masked during suspend if they are not
> wakeup source. Now this is not happen, since switching to
> use IRQ domain hierarchy, because suspend_device_irq() only checks flags
> in the last IRQ chip in hierarchy for IRQCHIP_MASK_ON_SUSPEND
> bit set. And in the case of TI OMAP DRA7 the last IRQ chip is TI Crossbar
> which do not have this flag set.
>
> In case of TI OMAP DRA7 the following IRQ hierarchy is defined:
>    ARM GIC <- OMAP wakeupgen <- TI CBAR
> ARM GIC - IRQCHIP_MASK_ON_SUSPEND=n

May be this won't affect your platform or this patch but even GIC marks
IRQCHIP_MASK_ON_SUSPEND=y now since GIC doesn't provide any facility to
configure the wakeup source and keeps all the interrupt source enabled.

We have this flag enabled now as it's always safer to mask all the non
wakeup interrupts are masked at the chip level when suspending.

Also the beginning of the commit message contradicts when you also say
in the following statement IRQCHIP_MASK_ON_SUSPEND=n. So you may need to
update the log.

Regards,
Sudeep
