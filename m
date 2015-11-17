From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:10 +0800
Subject: [PATCH v3 11/62] arm/acpi: Introduce ARM Boot Architecture Flags in
 FADT
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-12-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

The Power State Coordination Interface (PSCI) defines an API that
can be used to coordinate power control amongst the various supervisory
systems concurrently running on a device. ACPI support for this
technology would require the addition of two flags: PSCI_COMPLIANT and
PSCI_USE_HVC. When set, the former signals to the OS that the hardware
is PSCI compliant. The latter selects the appropriate conduit for PSCI
calls by toggling between Hypervisor Calls (HVC) and Secure Monitor
Calls (SMC).

An ARM Boot Architecture Flags structure to support new ARM hardware
was introduced in FADT in ACPI 5.1, add the code accordingly to
implement that in ACPICA core.

Since ACPI 5.1 doesn't support self defined PSCI function IDs,
which means that only PSCI 0.2+ is supported in ACPI.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/include/acpi/actbl.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/xen/include/acpi/actbl.h b/xen/include/acpi/actbl.h
index 856945d..66e29c3 100644
--- a/xen/include/acpi/actbl.h
+++ b/xen/include/acpi/actbl.h
@@ -244,7 +244,8 @@ struct acpi_table_fadt {
 	u32 flags;		/* Miscellaneous flag bits (see below for individual flags) */
 	struct acpi_generic_address reset_register;	/* 64-bit address of the Reset register */
 	u8 reset_value;		/* Value to write to the reset_register port to reset the system */
-	u8 reserved4[3];	/* Reserved, must be zero */
+	u16 arm_boot_flags;     /* ARM-Specific Boot Flags (see below for individual flags) (ACPI 5.1) */
+	u8 minor_revision;      /* FADT Minor Revision (ACPI 5.1) */
 	u64 Xfacs;		/* 64-bit physical address of FACS */
 	u64 Xdsdt;		/* 64-bit physical address of DSDT */
 	struct acpi_generic_address xpm1a_event_block;	/* 64-bit Extended Power Mgt 1a Event Reg Blk address */
@@ -259,7 +260,7 @@ struct acpi_table_fadt {
 	struct acpi_generic_address sleep_status;	/* 64-bit Sleep Status register */
 };
 
-/* Masks for FADT Boot Architecture Flags (boot_flags) */
+/* Masks for FADT IA-PC Boot Architecture Flags (boot_flags) */
 
 #define ACPI_FADT_LEGACY_DEVICES    (1)  	/* 00: [V2] System has LPC or ISA bus devices */
 #define ACPI_FADT_8042              (1<<1)	/* 01: [V3] System has an 8042 controller on port 60/64 */
@@ -270,6 +271,11 @@ struct acpi_table_fadt {
 
 #define FADT2_REVISION_ID               3
 
+/* Masks for FADT ARM Boot Architecture Flags (arm_boot_flags) ACPI 5.1 */
+
+#define ACPI_FADT_PSCI_COMPLIANT    (1)        /* 00:  [V5+] PSCI 0.2+ is implemented */
+#define ACPI_FADT_PSCI_USE_HVC      (1<<1)     /* 01:  [V5+] HVC must be used instead of SMC as the PSCI conduit */
+
 /* Masks for FADT flags */
 
 #define ACPI_FADT_WBINVD            (1)	/* 00: [V1] The wbinvd instruction works properly */
@@ -345,7 +351,7 @@ enum acpi_prefered_pm_profiles {
  *     FADT V5  size: 0x10C
  */
 #define ACPI_FADT_V1_SIZE       (u32) (ACPI_FADT_OFFSET (flags) + 4)
-#define ACPI_FADT_V2_SIZE       (u32) (ACPI_FADT_OFFSET (reserved4[0]) + 3)
+#define ACPI_FADT_V2_SIZE       (u32) (ACPI_FADT_OFFSET (minor_revision) + 1)
 #define ACPI_FADT_V3_SIZE       (u32) (ACPI_FADT_OFFSET (sleep_control))
 #define ACPI_FADT_V5_SIZE       (u32) (sizeof (struct acpi_table_fadt))
 
-- 
2.1.0
