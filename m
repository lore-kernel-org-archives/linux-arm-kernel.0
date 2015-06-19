From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 19 Jun 2015 16:46:04 +0800
Subject: [PATCH v2 1/9] ACPICA: ACPI 6.0: Add changes for MADT table.
In-Reply-To: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1434703572-26221-2-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 02cbb41232bccf7a91967140cab95d5f48291f21

New subtable type. Some additions to existing subtables.

Link: https://github.com/acpica/acpica/commit/02cbb412
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is already merged into APCICA core, sending
them out just for the help of better understanding later
GIC related code.

 include/acpi/actbl1.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index b80b0e6..cadf21c 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -673,7 +673,8 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR = 12,
 	ACPI_MADT_TYPE_GENERIC_MSI_FRAME = 13,
 	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR = 14,
-	ACPI_MADT_TYPE_RESERVED = 15	/* 15 and greater are reserved */
+	ACPI_MADT_TYPE_GENERIC_TRANSLATOR = 15,
+	ACPI_MADT_TYPE_RESERVED = 16	/* 16 and greater are reserved */
 };
 
 /*
@@ -794,7 +795,7 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];		/* reserved - must be zero */
 };
 
-/* 11: Generic Interrupt (ACPI 5.0) */
+/* 11: Generic Interrupt (ACPI 5.0 + ACPI 6.0 changes) */
 
 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
@@ -811,6 +812,8 @@ struct acpi_madt_generic_interrupt {
 	u32 vgic_interrupt;
 	u64 gicr_base_address;
 	u64 arm_mpidr;
+	u8 efficiency_class;
+	u8 reserved2[3];
 };
 
 /* Masks for Flags field above */
@@ -819,7 +822,7 @@ struct acpi_madt_generic_interrupt {
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintenance Interrupt mode */
 
-/* 12: Generic Distributor (ACPI 5.0) */
+/* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
 struct acpi_madt_generic_distributor {
 	struct acpi_subtable_header header;
@@ -827,7 +830,8 @@ struct acpi_madt_generic_distributor {
 	u32 gic_id;
 	u64 base_address;
 	u32 global_irq_base;
-	u32 reserved2;		/* reserved - must be zero */
+	u8 version;
+	u8 reserved2[3];	/* reserved - must be zero */
 };
 
 /* 13: Generic MSI Frame (ACPI 5.1) */
@@ -855,6 +859,16 @@ struct acpi_madt_generic_redistributor {
 	u32 length;
 };
 
+/* 15: Generic Translator (ACPI 6.0) */
+
+struct acpi_madt_generic_translator {
+	struct acpi_subtable_header header;
+	u16 reserved;		/* reserved - must be zero */
+	u32 translation_id;
+	u64 base_address;
+	u32 reserved2;
+};
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
1.9.1
