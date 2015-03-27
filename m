From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 27 Mar 2015 20:14:35 +0800
Subject: [PATCH 1/2] ARM64 / ACPI: Ignore the return error value of
 acpi_map_gic_cpu_interface()
Message-ID: <1427458476-20140-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MADT table scannig will stopped once it gets the errors
returned by the handler, which is acpi_map_gic_cpu_interface()
in for ARM64, so Ignore the return error value to search for
all enabled CPUs for SMP init.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 07649e4..c263cba 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -181,7 +181,8 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
 		return -EINVAL;
 
 	acpi_table_print_madt_entry(header);
-	return acpi_map_gic_cpu_interface(processor);
+	acpi_map_gic_cpu_interface(processor);
+	return 0;
 }
 
 /* Parse GIC cpu interface entries in MADT for SMP init */
-- 
1.9.1
