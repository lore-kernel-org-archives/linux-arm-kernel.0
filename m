From: khilman@ti.com (Kevin Hilman)
Date: Thu,  4 Aug 2011 08:45:06 -0700
Subject: [PATCH 2/6] OMAP3+: SR: ensure pm-runtime callbacks can be invoked
	with IRQs disabled
In-Reply-To: <1312472710-31758-1-git-send-email-khilman@ti.com>
References: <1312472710-31758-1-git-send-email-khilman@ti.com>
Message-ID: <1312472710-31758-3-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

SmartReflex should be disabled while entering low power mode due to
a) SmartReflex values are not defined for retention voltage, further
b) with SmartReflex enabled, if CPU enters lower c-states, FSM will try
to bump the voltage to current OPP's voltage for which it has entered c-state;
hence SmartReflex needs to be disabled for MPU, CORE and IVA voltage
domains in idle path before enabling auto retention voltage achievement
on the device.

However, since the current pm_runtime setup for SmartReflex devices are
setup to allow callbacks to be invoked with interrupts enabled, calling
SmartReflex enable/disable from other contexts such as idle paths
where preemption is disabled causes warnings such as the following
indicating of a potential race.
[   82.023895] [<c04d079c>] (__irq_svc+0x3c/0x120) from [<c04d0484>] (_raw_spin_unlock_irq+0x28/0x2c)
[   82.023895] [<c04d0484>] (_raw_spin_unlock_irq+0x28/0x2c) from [<c0323234>] (rpm_callback+0x4c/0x68)
[   82.023956] [<c0323234>] (rpm_callback+0x4c/0x68) from [<c0323f7c>] (rpm_resume+0x338/0x53c)
[   82.023956] [<c0323f7c>] (rpm_resume+0x338/0x53c) from [<c03243f4>] (__pm_runtime_resume+0x48/0x60)
[   82.023986] [<c03243f4>] (__pm_runtime_resume+0x48/0x60) from [<c008aee0>] (sr_enable+0xa8/0x19c)
[   82.023986] [<c008aee0>] (sr_enable+0xa8/0x19c) from [<c008b2fc>] (omap_sr_enable+0x50/0x90)
[   82.024017] [<c008b2fc>] (omap_sr_enable+0x50/0x90) from [<c00888c0>] (omap4_enter_sleep+0x138/0x168)

Instead, we use pm_runtime_irq_safe to tell the PM core that callbacks can be
invoked in interrupt disabled contexts.

Acked-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
[khilman at ti.com: minor changelog edits]
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 2ce2fb7..dc8e86a 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -860,6 +860,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_irq_safe(&pdev->dev);
 
 	sr_info->pdev = pdev;
 	sr_info->srid = pdev->id;
-- 
1.7.6
