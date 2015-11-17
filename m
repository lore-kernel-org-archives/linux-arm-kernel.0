From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:51 +0800
Subject: [PATCH v3 52/62] arm/acpi: Prepare EFI memory descriptor for Dom0
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-53-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Create a few EFI memory descriptors to tell Dom0 the RAM region
information, ACPI table regions and EFI tables reserved resions.

Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/arm/domain_build.c |  2 ++
 xen/common/efi/boot.c       | 48 +++++++++++++++++++++++++++++++++++++++++++++
 xen/include/asm-arm/setup.h |  4 ++++
 3 files changed, 54 insertions(+)

diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
index 9d667ea..073c634 100644
--- a/xen/arch/arm/domain_build.c
+++ b/xen/arch/arm/domain_build.c
@@ -1737,6 +1737,8 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
     acpi_map_rest_tables(d);
     acpi_create_efi_system_table(d->arch.efi_acpi_gpa, d->arch.efi_acpi_table,
                                  tbl_add);
+    acpi_create_efi_mmap_table(d->arch.efi_acpi_gpa, d->arch.efi_acpi_table,
+                               &kinfo->mem, tbl_add);
 
     return 0;
 }
diff --git a/xen/common/efi/boot.c b/xen/common/efi/boot.c
index 75835ae..ff2faed 100644
--- a/xen/common/efi/boot.c
+++ b/xen/common/efi/boot.c
@@ -1256,6 +1256,54 @@ void __init acpi_create_efi_system_table(paddr_t paddr, void *efi_acpi_table,
     tbl_add[TBL_EFIT].start = table_addr;
     tbl_add[TBL_EFIT].size = table_size;
 }
+
+void __init acpi_create_efi_mmap_table(paddr_t paddr, void *efi_acpi_table,
+                                       const struct meminfo *mem,
+                                       struct membank tbl_add[])
+{
+    EFI_MEMORY_DESCRIPTOR *memory_map;
+    int i, offset;
+    u8 *base_ptr;
+
+    tbl_add[TBL_MMAP].start = paddr + acpi_get_table_offset(tbl_add, TBL_MMAP);
+    tbl_add[TBL_MMAP].size = sizeof(EFI_MEMORY_DESCRIPTOR)
+                             * (mem->nr_banks + acpi_mem.nr_banks + TBL_MMAX);
+    base_ptr = efi_acpi_table + acpi_get_table_offset(tbl_add, TBL_MMAP);
+    memory_map = (EFI_MEMORY_DESCRIPTOR *)(base_ptr);
+
+    offset = 0;
+    for( i = 0; i < mem->nr_banks; i++, offset++ )
+    {
+        memory_map[offset].Type = EfiConventionalMemory;
+        memory_map[offset].PhysicalStart = mem->bank[i].start;
+        memory_map[offset].NumberOfPages = mem->bank[i].size/PAGE_SIZE;
+        memory_map[offset].Attribute = EFI_MEMORY_WB;
+    }
+
+    for( i = 0; i < acpi_mem.nr_banks; i++, offset++ )
+    {
+        memory_map[offset].Type = EfiACPIReclaimMemory;
+        memory_map[offset].PhysicalStart = acpi_mem.bank[i].start;
+        memory_map[offset].NumberOfPages = acpi_mem.bank[i].size/PAGE_SIZE;
+        memory_map[offset].Attribute = EFI_MEMORY_WB;
+    }
+
+    for( i = 0; i < TBL_EFIT; i++, offset++ )
+    {
+        memory_map[offset].Type = EfiACPIReclaimMemory;
+        memory_map[offset].PhysicalStart = tbl_add[i].start;
+        memory_map[offset].NumberOfPages =tbl_add[i].size/PAGE_SIZE;
+        memory_map[offset].Attribute = EFI_MEMORY_WB;
+    }
+
+    for( i = TBL_EFIT; i < TBL_MMAX; i++, offset++ )
+    {
+        memory_map[offset].Type = EfiReservedMemoryType;
+        memory_map[offset].PhysicalStart = tbl_add[i].start;
+        memory_map[offset].NumberOfPages =tbl_add[i].size/PAGE_SIZE;
+        memory_map[offset].Attribute = EFI_MEMORY_WB;
+    }
+}
 #endif
 
 #ifndef CONFIG_ARM /* TODO - runtime service support */
diff --git a/xen/include/asm-arm/setup.h b/xen/include/asm-arm/setup.h
index 2d65796..35447ee 100644
--- a/xen/include/asm-arm/setup.h
+++ b/xen/include/asm-arm/setup.h
@@ -56,6 +56,10 @@ int estimate_efi_size(int mem_nr_banks);
 void acpi_create_efi_system_table(paddr_t paddr, void *efi_acpi_table,
                                   struct membank tbl_add[]);
 
+void acpi_create_efi_mmap_table(paddr_t paddr, void *efi_acpi_table,
+                                const struct meminfo *mem,
+                                struct membank tbl_add[]);
+
 int construct_dom0(struct domain *d);
 
 void discard_initial_modules(void);
-- 
2.1.0
