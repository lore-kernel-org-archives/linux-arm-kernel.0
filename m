From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 14 Aug 2015 15:20:25 +0300
Subject: [PATCH v3 1/6] genirq: fix irq_chip_retrigger_hierarchy
In-Reply-To: <1439554830-19502-1-git-send-email-grygorii.strashko@ti.com>
References: <1439554830-19502-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1439554830-19502-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now irq_chip_retrigger_hierarchy() returns -ENOSYS if it
was not able to find at least one .irq_retrigger() callback
implemented in IRQ domain hierarchy. As result, IRQ
re-triggering is not working now on ARM (TI OMAP) where
ARM GIC is not implemented this callback.
The .irq_retrigger() is optional (see check_irq_resend())
and there are no reasons to fail if it was not found, hence
lets return 0 in this case.

In case of TI OMAP DRA7 the following IRQ hierarchy is defined:
ARM GIC <- OMAP wakeupgen <- TI CBAR

Failure is reproduced during resume from suspend to RAM:
- wakeup by IRQx
- suspend_enter
  + arch_suspend_enable_irqs
    + handle_fasteoi_irq
      + irq_may_run
        + irq_pm_check_wakeup
          + irq_disable(IRQx)
  + dpm_resume_noirq()
    + resume_device_irqs
      + resume_irqs
        + resume_irq
          + __enable_irq <== IRQx is not re-triggered

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Fixes: 85f08c17de26 ('genirq: Introduce helper functions...')
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 27f4332..6de638b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -997,7 +997,7 @@ int irq_chip_retrigger_hierarchy(struct irq_data *data)
 		if (data->chip && data->chip->irq_retrigger)
 			return data->chip->irq_retrigger(data);
 
-	return -ENOSYS;
+	return 0;
 }
 
 /**
-- 
2.5.0
