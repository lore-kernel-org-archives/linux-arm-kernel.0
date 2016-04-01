From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Fri,  1 Apr 2016 23:49:08 +0800
Subject: [PATCH v10 10/17] arm/xen: Get event-channel irq through HVM_PARAM
 when booting with ACPI
In-Reply-To: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
References: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1459525755-36968-11-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel will get the event-channel IRQ through
HVM_PARAM_CALLBACK_IRQ.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index d94f726..06bd61a 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -30,6 +30,7 @@
 #include <linux/time64.h>
 #include <linux/timekeeping.h>
 #include <linux/timekeeper_internal.h>
+#include <linux/acpi.h>
 
 #include <linux/mm.h>
 
@@ -278,6 +279,35 @@ void __init xen_early_init(void)
 		add_preferred_console("hvc", 0, NULL);
 }
 
+static void __init xen_acpi_guest_init(void)
+{
+#ifdef CONFIG_ACPI
+	struct xen_hvm_param a;
+	int interrupt, trigger, polarity;
+
+	a.domid = DOMID_SELF;
+	a.index = HVM_PARAM_CALLBACK_IRQ;
+
+	if (HYPERVISOR_hvm_op(HVMOP_get_param, &a)
+	    || (a.value >> 56) != HVM_PARAM_CALLBACK_TYPE_PPI) {
+		xen_events_irq = 0;
+		return;
+	}
+
+	interrupt = a.value & 0xff;
+	trigger = ((a.value >> 8) & 0x1) ? ACPI_EDGE_SENSITIVE
+					 : ACPI_LEVEL_SENSITIVE;
+	polarity = ((a.value >> 8) & 0x2) ? ACPI_ACTIVE_LOW
+					  : ACPI_ACTIVE_HIGH;
+	xen_events_irq = acpi_register_gsi(NULL, interrupt, trigger, polarity);
+#endif
+}
+
+static void __init xen_dt_guest_init(void)
+{
+	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
+}
+
 static int __init xen_guest_init(void)
 {
 	struct xen_add_to_physmap xatp;
@@ -286,7 +316,11 @@ static int __init xen_guest_init(void)
 	if (!xen_domain())
 		return 0;
 
-	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
+	if (!acpi_disabled)
+		xen_acpi_guest_init();
+	else
+		xen_dt_guest_init();
+
 	if (!xen_events_irq) {
 		pr_err("Xen event channel interrupt not found\n");
 		return -ENODEV;
-- 
2.1.4
