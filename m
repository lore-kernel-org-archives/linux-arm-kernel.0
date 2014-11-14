From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Nov 2014 18:56:36 +0000
Subject: [RFC PATCH v4 7/8] arm: call iommu_init before of_platform_populate
In-Reply-To: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
Message-ID: <1415991397-9618-8-git-send-email-will.deacon@arm.com>
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
index c03106378b49..1cfc94aa7fa2 100644
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
@@ -806,6 +807,7 @@ static int __init customize_machine(void)
 	 * machine from the device tree, if no callback is provided,
 	 * otherwise we would always need an init_machine callback.
 	 */
+	of_iommu_init();
 	if (machine_desc->init_machine)
 		machine_desc->init_machine();
 #ifdef CONFIG_OF
-- 
2.1.1
