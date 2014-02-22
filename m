From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 22 Feb 2014 23:45:58 +0100
Subject: [PATCH v2 1/5] ARM: S3C24XX: only store clock registers when old
 clock code is active
In-Reply-To: <1835515.oOiOlPWUhB@phil>
References: <1835515.oOiOlPWUhB@phil>
Message-ID: <1961499.6PD4R3zHyt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung ccf driver already handles the save and restore of the clock
registers on suspend and resume. The architecture code should not
duplicate this when the ccf is active.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-s3c24xx/pm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/pm.c b/arch/arm/mach-s3c24xx/pm.c
index 052ca23..e99d131 100644
--- a/arch/arm/mach-s3c24xx/pm.c
+++ b/arch/arm/mach-s3c24xx/pm.c
@@ -51,9 +51,6 @@
 #define PFX "s3c24xx-pm: "
 
 static struct sleep_save core_save[] = {
-	SAVE_ITEM(S3C2410_LOCKTIME),
-	SAVE_ITEM(S3C2410_CLKCON),
-
 	/* we restore the timings here, with the proviso that the board
 	 * brings the system up in an slower, or equal frequency setting
 	 * to the original system.
@@ -70,6 +67,9 @@ static struct sleep_save core_save[] = {
 	SAVE_ITEM(S3C2410_BANKCON4),
 	SAVE_ITEM(S3C2410_BANKCON5),
 
+#ifdef CONFIG_SAMSUNG_CLOCK
+	SAVE_ITEM(S3C2410_LOCKTIME),
+	SAVE_ITEM(S3C2410_CLKCON),
 #ifndef CONFIG_CPU_FREQ
 	SAVE_ITEM(S3C2410_CLKDIVN),
 	SAVE_ITEM(S3C2410_MPLLCON),
@@ -77,11 +77,14 @@ static struct sleep_save core_save[] = {
 #endif
 	SAVE_ITEM(S3C2410_UPLLCON),
 	SAVE_ITEM(S3C2410_CLKSLOW),
+#endif /* CONFIG_SAMSUNG_CLOCK */
 };
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 static struct sleep_save misc_save[] = {
 	SAVE_ITEM(S3C2410_DCLKCON),
 };
+#endif
 
 /* s3c_pm_check_resume_pin
  *
@@ -140,12 +143,16 @@ void s3c_pm_configure_extint(void)
 void s3c_pm_restore_core(void)
 {
 	s3c_pm_do_restore_core(core_save, ARRAY_SIZE(core_save));
+#ifdef CONFIG_SAMSUNG_CLOCK
 	s3c_pm_do_restore(misc_save, ARRAY_SIZE(misc_save));
+#endif
 }
 
 void s3c_pm_save_core(void)
 {
+#ifdef CONFIG_SAMSUNG_CLOCK
 	s3c_pm_do_save(misc_save, ARRAY_SIZE(misc_save));
+#endif
 	s3c_pm_do_save(core_save, ARRAY_SIZE(core_save));
 }
 
-- 
1.8.5.3
