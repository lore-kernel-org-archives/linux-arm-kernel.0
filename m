From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 12 Dec 2011 15:49:09 +0100
Subject: [PATCH 4/4] ARM: S3C2443/S3C2416: add s3c_rtc_setname and rename rtc
 devices
In-Reply-To: <201112121543.42299.heiko@sntech.de>
References: <201112121543.42299.heiko@sntech.de>
Message-ID: <201112121549.09830.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the S3C24xx SoCs use the same rtc device a renaming capability like in
the adc driver is necessary.

This patch adds a s3c_rtc_setname function and names the rtc devices for
S3C2443 and S3C2416 accordingly.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/s3c2416.c               |    2 +
 arch/arm/mach-s3c2443/s3c2443.c               |    2 +
 arch/arm/plat-samsung/include/plat/rtc-core.h |   27 +++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/rtc-core.h

diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index ee214bc..604cf98 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -61,6 +61,7 @@
 #include <plat/fb-core.h>
 #include <plat/nand-core.h>
 #include <plat/adc-core.h>
+#include <plat/rtc-core.h>
 
 static struct map_desc s3c2416_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
@@ -99,6 +100,7 @@ int __init s3c2416_init(void)
 	s3c_fb_setname("s3c2443-fb");
 
 	s3c_adc_setname("s3c2416-adc");
+	s3c_rtc_setname("s3c2416-rtc");
 
 #ifdef CONFIG_PM
 	register_syscore_ops(&s3c2416_pm_syscore_ops);
diff --git a/arch/arm/mach-s3c2443/s3c2443.c b/arch/arm/mach-s3c2443/s3c2443.c
index a22b771..9e6be20 100644
--- a/arch/arm/mach-s3c2443/s3c2443.c
+++ b/arch/arm/mach-s3c2443/s3c2443.c
@@ -42,6 +42,7 @@
 #include <plat/fb-core.h>
 #include <plat/nand-core.h>
 #include <plat/adc-core.h>
+#include <plat/rtc-core.h>
 
 static struct map_desc s3c2443_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
@@ -72,6 +73,7 @@ int __init s3c2443_init(void)
 	s3c_fb_setname("s3c2443-fb");
 
 	s3c_adc_setname("s3c2443-adc");
+	s3c_rtc_setname("s3c2443-rtc");
 
 	/* change WDT IRQ number */
 	s3c_device_wdt.resource[1].start = IRQ_S3C2443_WDT;
diff --git a/arch/arm/plat-samsung/include/plat/rtc-core.h b/arch/arm/plat-samsung/include/plat/rtc-core.h
new file mode 100644
index 0000000..21d8594
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/rtc-core.h
@@ -0,0 +1,27 @@
+/* linux/arch/arm/plat-samsung/include/plat/rtc-core.h
+ *
+ * Copyright (c) 2011 Heiko Stuebner <heiko@sntech.de>
+ *
+ * Samsung RTC Controller core functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_RTC_CORE_H
+#define __ASM_PLAT_RTC_CORE_H __FILE__
+
+/* These functions are only for use with the core support code, such as
+ * the cpu specific initialisation code
+ */
+
+/* re-define device name depending on support. */
+static inline void s3c_rtc_setname(char *name)
+{
+#if defined(CONFIG_SAMSUNG_DEV_RTC) || defined(CONFIG_PLAT_S3C24XX)
+	s3c_device_rtc.name = name;
+#endif
+}
+
+#endif /* __ASM_PLAT_RTC_CORE_H */
-- 
1.7.5.4
