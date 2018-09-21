From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Sep 2018 20:59:53 +0100
Subject: [PATCH 09/10] irqchip/gic-v3-its: Register LPI tables with EFI config
 table
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Message-ID: <20180921195954.21574-10-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upon enabling a redistributor, let's register the allocated tables
with the EFI table that tracks the memory reservations.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4d9604dd6fb1..4912dc57bf07 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -22,6 +22,7 @@
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
+#include <linux/efi.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/list.h>
@@ -1628,6 +1629,14 @@ static void its_free_prop_table(struct page *prop_page)
 		   get_order(LPI_PROPBASE_SZ));
 }
 
+static int gic_reserve_range(phys_addr_t addr, unsigned long size)
+{
+	if (efi_enabled(EFI_CONFIG_TABLES))
+		return efi_mem_reserve_persistent(addr, size);
+
+	return 0;
+}
+
 static int __init its_alloc_lpi_prop_table(void)
 {
 	if (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) {
@@ -1655,6 +1664,8 @@ static int __init its_alloc_lpi_prop_table(void)
 
 		gic_rdists->prop_table_pa = page_to_phys(page);
 		gic_rdists->prop_table_va = page_address(page);
+		WARN_ON(gic_reserve_range(gic_rdists->prop_table_pa,
+					  LPI_PROPBASE_SZ));
 	}
 
 	pr_info("GICv3: using LPI property table @%pa\n",
@@ -2049,6 +2060,7 @@ static void its_cpu_init_lpis(void)
 
 	pend_page = gic_data_rdist()->pend_page;
 	paddr = page_to_phys(pend_page);
+	WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
 
 	/* set PROPBASE */
 	val = (gic_rdists->prop_table_pa |
-- 
2.18.0
