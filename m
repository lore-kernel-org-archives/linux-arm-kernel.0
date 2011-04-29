From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 14:59:28 +1200
Subject: [PATCH v3 19/23] at91: Make RTC device common
In-Reply-To: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304045972-19319-20-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC device code for the AT91RM9200, AT91SAM9G45 and AT91SAM9RL are
all exactly the same. Remove the individual implementations and
replace them with a single version in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at91rm9200_devices.c  |   33 -----------------------------
 arch/arm/mach-at91/at91sam9g45_devices.c |   33 -----------------------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   34 ------------------------------
 arch/arm/mach-at91/devices.c             |   20 +++++++++++++++++
 4 files changed, 20 insertions(+), 100 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 9f678de..f251ed1 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -277,25 +277,6 @@ static struct at91_dev_table_tcb device_tcb1 __initdata = {
 };
 
 /* --------------------------------------------------------------------
- *  RTC
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_RTC_DRV_AT91RM9200) || defined(CONFIG_RTC_DRV_AT91RM9200_MODULE)
-static struct platform_device at91rm9200_rtc_device = {
-	.name		= "at91_rtc",
-	.id		= -1,
-	.num_resources	= 0,
-};
-
-static void __init at91_add_device_rtc(void)
-{
-	platform_device_register(&at91rm9200_rtc_device);
-}
-#else
-static void __init at91_add_device_rtc(void) {}
-#endif
-
-/* --------------------------------------------------------------------
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
 
@@ -444,17 +425,3 @@ void __init at91rm9200_init_devices(void)
 {
 	at91_init_devices(&at91rm9200_device_table);
 }
-
-/* -------------------------------------------------------------------- */
-
-/*
- * These devices are always present and don't need any board-specific
- * setup.
- */
-static int __init at91_add_standard_devices(void)
-{
-	at91_add_device_rtc();
-	return 0;
-}
-
-arch_initcall(at91_add_standard_devices);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index f67a675..3627c2e 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -377,26 +377,6 @@ static struct at91_dev_table_tcb device_tcb1 __initdata = {
 };
 
 /* --------------------------------------------------------------------
- *  RTC
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_RTC_DRV_AT91RM9200) || defined(CONFIG_RTC_DRV_AT91RM9200_MODULE)
-static struct platform_device at91sam9g45_rtc_device = {
-	.name		= "at91_rtc",
-	.id		= -1,
-	.num_resources	= 0,
-};
-
-static void __init at91_add_device_rtc(void)
-{
-	platform_device_register(&at91sam9g45_rtc_device);
-}
-#else
-static void __init at91_add_device_rtc(void) {}
-#endif
-
-
-/* --------------------------------------------------------------------
  *  Touchscreen
  * -------------------------------------------------------------------- */
 
@@ -569,16 +549,3 @@ void __init at91sam9g45_init_devices(void)
 {
 	at91_init_devices(&at91sam9g45_device_table);
 }
-
-/* -------------------------------------------------------------------- */
-/*
- * These devices are always present and don't need any board-specific
- * setup.
- */
-static int __init at91_add_standard_devices(void)
-{
-	at91_add_device_rtc();
-	return 0;
-}
-
-arch_initcall(at91_add_standard_devices);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 3dac87f..2aa465b 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -271,26 +271,6 @@ static struct at91_dev_table_tsadcc device_tsadcc __initdata = {
 };
 
 /* --------------------------------------------------------------------
- *  RTC
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_RTC_DRV_AT91RM9200) || defined(CONFIG_RTC_DRV_AT91RM9200_MODULE)
-static struct platform_device at91sam9rl_rtc_device = {
-	.name		= "at91_rtc",
-	.id		= -1,
-	.num_resources	= 0,
-};
-
-static void __init at91_add_device_rtc(void)
-{
-	platform_device_register(&at91sam9rl_rtc_device);
-}
-#else
-static void __init at91_add_device_rtc(void) {}
-#endif
-
-
-/* --------------------------------------------------------------------
  *  RTT
  * -------------------------------------------------------------------- */
 
@@ -445,17 +425,3 @@ void __init at91sam9rl_init_devices(void)
 {
 	at91_init_devices(&at91sam9rl_device_table);
 }
-
-/* -------------------------------------------------------------------- */
-
-/*
- * These devices are always present and don't need any board-specific
- * setup.
- */
-static int __init at91_add_standard_devices(void)
-{
-	at91_add_device_rtc();
-	return 0;
-}
-
-arch_initcall(at91_add_standard_devices);
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index a79d477..b867663 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -1745,12 +1745,32 @@ void __init at91_add_device_hdmac(void)
 void __init at91_add_device_hdmac(void) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  RTC
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_RTC_DRV_AT91RM9200) || defined(CONFIG_RTC_DRV_AT91RM9200_MODULE)
+static struct platform_device at91_rtc_device = {
+	.name		= "at91_rtc",
+	.id		= -1,
+	.num_resources	= 0,
+};
+
+static void __init at91_add_device_rtc(void)
+{
+	platform_device_register(&at91_rtc_device);
+}
+#else
+static void __init at91_add_device_rtc(void) {}
+#endif
+
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
 	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	at91_add_device_hdmac();
+	at91_add_device_rtc();
 	return 0;
 }
 
-- 
1.7.0.4
