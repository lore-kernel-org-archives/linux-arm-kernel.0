From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Sep 2018 20:59:51 +0100
Subject: [PATCH 07/10] irqchip/gic-v3-its: Use pre-programmed redistributor
 tables with kdump kernels
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Message-ID: <20180921195954.21574-8-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If using a kdump kernel, and that we cannot disable LPIs to install
our own tables, let's switch to using the already allocated tables.

This means that we'll change some of the initial kernel's memory,
but at least we'll be able to have LPIs in this secondary kernel.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e29ce9f2ac8a..0b3e76cdde26 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -19,6 +19,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
+#include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/interrupt.h>
@@ -1963,8 +1964,15 @@ static void its_free_pending_table(struct page *pt)
 	free_pages((unsigned long)page_address(pt), get_order(LPI_PENDBASE_SZ));
 }
 
+/*
+ * Booting with kdump and LPIs enabled is generally fine.
+ */
 static bool enabled_lpis_allowed(void)
 {
+	/* Allow a kdump kernel */
+	if (is_kdump_kernel())
+		return true;
+
 	return false;
 }
 
-- 
2.18.0
