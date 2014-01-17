From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Jan 2014 20:25:08 +0800
Subject: [PATCH 14/20] Irqchip / gic: Set as default domain so we can access
 from ACPI
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1389961514-13562-15-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only one GIC is supported in ACPI 5.0, even cascade GIC is not supported.

So if we set the GIC as the default domain then we can access it for IRQ
mapping within the ACPI code.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 341c601..40fde7b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -963,6 +963,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		register_cpu_notifier(&gic_cpu_notifier);
 #endif
 		set_handle_irq(gic_handle_irq);
+
+		/*
+		 * do not set default host for GIC domain multi-times.
+		 * FIXME: This probably needs revisited when multi GICs
+		 * supported
+		 */
+		irq_set_default_host(gic->domain);
 	}
 
 	gic_chip.flags |= gic_arch_extn.flags;
-- 
1.7.9.5
