From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:55 +0800
Subject: [PATCH v3 56/62] arm/acpi: Deny MMIO access of UART
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-57-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Firstly it permits full MMIO capabilities for Dom0. Then deny MMIO
access of UART device.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/arm/domain_build.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
index 6945f89..9532807 100644
--- a/xen/arch/arm/domain_build.c
+++ b/xen/arch/arm/domain_build.c
@@ -1360,6 +1360,32 @@ static int prepare_dtb(struct domain *d, struct kernel_info *kinfo)
 #define XEN_HYPERVISOR_ID 0x000058656E564D4D  /* "XenVMM" */
 #define ACPI_DOM0_FDT_MIN_SIZE 4096
 
+static int acpi_iomem_deny_access(struct domain *d)
+{
+    acpi_status status;
+    struct acpi_table_spcr *spcr=NULL;
+    unsigned long gfn;
+    int rc;
+
+    /* Firstly permit full MMIO capabilities. */
+    rc = iomem_permit_access(d, 0UL, ~0UL);
+    if (rc)
+        return rc;
+
+    status = acpi_get_table(ACPI_SIG_SPCR, 0,
+                            (struct acpi_table_header **)&spcr);
+
+    if ( ACPI_FAILURE(status) )
+    {
+        printk("Failed to get SPCR table\n");
+        return -EINVAL;
+    }
+
+    gfn = spcr->serial_port.address >> PAGE_SHIFT;
+    /* Deny MMIO access for UART */
+    return iomem_deny_access(d, gfn, gfn + 1);
+}
+
 static int acpi_route_spi(struct domain *d)
 {
     int i, res;
@@ -1930,6 +1956,10 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
     if ( rc != 0 )
         return rc;
 
+    rc = acpi_iomem_deny_access(d);
+    if ( rc != 0 )
+        return rc;
+
     return 0;
 }
 #else
-- 
2.1.0
