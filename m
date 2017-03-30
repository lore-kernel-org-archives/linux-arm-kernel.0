From: opendmb@gmail.com (Doug Berger)
Date: Wed, 29 Mar 2017 17:29:11 -0700
Subject: [PATCH v3 3/6] bus: brcmstb_gisb: add notifier handling
In-Reply-To: <20170330002914.7371-1-opendmb@gmail.com>
References: <20170330002914.7371-1-opendmb@gmail.com>
Message-ID: <20170330002914.7371-4-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for GISB arbitration errors through a chained notifier
when a process dies or a kernel panic occurs.  This allows a
meaningful GISB diagnostic message to occur along with other
diagnostic information from the event.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 017c37b9c7c1..a2e1c5c25a3a 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -24,6 +24,9 @@
 #include <linux/of.h>
 #include <linux/bitops.h>
 #include <linux/pm.h>
+#include <linux/kernel.h>
+#include <linux/kdebug.h>
+#include <linux/notifier.h>
 
 #ifdef CONFIG_ARM
 #include <asm/bug.h>
@@ -283,6 +286,36 @@ static irqreturn_t brcmstb_gisb_tea_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Dump out gisb errors on die or panic.
+ */
+static int dump_gisb_error(struct notifier_block *self, unsigned long v,
+			   void *p);
+
+static struct notifier_block gisb_die_notifier = {
+	.notifier_call = dump_gisb_error,
+};
+
+static struct notifier_block gisb_panic_notifier = {
+	.notifier_call = dump_gisb_error,
+};
+
+static int dump_gisb_error(struct notifier_block *self, unsigned long v,
+			   void *p)
+{
+	struct brcmstb_gisb_arb_device *gdev;
+	const char *reason = "panic";
+
+	if (self == &gisb_die_notifier)
+		reason = "die";
+
+	/* iterate over each GISB arb registered handlers */
+	list_for_each_entry(gdev, &brcmstb_gisb_arb_device_list, next)
+		brcmstb_gisb_arb_decode_addr(gdev, reason);
+
+	return NOTIFY_DONE;
+}
+
 static DEVICE_ATTR(gisb_arb_timeout, S_IWUSR | S_IRUGO,
 		gisb_arb_get_timeout, gisb_arb_set_timeout);
 
@@ -390,6 +423,12 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	board_be_handler = brcmstb_bus_error_handler;
 #endif
 
+	if (list_is_singular(&brcmstb_gisb_arb_device_list)) {
+		register_die_notifier(&gisb_die_notifier);
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &gisb_panic_notifier);
+	}
+
 	dev_info(&pdev->dev, "registered mem: %p, irqs: %d, %d\n",
 			gdev->base, timeout_irq, tea_irq);
 
-- 
2.12.0
