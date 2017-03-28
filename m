From: opendmb@gmail.com (Doug Berger)
Date: Tue, 28 Mar 2017 14:34:30 -0700
Subject: [PATCH v2 7/8] bus: brcmstb_gisb: add notifier handling
In-Reply-To: <20170328213431.10904-1-opendmb@gmail.com>
References: <20170328213431.10904-1-opendmb@gmail.com>
Message-ID: <20170328213431.10904-8-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for GISB arbitration errors through a chained notifier
when a process dies or a kernel panic occurs.  This allows a
meaningful diagnostic message to occur along with other
diagnostic information.

Notably writes to a bad GISB address on an ARM64 architecture
kernel cause unrecoverable SError aborts and this allows the
cause of the abort to be seen.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 500b6bb5c739..774729002b8c 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -24,6 +24,8 @@
 #include <linux/of.h>
 #include <linux/bitops.h>
 #include <linux/pm.h>
+#include <linux/kernel.h>
+#include <linux/kdebug.h>
 
 #ifdef CONFIG_ARM
 #include <asm/bug.h>
@@ -290,6 +292,25 @@ static irqreturn_t brcmstb_gisb_tea_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Dump out gisb errors on die or panic.
+ */
+static int dump_gisb_error(struct notifier_block *self, unsigned long v,
+			   void *p)
+{
+	struct brcmstb_gisb_arb_device *gdev;
+
+	/* iterate over each GISB arb registered handlers */
+	list_for_each_entry(gdev, &brcmstb_gisb_arb_device_list, next)
+		brcmstb_gisb_arb_decode_addr(gdev, "async abort");
+
+	return 0;
+}
+
+static struct notifier_block gisb_error_notifier = {
+	.notifier_call = dump_gisb_error,
+};
+
 static DEVICE_ATTR(gisb_arb_timeout, S_IWUSR | S_IRUGO,
 		gisb_arb_get_timeout, gisb_arb_set_timeout);
 
@@ -408,6 +429,12 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	board_be_handler = brcmstb_bus_error_handler;
 #endif
 
+	if (list_is_singular(&brcmstb_gisb_arb_device_list)) {
+		register_die_notifier(&gisb_error_notifier);
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &gisb_error_notifier);
+	}
+
 	dev_info(&pdev->dev, "registered mem: %p, irqs: %d, %d\n",
 			gdev->base, timeout_irq, tea_irq);
 
-- 
2.12.0
