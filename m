From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:01 +0800
Subject: [PATCH v4 04/18] arm64: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-5-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers about the
of_platform_populate with default match table.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/kernel/setup.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index e20b64f..df6b819 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -40,7 +40,6 @@
 #include <linux/proc_fs.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/efi.h>
 #include <linux/psci.h>
 
@@ -361,18 +360,6 @@ void __init setup_arch(char **cmdline_p)
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
