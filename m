From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:13 +0800
Subject: [PATCH v3 14/62] arm/acpi: Add Generic Interrupt and Distributor
 struct
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-15-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Add Generic Interrupt and Distributor (ACPI 5.0) structure.
Add new features for MADT introduced by ACPI 5.1.
Comment on the GIC ID field of the GIC structure which is replaced
by CPU Interface Number.
Add new fields: Redistributor Base Address, GICV, GICH, and MPIDR.
Add new structures for GIC MSI frame and GICR.
Add flag definition for GICC flags.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/include/acpi/actbl1.h | 69 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/xen/include/acpi/actbl1.h b/xen/include/acpi/actbl1.h
index 9311e3a..2fb2ad7 100644
--- a/xen/include/acpi/actbl1.h
+++ b/xen/include/acpi/actbl1.h
@@ -639,7 +639,11 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_INTERRUPT_SOURCE = 8,
 	ACPI_MADT_TYPE_LOCAL_X2APIC = 9,
 	ACPI_MADT_TYPE_LOCAL_X2APIC_NMI = 10,
-	ACPI_MADT_TYPE_RESERVED = 11	/* 11 and greater are reserved */
+	ACPI_MADT_TYPE_GENERIC_INTERRUPT = 11,
+	ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR = 12,
+	ACPI_MADT_TYPE_GENERIC_MSI_FRAME = 13,
+	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR = 14,
+	ACPI_MADT_TYPE_RESERVED = 15    /* 15 and greater are reserved */
 };
 
 /*
@@ -760,11 +764,72 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];
 };
 
+/* 11: Generic Interrupt (ACPI 5.0) */
+
+struct acpi_madt_generic_interrupt {
+	struct acpi_subtable_header header;
+	u16 reserved;           /* reserved - must be zero */
+	u32 cpu_interface_number;
+	u32 uid;
+	u32 flags;
+	u32 parking_version;
+	u32 performance_interrupt;
+	u64 parked_address;
+	u64 base_address;
+	u64 gicv_base_address;
+	u64 gich_base_address;
+	u32 vgic_interrupt;
+	u64 gicr_base_address;
+	u64 arm_mpidr;
+};
+
+/* Masks for Flags field above */
+
+/* ACPI_MADT_ENABLED                    (1)      Processor is usable if set */
+#define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1) /* 01: Performance Interrupt Mode */
+#define ACPI_MADT_VGIC_IRQ_MODE         (1<<2) /* 02: VGIC Maintenance Interrupt mode */
+
+/* 12: Generic Distributor (ACPI 5.0) */
+
+struct acpi_madt_generic_distributor {
+	struct acpi_subtable_header header;
+	u16 reserved;           /* reserved - must be zero */
+	u32 gic_id;
+	u64 base_address;
+	u32 global_irq_base;
+	u32 reserved2;          /* reserved - must be zero */
+};
+
+/* 13: GIC MSI Frame (ACPI 5.1) */
+
+struct acpi_madt_generic_msi_frame {
+	struct acpi_subtable_header header;
+	u16 reserved;		/* reserved - must be zero */
+	u32 msi_frame_id;
+	u64 base_address;
+	u32 flags;
+	u16 spi_count;
+	u16 spi_base;
+};
+
+/* Masks for Flags field above */
+
+#define ACPI_MADT_OVERRIDE_SPI_VALUES   (1)
+
+/* 14: GIC Redistributor (ACPI 5.1) */
+
+struct acpi_madt_generic_redistributor {
+	struct acpi_subtable_header header;
+	u16 reserved;		/* reserved - must be zero */
+	u64 base_address;
+	u32 length;
+};
+
 /*
  * Common flags fields for MADT subtables
  */
 
-/* MADT Local APIC flags (lapic_flags) */
+/* MADT Local APIC flags */
 
 #define ACPI_MADT_ENABLED           (1)	/* 00: Processor is usable if set */
 
-- 
2.1.0
