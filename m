From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 24 Jul 2014 21:00:14 +0800
Subject: [PATCH 08/19] ACPI / table: Print GIC information when MADT is parsed
In-Reply-To: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1406206825-15590-9-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When MADT is parsed, print GIC information to make the boot
log look pretty.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/tables.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 6d5a6cd..8bb8159 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -183,6 +183,44 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
+		{
+			struct acpi_madt_generic_interrupt *p =
+				(struct acpi_madt_generic_interrupt *)header;
+			pr_info("GICC (acpi_id[0x%04x] cpu_address[0x%08llx] MPDIR[0x%llx] %s)\n",
+				p->uid, p->base_address, p->mpidr,
+				(p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+
+		}
+		break;
+
+	case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
+		{
+			struct acpi_madt_generic_distributor *p =
+				(struct acpi_madt_generic_distributor *)header;
+			pr_info("GIC Distributor (id[0x%04x] address[0x%08llx] gsi_base[%d])\n",
+				p->gic_id, p->base_address, p->global_irq_base);
+		}
+		break;
+
+	case ACPI_MADT_TYPE_GIC_MSI_FRAME:
+		{
+			struct acpi_madt_gic_msi_frame *p =
+				(struct acpi_madt_gic_msi_frame *)header;
+			pr_info("GIC MSI Frame (address[0x%08llx] msi_fame_id[%d])\n",
+				p->base_address, p->gic_msi_frame_id);
+		}
+		break;
+
+	case ACPI_MADT_TYPE_GIC_REDISTRIBUTOR:
+		{
+			struct acpi_madt_gic_redistributor *p =
+				(struct acpi_madt_gic_redistributor *)header;
+			pr_info("GIC Redistributor (address[0x%08llx] region_size[0x%x])\n",
+				p->base_address, p->region_size);
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
 			header->type);
@@ -190,7 +228,6 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
-
 int __init
 acpi_table_parse_entries(char *id,
 			     unsigned long table_size,
-- 
1.7.9.5
