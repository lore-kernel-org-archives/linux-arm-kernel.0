From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Jul 2012 10:20:21 +0100
Subject: [RFC PATCH 3/4] ARM: arch_timers: give the virtual timer its own
 interrupt handler
In-Reply-To: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
References: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1341566422-20368-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prepare for the timer interrupt offloading to the hypervisor,
give the virtual timer its own interrupt handler.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/arch_timer.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 2b5da66..4473f66 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -202,6 +202,11 @@ static irqreturn_t arch_timer_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static irqreturn_t arch_timer_virt_handler(int irq, void *dev_id)
+{
+	return arch_timer_handler(irq, dev_id);
+}
+
 static void arch_timer_disable(void)
 {
 	unsigned long ctrl;
@@ -408,6 +413,9 @@ static int __init arch_timer_register(void)
 		if (!arch_timer_ppi[i])
 			continue;
 
+		if (i == VIRT_PPI)
+			handler = arch_timer_virt_handler;
+
 		err = request_percpu_irq(arch_timer_ppi[i], handler,
 					 "arch_timer", arch_timer_evt);
 		if (err) {
-- 
1.7.10.3
