From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:50:35 +0100
Subject: [PATCH 3/6] ARM: s3c24xx: fix unused gta02_configure_pmu_for_charger
 warning
In-Reply-To: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
References: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
Message-ID: <1454079040-3567945-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gta02_configure_pmu_for_charger is only used when CONFIG_PCF50633_ADC
is set, and otherwise we get a warning about an unused symbol:

arch/arm/mach-s3c24xx/mach-gta02.c:158:1: warning: 'gta02_configure_pmu_for_charger' defined but not used [-Wunused-function]
 gta02_configure_pmu_for_charger(struct pcf50633 *pcf, void *unused, int res)

This adds an #ifdef to shut up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/mach-gta02.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 6d1e0b9c5b27..27ae6877550f 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -154,6 +154,7 @@ static struct s3c2410_uartcfg gta02_uartcfgs[] = {
 #define ADC_NOM_CHG_DETECT_1A 6
 #define ADC_NOM_CHG_DETECT_USB 43
 
+#ifdef CONFIG_PCF50633_ADC
 static void
 gta02_configure_pmu_for_charger(struct pcf50633 *pcf, void *unused, int res)
 {
@@ -174,6 +175,7 @@ gta02_configure_pmu_for_charger(struct pcf50633 *pcf, void *unused, int res)
 
 	pcf50633_mbc_usb_curlim_set(pcf, ma);
 }
+#endif
 
 static struct delayed_work gta02_charger_work;
 static int gta02_usb_vbus_draw;
-- 
2.7.0
