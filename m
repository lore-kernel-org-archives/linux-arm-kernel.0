From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Sat, 12 Feb 2011 12:06:14 -0500
Subject: [PATCH] ARM: SAMSUNG: Removing dependency on CONFIG_PM_DEBUG for
	clock debugging
Message-ID: <1297530374-32635-1-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling the macro CONFIG_PM_DEBUG is causing compilation error as all PM components
are included which is not in mainline for samsung V310 platform, therefore, this patch
removes the dependency on macro CONFIG_PM_DEBUG for clock debugging through debugfs
interface.

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/plat-samsung/clock.c              |    4 ++--
 arch/arm/plat-samsung/include/plat/clock.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index 7728928..aca5a25 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -450,7 +450,7 @@ int __init s3c24xx_register_baseclocks(unsigned long xtal)
 	return 0;
 }
 
-#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
+#if defined(CONFIG_DEBUG_FS)
 /* debugfs support to trace clock tree hierarchy and attributes */
 
 static struct dentry *clk_debugfs_root;
@@ -538,4 +538,4 @@ err_out:
 }
 late_initcall(clk_debugfs_init);
 
-#endif /* defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) */
+#endif /* defined(CONFIG_DEBUG_FS) */
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 9a82b88..f6180ab 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -47,7 +47,7 @@ struct clk {
 
 	struct clk_ops		*ops;
 	int		    (*enable)(struct clk *, int enable);
-#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
+#if defined(CONFIG_DEBUG_FS)
 	struct dentry		*dent;	/* For visible tree hierarchy */
 #endif
 };
-- 
1.7.1
