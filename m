From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 12 Mar 2012 10:13:54 +0530
Subject: [PATCH] AMBA: Add module_amba_driver() helper macro for amba_driver
Message-ID: <e8a9a1ba29099f7d6fd374d960f030b0cbdaf359.1331527353.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For simple modules that contain a single amba_driver without any
additional setup code then ends up being a block of duplicated
boilerplate. This patch adds a new macro, module_amba_driver(),
which replaces the module_init()/module_exit() registrations with
template functions.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/char/hw_random/nomadik-rng.c |   13 +------------
 drivers/dma/pl330.c                  |   13 +------------
 drivers/input/serio/ambakmi.c        |   13 +------------
 drivers/mmc/host/mmci.c              |   12 +-----------
 drivers/rtc/rtc-pl030.c              |   13 +------------
 drivers/rtc/rtc-pl031.c              |   13 +------------
 drivers/watchdog/sp805_wdt.c         |   12 +-----------
 include/linux/amba/bus.h             |    9 +++++++++
 sound/arm/aaci.c                     |   13 +------------
 9 files changed, 17 insertions(+), 94 deletions(-)

diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
index 3d3c1e6..96de024 100644
--- a/drivers/char/hw_random/nomadik-rng.c
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -107,17 +107,6 @@ static struct amba_driver nmk_rng_driver = {
 	.id_table = nmk_rng_ids,
 };
 
-static int __init nmk_rng_init(void)
-{
-	return amba_driver_register(&nmk_rng_driver);
-}
-
-static void __devexit nmk_rng_exit(void)
-{
-	amba_driver_unregister(&nmk_rng_driver);
-}
-
-module_init(nmk_rng_init);
-module_exit(nmk_rng_exit);
+module_amba_driver(nmk_rng_driver);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 84ebea9..79df175 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1040,18 +1040,7 @@ static struct amba_driver pl330_driver = {
 	.remove = pl330_remove,
 };
 
-static int __init pl330_init(void)
-{
-	return amba_driver_register(&pl330_driver);
-}
-module_init(pl330_init);
-
-static void __exit pl330_exit(void)
-{
-	amba_driver_unregister(&pl330_driver);
-	return;
-}
-module_exit(pl330_exit);
+module_amba_driver(pl330_driver);
 
 MODULE_AUTHOR("Jaswinder Singh <jassi.brar@samsung.com>");
 MODULE_DESCRIPTION("API Driver for PL330 DMAC");
diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index 8407d5b..2ffd110 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -208,18 +208,7 @@ static struct amba_driver ambakmi_driver = {
 	.resume		= amba_kmi_resume,
 };
 
-static int __init amba_kmi_init(void)
-{
-	return amba_driver_register(&ambakmi_driver);
-}
-
-static void __exit amba_kmi_exit(void)
-{
-	amba_driver_unregister(&ambakmi_driver);
-}
-
-module_init(amba_kmi_init);
-module_exit(amba_kmi_exit);
+module_amba_driver(ambakmi_driver);
 
 MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
 MODULE_DESCRIPTION("AMBA KMI controller driver");
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index ea2236a..a7f079a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1598,18 +1598,8 @@ static struct amba_driver mmci_driver = {
 	.id_table	= mmci_ids,
 };
 
-static int __init mmci_init(void)
-{
-	return amba_driver_register(&mmci_driver);
-}
-
-static void __exit mmci_exit(void)
-{
-	amba_driver_unregister(&mmci_driver);
-}
+module_amba_driver(mmci_driver);
 
-module_init(mmci_init);
-module_exit(mmci_exit);
 module_param(fmax, uint, 0444);
 
 MODULE_DESCRIPTION("ARM PrimeCell PL180/181 Multimedia Card Interface driver");
diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index a4a1e53..22bacdb 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -185,18 +185,7 @@ static struct amba_driver pl030_driver = {
 	.id_table	= pl030_ids,
 };
 
-static int __init pl030_init(void)
-{
-	return amba_driver_register(&pl030_driver);
-}
-
-static void __exit pl030_exit(void)
-{
-	amba_driver_unregister(&pl030_driver);
-}
-
-module_init(pl030_init);
-module_exit(pl030_exit);
+module_amba_driver(pl030_driver);
 
 MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
 MODULE_DESCRIPTION("ARM AMBA PL030 RTC Driver");
diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 3a470e2..692de73 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -431,18 +431,7 @@ static struct amba_driver pl031_driver = {
 	.remove = pl031_remove,
 };
 
-static int __init pl031_init(void)
-{
-	return amba_driver_register(&pl031_driver);
-}
-
-static void __exit pl031_exit(void)
-{
-	amba_driver_unregister(&pl031_driver);
-}
-
-module_init(pl031_init);
-module_exit(pl031_exit);
+module_amba_driver(pl031_driver);
 
 MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net");
 MODULE_DESCRIPTION("ARM AMBA PL031 RTC Driver");
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index e2d5249..2b0939a 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -403,17 +403,7 @@ static struct amba_driver sp805_wdt_driver = {
 	.remove = __devexit_p(sp805_wdt_remove),
 };
 
-static int __init sp805_wdt_init(void)
-{
-	return amba_driver_register(&sp805_wdt_driver);
-}
-module_init(sp805_wdt_init);
-
-static void __exit sp805_wdt_exit(void)
-{
-	amba_driver_unregister(&sp805_wdt_driver);
-}
-module_exit(sp805_wdt_exit);
+module_amba_driver(sp805_wdt_driver);
 
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout,
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index a9fab83..7847e19 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -125,4 +125,13 @@ struct amba_device name##_device = {				\
 	.periphid = id,						\
 }
 
+/*
+ * module_amba_driver() - Helper macro for drivers that don't do anything
+ * special in module init/exit.  This eliminates a lot of boilerplate.  Each
+ * module may only use this macro once, and calling it replaces module_init()
+ * and module_exit()
+ */
+#define module_amba_driver(__amba_drv) \
+	module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)
+
 #endif
diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index b37b702a..5119fda 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -1110,18 +1110,7 @@ static struct amba_driver aaci_driver = {
 	.id_table	= aaci_ids,
 };
 
-static int __init aaci_init(void)
-{
-	return amba_driver_register(&aaci_driver);
-}
-
-static void __exit aaci_exit(void)
-{
-	amba_driver_unregister(&aaci_driver);
-}
-
-module_init(aaci_init);
-module_exit(aaci_exit);
+module_amba_driver(aaci_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ARM PrimeCell PL041 Advanced Audio CODEC Interface driver");
-- 
1.7.8.110.g4cb5d
