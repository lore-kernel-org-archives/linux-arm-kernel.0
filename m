From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:52 +0800
Subject: [PATCH v3 53/62] arm/acpi: Map the new created EFI and ACPI tables to
 Dom0
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-54-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Here we map these new created EFI and ACPI tables to the non-RAM space
of Dom0. Then Dom0 could visit them.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/arm/domain_build.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
index 073c634..55f85b4 100644
--- a/xen/arch/arm/domain_build.c
+++ b/xen/arch/arm/domain_build.c
@@ -1740,6 +1740,21 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
     acpi_create_efi_mmap_table(d->arch.efi_acpi_gpa, d->arch.efi_acpi_table,
                                &kinfo->mem, tbl_add);
 
+    /* Map the EFI and ACPI tables to Dom0 */
+    rc = map_regions(d,
+                     paddr_to_pfn(d->arch.efi_acpi_gpa),
+                     DIV_ROUND_UP(d->arch.efi_acpi_len, PAGE_SIZE),
+                     paddr_to_pfn(virt_to_maddr(d->arch.efi_acpi_table)));
+    if ( rc != 0 )
+    {
+        printk(XENLOG_ERR "Unable to map 0x%"PRIx64
+               " - 0x%"PRIx64" in domain %d\n",
+               d->arch.efi_acpi_gpa & PAGE_MASK,
+               PAGE_ALIGN(d->arch.efi_acpi_gpa + d->arch.efi_acpi_len) - 1,
+               d->domain_id);
+        return rc;
+    }
+
     return 0;
 }
 #else
-- 
2.1.0
