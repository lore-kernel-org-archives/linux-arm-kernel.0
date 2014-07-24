From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 24 Jul 2014 20:59:16 +0800
Subject: [PATCH 2/3] ACPI / ACPICA: Add new features for MADT which introduced
 by ACPI 5.1
In-Reply-To: <1406206757-15512-1-git-send-email-hanjun.guo@linaro.org>
References: <1406206757-15512-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1406206757-15512-3-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Add new features for MADT which introduced by ACPI 5.1:
 -comment on the GIC ID field of the GIC structure which is replaced
  by CPU Interface Number.
 -add new fields: Redistributor Base Address, GICV, GICH, and MPIDR.
 -add new structures for GIC MSI frame and GICR.
 -add flag definition for GICC flags.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/acpi/actbl1.h |   40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 9613e8e..8c91ad6 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -671,7 +671,9 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_LOCAL_X2APIC_NMI = 10,
 	ACPI_MADT_TYPE_GENERIC_INTERRUPT = 11,
 	ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR = 12,
-	ACPI_MADT_TYPE_RESERVED = 13	/* 13 and greater are reserved */
+	ACPI_MADT_TYPE_GIC_MSI_FRAME = 13,
+	ACPI_MADT_TYPE_GIC_REDISTRIBUTOR = 14,
+	ACPI_MADT_TYPE_RESERVED = 15	/* 15 and greater are reserved */
 };
 
 /*
@@ -792,18 +794,23 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];		/* reserved - must be zero */
 };
 
-/* 11: Generic Interrupt (ACPI 5.0) */
+/* 11: Generic Interrupt (ACPI 5.1) */
 
 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
 	u16 reserved;		/* reserved - must be zero */
-	u32 gic_id;
+	u32 gic_id;		/* it was renamed to cpu interface number in ACPI 5.1 */
 	u32 uid;
 	u32 flags;
 	u32 parking_version;
 	u32 performance_interrupt;
 	u64 parked_address;
 	u64 base_address;
+	u64 gicv_base_address;
+	u64 gich_base_address;
+	u32 vgic_maintenance_interrupt;
+	u64 redist_base_address;
+	u64 mpidr;
 };
 
 /* 12: Generic Distributor (ACPI 5.0) */
@@ -817,13 +824,36 @@ struct acpi_madt_generic_distributor {
 	u32 reserved2;		/* reserved - must be zero */
 };
 
+/* 13: GIC MSI Frame (ACPI 5.1) */
+
+struct acpi_madt_gic_msi_frame {
+	struct acpi_subtable_header header;
+	u16 reserved;           /* reserved - must be zero */
+	u32 gic_msi_frame_id;
+	u64 base_address;
+};
+
+/* 14: GIC Redistributor (ACPI 5.1) */
+
+struct acpi_madt_gic_redistributor {
+	struct acpi_subtable_header header;
+	u16 reserved;           /* reserved - must be zero */
+	u64 base_address;
+	u32 region_size;
+};
+
 /*
  * Common flags fields for MADT subtables
  */
 
-/* MADT Local APIC flags (lapic_flags) and GIC flags */
+/* MADT Local APIC flags (lapic_flags) and GICC flags */
+
+#define ACPI_MADT_ENABLED           (1)         /* 00: Processor is usable if set */
+
+/* MADT GICC flags only */
 
-#define ACPI_MADT_ENABLED           (1)	/* 00: Processor is usable if set */
+#define ACPI_MADT_PERF_INT_MODE     (1<<1)	/* 01: Performance Interrupt Mode */
+#define ACPI_MADT_VGIC              (1<<2)	/* 02: VGIC Maintenance interrupt mode */
 
 /* MADT MPS INTI flags (inti_flags) */
 
-- 
1.7.9.5
