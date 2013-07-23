From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 23:31:26 -0400
Subject: [PATCH 10/13] ARM: bL_switcher: add kernel cmdline param to disable
 the switcher on boot
In-Reply-To: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374550289-25305-11-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By adding no_bL_switcher to the kernel cmdline string, the switcher
won't be activated automatically at boot time.  It is still possible
to activate it later with:

	echo 1 > /sys/kernel/bL_switcher/active

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index abeeff5520..704c4b4ef3 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -26,6 +26,7 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/moduleparam.h>
 
 #include <asm/smp_plat.h>
 #include <asm/cacheflush.h>
@@ -527,6 +528,9 @@ static int __init bL_switcher_sysfs_init(void)
 
 #endif  /* CONFIG_SYSFS */
 
+static bool no_bL_switcher;
+core_param(no_bL_switcher, no_bL_switcher, bool, 0644);
+
 static int __init bL_switcher_init(void)
 {
 	int ret;
@@ -536,9 +540,11 @@ static int __init bL_switcher_init(void)
 		return -EINVAL;
 	}
 
-	ret = bL_switcher_enable();
-	if (ret)
-		return ret;
+	if (!no_bL_switcher) {
+		ret = bL_switcher_enable();
+		if (ret)
+			return ret;
+	}
 
 #ifdef CONFIG_SYSFS
 	ret = bL_switcher_sysfs_init();
-- 
1.8.1.2
