From: wuyun.wu@huawei.com (Yun Wu)
Date: Fri, 30 Jan 2015 15:46:49 +0800
Subject: [PATCH 5/5] irqchip: gicv3-its: add support for power down
In-Reply-To: <1422604009-9248-1-git-send-email-wuyun.wu@huawei.com>
References: <1422604009-9248-1-git-send-email-wuyun.wu@huawei.com>
Message-ID: <1422604009-9248-6-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configurations of an ITS cannot be changed if the ITS is in an
active status, so it might not be safe to perform a soft reboot
with all the active ITSes un-disabled, etc. kexec.

This patch will make sure all the active ITSes disabled before
enabling them again without resetting ITS hardware.

Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index facf6d6..1d85471 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -29,6 +29,7 @@
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/reboot.h>

 #include <linux/irqchip/arm-gic-v3.h>

@@ -1410,6 +1411,63 @@ int its_cpu_init(void)
 	return 0;
 }

+static void its_disable(struct its_node *its)
+{
+	u32 count = 1000000;	/* 1s */
+	u32 val;
+
+	/* Disable the generation of all interrupts to this ITS */
+	val = readl_relaxed(its->base + GITS_CTLR);
+	val &= ~GITS_CTLR_ENABLE;
+	writel_relaxed(val, its->base + GITS_CTLR);
+
+	/* Poll GITS_CTLR and wait until ITS becomes quiescent */
+	while (count--) {
+		val = readl_relaxed(its->base + GITS_CTLR);
+		if (val & GITS_CTLR_QUIESCENT)
+			break;
+		cpu_relax();
+		udelay(1);
+	}
+
+	if (!count)
+		pr_err("%s: failed to shutdown!\n",
+		       its->msi_chip.of_node->full_name);
+
+	/*
+	 * Release all resources of this ITS node to completely put
+	 * an end to it. Note that this step may not be necessary
+	 * in some cases, but leaving it here does no harm.
+	 */
+	irq_domain_remove(its->msi_chip.domain);
+	irq_domain_remove(its->domain);
+	its_free_tables(its);
+	kfree(its->cmd_base);
+	iounmap(its->base);
+
+	spin_lock(&its_lock);
+	list_del(&its->entry);
+	spin_unlock(&its_lock);
+	kfree(its);
+}
+
+static int its_shutdown(struct notifier_block *nfb, unsigned long val, void *v)
+{
+	struct its_node *its, *tmp;
+
+	list_for_each_entry_safe(its, tmp, &its_nodes, entry)
+		its_disable(its);
+
+	kfree(gic_rdists->prop_page);
+	kfree(lpi_bitmap);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block its_reboot_notifier = {
+	.notifier_call	= its_shutdown,
+};
+
 static struct of_device_id its_device_id[] = {
 	{	.compatible	= "arm,gic-v3-its",	},
 	{},
@@ -1435,6 +1493,7 @@ int its_init(struct device_node *node, struct rdists *rdists,

 	its_alloc_lpi_tables();
 	its_lpi_init(rdists->id_bits);
+	register_reboot_notifier(&its_reboot_notifier);

 	return 0;
 }
--
1.8.0
