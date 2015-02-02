From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  2 Feb 2015 20:45:40 +0800
Subject: [PATCH v8 12/21] ACPI / table: Print GIC information when MADT is
 parsed
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1422881149-8177-13-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When MADT is parsed, print GIC information to make the boot
log look pretty:

ACPI: GICC (acpi_id[0x0000] address[00000000e112f000] MPIDR[0x0] enabled)
ACPI: GICC (acpi_id[0x0001] address[00000000e112f000] MPIDR[0x1] enabled)
...
ACPI: GICC (acpi_id[0x0201] address[00000000e112f000] MPIDR[0x201] enabled)

These information will be very helpful to bring up early systems to
see if acpi_id and MPIDR are matched or not as spec defined.

CC: Rafael J. Wysocki <rjw@rjwysocki.net>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/tables.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 93b8152..42d314f 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -183,6 +183,49 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
+		{
+			struct acpi_madt_generic_interrupt *p =
+				(struct acpi_madt_generic_interrupt *)header;
+			pr_info("GICC (acpi_id[0x%04x] address[%p] MPIDR[0x%llx] %s)\n",
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
1.9.1
