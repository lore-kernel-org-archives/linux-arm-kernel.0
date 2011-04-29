From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 14:59:20 +1200
Subject: [PATCH v3 11/23] at91: Make watchdog device common
In-Reply-To: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304045972-19319-12-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code for the watchdog device for each of the at91 variants is
identical. Remove it from each variant and replace them with a single
version in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c |   34 ------------------------------
 arch/arm/mach-at91/at91cap9_devices.c    |   33 -----------------------------
 arch/arm/mach-at91/at91rm9200_devices.c  |   22 -------------------
 arch/arm/mach-at91/at91sam9260_devices.c |   33 -----------------------------
 arch/arm/mach-at91/at91sam9261_devices.c |   34 ------------------------------
 arch/arm/mach-at91/at91sam9263_devices.c |   33 -----------------------------
 arch/arm/mach-at91/at91sam9g45_devices.c |   21 ------------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   21 ------------------
 arch/arm/mach-at91/devices.c             |   23 ++++++++++++++++++++
 9 files changed, 23 insertions(+), 231 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index c8be92a..9220201 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -192,26 +192,6 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
 };
 
 /* --------------------------------------------------------------------
- *  Watchdog
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
-static struct platform_device at572d940hf_wdt_device = {
-	.name		= "at91_wdt",
-	.id		= -1,
-	.num_resources	= 0,
-};
-
-static void __init at91_add_device_watchdog(void)
-{
-	platform_device_register(&at572d940hf_wdt_device);
-}
-#else
-static void __init at91_add_device_watchdog(void) {}
-#endif
-
-
-/* --------------------------------------------------------------------
  *  UART
  * -------------------------------------------------------------------- */
 
@@ -538,17 +518,3 @@ void __init at572d940hf_init_devices(void)
 {
 	at91_init_devices(&at572d940hf_device_table);
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
-	at91_add_device_watchdog();
-	return 0;
-}
-
-arch_initcall(at91_add_standard_devices);
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 79778c9..dce861c 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -299,26 +299,6 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
 };
 
 /* --------------------------------------------------------------------
- *  Watchdog
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
-static struct platform_device at91cap9_wdt_device = {
-	.name		= "at91_wdt",
-	.id		= -1,
-	.num_resources	= 0,
-};
-
-static void __init at91_add_device_watchdog(void)
-{
-	platform_device_register(&at91cap9_wdt_device);
-}
-#else
-static void __init at91_add_device_watchdog(void) {}
-#endif
-
-
-/* --------------------------------------------------------------------
  *  PWM
  * --------------------------------------------------------------------*/
 
@@ -876,16 +856,3 @@ void __init at91cap9_init_devices(void)
 {
 	at91_init_devices(&at91cap9_device_table);
 }
-
-/* -------------------------------------------------------------------- */
-/*
- * These devices are always present and don't need any board-specific
- * setup.
- */
-static int __init at91_add_standard_devices(void)
-{
-	at91_add_device_watchdog();
-	return 0;
-}
-
-arch_initcall(at91_add_standard_devices);
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 5e9f269..6cec253 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -295,27 +295,6 @@ static void __init at91_add_device_rtc(void)
 static void __init at91_add_device_rtc(void) {}
 #endif
 
-
-/* --------------------------------------------------------------------
- *  Watchdog
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_AT91RM9200_WATCHDOG) || defined(CONFIG_AT91RM9200_WATCHDOG_MODULE)
-static struct platform_device at91rm9200_wdt_device = {
-	.name		= "at91_wdt",
-	.id		= -1,
-	.num_resources	= 0,
-};
-
-static void __init at91_add_device_watchdog(void)
-{
-	platform_device_register(&at91rm9200_wdt_device);
-}
-#else
-static void __init at91_add_device_watchdog(void) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
@@ -812,7 +791,6 @@ void __init at91rm9200_init_devices(void)
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_rtc();
-	at91_add_device_watchdog();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index d3d7fd5..8f1f866 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -197,26 +197,6 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
 };
 
 /* --------------------------------------------------------------------
- *  Watchdog
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
-static struct platform_device at91sam9260_wdt_device = {
-	.name		= "at91_wdt",
-	.id		= -1,
-	.num_resources	= 0,
-};
-
-static void __init at91_add_device_watchdog(void)
-{
-	platform_device_register(&at91sam9260_wdt_device);
-}
-#else
-static void __init at91_add_device_watchdog(void) {}
-#endif
-
-
-/* --------------------------------------------------------------------
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
 
@@ -805,16 +785,3 @@ void __init at91sam9260_init_devices(void)
 {
 	at91_init_devices(&at91sam9260_device_table);
 }
-
-/* -------------------------------------------------------------------- */
-/*
- * These devices are always present and don't need any board-specific
- * setup.
- */
-static int __init at91_add_standard_devices(void)
-{
-	at91_add_device_watchdog();
-	return 0;
-}
-
-arch_initcall(at91_add_standard_devices);
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 2977c82..bc9f0c7 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -249,26 +249,6 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
 };
 
 /* --------------------------------------------------------------------
- *  Watchdog
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
-static struct platform_device at91sam9261_wdt_device = {
-	.name		= "at91_wdt",
-	.id		= -1,
-	.num_resources	= 0,
-};
-
-static void __init at91_add_device_watchdog(void)
-{
-	platform_device_register(&at91sam9261_wdt_device);
-}
-#else
-static void __init at91_add_device_watchdog(void) {}
-#endif
-
-
-/* --------------------------------------------------------------------
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
 
@@ -691,17 +671,3 @@ void __init at91sam9261_init_devices(void)
 {
 	at91_init_devices(&at91sam9261_device_table);
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
-	at91_add_device_watchdog();
-	return 0;
-}
-
-arch_initcall(at91_add_standard_devices);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 7feb18e..109e230 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -533,26 +533,6 @@ static struct at91_dev_table_rtt device_rtt1 __initdata = {
 };
 
 /* --------------------------------------------------------------------
- *  Watchdog
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
-static struct platform_device at91sam9263_wdt_device = {
-	.name		= "at91_wdt",
-	.id		= -1,
-	.num_resources	= 0,
-};
-
-static void __init at91_add_device_watchdog(void)
-{
-	platform_device_register(&at91sam9263_wdt_device);
-}
-#else
-static void __init at91_add_device_watchdog(void) {}
-#endif
-
-
-/* --------------------------------------------------------------------
  *  PWM
  * --------------------------------------------------------------------*/
 
@@ -985,16 +965,3 @@ void __init at91sam9263_init_devices(void)
 {
 	at91_init_devices(&at91sam9263_device_table);
 }
-
-/* -------------------------------------------------------------------- */
-/*
- * These devices are always present and don't need any board-specific
- * setup.
- */
-static int __init at91_add_standard_devices(void)
-{
-	at91_add_device_watchdog();
-	return 0;
-}
-
-arch_initcall(at91_add_standard_devices);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 3e1b5ff..96631f3 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -566,26 +566,6 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
 };
 
 /* --------------------------------------------------------------------
- *  Watchdog
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
-static struct platform_device at91sam9g45_wdt_device = {
-	.name		= "at91_wdt",
-	.id		= -1,
-	.num_resources	= 0,
-};
-
-static void __init at91_add_device_watchdog(void)
-{
-	platform_device_register(&at91sam9g45_wdt_device);
-}
-#else
-static void __init at91_add_device_watchdog(void) {}
-#endif
-
-
-/* --------------------------------------------------------------------
  *  PWM
  * --------------------------------------------------------------------*/
 
@@ -1076,7 +1056,6 @@ static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_hdmac();
 	at91_add_device_rtc();
-	at91_add_device_watchdog();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 0d78c8f..fa11eac 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -444,26 +444,6 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
 };
 
 /* --------------------------------------------------------------------
- *  Watchdog
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
-static struct platform_device at91sam9rl_wdt_device = {
-	.name		= "at91_wdt",
-	.id		= -1,
-	.num_resources	= 0,
-};
-
-static void __init at91_add_device_watchdog(void)
-{
-	platform_device_register(&at91sam9rl_wdt_device);
-}
-#else
-static void __init at91_add_device_watchdog(void) {}
-#endif
-
-
-/* --------------------------------------------------------------------
  *  PWM
  * --------------------------------------------------------------------*/
 
@@ -956,7 +936,6 @@ static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_hdmac();
 	at91_add_device_rtc();
-	at91_add_device_watchdog();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index 5e97738..760ed81 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -973,6 +973,28 @@ static void __init at91_add_device_rtt(void)
 	}
 }
 
+/* --------------------------------------------------------------------
+ *  Watchdog
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_AT91SAM9X_WATCHDOG)        || \
+    defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE) || \
+    defined(CONFIG_AT91RM9200_WATCHDOG)       || \
+    defined(CONFIG_AT91RM9200_WATCHDOG_MODULE)
+static struct platform_device at91_wdt_device = {
+	.name		= "at91_wdt",
+	.id		= -1,
+	.num_resources	= 0,
+};
+
+static void __init at91_add_device_watchdog(void)
+{
+	platform_device_register(&at91_wdt_device);
+}
+#else
+static void __init at91_add_device_watchdog(void) {}
+#endif
+
 void __init at91_init_devices(struct at91_device_table *device_table)
 {
 	devices = device_table;
@@ -982,6 +1004,7 @@ static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
 	at91_add_device_rtt();
+	at91_add_device_watchdog();
 	return 0;
 }
 
-- 
1.7.0.4
