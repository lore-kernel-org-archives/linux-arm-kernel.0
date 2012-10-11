From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Oct 2012 12:56:41 +0000
Subject: [PATCH] pinctrl/nomadik: provide stubs for legacy Nomadik
In-Reply-To: <1349959302-12151-1-git-send-email-linus.walleij@stericsson.com>
References: <1349959302-12151-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201210111256.41600.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 October 2012, Linus Walleij wrote:
> 
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The compilation of the pinctrl driver failed on the legacy
> Nomadik NHK8815 platform because it was not providing the PRCMU
> interfaces needed to support the extended alternate functions
> used by the ux500 series.
> 
> Solve this by providing some stubs for the legacy platform, to
> avoid too much #ifdefs in the code per se. Theoretically this
> actually allows the Nomadik and Ux500 to have a single kernel
> image with support for the PRCM registers on the Ux500 (though
> they have incompatible archs, but the spirit is there).
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for the quick reply!

This looks like it will work correctly, but I've also just
looked into the problem deeper and found that we actually have
too many inline function alternatives in the !UX500 case.

The below is what I just added locally. I don't care which version
you end up using though, as you maintain both the driver and the
platform sides of the problem.

	Arnd

commit c386dcea42be85822ef5a9ab5ab1785a063da889
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Oct 11 12:39:07 2012 +0000

    mfd: db8500-prcmu: remove duplicate declarations
    
    These are already present in dbx500-prcmu.h, so we must not define them
    here or nomadik won't build.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index b82f6ee..7ef550b 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -521,16 +521,12 @@ void prcmu_configure_auto_pm(struct prcmu_auto_pm_config *sleep,
 	struct prcmu_auto_pm_config *idle);
 bool prcmu_is_auto_pm_enabled(void);
 
-int prcmu_config_clkout(u8 clkout, u8 source, u8 div);
 int prcmu_set_clock_divider(u8 clock, u8 divider);
 int db8500_prcmu_config_hotdog(u8 threshold);
 int db8500_prcmu_config_hotmon(u8 low, u8 high);
 int db8500_prcmu_start_temp_sense(u16 cycles32k);
 int db8500_prcmu_stop_temp_sense(void);
-int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size);
-int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size);
 
-int prcmu_ac_wake_req(void);
 void prcmu_ac_sleep_req(void);
 void db8500_prcmu_modem_reset(void);
 
@@ -640,11 +636,6 @@ static inline bool prcmu_is_auto_pm_enabled(void)
 	return false;
 }
 
-static inline int prcmu_config_clkout(u8 clkout, u8 source, u8 div)
-{
-	return 0;
-}
-
 static inline int prcmu_set_clock_divider(u8 clock, u8 divider)
 {
 	return 0;
@@ -670,23 +661,6 @@ static inline int db8500_prcmu_stop_temp_sense(void)
 	return 0;
 }
 
-static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
-{
-	return -ENOSYS;
-}
-
-static inline int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size)
-{
-	return -ENOSYS;
-}
-
-static inline int prcmu_ac_wake_req(void)
-{
-	return 0;
-}
-
-static inline void prcmu_ac_sleep_req(void) {}
-
 static inline void db8500_prcmu_modem_reset(void) {}
 
 static inline void db8500_prcmu_system_reset(u16 reset_code) {}
