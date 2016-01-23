From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Sat, 23 Jan 2016 11:19:37 +0800
Subject: [PATCH v3 10/17] arm/xen: Get event-channel irq through HVM_PARAM
 when booting with ACPI
In-Reply-To: <1453519184-11908-1-git-send-email-zhaoshenglong@huawei.com>
References: <1453519184-11908-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1453519184-11908-11-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

When booting with ACPI, it could get the event-channel irq through
HVM_PARAM_CALLBACK_IRQ.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm/xen/enlighten.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 6d90a62..0e010bb 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -29,6 +29,7 @@
 #include <linux/time64.h>
 #include <linux/timekeeping.h>
 #include <linux/timekeeper_internal.h>
+#include <linux/acpi.h>
 
 #include <linux/mm.h>
 
@@ -262,6 +263,35 @@ void __init xen_early_init(void)
 		add_preferred_console("hvc", 0, NULL);
 }
 
+static void __init xen_acpi_guest_init_events_irq(void)
+{
+#ifdef CONFIG_ACPI
+	struct xen_hvm_param a;
+	int interrupt, trigger, polarity;
+
+	a.domid = DOMID_SELF;
+	a.index = HVM_PARAM_CALLBACK_IRQ;
+	xen_events_irq = 0;
+
+	if (!HYPERVISOR_hvm_op(HVMOP_get_param, &a)) {
+		if ((a.value >> 56) == HVM_PARAM_CALLBACK_TYPE_EVENT) {
+			interrupt = a.value & 0xff;
+			trigger = ((a.value >> 8) & 0x1) ? ACPI_EDGE_SENSITIVE
+							 : ACPI_LEVEL_SENSITIVE;
+			polarity = ((a.value >> 8) & 0x2) ? ACPI_ACTIVE_LOW
+							  : ACPI_ACTIVE_HIGH;
+			xen_events_irq = acpi_register_gsi(NULL, interrupt,
+							   trigger, polarity);
+		}
+	}
+#endif
+}
+
+static void __init xen_dt_guest_init_events_irq(void)
+{
+	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
+}
+
 static int __init xen_guest_init(void)
 {
 	struct xen_add_to_physmap xatp;
@@ -270,7 +300,11 @@ static int __init xen_guest_init(void)
 	if (!xen_domain())
 		return 0;
 
-	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
+	if (!acpi_disabled)
+		xen_acpi_guest_init_events_irq();
+	else
+		xen_dt_guest_init_events_irq();
+
 	if (!xen_events_irq) {
 		pr_err("Xen event channel interrupt not found\n");
 		return -ENODEV;
-- 
2.0.4
