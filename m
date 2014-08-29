From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Aug 2014 16:54:29 +0100
Subject: [RFC PATCH 6/7] arm: call iommu_init before of_platform_populate
In-Reply-To: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409327670-3495-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to ensure that the IOMMUs in the system have a chance to perform
some basic initialisation before we start adding masters to them.

This patch adds a call to of_iommu_init before of_platform_populate.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/setup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 84db893dedc2..38a0203523af 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -18,6 +18,7 @@
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/screen_info.h>
+#include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
@@ -803,9 +804,11 @@ static int __init customize_machine(void)
 	if (machine_desc->init_machine)
 		machine_desc->init_machine();
 #ifdef CONFIG_OF
-	else
+	else {
+		of_iommu_init();
 		of_platform_populate(NULL, of_default_bus_match_table,
 					NULL, NULL);
+	}
 #endif
 	return 0;
 }
-- 
2.1.0
