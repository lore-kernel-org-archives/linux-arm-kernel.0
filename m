From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 1 Jun 2016 14:52:57 +0800
Subject: [PATCH v5 04/18] arm64: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1464763991-26634-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1464763991-26634-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1464763991-26634-5-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers of
of_platform_populate with default match table.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/kernel/setup.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 8412520..c907e2f 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -40,7 +40,6 @@
 #include <linux/proc_fs.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/efi.h>
 #include <linux/psci.h>
 
@@ -301,18 +300,6 @@ void __init setup_arch(char **cmdline_p)
 	}
 }
 
-static int __init arm64_device_init(void)
-{
-	if (of_have_populated_dt()) {
-		of_platform_populate(NULL, of_default_bus_match_table,
-				     NULL, NULL);
-	} else if (acpi_disabled) {
-		pr_crit("Device tree not populated\n");
-	}
-	return 0;
-}
-arch_initcall_sync(arm64_device_init);
-
 static int __init topology_init(void)
 {
 	int i;
-- 
1.7.12.4
