From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Thu, 19 May 2016 19:15:14 +0300
Subject: [PATCH v2 3/5] ACPI: table upgrade: move arch-specific symbol to
 asm/acpi.h
In-Reply-To: <1463674518-22477-1-git-send-email-aleksey.makarov@linaro.org>
References: <1463674518-22477-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1463674518-22477-4-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The constant that defines max phys address where the new upgraded
ACPI table should be allocated is arch-specific.  Move it to
<asm/acpi.h>

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/x86/include/asm/acpi.h | 2 ++
 drivers/acpi/tables.c       | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 94c18eb..c24c070 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -170,4 +170,6 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 }
 #endif
 
+#define ACPI_TABLE_UPGRADE_MAX_PHYS (max_low_pfn_mapped << PAGE_SHIFT)
+
 #endif /* _ASM_X86_ACPI_H */
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b05df13..9f0ad6e 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -35,6 +35,7 @@
 #include <linux/earlycpio.h>
 #include <linux/memblock.h>
 #include <linux/initrd.h>
+#include <linux/acpi.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -543,7 +544,7 @@ void __init acpi_table_upgrade(void)
 		return;
 
 	acpi_tables_addr =
-		memblock_find_in_range(0, max_low_pfn_mapped << PAGE_SHIFT,
+		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
 	if (!acpi_tables_addr) {
 		WARN_ON(1);
-- 
2.8.2
