From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:35 +0800
Subject: [PATCH 10/15] ARM: prima2: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-11-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Barry Song <baohua.song@csr.com>
---
 arch/arm/mach-prima2/common.h |    6 ++++++
 arch/arm/mach-prima2/pm.c     |    3 +--
 arch/arm/mach-prima2/prima2.c |    6 ++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index b28a930..60d826f 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -24,4 +24,10 @@ static inline void sirfsoc_map_lluart(void)  {}
 extern void __init sirfsoc_map_lluart(void);
 #endif
 
+#ifdef CONFIG_SUSPEND
+extern int sirfsoc_pm_init(void);
+#else
+static inline int sirfsoc_pm_init(void) { return 0; }
+#endif
+
 #endif
diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index 26ebb57..fb5a791 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -85,12 +85,11 @@ static const struct platform_suspend_ops sirfsoc_pm_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-static int __init sirfsoc_pm_init(void)
+int __init sirfsoc_pm_init(void)
 {
 	suspend_set_ops(&sirfsoc_pm_ops);
 	return 0;
 }
-late_initcall(sirfsoc_pm_init);
 
 static const struct of_device_id pwrc_ids[] = {
 	{ .compatible = "sirf,prima2-pwrc" },
diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/prima2.c
index 02b9c05..8f0429d 100644
--- a/arch/arm/mach-prima2/prima2.c
+++ b/arch/arm/mach-prima2/prima2.c
@@ -25,6 +25,11 @@ void __init sirfsoc_mach_init(void)
 	of_platform_bus_probe(NULL, sirfsoc_of_bus_ids, NULL);
 }
 
+void __init sirfsoc_init_late(void)
+{
+	sirfsoc_pm_init();
+}
+
 static const char *prima2cb_dt_match[] __initdata = {
        "sirf,prima2-cb",
        NULL
@@ -39,6 +44,7 @@ MACHINE_START(PRIMA2_EVB, "prima2cb")
 	.timer		= &sirfsoc_timer,
 	.dma_zone_size	= SZ_256M,
 	.init_machine	= sirfsoc_mach_init,
+	.init_late	= sirfsoc_init_late,
 	.dt_compat      = prima2cb_dt_match,
 	.restart	= sirfsoc_restart,
 MACHINE_END
-- 
1.7.5.4
