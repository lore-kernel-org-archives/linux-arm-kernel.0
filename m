From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:48 +0800
Subject: [PATCH v3 49/62] arm/acpi: Map rest tables for Dom0
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-50-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Map other reused tables for Dom0.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/arm/domain_build.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
index 6ae5761..da4e271 100644
--- a/xen/arch/arm/domain_build.c
+++ b/xen/arch/arm/domain_build.c
@@ -1359,6 +1359,29 @@ static int prepare_dtb(struct domain *d, struct kernel_info *kinfo)
 #ifdef CONFIG_ACPI
 #define XEN_HYPERVISOR_ID 0x000058656E564D4D  /* "XenVMM" */
 
+static void acpi_map_rest_tables(struct domain *d)
+{
+    int i;
+    unsigned long res;
+    u64 addr, size;
+
+    for( i = 0; i < acpi_gbl_root_table_list.count; i++ )
+    {
+        addr = acpi_gbl_root_table_list.tables[i].address;
+        size = acpi_gbl_root_table_list.tables[i].length;
+        res = map_regions(d,
+                          paddr_to_pfn(addr & PAGE_MASK),
+                          DIV_ROUND_UP(size, PAGE_SIZE),
+                          paddr_to_pfn(addr & PAGE_MASK));
+        if ( res )
+        {
+             panic(XENLOG_ERR "Unable to map 0x%"PRIx64
+                   " - 0x%"PRIx64" in domain \n",
+                   addr & PAGE_MASK, PAGE_ALIGN(addr + size) - 1);
+        }
+    }
+}
+
 static int acpi_create_rsdp(struct domain *d, struct membank tbl_add[])
 {
 
@@ -1711,6 +1734,8 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
     if ( rc != 0 )
         return rc;
 
+    acpi_map_rest_tables(d);
+
     return 0;
 }
 #else
-- 
2.1.0
