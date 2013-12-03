From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed,  4 Dec 2013 00:39:10 +0800
Subject: [RFC part2 PATCH 6/9] Irqchip / gic: Set as default domain so we can
 access from ACPI
In-Reply-To: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1386088753-2850-7-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we set the GIC as the default domain then we can access it for IRQ
mapping within the ACPI code.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 9031171..f522c9a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -957,6 +957,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	if (WARN_ON(!gic->domain))
 		return;
 
+	/*
+	 * do not set default host for GIC domain multi-times.
+	 * FIXME: This probably needs revisited when multi GICs supported
+	 */
+	if (!gic_nr)
+		irq_set_default_host(gic->domain);
+
 #ifdef CONFIG_SMP
 	set_smp_cross_call(gic_raise_softirq);
 	register_cpu_notifier(&gic_cpu_notifier);
-- 
1.7.9.5
