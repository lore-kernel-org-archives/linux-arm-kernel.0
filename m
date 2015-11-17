From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:44 +0800
Subject: [PATCH v3 45/62] arm/acpi: Prepare STAO table for Dom0
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-46-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Create STAO table for Dom0. This table is used to tell Dom0 whether it
should ignore UART defined in SPCR table or the ACPI namespace names.

Look at below url for details:
http://wiki.xenproject.org/mediawiki/images/0/02/Status-override-table.pdf

Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/arm/domain_build.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
index 4591955..fb3f150 100644
--- a/xen/arch/arm/domain_build.c
+++ b/xen/arch/arm/domain_build.c
@@ -1359,6 +1359,45 @@ static int prepare_dtb(struct domain *d, struct kernel_info *kinfo)
 #ifdef CONFIG_ACPI
 #define XEN_HYPERVISOR_ID 0x000058656E564D4D  /* "XenVMM" */
 
+static int acpi_create_stao(struct domain *d, struct membank tbl_add[])
+{
+    struct acpi_table_header *table = NULL;
+    struct acpi_table_stao *stao = NULL;
+    u64 table_size = sizeof(struct acpi_table_stao);
+    acpi_status status;
+    u8 *base_ptr;
+    u8 checksum;
+
+    status = acpi_get_table(ACPI_SIG_MADT, 0, &table);
+
+    if ( ACPI_FAILURE(status) )
+    {
+        const char *msg = acpi_format_exception(status);
+
+        printk("Failed to get MADT table, %s\n", msg);
+        return -EINVAL;
+    }
+
+    base_ptr = d->arch.efi_acpi_table
+               + acpi_get_table_offset(tbl_add, TBL_STAO);
+    /* Copy header of one table, here use MADT */
+    ACPI_MEMCPY(base_ptr, table, sizeof(struct acpi_table_header));
+    stao = (struct acpi_table_stao *)base_ptr;
+
+    ACPI_MEMCPY(stao->header.signature, ACPI_SIG_STAO, 4);
+    stao->header.revision = 1;
+    stao->header.length = table_size;
+    stao->ignore_uart = 1;
+    checksum = acpi_tb_checksum(ACPI_CAST_PTR(u8, stao), table_size);
+    stao->header.checksum = stao->header.checksum - checksum;
+
+    tbl_add[TBL_STAO].start = d->arch.efi_acpi_gpa
+                              + acpi_get_table_offset(tbl_add, TBL_STAO);
+    tbl_add[TBL_STAO].size = table_size;
+
+    return 0;
+}
+
 static int acpi_create_madt(struct domain *d, struct membank tbl_add[])
 {
     struct acpi_table_header *table = NULL;
@@ -1561,6 +1600,10 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
     if ( rc != 0 )
         return rc;
 
+    rc = acpi_create_stao(d, tbl_add);
+    if ( rc != 0 )
+        return rc;
+
     return 0;
 }
 #else
-- 
2.1.0
