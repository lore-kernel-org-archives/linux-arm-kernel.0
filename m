From: al.stone@linaro.org (Al Stone)
Date: Thu, 18 Jun 2015 16:36:08 -0600
Subject: [PATCH v2 3/3] ACPI / ARM64 : use the new BAD_MADT_GICC_ENTRY macro
In-Reply-To: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
Message-ID: <1434666968-1543-4-git-send-email-al.stone@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For those parts of the arm64 ACPI code that need to check GICC subtables
in the MADT, use the new BAD_MADT_GICC_ENTRY macro instead of the previous
BAD_MADT_ENTRY.  The new macro takes into account differences in the size
of the GICC subtable that the old macro did not; this caused failures even
though the subtable entries are valid.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 arch/arm64/kernel/smp.c   | 2 +-
 drivers/irqchip/irq-gic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4b2121b..80d5984 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -438,7 +438,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
 	struct acpi_madt_generic_interrupt *processor;
 
 	processor = (struct acpi_madt_generic_interrupt *)header;
-	if (BAD_MADT_ENTRY(processor, end))
+	if (BAD_MADT_GICC_ENTRY(processor, end))
 		return -EINVAL;
 
 	acpi_table_print_madt_entry(header);
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 8d7e1c8..4dd8826 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1055,7 +1055,7 @@ gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
 
 	processor = (struct acpi_madt_generic_interrupt *)header;
 
-	if (BAD_MADT_ENTRY(processor, end))
+	if (BAD_MADT_GICC_ENTRY(processor, end))
 		return -EINVAL;
 
 	/*
-- 
2.4.0
