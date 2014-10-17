From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Oct 2014 21:37:06 +0800
Subject: [PATCH v5 10/18] ACPI / table: Print GIC information when MADT is
 parsed
In-Reply-To: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1413553034-20956-11-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When MADT is parsed, print GIC information to make the boot
log look pretty:

ACPI: GICC (acpi_id[0x0000] address[00000000e112f000] MPDIR[0x0] enabled)
ACPI: GICC (acpi_id[0x0001] address[00000000e112f000] MPDIR[0x1] enabled)
...
ACPI: GICC (acpi_id[0x0201] address[00000000e112f000] MPDIR[0x201] enabled)

These information will be very helpful to bring up early systems to
see if acpi_id and MPIDR are matched or not as spec defined.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/tables.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b18e45e..47f36d4 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -183,6 +183,49 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
+		{
+			struct acpi_madt_generic_interrupt *p =
+				(struct acpi_madt_generic_interrupt *)header;
+			pr_info("GICC (acpi_id[0x%04x] address[%p] MPDIR[0x%llx] %s)\n",
+				p->uid, (void *)(unsigned long)p->base_address,
+				p->arm_mpidr,
+				(p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+
+		}
+		break;
+
+	case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
+		{
+			struct acpi_madt_generic_distributor *p =
+				(struct acpi_madt_generic_distributor *)header;
+			pr_info("GIC Distributor (gic_id[0x%04x] address[%p] gsi_base[%d])\n",
+				p->gic_id,
+				(void *)(unsigned long)p->base_address,
+				p->global_irq_base);
+		}
+		break;
+
+	case ACPI_MADT_TYPE_GENERIC_MSI_FRAME:
+		{
+			struct acpi_madt_generic_msi_frame *p =
+				(struct acpi_madt_generic_msi_frame *)header;
+			pr_info("GIC MSI Frame (msi_fame_id[%d] address[%p])\n",
+				p->msi_frame_id,
+				(void *)(unsigned long)p->base_address);
+		}
+		break;
+
+	case ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR:
+		{
+			struct acpi_madt_generic_redistributor *p =
+				(struct acpi_madt_generic_redistributor *)header;
+			pr_info("GIC Redistributor (address[%p] region_size[0x%x])\n",
+				(void *)(unsigned long)p->base_address,
+				p->length);
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
 			header->type);
-- 
1.7.9.5
