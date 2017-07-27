From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Jul 2017 15:38:17 -0700
Subject: [PATCH] irqchip: brcmstb-l2: Define an irq_pm_shutdown function
Message-ID: <20170727223817.7494-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom STB platforms support S5 and we allow specific hardware
wake-up events to take us out of this state. Because we were not
defining an irq_pm_shutdown() function pointer, we would not be
correctly masking non-wakeup events, which would result in spurious
wake-ups from sources that were not explicitly configured for wake-up.

Fixes: 7f646e92766e ("irqchip: brcmstb-l2: Add Broadcom Set Top Box Level-2 interrupt controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index bddf169c4b37..b009b916a292 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -189,6 +189,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 
 	ct->chip.irq_suspend = brcmstb_l2_intc_suspend;
 	ct->chip.irq_resume = brcmstb_l2_intc_resume;
+	ct->chip.irq_pm_shutdown = brcmstb_l2_intc_suspend;
 
 	if (data->can_wake) {
 		/* This IRQ chip can wake the system, set all child interrupts
-- 
2.9.3
