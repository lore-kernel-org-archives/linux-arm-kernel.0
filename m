From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 13 Dec 2013 14:00:26 +0100
Subject: [PATCH 05/12] ARM: S3C24XX: only store clock registers when old clock
 code is active
In-Reply-To: <201312131356.40755.heiko@sntech.de>
References: <201312131356.40755.heiko@sntech.de>
Message-ID: <201312131400.26979.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung ccf driver already handles the save and restore of the clock
registers on suspend and resume. The architecture code should not
duplicate this when the ccf is active.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/pm.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/pm.c b/arch/arm/mach-s3c24xx/pm.c
index 75181db..9cc6fc1 100644
--- a/arch/arm/mach-s3c24xx/pm.c
+++ b/arch/arm/mach-s3c24xx/pm.c
@@ -50,9 +50,6 @@
 #define PFX "s3c24xx-pm: "
 
 static struct sleep_save core_save[] = {
-	SAVE_ITEM(S3C2410_LOCKTIME),
-	SAVE_ITEM(S3C2410_CLKCON),
-
 	/* we restore the timings here, with the proviso that the board
 	 * brings the system up in an slower, or equal frequency setting
 	 * to the original system.
@@ -69,6 +66,9 @@ static struct sleep_save core_save[] = {
 	SAVE_ITEM(S3C2410_BANKCON4),
 	SAVE_ITEM(S3C2410_BANKCON5),
 
+#ifdef CONFIG_SAMSUNG_CLOCK
+	SAVE_ITEM(S3C2410_LOCKTIME),
+	SAVE_ITEM(S3C2410_CLKCON),
 #ifndef CONFIG_CPU_FREQ
 	SAVE_ITEM(S3C2410_CLKDIVN),
 	SAVE_ITEM(S3C2410_MPLLCON),
@@ -76,6 +76,7 @@ static struct sleep_save core_save[] = {
 #endif
 	SAVE_ITEM(S3C2410_UPLLCON),
 	SAVE_ITEM(S3C2410_CLKSLOW),
+#endif /* CONFIG_SAMSUNG_CLOCK */
 };
 
 #ifdef CONFIG_SAMSUNG_CLOCK
-- 
1.7.10.4
