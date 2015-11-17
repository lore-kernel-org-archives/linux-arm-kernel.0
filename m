From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:14 +0800
Subject: [PATCH v3 15/62] ACPICA: ACPI 6.0: Add changes for MADT table.
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-16-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 02cbb41232bccf7a91967140cab95d5f48291f21

New subtable type. Some additions to existing subtables.

Link: https://github.com/acpica/acpica/commit/02cbb412
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[Linux commit 0cff8dc0099f6d4f7431181918b37a472bcd1bbb]
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/include/acpi/actbl1.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/xen/include/acpi/actbl1.h b/xen/include/acpi/actbl1.h
index 2fb2ad7..7dd6960 100644
--- a/xen/include/acpi/actbl1.h
+++ b/xen/include/acpi/actbl1.h
@@ -643,7 +643,8 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR = 12,
 	ACPI_MADT_TYPE_GENERIC_MSI_FRAME = 13,
 	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR = 14,
-	ACPI_MADT_TYPE_RESERVED = 15    /* 15 and greater are reserved */
+	ACPI_MADT_TYPE_GENERIC_TRANSLATOR = 15,
+	ACPI_MADT_TYPE_RESERVED = 16    /* 16 and greater are reserved */
 };
 
 /*
@@ -764,7 +765,7 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];
 };
 
-/* 11: Generic Interrupt (ACPI 5.0) */
+/* 11: Generic Interrupt (ACPI 5.0 + ACPI 6.0 changes) */
 
 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
@@ -781,6 +782,8 @@ struct acpi_madt_generic_interrupt {
 	u32 vgic_interrupt;
 	u64 gicr_base_address;
 	u64 arm_mpidr;
+	u8 efficiency_class;
+	u8 reserved2[3];
 };
 
 /* Masks for Flags field above */
@@ -789,7 +792,7 @@ struct acpi_madt_generic_interrupt {
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1) /* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2) /* 02: VGIC Maintenance Interrupt mode */
 
-/* 12: Generic Distributor (ACPI 5.0) */
+/* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
 struct acpi_madt_generic_distributor {
 	struct acpi_subtable_header header;
@@ -797,7 +800,8 @@ struct acpi_madt_generic_distributor {
 	u32 gic_id;
 	u64 base_address;
 	u32 global_irq_base;
-	u32 reserved2;          /* reserved - must be zero */
+	u8 version;
+	u8 reserved2[3];          /* reserved - must be zero */
 };
 
 /* 13: GIC MSI Frame (ACPI 5.1) */
@@ -825,6 +829,16 @@ struct acpi_madt_generic_redistributor {
 	u32 length;
 };
 
+/* 15: Generic Translator (ACPI 6.0) */
+
+struct acpi_madt_generic_translator {
+	struct acpi_subtable_header header;
+	u16 reserved;           /* reserved - must be zero */
+	u32 translation_id;
+	u64 base_address;
+	u32 reserved2;
+};
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
2.1.0
