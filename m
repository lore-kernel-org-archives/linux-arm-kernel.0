From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Fri, 15 May 2015 21:50:06 +0200
Subject: [PATCH 1/2] arm: devtree: Save atags if are in DT atags field
In-Reply-To: <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1431719407-18230-2-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch creates /proc/atags from DT /atags field.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/kernel/devtree.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 7e13e27..dd98322 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -29,6 +29,7 @@
 #include <asm/mach-types.h>
 #include <asm/system_info.h>
 
+#include "atags.h"
 
 #ifdef CONFIG_SMP
 extern struct of_cpu_method __cpu_method_of_table[];
@@ -256,5 +257,10 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 			system_rev = 0;
 	}
 
+	/* Save atags */
+	prop = of_get_flat_dt_prop(dt_root, "atags", NULL);
+	if (prop)
+		save_atags((void *)prop);
+
 	return mdesc;
 }
-- 
1.7.9.5
