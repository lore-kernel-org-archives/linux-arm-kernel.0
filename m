From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Sep 2014 17:34:54 +0100
Subject: [RFC PATCH v3 6/7] arm: call iommu_init before of_platform_populate
In-Reply-To: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
Message-ID: <1410539695-29128-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to ensure that the IOMMUs in the system have a chance to perform
some basic initialisation before we start adding masters to them.

This patch adds a call to of_iommu_init before of_platform_populate.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 84db893dedc2..495e29697a67 100644
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
@@ -800,6 +801,7 @@ static int __init customize_machine(void)
 	 * machine from the device tree, if no callback is provided,
 	 * otherwise we would always need an init_machine callback.
 	 */
+	of_iommu_init();
 	if (machine_desc->init_machine)
 		machine_desc->init_machine();
 #ifdef CONFIG_OF
-- 
2.1.0
