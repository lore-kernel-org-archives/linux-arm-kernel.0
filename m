From: levex@linux.com (Levente Kurusa)
Date: Thu, 19 Dec 2013 16:03:21 +0100
Subject: [PATCH 10/38] arm: exynos: add missing put_device call
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Message-ID: <1387465429-3568-11-git-send-email-levex@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required so that we give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/arm/mach-exynos/common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 61d2906..8b58829 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -407,7 +407,13 @@ early_initcall(exynos4_l2x0_cache_init);
 
 static int __init exynos_init(void)
 {
+	int rc = 0;
+
 	printk(KERN_INFO "EXYNOS: Initializing architecture\n");
 
-	return device_register(&exynos4_dev);
+	rc = device_register(&exynos4_dev);
+	if (rc)
+		put_device(&exynos4_dev);
+	
+	return rc;
 }
-- 
1.8.3.1
